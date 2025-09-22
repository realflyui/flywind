import 'dart:math';

/// Color conversion utilities for CSS to Flutter
class ColorConverter {
  /// Convert hex color to Flutter Color format
  static String hexToFlutterColor(String hexString) {
    // Remove # if present
    String hex = hexString.replaceAll('#', '');
    
    // Ensure it's 6 characters
    if (hex.length == 3) {
      hex = hex.split('').map((c) => c + c).join('');
    }
    
    if (hex.length != 6) {
      throw Exception('Invalid hex format: $hexString');
    }
    
    // Convert to Flutter Color format
    int colorValue = (0xFF << 24) | int.parse(hex, radix: 16);
    return 'Color(0x${colorValue.toRadixString(16).toUpperCase()})';
  }

  /// Convert OKLCH color to Flutter Color format
  static String oklchToFlutterColor(String oklchString) {
    // Parse OKLCH string like "oklch(97.1% 0.013 17.38)"
    RegExp regex = RegExp(r'oklch\(([0-9.]+)%\s+([0-9.]+)\s+([0-9.]+)\)');
    Match? match = regex.firstMatch(oklchString);
    
    if (match == null) {
      throw Exception('Invalid OKLCH format: $oklchString');
    }
    
    double l = double.parse(match.group(1)!) / 100.0; // Convert percentage to decimal
    double c = double.parse(match.group(2)!);
    double h = double.parse(match.group(3)!);
    
    List<int> rgb = _oklchToRgb(l, c, h);
    
    // Convert to Flutter Color format
    int colorValue = (0xFF << 24) | (rgb[0] << 16) | (rgb[1] << 8) | rgb[2];
    return 'Color(0x${colorValue.toRadixString(16).toUpperCase()})';
  }

  // OKLCH to RGB conversion functions (copied from convert_oklch.dart)
  static double _linearToSrgb(double c) {
    if (c <= 0.0031308) {
      return 12.92 * c;
    } else {
      return 1.055 * pow(c, 1.0 / 2.4) - 0.055;
    }
  }

  // Convert OKLCH to RGB
  static List<int> _oklchToRgb(double l, double c, double h) {
    // Convert OKLCH to OKLab
    double a = c * cos(h * pi / 180);
    double b = c * sin(h * pi / 180);
    
    // OKLab to LMS matrix (M1) - using correct coefficients
    double lms_l = 0.99999999845051981432 * l + 0.39633779217376785678 * a + 0.21580375806075880339 * b;
    double lms_m = 1.0000000088817607767 * l - 0.1055613423236563494 * a - 0.063854174771705903402 * b;
    double lms_s = 1.0000000546724109177 * l - 0.089484182094965759684 * a - 1.2914855378640917399 * b;
    
    // Cube LMS values
    lms_l = pow(lms_l, 3).toDouble();
    lms_m = pow(lms_m, 3).toDouble();
    lms_s = pow(lms_s, 3).toDouble();
    
    // LMS to linear RGB matrix (M2) - using correct coefficients
    double r = 4.076741661347994 * lms_l - 3.307711590408193 * lms_m + 0.230969928059508 * lms_s;
    double g = -1.2684380040921763 * lms_l + 2.609757401360705 * lms_m - 0.341319397268529 * lms_s;
    double b_val = -0.004196086541837188 * lms_l - 0.7034186144594493 * lms_m + 1.707614700001242 * lms_s;
    
    // Convert linear RGB to sRGB (gamma correction)
    r = _linearToSrgb(r);
    g = _linearToSrgb(g);
    b_val = _linearToSrgb(b_val);
    
    // Clamp and convert to 0-255
    int rInt = (r * 255).round().clamp(0, 255);
    int gInt = (g * 255).round().clamp(0, 255);
    int bInt = (b_val * 255).round().clamp(0, 255);
    
    return [rInt, gInt, bInt];
  }
}
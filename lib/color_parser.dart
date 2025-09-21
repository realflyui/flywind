import 'package:flutter/material.dart';

/// Color parser for handling various color string formats
class FlyColorParser {
  /// Parse a color string or Color object into a Color object
  ///
  /// Supported formats:
  /// - Hex colors: "#FF5733", "#ff5733", "FF5733", "ff5733"
  /// - RGB colors: "rgb(255, 87, 51)"
  /// - RGBA colors: "rgba(255, 87, 51, 0.8)"
  /// - Theme colors: "leif", "brand", "primary" (custom theme colors)
  /// - Color objects: Color(0xFF8B5CF6) (returns as-is)
  static Color? parse(dynamic value, {Map<String, Color>? themeColors}) {
    // If it's already a Color object, return it
    if (value is Color) {
      return value;
    }
    
    // Otherwise, treat it as a string
    if (value is! String) {
      return null;
    }
    
    final trimmed = value.trim().toLowerCase();

    // Handle hex colors
    if (trimmed.startsWith('#') || _isHexColor(trimmed)) {
      return _parseHexColor(trimmed);
    }

    // Handle RGB colors
    if (trimmed.startsWith('rgb(')) {
      return _parseRgbColor(trimmed);
    }

    // Handle RGBA colors
    if (trimmed.startsWith('rgba(')) {
      return _parseRgbaColor(trimmed);
    }


    // Handle theme colors (if themeColors map is provided)
    if (themeColors != null && themeColors.containsKey(trimmed)) {
      return themeColors[trimmed];
    }

    return null; // Invalid format
  }

  /// Parse a color string or Color object into a Color object, returning Colors.black if parsing fails
  static Color parseOrBlack(dynamic value, {Map<String, Color>? themeColors}) {
    return parse(value, themeColors: themeColors) ?? Colors.black;
  }

  /// Check if a string is a hex color (with or without #)
  static bool _isHexColor(String value) {
    final hexPattern = RegExp(r'^[0-9a-f]{6}$|^[0-9a-f]{8}$');
    return hexPattern.hasMatch(value);
  }

  /// Parse hex color string
  static Color? _parseHexColor(String value) {
    String hex = value.replaceFirst('#', '');
    
    // Handle 3-character hex (e.g., "f53" -> "ff5533")
    if (hex.length == 3) {
      hex = hex.split('').map((char) => char + char).join();
    }
    
    // Handle 6-character hex
    if (hex.length == 6) {
      hex = 'FF$hex'; // Add alpha channel
    }
    
    // Handle 8-character hex
    if (hex.length == 8) {
      final colorValue = int.tryParse(hex, radix: 16);
      if (colorValue != null) {
        return Color(colorValue);
      }
    }
    
    return null;
  }

  /// Parse RGB color string
  static Color? _parseRgbColor(String value) {
    final rgbPattern = RegExp(r'rgb\((\d+),\s*(\d+),\s*(\d+)\)');
    final match = rgbPattern.firstMatch(value);
    
    if (match != null) {
      final r = int.tryParse(match.group(1) ?? '');
      final g = int.tryParse(match.group(2) ?? '');
      final b = int.tryParse(match.group(3) ?? '');
      
      if (r != null && g != null && b != null) {
        return Color.fromRGBO(r, g, b, 1.0);
      }
    }
    
    return null;
  }

  /// Parse RGBA color string
  static Color? _parseRgbaColor(String value) {
    final rgbaPattern = RegExp(r'rgba\((\d+),\s*(\d+),\s*(\d+),\s*([\d.]+)\)');
    final match = rgbaPattern.firstMatch(value);
    
    if (match != null) {
      final r = int.tryParse(match.group(1) ?? '');
      final g = int.tryParse(match.group(2) ?? '');
      final b = int.tryParse(match.group(3) ?? '');
      final a = double.tryParse(match.group(4) ?? '');
      
      if (r != null && g != null && b != null && a != null) {
        return Color.fromRGBO(r, g, b, a);
      }
    }
    
    return null;
  }

}

/// Extension methods for convenient color parsing on String
extension FlyColorStringExtension on String {
  Color? parseFlyColor({Map<String, Color>? themeColors}) => 
    FlyColorParser.parse(this, themeColors: themeColors);
  
  Color parseFlyColorOrBlack({Map<String, Color>? themeColors}) => 
    FlyColorParser.parseOrBlack(this, themeColors: themeColors);
}

/// Extension methods for convenient color parsing on Color
extension FlyColorObjectExtension on Color {
  Color? parseFlyColor({Map<String, Color>? themeColors}) => 
    FlyColorParser.parse(this, themeColors: themeColors);
  
  Color parseFlyColorOrBlack({Map<String, Color>? themeColors}) => 
    FlyColorParser.parseOrBlack(this, themeColors: themeColors);
}

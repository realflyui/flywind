import 'package:flutter/material.dart';
import 'tokens.dart';
import 'theme.dart';

/// Single source of truth for all custom Tailwind values
/// This is the ONLY place you need to define your custom colors and spacing
class FlyConfig {
  /// Custom colors - add your custom colors here
  static const Map<String, Color> customColors = {
    'leif': Color(0xFF8B5CF6),     // Purple
    'brand': Color(0xFF10B981),    // Green
    'accent': Color(0xFFF59E0B),   // Orange
    'primary': Color(0xFF3B82F6),  // Blue
    'secondary': Color(0xFF6B7280), // Gray
  };

  /// Custom spacing - add your custom spacing here
  static const Map<String, double> customSpacing = {
    'leif': 64.0,
    'brand': 80.0,
    'large': 96.0,
    'huge': 128.0,
    'massive': 256.0,
  };


  /// Create a complete FlyTheme with all custom values
  static FlyTheme createTheme() {
    return FlyTheme.withCustom(
      customColors: customColors,
      customSpacing: customSpacing,
    );
  }
}

/// Extensions for custom colors - provides clean dot notation
extension FlyCustomColors on FlyColors {
  Color? get leif => customColors?['leif'];
  Color? get brand => customColors?['brand'];
  Color? get accent => customColors?['accent'];
  Color? get primary => customColors?['primary'];
  Color? get secondary => customColors?['secondary'];
}

/// Extensions for custom spacing - provides clean dot notation
extension FlyCustomSpacing on FlySpacing {
  double? get leif => customSpacing?['leif'];
  double? get brand => customSpacing?['brand'];
  double? get large => customSpacing?['large'];
  double? get huge => customSpacing?['huge'];
  double? get massive => customSpacing?['massive'];
}

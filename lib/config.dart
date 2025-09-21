import 'package:flutter/material.dart';
import 'tokens/colors.dart';
import 'tokens/spacing.dart';
import 'tokens/border_radius.dart';
import 'helpers/theme.dart';

/// Single source of truth for all custom Flywind values
/// This is the ONLY place you need to define your custom colors and spacing
class FlyConfig {
  /// Custom colors - add your custom colors here as strings
  static const Map<String, String> customColors = {
    'leif': '#8B5CF6', // Purple
    'brand': '#10B981', // Green
    'accent': '#F59E0B', // Orange
    'primary': '#3B82F6', // Blue
    'secondary': '#6B7280', // Gray
  };

  /// Custom spacing - add your custom spacing here
  static const Map<String, String> customSpacing = {
    'leif': '64',
    'brand': '80',
    'large': '96',
    'huge': '128',
    'massive': '256',
  };

  /// Custom border radius - add your custom border radius here
  static const Map<String, String> customBorderRadius = {
    'leif': '20',
    'brand': '16',
    'pill': '50',
    'card': '12',
    'button': '8',
  };

  /// Create a complete FlyTheme with all custom values
  static FlyTheme createTheme() {
    return FlyTheme.withCustom(
      customColors: customColors,
      customSpacing: customSpacing,
      customBorderRadius: customBorderRadius,
    );
  }

  /// Get a custom spacing value
  static String? getCustomSpacing(String key) {
    return customSpacing[key];
  }

  /// Get a custom color value as string
  static String? getCustomColor(String key) {
    return customColors[key];
  }

  /// Get a custom border radius value
  static double? getCustomBorderRadius(String key) {
    final stringValue = customBorderRadius[key];
    if (stringValue == null) return null;
    return double.tryParse(stringValue);
  }
}

/// Extensions for custom colors - provides clean dot notation
extension FlyCustomColors on FlyColors {
  Color? get leif => customColors['leif'];
  Color? get brand => customColors['brand'];
  Color? get accent => customColors['accent'];
  Color? get primary => customColors['primary'];
  Color? get secondary => customColors['secondary'];
}

/// Extensions for custom spacing - provides clean dot notation
extension FlyCustomSpacing on FlySpacing {
  String? get leif => customSpacing['leif'];
  String? get brand => customSpacing['brand'];
  String? get large => customSpacing['large'];
  String? get huge => customSpacing['huge'];
  String? get massive => customSpacing['massive'];
}

/// Extensions for custom border radius - provides clean dot notation
extension FlyCustomBorderRadius on FlyBorderRadius {
  String? get leif => customBorderRadius['leif'];
  String? get brand => customBorderRadius['brand'];
  String? get pill => customBorderRadius['pill'];
  String? get card => customBorderRadius['card'];
  String? get button => customBorderRadius['button'];
}

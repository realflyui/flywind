import 'package:flutter/material.dart';
import 'style.dart';
import 'theme.dart';

/// Utility class for handling Tailwind-like color logic
class FlyColorUtils {
  /// Resolves color from FlyStyle and FlyConfig into Color
  static Color? resolve(BuildContext context, FlyStyle style) {
    if (style.color == null) return null;
    
    final theme = Theme.of(context);
    final flywind = theme.extension<FlyTheme>();
    if (flywind == null) {
      throw FlutterError('FlyTheme extension not found. Make sure to add FlyTheme to your ThemeData.extensions');
    }
    final config = flywind;
    final color = _getColorValue(config, style.color!);
    
    if (color == null) {
      _handleMissingColor(style.color!, _getAvailableColors(config));
    }
    
    return color;
  }
  
  /// Applies color to a TextStyle
  static TextStyle applyToTextStyle(BuildContext context, FlyStyle style, TextStyle? baseStyle) {
    final color = resolve(context, style);
    
    if (color == null) {
      return baseStyle ?? const TextStyle();
    }
    
    return (baseStyle ?? const TextStyle()).copyWith(color: color);
  }
  
  /// Applies color to a Container's background
  static Color? applyToContainer(BuildContext context, FlyStyle style) {
    return resolve(context, style);
  }
  
  /// Gets color value from FlyColors class
  static Color? _getColorValue(FlyTheme theme, String key) {
    return theme.colors[key];
  }

  /// Gets list of available color keys from the actual theme
  static List<String> _getAvailableColors(FlyTheme theme) {
    final defaultColors = theme.colors.values.keys.toList();
    final customColors = theme.colors.customColors?.keys.toList() ?? [];
    return [...defaultColors, ...customColors];
  }

  /// Handles missing color errors with helpful messages
  static void _handleMissingColor(String colorKey, List<String> availableColors) {
    final sortedColors = availableColors.toList()..sort();
    
    String errorMessage = 'Color "$colorKey" not found in FlyConfig. Available colors: ${sortedColors.join(', ')}.';
    
    // In debug mode, throw an assertion error with helpful message
    assert(false, errorMessage);
    
    // In release mode, print a warning
    print('⚠️ FlyColor Warning: $errorMessage');
  }
}

/// Mixin that provides Tailwind-like color methods for any widget
mixin FlyColor<T> {
  FlyStyle get style;
  
  T Function(FlyStyle newStyle) get copyWith;

  /// Set text color using named token
  T color(String key) {
    return copyWith(style.copyWith(color: key));
  }
}

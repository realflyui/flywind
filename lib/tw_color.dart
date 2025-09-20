import 'package:flutter/material.dart';
import 'tw_theme.dart';
import 'tw_style.dart';

/// Utility class for handling Tailwind-like color logic
class TwColorUtils {
  /// Resolves color from TwStyle and TwTheme into Color
  static Color? resolve(BuildContext context, TwStyle style) {
    if (style.color == null) return null;
    
    final theme = TwTheme.of(context);
    final color = theme.colors[style.color];
    
    if (color == null) {
      _handleMissingColor(style.color!, theme.colors.keys.toList());
    }
    
    return color;
  }
  
  /// Applies color to a TextStyle
  static TextStyle applyToTextStyle(BuildContext context, TwStyle style, TextStyle? baseStyle) {
    final color = resolve(context, style);
    
    if (color == null) {
      return baseStyle ?? const TextStyle();
    }
    
    return (baseStyle ?? const TextStyle()).copyWith(color: color);
  }
  
  /// Applies color to a Container's background
  static Color? applyToContainer(BuildContext context, TwStyle style) {
    return resolve(context, style);
  }
  
  /// Handles missing color errors with helpful messages
  static void _handleMissingColor(String colorKey, List<String> availableColors) {
    final sortedColors = availableColors.toList()..sort();
    
    String errorMessage = 'Color "$colorKey" not found in TwTheme. Available colors: ${sortedColors.join(', ')}.';
    
    // In debug mode, throw an assertion error with helpful message
    assert(false, errorMessage);
    
    // In release mode, print a warning
    print('⚠️ TwColor Warning: $errorMessage');
  }
}

/// Mixin that provides Tailwind-like color methods for any widget
mixin TwColor<T> {
  TwStyle get style;
  
  T Function(TwStyle newStyle) get copyWith;

  /// Set text color using named token
  T color(String key) {
    return copyWith(style.copyWith(color: key));
  }
}

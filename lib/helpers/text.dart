import 'package:flutter/material.dart';
import 'style.dart';
import '../core/theme.dart';

/// Utility class for handling Tailwind-like text style logic
class FlyTextUtils {
  /// Resolves text alignment from string to TextAlign enum
  static TextAlign? resolveTextAlign(dynamic value) {
    if (value == null) return null;
    
    // If it's already a TextAlign, return it directly
    if (value is TextAlign) {
      return value;
    }
    
    // Otherwise, resolve as string
    if (value is String) {
      switch (value.toLowerCase()) {
        case 'left':
          return TextAlign.left;
        case 'right':
          return TextAlign.right;
        case 'center':
          return TextAlign.center;
        case 'justify':
          return TextAlign.justify;
        case 'start':
          return TextAlign.start;
        case 'end':
          return TextAlign.end;
        default:
          throw ArgumentError('Invalid text alignment: "$value". Supported values: left, right, center, justify, start, end');
      }
    }
    
    throw ArgumentError('Text alignment must be a String or TextAlign, got ${value.runtimeType}');
  }

  /// Transforms text based on the specified transformation type
  static String transformText(String text, dynamic transform) {
    if (transform == null || text.isEmpty) return text;
    
    final transformStr = transform.toString().toLowerCase();
    
    switch (transformStr) {
      case 'uppercase':
        return text.toUpperCase();
      case 'lowercase':
        return text.toLowerCase();
      case 'capitalize':
        return _toTitleCase(text);
      case 'none':
      default:
        return text;
    }
  }

  /// Converts text to title case (capitalize first letter of each word)
  static String _toTitleCase(String text) {
    if (text.isEmpty) return text;
    
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
    }).join(' ');
  }
  /// Resolves text style from FlyStyle and FlyThemeData into TextStyle
  static TextStyle? resolve(BuildContext context, FlyStyle style) {
    if (style.text == null) return null;
    
    // If it's already a TextStyle, return it directly
    if (style.text is TextStyle) {
      return style.text as TextStyle;
    }
    
    // Otherwise, resolve as token
    try {
      final textStyles = FlyTheme.of(context).textStyle;
      return textStyles[style.text];
    } catch (e) {
      throw ArgumentError('Failed to resolve text style "${style.text}": $e');
    }
  }

  /// Applies text style to a TextStyle using copyWith
  static TextStyle applyToTextStyle(
    BuildContext context,
    FlyStyle style,
    TextStyle? baseStyle,
  ) {
    final textStyle = resolve(context, style);

    if (textStyle == null) {
      return baseStyle ?? const TextStyle();
    }

    // Use copyWith to merge token style with existing style
    return textStyle.copyWith(
      color: baseStyle?.color,
      fontWeight: baseStyle?.fontWeight,
      fontStyle: baseStyle?.fontStyle,
      letterSpacing: baseStyle?.letterSpacing,
      wordSpacing: baseStyle?.wordSpacing,
      textBaseline: baseStyle?.textBaseline,
      height: baseStyle?.height,
      leadingDistribution: baseStyle?.leadingDistribution,
      locale: baseStyle?.locale,
      foreground: baseStyle?.foreground,
      background: baseStyle?.background,
      shadows: baseStyle?.shadows,
      fontFeatures: baseStyle?.fontFeatures,
      decoration: baseStyle?.decoration,
      decorationColor: baseStyle?.decorationColor,
      decorationStyle: baseStyle?.decorationStyle,
      decorationThickness: baseStyle?.decorationThickness,
      debugLabel: baseStyle?.debugLabel,
      fontFamily: baseStyle?.fontFamily,
      fontFamilyFallback: baseStyle?.fontFamilyFallback,
    );
  }
}

/// Mixin that provides Tailwind-like text style methods for any widget
mixin FlyTextHelper<T> {
  FlyStyle get style;

  T Function(FlyStyle newStyle) get copyWith;

  /// Set text style - accepts String (token name like 'sm', 'base', 'lg', etc.) or TextStyle
  T text(dynamic value) {
    return copyWith(style.copyWith(text: value));
  }

  /// Set text alignment - accepts String ('left', 'right', 'center', 'justify', 'start', 'end') or TextAlign
  T align(dynamic value) {
    return copyWith(style.copyWith(textAlign: value));
  }

  /// Transform text to uppercase
  T uppercase() {
    return copyWith(style.copyWith(textTransform: 'uppercase'));
  }

  /// Transform text to lowercase
  T lowercase() {
    return copyWith(style.copyWith(textTransform: 'lowercase'));
  }

  /// Transform text to capitalize first letter of each word
  T capitalize() {
    return copyWith(style.copyWith(textTransform: 'capitalize'));
  }
}

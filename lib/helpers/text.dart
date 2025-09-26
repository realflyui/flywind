import 'package:flutter/material.dart';
import 'style.dart';
import '../core/theme.dart';
import 'leading.dart';
import 'font_weight.dart';
import 'tracking.dart';

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

  /// Resolves text decoration from string to TextDecoration enum
  static TextDecoration? resolveTextDecoration(dynamic value) {
    if (value == null) return null;
    
    // If it's already a TextDecoration, return it directly
    if (value is TextDecoration) {
      return value;
    }
    
    // Otherwise, resolve as string
    if (value is String) {
      switch (value.toLowerCase()) {
        case 'underline':
          return TextDecoration.underline;
        case 'line-through':
        case 'lineThrough':
          return TextDecoration.lineThrough;
        case 'overline':
          return TextDecoration.overline;
        case 'none':
          return TextDecoration.none;
        default:
          throw ArgumentError('Invalid text decoration: "$value". Supported values: underline, line-through, overline, none');
      }
    }
    
    throw ArgumentError('Text decoration must be a String or TextDecoration, got ${value.runtimeType}');
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
    final leadingValue = FlyLeadingUtils.resolve(context, style);
    final textDecoration = resolveTextDecoration(style.textDecoration);
    final fontWeight = FlyFontWeightUtils.resolve(context, style.fontWeight);
    final trackingValue = FlyTrackingUtils.resolve(context, style);

    if (textStyle == null && leadingValue == null && textDecoration == null && fontWeight == null && trackingValue == null) {
      return baseStyle ?? const TextStyle();
    }

    // Start with base style or empty style
    TextStyle result = baseStyle ?? const TextStyle();
    
    // Apply text style if available
    if (textStyle != null) {
      result = textStyle.copyWith(
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
    
    // Apply leading if available
    if (leadingValue != null) {
      result = result.copyWith(height: leadingValue);
    }

    // Apply text decoration if available
    if (textDecoration != null) {
      result = result.copyWith(decoration: textDecoration);
    }

    // Apply font weight if available
    if (fontWeight != null) {
      result = result.copyWith(fontWeight: fontWeight);
    }

    // Apply tracking (letter spacing) if available
    if (trackingValue != null) {
      result = result.copyWith(letterSpacing: trackingValue);
    }

    return result;
  }
}

/// Mixin that provides Tailwind-like text style methods for any widget
mixin FlyTextHelper<T> {
  FlyStyle get style;

  T Function(FlyStyle newStyle) get copyWith;

  /// Set text style - accepts String (token name like 'sm', 'base', 'lg', etc.) or TextStyle
  /// Pass null to remove all text styling and use Flutter's default text style
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

  /// Set line height - accepts int, double, or String (token name like 'tight', 'normal', 'relaxed')
  T leading(dynamic value) {
    return copyWith(style.copyWith(leading: value));
  }

  /// Add underline decoration to text
  T underline() {
    return copyWith(style.copyWith(textDecoration: 'underline'));
  }

  /// Add line-through decoration to text
  T lineThrough() {
    return copyWith(style.copyWith(textDecoration: 'line-through'));
  }

  /// Add overline decoration to text
  T overline() {
    return copyWith(style.copyWith(textDecoration: 'overline'));
  }

  /// Remove text decoration
  T noDecoration() {
    return copyWith(style.copyWith(textDecoration: 'none'));
  }

  /// Set font weight - accepts String ('thin', 'light', 'normal', 'medium', 'bold', etc.) or FontWeight
  T weight(dynamic value) {
    return copyWith(style.copyWith(fontWeight: value));
  }
}

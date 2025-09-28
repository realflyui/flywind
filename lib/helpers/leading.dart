import 'package:flutter/material.dart';
import 'style.dart';
import 'value.dart';
import '../core/theme.dart';
import '../tokens/leading.dart';

/// Utility class for handling Tailwind-like leading (line height) logic
class FlyLeadingUtils {
  /// Resolves leading values from FlyStyle and FlyThemeData into TextStyle height
  static double? resolve(BuildContext context, FlyStyle style) {
    if (style.leading == null) return null;

    try {
      final leading = FlyTheme.of(context).leading;
      return _resolveValue(style.leading, context, leading);
    } catch (e) {
      throw ArgumentError('Failed to resolve leading: $e');
    }
  }

  /// Resolves a dynamic value to double using the numeric value resolver
  static double _resolveValue(
    dynamic value,
    BuildContext context,
    FlyLeadingToken tokens,
  ) {
    if (value == null) return 0;
    return FlyValue.resolveDouble(value, context, tokens);
  }

  /// Applies leading styling to a TextStyle using copyWith
  static TextStyle applyToTextStyle(
    BuildContext context,
    FlyStyle style,
    TextStyle? baseStyle,
  ) {
    final leadingValue = resolve(context, style);

    if (leadingValue == null) {
      return baseStyle ?? const TextStyle();
    }

    // Use copyWith to merge leading with existing style
    return (baseStyle ?? const TextStyle()).copyWith(height: leadingValue);
  }
}

/// Mixin that provides Tailwind-like leading methods for any widget
mixin FlyLeading<T> {
  FlyStyle get style;

  T Function(FlyStyle newStyle) get copyWith;

  /// Set line height - accepts int, double, or String (token name like 'tight', 'normal', 'relaxed')
  T leading(dynamic value) {
    return copyWith(style.copyWith(leading: value));
  }

  /// Resolves leading styling from FlyStyle and FlyThemeData into double
  double? resolveLeading(BuildContext context) {
    return FlyLeadingUtils.resolve(context, style);
  }

  /// Applies leading styling to a TextStyle using the resolved value
  TextStyle applyLeading(BuildContext context, TextStyle? baseStyle) {
    return FlyLeadingUtils.applyToTextStyle(context, style, baseStyle);
  }
}

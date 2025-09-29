import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../tokens/tracking.dart';
import 'style.dart';
import 'value.dart';

/// Utility class for handling Tailwind-like tracking (letter spacing) logic
class FlyTrackingUtils {
  /// Resolves tracking values from FlyStyle and FlyThemeData into TextStyle letterSpacing
  static double? resolve(BuildContext context, FlyStyle style) {
    if (style.tracking == null) return null;
    try {
      final tracking = FlyTheme.of(context).tracking;
      return _resolveValue(style.tracking, context, tracking);
    } catch (e) {
      throw ArgumentError('Failed to resolve tracking: $e');
    }
  }

  /// Resolves a dynamic value to double using the numeric value resolver
  static double _resolveValue(
    dynamic value,
    BuildContext context,
    FlyTrackingToken tokens,
  ) {
    if (value == null) return 0;
    return FlyValue.resolveDoubleAllowNegative(value, context, tokens);
  }

  /// Applies tracking styling to a TextStyle using copyWith
  static TextStyle applyToTextStyle(
    BuildContext context,
    FlyStyle style,
    TextStyle? baseStyle,
  ) {
    final trackingValue = resolve(context, style);
    if (trackingValue == null) {
      return baseStyle ?? const TextStyle();
    }
    return (baseStyle ?? const TextStyle()).copyWith(
      letterSpacing: trackingValue,
    );
  }
}

/// Mixin that provides Tailwind-like tracking methods for any widget
mixin FlyTracking<T> {
  FlyStyle get style;

  T Function(FlyStyle newStyle) get copyWith;

  /// Set letter spacing - accepts int, double, or String (token name like 'tight', 'normal', 'wide')
  T tracking(dynamic value) {
    return copyWith(style.copyWith(tracking: value));
  }

  /// Resolves tracking styling from FlyStyle and FlyThemeData into double
  double? resolveTracking(BuildContext context) {
    return FlyTrackingUtils.resolve(context, style);
  }

  /// Applies tracking styling to a TextStyle using the resolved value
  TextStyle applyTracking(BuildContext context, TextStyle? baseStyle) {
    return FlyTrackingUtils.applyToTextStyle(context, style, baseStyle);
  }
}

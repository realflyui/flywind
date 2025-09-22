import 'package:flutter/material.dart';
import 'style.dart';

/// Utility class for handling Tailwind-like color logic
class FlyColorUtils {
  /// Resolves color from FlyStyle and FlyThemeData into Color
  static Color? resolve(BuildContext context, FlyStyle style) {
    // With typed values, we can return the color directly
    return style.color;
  }

  /// Applies color to a TextStyle
  static TextStyle applyToTextStyle(
    BuildContext context,
    FlyStyle style,
    TextStyle? baseStyle,
  ) {
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

}

/// Mixin that provides Tailwind-like color methods for any widget
mixin FlyColor<T> {
  FlyStyle get style;

  T Function(FlyStyle newStyle) get copyWith;

  /// Set text color using Color object
  T color(Color color) {
    return copyWith(style.copyWith(color: color));
  }
}

import 'package:flutter/material.dart';

import '../core/theme.dart';
import 'style.dart';
import 'value.dart';

/// Utility class for handling Tailwind-like color logic
class FlyColorUtils {
  /// Resolves color from FlyStyle and FlyThemeData into Color
  static Color? resolve(BuildContext context, FlyStyle style) {
    if (style.color == null) return null;

    try {
      final colors = FlyTheme.of(context).colors;
      return FlyValue.resolveColor(style.color, context, colors);
    } catch (e) {
      throw ArgumentError('Failed to resolve color "${style.color}": $e');
    }
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
  FlyStyle get flyStyle;

  T Function(FlyStyle newStyle) get copyWith;

  /// Set text color - accepts Color object or String (token name/hex)
  T color(dynamic value) {
    return copyWith(flyStyle.copyWith(color: value));
  }

  /// Set background color - accepts Color object or String (token name/hex)
  T bg(dynamic value) {
    return copyWith(flyStyle.copyWith(bg: value));
  }
}

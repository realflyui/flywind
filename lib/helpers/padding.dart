import 'package:flutter/material.dart';

import '../core/style.dart';
import '../core/theme.dart';
import '../tokens/spacing.dart';
import 'value.dart';

/// Utility class for handling Tailwind-like padding logic
class FlyPaddingUtils {
  /// Resolves padding from FlyStyle and FlyTheme into EdgeInsets
  static EdgeInsets resolve(BuildContext context, FlyStyle style) {
    try {
      final spacing = FlyTheme.of(context).spacing;

      return EdgeInsets.only(
        left: _resolveValue(style.pl ?? style.px ?? style.p, context, spacing),
        right: _resolveValue(style.pr ?? style.px ?? style.p, context, spacing),
        top: _resolveValue(style.pt ?? style.py ?? style.p, context, spacing),
        bottom: _resolveValue(
          style.pb ?? style.py ?? style.p,
          context,
          spacing,
        ),
      );
    } catch (e) {
      throw ArgumentError('Failed to resolve padding: $e');
    }
  }

  /// Resolves a dynamic value to double using the numeric value resolver
  static double _resolveValue(
    dynamic value,
    BuildContext context,
    FlySpacingToken tokens,
  ) {
    if (value == null) return 0;
    return FlyValue.resolveDouble(value, context, tokens);
  }

  /// Applies padding to a widget using the resolved EdgeInsets
  static Widget apply(BuildContext context, FlyStyle style, Widget child) {
    final padding = resolve(context, style);

    // If no padding is set, return the child as-is
    if (padding == EdgeInsets.zero) {
      return child;
    }

    // Apply padding using Padding widget
    return Padding(padding: padding, child: child);
  }
}

/// Mixin that provides Tailwind-like padding methods for any widget
mixin FlyPadding<T> {
  FlyStyle get flyStyle;

  T Function(FlyStyle newStyle) get copyWith;

  /// Set uniform padding - accepts int, double, or String (token name/unit)
  T p(dynamic value) {
    return copyWith(flyStyle.copyWith(p: value));
  }

  /// Set horizontal padding (left + right) - accepts int, double, or String (token name/unit)
  T px(dynamic value) {
    return copyWith(flyStyle.copyWith(px: value));
  }

  /// Set vertical padding (top + bottom) - accepts int, double, or String (token name/unit)
  T py(dynamic value) {
    return copyWith(flyStyle.copyWith(py: value));
  }

  /// Set top padding - accepts int, double, or String (token name/unit)
  T pt(dynamic value) {
    return copyWith(flyStyle.copyWith(pt: value));
  }

  /// Set right padding - accepts int, double, or String (token name/unit)
  T pr(dynamic value) {
    return copyWith(flyStyle.copyWith(pr: value));
  }

  /// Set bottom padding - accepts int, double, or String (token name/unit)
  T pb(dynamic value) {
    return copyWith(flyStyle.copyWith(pb: value));
  }

  /// Set left padding - accepts int, double, or String (token name/unit)
  T pl(dynamic value) {
    return copyWith(flyStyle.copyWith(pl: value));
  }

  /// Resolves padding from FlyStyle and FlyTheme into EdgeInsets
  EdgeInsets resolvePadding(BuildContext context) {
    return FlyPaddingUtils.resolve(context, flyStyle);
  }

  /// Applies padding to a widget using the resolved EdgeInsets
  Widget applyPadding(BuildContext context, Widget child) {
    return FlyPaddingUtils.apply(context, flyStyle, child);
  }
}

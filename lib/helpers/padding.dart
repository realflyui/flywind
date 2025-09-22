import 'package:flutter/material.dart';
import 'style.dart';
import 'spacing.dart';

/// Utility class for handling Tailwind-like padding logic
class FlyPaddingUtils {
  /// Resolves padding from FlyStyle and FlyTheme into EdgeInsets
  static EdgeInsets resolve(BuildContext context, FlyStyle style) {
    return FlySpacingUtils.resolve(
      context,
      style,
      getUniform: (s) => s.p,
      getX: (s) => s.px,
      getY: (s) => s.py,
      getLeft: (s) => s.pl,
      getRight: (s) => s.pr,
      getTop: (s) => s.pt,
      getBottom: (s) => s.pb,
    );
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
  FlyStyle get style;

  T Function(FlyStyle newStyle) get copyWith;

  /// Set uniform padding using double values
  T p(double value) {
    return copyWith(style.copyWith(p: value));
  }

  /// Set horizontal padding (left + right) using double values
  T px(double value) {
    return copyWith(style.copyWith(px: value));
  }

  /// Set vertical padding (top + bottom) using double values
  T py(double value) {
    return copyWith(style.copyWith(py: value));
  }

  /// Set top padding using double values
  T pt(double value) {
    return copyWith(style.copyWith(pt: value));
  }

  /// Set right padding using double values
  T pr(double value) {
    return copyWith(style.copyWith(pr: value));
  }

  /// Set bottom padding using double values
  T pb(double value) {
    return copyWith(style.copyWith(pb: value));
  }

  /// Set left padding using double values
  T pl(double value) {
    return copyWith(style.copyWith(pl: value));
  }

  /// Resolves padding from FlyStyle and FlyTheme into EdgeInsets
  EdgeInsets resolvePadding(BuildContext context) {
    return FlyPaddingUtils.resolve(context, style);
  }

  /// Applies padding to a widget using the resolved EdgeInsets
  Widget applyPadding(BuildContext context, Widget child) {
    return FlyPaddingUtils.apply(context, style, child);
  }
}

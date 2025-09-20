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
    return Padding(
      padding: padding,
      child: child,
    );
  }
}

/// Mixin that provides Tailwind-like padding methods for any widget
mixin FlyPadding<T> {
  FlyStyle get style;
  
  T Function(FlyStyle newStyle) get copyWith;

  /// Set uniform padding using token scale
  T p(int step) {
    return copyWith(style.copyWith(p: step));
  }

  /// Set horizontal padding (left + right) using token scale
  T px(int step) {
    return copyWith(style.copyWith(px: step));
  }

  /// Set vertical padding (top + bottom) using token scale
  T py(int step) {
    return copyWith(style.copyWith(py: step));
  }

  /// Set top padding using token scale
  T pt(int step) {
    return copyWith(style.copyWith(pt: step));
  }

  /// Set right padding using token scale
  T pr(int step) {
    return copyWith(style.copyWith(pr: step));
  }

  /// Set bottom padding using token scale
  T pb(int step) {
    return copyWith(style.copyWith(pb: step));
  }

  /// Set left padding using token scale
  T pl(int step) {
    return copyWith(style.copyWith(pl: step));
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

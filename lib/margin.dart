import 'package:flutter/material.dart';
import 'style.dart';
import 'spacing.dart';

/// Utility class for handling Tailwind-like margin logic
class FlyMarginUtils {
  /// Resolves margin from FlyStyle and FlyTheme into EdgeInsets
  static EdgeInsets resolve(BuildContext context, FlyStyle style) {
    return FlySpacingUtils.resolve(
      context,
      style,
      getUniform: (s) => s.m,
      getX: (s) => s.mx,
      getY: (s) => s.my,
      getLeft: (s) => s.ml,
      getRight: (s) => s.mr,
      getTop: (s) => s.mt,
      getBottom: (s) => s.mb,
    );
  }

  /// Applies margin to a widget using the resolved EdgeInsets
  static Widget apply(BuildContext context, FlyStyle style, Widget child) {
    final margin = resolve(context, style);
    
    // If no margin is set, return the child as-is
    if (margin == EdgeInsets.zero) {
      return child;
    }
    
    // Apply margin using Container
    return Container(
      margin: margin,
      child: child,
    );
  }
}

/// Mixin that provides Tailwind-like margin methods for any widget
mixin FlyMargin<T> {
  FlyStyle get style;
  
  T Function(FlyStyle newStyle) get copyWith;

  /// Set uniform margin using string values (e.g., "10", "100px", "1rem")
  T m(String value) {
    return copyWith(style.copyWith(m: value));
  }

  /// Set horizontal margin (left + right) using string values
  T mx(String value) {
    return copyWith(style.copyWith(mx: value));
  }

  /// Set vertical margin (top + bottom) using string values
  T my(String value) {
    return copyWith(style.copyWith(my: value));
  }

  /// Set top margin using string values
  T mt(String value) {
    return copyWith(style.copyWith(mt: value));
  }

  /// Set right margin using string values
  T mr(String value) {
    return copyWith(style.copyWith(mr: value));
  }

  /// Set bottom margin using string values
  T mb(String value) {
    return copyWith(style.copyWith(mb: value));
  }

  /// Set left margin using string values
  T ml(String value) {
    return copyWith(style.copyWith(ml: value));
  }

  /// Resolves margin from FlyStyle and FlyTheme into EdgeInsets
  EdgeInsets resolveMargin(BuildContext context) {
    return FlyMarginUtils.resolve(context, style);
  }

  /// Applies margin to a widget using the resolved EdgeInsets
  Widget applyMargin(BuildContext context, Widget child) {
    return FlyMarginUtils.apply(context, style, child);
  }
}

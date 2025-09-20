import 'package:flutter/material.dart';
import 'tw_style.dart';
import 'tw_spacing.dart';

/// Utility class for handling Tailwind-like margin logic
class TwMarginUtils {
  /// Resolves margin from TwStyle and TwTheme into EdgeInsets
  static EdgeInsets resolve(BuildContext context, TwStyle style) {
    return TwSpacing.resolve(
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
  static Widget apply(BuildContext context, TwStyle style, Widget child) {
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
mixin TwMargin<T> {
  TwStyle get style;
  
  T Function(TwStyle newStyle) get copyWith;

  /// Set uniform margin using token scale
  T m(int step) {
    return copyWith(style.copyWith(m: step));
  }

  /// Set horizontal margin (left + right) using token scale
  T mx(int step) {
    return copyWith(style.copyWith(mx: step));
  }

  /// Set vertical margin (top + bottom) using token scale
  T my(int step) {
    return copyWith(style.copyWith(my: step));
  }

  /// Set top margin using token scale
  T mt(int step) {
    return copyWith(style.copyWith(mt: step));
  }

  /// Set right margin using token scale
  T mr(int step) {
    return copyWith(style.copyWith(mr: step));
  }

  /// Set bottom margin using token scale
  T mb(int step) {
    return copyWith(style.copyWith(mb: step));
  }

  /// Set left margin using token scale
  T ml(int step) {
    return copyWith(style.copyWith(ml: step));
  }

  /// Resolves margin from TwStyle and TwTheme into EdgeInsets
  EdgeInsets resolveMargin(BuildContext context) {
    return TwMarginUtils.resolve(context, style);
  }

  /// Applies margin to a widget using the resolved EdgeInsets
  Widget applyMargin(BuildContext context, Widget child) {
    return TwMarginUtils.apply(context, style, child);
  }
}

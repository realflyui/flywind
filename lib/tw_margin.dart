import 'package:flutter/material.dart';
import 'tw_style.dart';
import 'tw_spacing.dart';

/// Utility class for handling Tailwind-like margin logic
class TwMargin {
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

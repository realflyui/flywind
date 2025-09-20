import 'package:flutter/material.dart';
import 'tw_style.dart';
import 'tw_spacing.dart';

/// Utility class for handling Tailwind-like padding logic
class TwPadding {
  /// Resolves padding from TwStyle and TwTheme into EdgeInsets
  static EdgeInsets resolve(BuildContext context, TwStyle style) {
    return TwSpacing.resolve(
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
  static Widget apply(BuildContext context, TwStyle style, Widget child) {
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

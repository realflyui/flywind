import 'package:flutter/material.dart';
import 'tw_theme.dart';
import 'tw_style.dart';

/// Utility class for handling Tailwind-like padding logic
class TwPadding {
  /// Resolves padding from TwStyle and TwTheme into EdgeInsets
  static EdgeInsets resolve(BuildContext context, TwStyle style) {
    final theme = TwTheme.of(context);
    final spacing = theme.spacing;
    
    // Calculate padding values
    double left = 0;
    double right = 0;
    double top = 0;
    double bottom = 0;
    
    // Apply uniform padding
    if (style.p != null) {
      final value = spacing[style.p] ?? 0.0;
      left = right = top = bottom = value;
    }
    
    // Apply directional padding (these override uniform padding)
    if (style.px != null) {
      final value = spacing[style.px] ?? 0.0;
      left = right = value;
    }
    if (style.py != null) {
      final value = spacing[style.py] ?? 0.0;
      top = bottom = value;
    }
    if (style.pl != null) {
      left = spacing[style.pl] ?? 0.0;
    }
    if (style.pr != null) {
      right = spacing[style.pr] ?? 0.0;
    }
    if (style.pt != null) {
      top = spacing[style.pt] ?? 0.0;
    }
    if (style.pb != null) {
      bottom = spacing[style.pb] ?? 0.0;
    }
    
    return EdgeInsets.only(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
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

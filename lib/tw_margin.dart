import 'package:flutter/material.dart';
import 'tw_theme.dart';
import 'tw_style.dart';

/// Utility class for handling Tailwind-like margin logic
class TwMargin {
  /// Resolves margin from TwStyle and TwTheme into EdgeInsets
  static EdgeInsets resolve(BuildContext context, TwStyle style) {
    final theme = TwTheme.of(context);
    final spacing = theme.spacing;
    
    // Calculate margin values
    double left = 0;
    double right = 0;
    double top = 0;
    double bottom = 0;
    
    // Apply uniform margin
    if (style.m != null) {
      final value = spacing[style.m] ?? 0.0;
      left = right = top = bottom = value;
    }
    
    // Apply directional margins (these override uniform margin)
    if (style.mx != null) {
      final value = spacing[style.mx] ?? 0.0;
      left = right = value;
    }
    if (style.my != null) {
      final value = spacing[style.my] ?? 0.0;
      top = bottom = value;
    }
    if (style.ml != null) {
      left = spacing[style.ml] ?? 0.0;
    }
    if (style.mr != null) {
      right = spacing[style.mr] ?? 0.0;
    }
    if (style.mt != null) {
      top = spacing[style.mt] ?? 0.0;
    }
    if (style.mb != null) {
      bottom = spacing[style.mb] ?? 0.0;
    }
    
    return EdgeInsets.only(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
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

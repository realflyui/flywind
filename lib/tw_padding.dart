import 'package:flutter/material.dart';
import 'tw_theme.dart';
import 'tw_style.dart';

/// Utility class for handling Tailwind-like padding logic
class TwPadding {
  /// Resolves padding from TwStyle and TwTheme into EdgeInsets
  static EdgeInsets resolve(BuildContext context, TwStyle style) {
    final theme = TwTheme.of(context);
    
    // Check if we have any padding set
    if (style.px == null && style.py == null && style.padding == null && 
        style.pt == null && style.pr == null && style.pb == null && style.pl == null) {
      return EdgeInsets.zero;
    }
    
    // Check if we have any directional padding (px, py, pt, pr, pb, pl)
    final hasDirectionalPadding = style.px != null || style.py != null || 
        style.pt != null || style.pr != null || style.pb != null || style.pl != null;
    
    if (hasDirectionalPadding) {
      // Use specific directional padding
      // Start with uniform padding as base, then override with directional values
      final uniformValue = style.padding != null ? theme.spacing[style.padding!] ?? 0.0 : 0.0;
      
      final left = style.pl != null ? theme.spacing[style.pl!] ?? 0.0 : 
                  style.px != null ? theme.spacing[style.px!] ?? 0.0 : uniformValue;
      final right = style.pr != null ? theme.spacing[style.pr!] ?? 0.0 : 
                   style.px != null ? theme.spacing[style.px!] ?? 0.0 : uniformValue;
      final top = style.pt != null ? theme.spacing[style.pt!] ?? 0.0 : 
                 style.py != null ? theme.spacing[style.py!] ?? 0.0 : uniformValue;
      final bottom = style.pb != null ? theme.spacing[style.pb!] ?? 0.0 : 
                    style.py != null ? theme.spacing[style.py!] ?? 0.0 : uniformValue;
      
      return EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      );
    } else {
      // Use uniform padding only
      final paddingValue = theme.spacing[style.padding!] ?? 0.0;
      return EdgeInsets.all(paddingValue);
    }
  }
  
  /// Applies padding to a widget using the resolved EdgeInsets
  static Widget apply(BuildContext context, TwStyle style, Widget child) {
    final padding = resolve(context, style);
    
    if (padding == EdgeInsets.zero) {
      return child;
    }
    
    return Padding(
      padding: padding,
      child: child,
    );
  }
}

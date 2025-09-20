import 'package:flutter/material.dart';
import 'tw_theme.dart';
import 'tw_style.dart';

/// Common spacing utilities for padding and margin
class TwSpacing {
  /// Resolves spacing from TwStyle and TwTheme into EdgeInsets
  static EdgeInsets resolve(BuildContext context, TwStyle style, {
    required int? Function(TwStyle) getUniform,
    required int? Function(TwStyle) getX,
    required int? Function(TwStyle) getY,
    required int? Function(TwStyle) getLeft,
    required int? Function(TwStyle) getRight,
    required int? Function(TwStyle) getTop,
    required int? Function(TwStyle) getBottom,
  }) {
    final theme = TwTheme.of(context);
    final spacing = theme.spacing;
    
    // Calculate spacing values
    double left = 0;
    double right = 0;
    double top = 0;
    double bottom = 0;
    
    // Apply uniform spacing
    final uniformValue = getUniform(style);
    if (uniformValue != null) {
      final value = spacing[uniformValue] ?? 0.0;
      left = right = top = bottom = value;
    }
    
    // Apply directional spacing (these override uniform spacing)
    final xValue = getX(style);
    if (xValue != null) {
      final value = spacing[xValue] ?? 0.0;
      left = right = value;
    }
    final yValue = getY(style);
    if (yValue != null) {
      final value = spacing[yValue] ?? 0.0;
      top = bottom = value;
    }
    final leftValue = getLeft(style);
    if (leftValue != null) {
      left = spacing[leftValue] ?? 0.0;
    }
    final rightValue = getRight(style);
    if (rightValue != null) {
      right = spacing[rightValue] ?? 0.0;
    }
    final topValue = getTop(style);
    if (topValue != null) {
      top = spacing[topValue] ?? 0.0;
    }
    final bottomValue = getBottom(style);
    if (bottomValue != null) {
      bottom = spacing[bottomValue] ?? 0.0;
    }
    
    return EdgeInsets.only(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
    );
  }
}

import 'package:flutter/material.dart';
import 'style.dart';

/// Common spacing utilities for padding and margin
class FlySpacingUtils {
  /// Resolves spacing from FlyStyle and FlyThemeData into EdgeInsets
  static EdgeInsets resolve(
    BuildContext context,
    FlyStyle style, {
    required double? Function(FlyStyle) getUniform,
    required double? Function(FlyStyle) getX,
    required double? Function(FlyStyle) getY,
    required double? Function(FlyStyle) getLeft,
    required double? Function(FlyStyle) getRight,
    required double? Function(FlyStyle) getTop,
    required double? Function(FlyStyle) getBottom,
  }) {
    // Calculate spacing values
    double left = 0;
    double right = 0;
    double top = 0;
    double bottom = 0;

    // Apply uniform spacing
    final uniformValue = getUniform(style);
    if (uniformValue != null) {
      left = right = top = bottom = uniformValue;
    }

    // Apply directional spacing (these override uniform spacing)
    final xValue = getX(style);
    if (xValue != null) {
      left = right = xValue;
    }
    final yValue = getY(style);
    if (yValue != null) {
      top = bottom = yValue;
    }
    final leftValue = getLeft(style);
    if (leftValue != null) {
      left = leftValue;
    }
    final rightValue = getRight(style);
    if (rightValue != null) {
      right = rightValue;
    }
    final topValue = getTop(style);
    if (topValue != null) {
      top = topValue;
    }
    final bottomValue = getBottom(style);
    if (bottomValue != null) {
      bottom = bottomValue;
    }

    return EdgeInsets.only(left: left, right: right, top: top, bottom: bottom);
  }

}

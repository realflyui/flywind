import 'package:flutter/material.dart';
import 'tokens.dart';
import 'style.dart';
import 'theme.dart';

/// Common spacing utilities for padding and margin
class FlySpacingUtils {
  /// Resolves spacing from FlyStyle and FlyConfig into EdgeInsets
  static EdgeInsets resolve(BuildContext context, FlyStyle style, {
    required int? Function(FlyStyle) getUniform,
    required int? Function(FlyStyle) getX,
    required int? Function(FlyStyle) getY,
    required int? Function(FlyStyle) getLeft,
    required int? Function(FlyStyle) getRight,
    required int? Function(FlyStyle) getTop,
    required int? Function(FlyStyle) getBottom,
  }) {
    final theme = Theme.of(context);
    final flywind = theme.extension<FlyTheme>();
    if (flywind == null) {
      throw FlutterError('FlyTheme extension not found. Make sure to add FlyTheme to your ThemeData.extensions');
    }
    final spacing = flywind.spacing;
    
    // Calculate spacing values
    double left = 0;
    double right = 0;
    double top = 0;
    double bottom = 0;
    
    // Apply uniform spacing
    final uniformValue = getUniform(style);
    if (uniformValue != null) {
      final value = _getSpacingValue(spacing, uniformValue, 'uniform');
      left = right = top = bottom = value;
    }
    
    // Apply directional spacing (these override uniform spacing)
    final xValue = getX(style);
    if (xValue != null) {
      final value = _getSpacingValue(spacing, xValue, 'horizontal');
      left = right = value;
    }
    final yValue = getY(style);
    if (yValue != null) {
      final value = _getSpacingValue(spacing, yValue, 'vertical');
      top = bottom = value;
    }
    final leftValue = getLeft(style);
    if (leftValue != null) {
      left = _getSpacingValue(spacing, leftValue, 'left');
    }
    final rightValue = getRight(style);
    if (rightValue != null) {
      right = _getSpacingValue(spacing, rightValue, 'right');
    }
    final topValue = getTop(style);
    if (topValue != null) {
      top = _getSpacingValue(spacing, topValue, 'top');
    }
    final bottomValue = getBottom(style);
    if (bottomValue != null) {
      bottom = _getSpacingValue(spacing, bottomValue, 'bottom');
    }
    
    return EdgeInsets.only(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
    );
  }

  /// Gets spacing value with error handling for invalid keys
  static double _getSpacingValue(FlySpacing spacing, int key, String direction) {
    final value = spacing[key];
    
    if (value == null) {
      _handleMissingSpacing(key, direction, spacing.values.keys.toList());
      return 0.0;
    }
    
    return value;
  }

  /// Handles missing spacing errors with helpful messages
  static void _handleMissingSpacing(int spacingKey, String direction, List<int> availableKeys) {
    final sortedKeys = availableKeys.toList()..sort();
    
    String errorMessage = 'Spacing key "$spacingKey" not found in FlyConfig for $direction spacing. Available spacing keys: ${sortedKeys.join(', ')}.';
    
    // In debug mode, throw an assertion error with helpful message
    assert(false, errorMessage);
    
    // In release mode, print a warning
    print('⚠️ FlySpacing Warning: $errorMessage');
  }
}

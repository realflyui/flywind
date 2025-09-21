import 'package:flutter/material.dart';
import 'style.dart';
import 'unit_parser.dart';

/// Common spacing utilities for padding and margin
class FlySpacingUtils {
  /// Resolves spacing from FlyStyle and FlyConfig into EdgeInsets
  static EdgeInsets resolve(BuildContext context, FlyStyle style, {
    required String? Function(FlyStyle) getUniform,
    required String? Function(FlyStyle) getX,
    required String? Function(FlyStyle) getY,
    required String? Function(FlyStyle) getLeft,
    required String? Function(FlyStyle) getRight,
    required String? Function(FlyStyle) getTop,
    required String? Function(FlyStyle) getBottom,
  }) {
    // Calculate spacing values
    double left = 0;
    double right = 0;
    double top = 0;
    double bottom = 0;
    
    // Apply uniform spacing
    final uniformValue = getUniform(style);
    if (uniformValue != null) {
      final value = _parseSpacingValue(uniformValue, 'uniform');
      left = right = top = bottom = value;
    }
    
    // Apply directional spacing (these override uniform spacing)
    final xValue = getX(style);
    if (xValue != null) {
      final value = _parseSpacingValue(xValue, 'horizontal');
      left = right = value;
    }
    final yValue = getY(style);
    if (yValue != null) {
      final value = _parseSpacingValue(yValue, 'vertical');
      top = bottom = value;
    }
    final leftValue = getLeft(style);
    if (leftValue != null) {
      left = _parseSpacingValue(leftValue, 'left');
    }
    final rightValue = getRight(style);
    if (rightValue != null) {
      right = _parseSpacingValue(rightValue, 'right');
    }
    final topValue = getTop(style);
    if (topValue != null) {
      top = _parseSpacingValue(topValue, 'top');
    }
    final bottomValue = getBottom(style);
    if (bottomValue != null) {
      bottom = _parseSpacingValue(bottomValue, 'bottom');
    }
    
    return EdgeInsets.only(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
    );
  }

  /// Parses spacing value from string with fallback to token scale
  static double _parseSpacingValue(String value, String direction) {
    // First try to parse as a direct unit value (px, rem, em, %, etc.)
    final parsedValue = FlyUnitParser.parse(value);
    if (parsedValue != null) {
      return parsedValue;
    }
    
    // If parsing fails, try to treat it as a token scale index
    final tokenIndex = int.tryParse(value);
    if (tokenIndex != null) {
      // For backward compatibility, we could still support token scale
      // but for now, we'll just return 0 and show a warning
      _handleInvalidSpacingValue(value, direction);
      return 0.0;
    }
    
    // If all parsing fails, show error and return 0
    _handleInvalidSpacingValue(value, direction);
    return 0.0;
  }

  /// Handles invalid spacing values with helpful messages
  static void _handleInvalidSpacingValue(String value, String direction) {
    String errorMessage = 'Invalid spacing value "$value" for $direction spacing. '
        'Supported formats: "10", "10px", "1rem", "1em", "50%", etc.';
    
    // In debug mode, throw an assertion error with helpful message
    assert(false, errorMessage);
    
    // In release mode, print a warning
    print('⚠️ FlySpacing Warning: $errorMessage');
  }
}

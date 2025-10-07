import 'package:flutter/material.dart';
import '../core/theme.dart';

/// Utility class for handling font weight resolution
class FlyFontWeightUtils {
  /// Resolves font weight from string token or FontWeight to FontWeight
  static FontWeight? resolve(BuildContext context, dynamic value) {
    if (value == null) return null;

    // If it's already a FontWeight, return it directly
    if (value is FontWeight) {
      return value;
    }

    // Otherwise, resolve as string token
    if (value is String) {
      try {
        final fontWeights = FlyTheme.of(context).fontWeight;
        return fontWeights[value];
      } catch (e) {
        throw ArgumentError('Failed to resolve font weight "$value": $e');
      }
    }

    throw ArgumentError(
      'Font weight must be a String or FontWeight, got ${value.runtimeType}',
    );
  }
}

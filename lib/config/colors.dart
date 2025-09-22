// GENERATED FILE - DO NOT EDIT MANUALLY
// To regenerate, run: dart cli/generate_config.dart

import 'package:flutter/material.dart';
import '../tokens/color.dart';

/// Custom colors that provide dot notation access to custom color values
class CustomColors {
  const CustomColors._();

  /// Custom color: test
  static const Color test = Color(0xFFFF0000);

  /// Create default custom colors as FlyColorToken
  static FlyColorToken defaultColors() {
    return FlyColorToken.defaultColor().copyWith(
      extras: {
        'test': Color(0xFFFF0000),
      },
    );
  }
}

/// Extension methods for FlyColorToken to provide dot notation access
extension FlyColorTokenExtensions on FlyColorToken {
  /// Custom color: test
  Color get test => extras['test'] ?? Color(0xFFFF0000);
}

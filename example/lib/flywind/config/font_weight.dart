// GENERATED FILE - DO NOT EDIT MANUALLY
// To regenerate, run: dart run flywind:fly generate

import 'package:flutter/material.dart';
import 'package:flywind/tokens/font_weight.dart';

/// Custom font weight that provide dot notation access to custom font weight values
class CustomFontWeight {
  const CustomFontWeight._();

  /// Custom font weight: test
  static const FontWeight test = FontWeight.w900;

  /// Create default custom font weight as FlyFontWeightToken
  static FlyFontWeightToken defaultFontWeight() {
    return FlyFontWeightToken.defaultFontWeight().copyWith(
      extras: {'test': FontWeight.w900},
    );
  }
}

/// Extension methods for FlyFontWeightToken to provide dot notation access
extension FlyFontWeightTokenExtensions on FlyFontWeightToken {
  /// Custom font weight: test
  FontWeight get test => extras['test'] ?? FontWeight.w900;
}

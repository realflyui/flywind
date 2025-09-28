// GENERATED FILE - DO NOT EDIT MANUALLY
// To regenerate, run: dart run flywind:fly generate

import 'package:flutter/material.dart';
import 'package:flywind/tokens/text_style.dart';

/// Custom text style that provide dot notation access to custom text style values
class CustomTextStyle {
  const CustomTextStyle._();

  /// Custom text style: test
  static const TextStyle test = TextStyle(fontSize: 16.0, height: 1.5);

  /// Create default custom text style as FlyTextStyleToken
  static FlyTextStyleToken defaultTextStyle() {
    return FlyTextStyleToken.defaultTextStyle().copyWith(
      extras: {'test': TextStyle(fontSize: 16.0, height: 1.5)},
    );
  }
}

/// Extension methods for FlyTextStyleToken to provide dot notation access
extension FlyTextStyleTokenExtensions on FlyTextStyleToken {
  /// Custom text style: test
  TextStyle get test =>
      extras['test'] ?? TextStyle(fontSize: 16.0, height: 1.5);
}

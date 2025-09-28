// GENERATED FILE - DO NOT EDIT MANUALLY
// To regenerate, run: dart run flywind:fly generate

import 'package:flywind/tokens/spacing.dart';

/// Custom spacing that provide dot notation access to custom spacing values
class CustomSpacing {
  const CustomSpacing._();

  /// Custom spacing: test
  static const double test = 99.0;

  /// Create default custom spacing as FlySpacingToken
  static FlySpacingToken defaultSpacing() {
    return FlySpacingToken.defaultSpacing().copyWith(extras: {'test': 99.0});
  }
}

/// Extension methods for FlySpacingToken to provide dot notation access
extension FlySpacingTokenExtensions on FlySpacingToken {
  /// Custom spacing: test
  double get test => extras['test'] ?? 99.0;
}

// GENERATED FILE - DO NOT EDIT MANUALLY
// To regenerate, run: dart cli/generate_config.dart

import '../tokens/radius.dart';

/// Custom radius that provide dot notation access to custom radius values
class CustomRadius {
  const CustomRadius._();

  /// Custom radius: test
  static const double test = 99.0;

  /// Create default custom radius as FlyRadiusToken
  static FlyRadiusToken defaultRadius() {
    return FlyRadiusToken.defaultRadius().copyWith(
      extras: {
        'test': 99.0,
      },
    );
  }
}

/// Extension methods for FlyRadiusToken to provide dot notation access
extension FlyRadiusTokenExtensions on FlyRadiusToken {
  /// Custom radius: test
  double get test => extras['test'] ?? 99.0;
}

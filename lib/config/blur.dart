// GENERATED FILE - DO NOT EDIT MANUALLY
// To regenerate, run: dart cli/generate_config.dart

import '../tokens/blur.dart';

/// Custom blur that provide dot notation access to custom blur values
class CustomBlur {
  const CustomBlur._();

  /// Custom blur: test
  static const double test = 99.0;

  /// Create default custom blur as FlyBlurToken
  static FlyBlurToken defaultBlur() {
    return FlyBlurToken.defaultBlur().copyWith(
      extras: {
        'test': 99.0,
      },
    );
  }
}

/// Extension methods for FlyBlurToken to provide dot notation access
extension FlyBlurTokenExtensions on FlyBlurToken {
  /// Custom blur: test
  double get test => extras['test'] ?? 99.0;
}

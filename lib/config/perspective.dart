// GENERATED FILE - DO NOT EDIT MANUALLY
// To regenerate, run: dart cli/generate_config.dart

import '../tokens/perspective.dart';

/// Custom perspective that provide dot notation access to custom perspective values
class CustomPerspective {
  const CustomPerspective._();

  /// Custom perspective: test
  static const double test = 999.0;

  /// Create default custom perspective as FlyPerspectiveToken
  static FlyPerspectiveToken defaultPerspective() {
    return FlyPerspectiveToken.defaultPerspective().copyWith(
      extras: {
        'test': 999.0,
      },
    );
  }
}

/// Extension methods for FlyPerspectiveToken to provide dot notation access
extension FlyPerspectiveTokenExtensions on FlyPerspectiveToken {
  /// Custom perspective: test
  double get test => extras['test'] ?? 999.0;
}

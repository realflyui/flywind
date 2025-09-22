// GENERATED FILE - DO NOT EDIT MANUALLY
// To regenerate, run: dart cli/generate_config.dart

import '../tokens/tracking.dart';

/// Custom tracking that provide dot notation access to custom tracking values
class CustomTracking {
  const CustomTracking._();

  /// Custom tracking: test
  static const double test = 0.99;

  /// Create default custom tracking as FlyTrackingToken
  static FlyTrackingToken defaultTracking() {
    return FlyTrackingToken.defaultTracking().copyWith(
      extras: {
        'test': 0.99,
      },
    );
  }
}

/// Extension methods for FlyTrackingToken to provide dot notation access
extension FlyTrackingTokenExtensions on FlyTrackingToken {
  /// Custom tracking: test
  double get test => extras['test'] ?? 0.99;
}

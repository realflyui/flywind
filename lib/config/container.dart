// GENERATED FILE - DO NOT EDIT MANUALLY
// To regenerate, run: dart cli/generate_config.dart

import '../tokens/container.dart';

/// Custom container that provide dot notation access to custom container values
class CustomContainer {
  const CustomContainer._();

  /// Custom container: test
  static const double test = 999.0;

  /// Create default custom container as FlyContainerToken
  static FlyContainerToken defaultContainer() {
    return FlyContainerToken.defaultContainer().copyWith(
      extras: {
        'test': 999.0,
      },
    );
  }
}

/// Extension methods for FlyContainerToken to provide dot notation access
extension FlyContainerTokenExtensions on FlyContainerToken {
  /// Custom container: test
  double get test => extras['test'] ?? 999.0;
}

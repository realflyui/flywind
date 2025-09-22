// GENERATED FILE - DO NOT EDIT MANUALLY
// To regenerate, run: dart cli/generate_config.dart

import '../tokens/breakpoint.dart';

/// Custom breakpoint that provide dot notation access to custom breakpoint values
class CustomBreakpoint {
  const CustomBreakpoint._();

  /// Custom breakpoint: test
  static const double test = 999.0;

  /// Create default custom breakpoint as FlyBreakpointToken
  static FlyBreakpointToken defaultBreakpoint() {
    return FlyBreakpointToken.defaultBreakpoint().copyWith(
      extras: {
        'test': 999.0,
      },
    );
  }
}

/// Extension methods for FlyBreakpointToken to provide dot notation access
extension FlyBreakpointTokenExtensions on FlyBreakpointToken {
  /// Custom breakpoint: test
  double get test => extras['test'] ?? 999.0;
}

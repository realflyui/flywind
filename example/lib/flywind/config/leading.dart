// GENERATED FILE - DO NOT EDIT MANUALLY
// To regenerate, run: dart run flywind:fly generate


import 'package:flywind/tokens/leading.dart';

/// Custom leading that provide dot notation access to custom leading values
class CustomLeading {
  const CustomLeading._();

  /// Custom leading: test
  static const double test = 9.9;

  /// Create default custom leading as FlyLeadingToken
  static FlyLeadingToken defaultLeading() {
    return FlyLeadingToken.defaultLeading().copyWith(
      extras: {
        'test': 9.9,
      },
    );
  }
}

/// Extension methods for FlyLeadingToken to provide dot notation access
extension FlyLeadingTokenExtensions on FlyLeadingToken {
  /// Custom leading: test
  double get test => extras['test'] ?? 9.9;
}

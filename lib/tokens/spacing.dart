import 'package:flutter/material.dart';

/// Spacing scale class with type-safe access to spacing values
class FlySpacing {
  const FlySpacing({
    required this.s0,
    required this.s1,
    required this.s2,
    required this.s3,
    required this.s4,
    required this.s5,
    required this.s6,
    required this.s7,
    required this.s8,
    required this.s9,
    required this.s10,
    required this.s11,
    required this.s12,
    this.customSpacing = const {},
  });

  final String s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12;
  final Map<String, String> customSpacing;

  /// Get all spacing values as a map
  Map<int, String> get values => {
    0: s0, 1: s1, 2: s2, 3: s3, 4: s4, 5: s5,
    6: s6, 7: s7, 8: s8, 9: s9, 10: s10, 11: s11, 12: s12,
  };
  
  /// Access spacing values by index (0-12)
  String? operator [](int index) => values[index];

  /// Default spacing scale (0-12 steps)
  static const FlySpacing defaultSpacing = FlySpacing(
    s0: '0', s1: '4', s2: '8', s3: '12', s4: '16', s5: '20',
    s6: '24', s7: '28', s8: '32', s9: '36', s10: '40', s11: '44', s12: '48',
  );

  /// Create a new FlySpacing instance with custom spacing overrides
  FlySpacing copyWith({
    Map<String, String>? customSpacing,
  }) {
    return FlySpacing(
      s0: s0, s1: s1, s2: s2, s3: s3, s4: s4, s5: s5,
      s6: s6, s7: s7, s8: s8, s9: s9, s10: s10, s11: s11, s12: s12,
      customSpacing: customSpacing ?? this.customSpacing,
    );
  }
}

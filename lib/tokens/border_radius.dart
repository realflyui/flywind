import 'package:flutter/material.dart';

/// Border radius scale class with type-safe access to radius values
class FlyBorderRadius {
  const FlyBorderRadius({
    required this.none, required this.sm, required this.md, required this.lg, required this.xl,
    required this.xl2, required this.xl3, required this.full, required this.defaultRadius,
    this.customBorderRadius = const {},
  });

  final double none, sm, md, lg, xl, xl2, xl3, full, defaultRadius;
  final Map<String, double> customBorderRadius;

  /// Get all border radius values as a map
  Map<String, double> get values => {
    'none': none, 'sm': sm, 'md': md, 'lg': lg, 'xl': xl,
    '2xl': xl2, '3xl': xl3, 'full': full, '': defaultRadius,
    ...customBorderRadius,
  };
  
  /// Access border radius values by key
  double? operator [](String key) => values[key];

  /// Create a copy with updated values
  FlyBorderRadius copyWith({
    double? none, double? sm, double? md, double? lg, double? xl,
    double? xl2, double? xl3, double? full, double? defaultRadius,
    Map<String, double>? customBorderRadius,
  }) {
    return FlyBorderRadius(
      none: none ?? this.none, sm: sm ?? this.sm, md: md ?? this.md, lg: lg ?? this.lg, xl: xl ?? this.xl,
      xl2: xl2 ?? this.xl2, xl3: xl3 ?? this.xl3, full: full ?? this.full, defaultRadius: defaultRadius ?? this.defaultRadius,
      customBorderRadius: customBorderRadius ?? this.customBorderRadius,
    );
  }

  /// Default border radius scale matching Tailwind CSS
  static const FlyBorderRadius defaultBorderRadius = FlyBorderRadius(
    none: 0.0, sm: 2.0, md: 6.0, lg: 8.0, xl: 12.0,
    xl2: 16.0, xl3: 24.0, full: 9999.0, defaultRadius: 4.0,
  );
}

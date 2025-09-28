// GENERATED FILE - DO NOT EDIT MANUALLY
// To regenerate, run: dart cli/generate_defaults.dart

import 'package:flutter/material.dart';
import '../core/token.dart';

/// Text style values with fontSize and height
class FlyTextStyleToken implements FlyToken<TextStyle> {
  const FlyTextStyleToken({
    required this.xs,
    required this.sm,
    required this.base,
    required this.lg,
    required this.xl,
    required this.xl2,
    required this.xl3,
    required this.xl4,
    required this.xl5,
    required this.xl6,
    required this.xl7,
    required this.xl8,
    required this.xl9,
    this.extras = const {},
  });

  /// xs Text style values with fontSize and height
  final TextStyle xs;

  /// sm Text style values with fontSize and height
  final TextStyle sm;

  /// base Text style values with fontSize and height
  final TextStyle base;

  /// lg Text style values with fontSize and height
  final TextStyle lg;

  /// xl Text style values with fontSize and height
  final TextStyle xl;

  /// 2xl Text style values with fontSize and height
  final TextStyle xl2;

  /// 3xl Text style values with fontSize and height
  final TextStyle xl3;

  /// 4xl Text style values with fontSize and height
  final TextStyle xl4;

  /// 5xl Text style values with fontSize and height
  final TextStyle xl5;

  /// 6xl Text style values with fontSize and height
  final TextStyle xl6;

  /// 7xl Text style values with fontSize and height
  final TextStyle xl7;

  /// 8xl Text style values with fontSize and height
  final TextStyle xl8;

  /// 9xl Text style values with fontSize and height
  final TextStyle xl9;

  /// Additional custom values
  final Map<String, TextStyle> extras;

  /// All values in a single map for easier iteration
  Map<String, TextStyle> get _allValues => {
    'xs': xs,
    'sm': sm,
    'base': base,
    'lg': lg,
    'xl': xl,
    'xl2': xl2,
    'xl3': xl3,
    'xl4': xl4,
    'xl5': xl5,
    'xl6': xl6,
    'xl7': xl7,
    'xl8': xl8,
    'xl9': xl9,
    ...extras,
  };

  /// Access value by key (canonical or extra)
  @override
  TextStyle? operator [](String key) => _allValues[key];

  /// Get all available keys (canonical + extras)
  @override
  Iterable<String> get keys => _allValues.keys;

  /// Put a new value for the given key
  @override
  FlyTextStyleToken put(String key, TextStyle value) {
    switch (key) {
      case 'xs':
        return copyWith(xs: value);
      case 'sm':
        return copyWith(sm: value);
      case 'base':
        return copyWith(base: value);
      case 'lg':
        return copyWith(lg: value);
      case 'xl':
        return copyWith(xl: value);
      case 'xl2':
        return copyWith(xl2: value);
      case 'xl3':
        return copyWith(xl3: value);
      case 'xl4':
        return copyWith(xl4: value);
      case 'xl5':
        return copyWith(xl5: value);
      case 'xl6':
        return copyWith(xl6: value);
      case 'xl7':
        return copyWith(xl7: value);
      case 'xl8':
        return copyWith(xl8: value);
      case 'xl9':
        return copyWith(xl9: value);
      default:
        final newExtras = Map<String, TextStyle>.from(extras);
        newExtras[key] = value;
        return copyWith(extras: newExtras);
    }
  }

  /// Merge another token into this one (right side wins)
  @override
  FlyTextStyleToken merge(FlyToken<TextStyle> other) {
    if (other is! FlyTextStyleToken) return this;

    return copyWith(
      xs: other.xs,
      sm: other.sm,
      base: other.base,
      lg: other.lg,
      xl: other.xl,
      xl2: other.xl2,
      xl3: other.xl3,
      xl4: other.xl4,
      xl5: other.xl5,
      xl6: other.xl6,
      xl7: other.xl7,
      xl8: other.xl8,
      xl9: other.xl9,
      extras: {...extras, ...other.extras},
    );
  }

  /// Create a copy with updated values
  FlyTextStyleToken copyWith({
    TextStyle? xs,
    TextStyle? sm,
    TextStyle? base,
    TextStyle? lg,
    TextStyle? xl,
    TextStyle? xl2,
    TextStyle? xl3,
    TextStyle? xl4,
    TextStyle? xl5,
    TextStyle? xl6,
    TextStyle? xl7,
    TextStyle? xl8,
    TextStyle? xl9,
    Map<String, TextStyle>? extras,
  }) {
    return FlyTextStyleToken(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      base: base ?? this.base,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xl2: xl2 ?? this.xl2,
      xl3: xl3 ?? this.xl3,
      xl4: xl4 ?? this.xl4,
      xl5: xl5 ?? this.xl5,
      xl6: xl6 ?? this.xl6,
      xl7: xl7 ?? this.xl7,
      xl8: xl8 ?? this.xl8,
      xl9: xl9 ?? this.xl9,
      extras: extras ?? this.extras,
    );
  }

  /// Linear interpolation between two tokens
  FlyTextStyleToken lerp(FlyTextStyleToken other, double t) {
    final result = <String, TextStyle>{};
    final allKeys = {..._allValues.keys, ...other._allValues.keys};

    for (final key in allKeys) {
      final valueA = _allValues[key];
      final valueB = other._allValues[key];
      if (valueA != null && valueB != null) {
        result[key] = TextStyle.lerp(valueA, valueB, t) ?? valueA;
      } else if (valueA != null) {
        result[key] = valueA;
      } else if (valueB != null) {
        result[key] = valueB;
      }
    }

    return FlyTextStyleToken(
      xs: result['xs']!,
      sm: result['sm']!,
      base: result['base']!,
      lg: result['lg']!,
      xl: result['xl']!,
      xl2: result['xl2']!,
      xl3: result['xl3']!,
      xl4: result['xl4']!,
      xl5: result['xl5']!,
      xl6: result['xl6']!,
      xl7: result['xl7']!,
      xl8: result['xl8']!,
      xl9: result['xl9']!,
      extras: Map.fromEntries(
        result.entries.where(
          (e) => ![
            'xs',
            'sm',
            'base',
            'lg',
            'xl',
            'xl2',
            'xl3',
            'xl4',
            'xl5',
            'xl6',
            'xl7',
            'xl8',
            'xl9',
          ].contains(e.key),
        ),
      ),
    );
  }

  /// Create default values
  static FlyTextStyleToken defaultTextStyle() {
    return const FlyTextStyleToken(
      xs: TextStyle(fontSize: 12, height: 1.3333333333333333),
      sm: TextStyle(fontSize: 14, height: 1.4285714285714286),
      base: TextStyle(fontSize: 16, height: 1.5),
      lg: TextStyle(fontSize: 18, height: 1.5555555555555556),
      xl: TextStyle(fontSize: 20, height: 1.4),
      xl2: TextStyle(fontSize: 24, height: 1.3333333333333333),
      xl3: TextStyle(fontSize: 30, height: 1.2),
      xl4: TextStyle(fontSize: 36, height: 1.1111111111111112),
      xl5: TextStyle(fontSize: 48, height: 1),
      xl6: TextStyle(fontSize: 60, height: 1),
      xl7: TextStyle(fontSize: 72, height: 1),
      xl8: TextStyle(fontSize: 96, height: 1),
      xl9: TextStyle(fontSize: 128, height: 1),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FlyTextStyleToken &&
        _allValues.toString() == other._allValues.toString();
  }

  @override
  int get hashCode => _allValues.hashCode;
}

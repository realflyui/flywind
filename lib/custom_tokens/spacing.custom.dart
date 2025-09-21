// GENERATED FILE - DO NOT EDIT
// This file demonstrates how custom spacing tokens would be generated

import '../tokens/spacing_base.dart';

/// Custom spacing token class generated from design system
/// 
/// This class extends FlySpacingBase and overrides default values
/// while adding new custom spacing values as typed fields.
class CustomSpacing extends FlySpacingBase {
  const CustomSpacing({
    super.base = 6.0,  // Override default base from 4.0 to 6.0
    super.sm = 12.0,   // Override default sm from 8.0 to 12.0
    super.md = 20.0,   // Override default md from 16.0 to 20.0
    super.lg = 32.0,   // Override default lg from 24.0 to 32.0
    super.extras = const {
      'xs': 4.0,       // Extra small spacing
      'xl': 48.0,      // Extra large spacing
      '2xl': 64.0,     // 2x extra large spacing
      '3xl': 96.0,     // 3x extra large spacing
    },
  });

  /// Extra small spacing (4.0)
  double get xs => extras['xs'] as double;
  
  /// Extra large spacing (48.0)
  double get xl => extras['xl'] as double;
  
  /// 2x extra large spacing (64.0)
  double get xl2 => extras['2xl'] as double;
  
  /// 3x extra large spacing (96.0)
  double get xl3 => extras['3xl'] as double;

  /// Create a copy with updated values
  @override
  CustomSpacing copyWith({
    double? base,
    double? sm,
    double? md,
    double? lg,
    Map<String, double>? extras,
  }) {
    return CustomSpacing(
      base: base ?? this.base,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      extras: extras ?? this.extras,
    );
  }

  /// Linear interpolation between two custom spacing tokens
  @override
  CustomSpacing lerp(FlySpacingBase other, double t) {
    if (other is! CustomSpacing) {
      return CustomSpacing(
        base: _lerpDouble(base, other.base, t) ?? base,
        sm: _lerpDouble(sm, other.sm, t) ?? sm,
        md: _lerpDouble(md, other.md, t) ?? md,
        lg: _lerpDouble(lg, other.lg, t) ?? lg,
        extras: _lerpExtras(extras, other.extras, t),
      );
    }
    
    return CustomSpacing(
      base: _lerpDouble(base, other.base, t) ?? base,
      sm: _lerpDouble(sm, other.sm, t) ?? sm,
      md: _lerpDouble(md, other.md, t) ?? md,
      lg: _lerpDouble(lg, other.lg, t) ?? lg,
      extras: _lerpExtras(extras, other.extras, t),
    );
  }

  /// Helper to interpolate extras maps
  Map<String, double> _lerpExtras(Map<String, double> a, Map<String, double> b, double t) {
    final result = <String, double>{};
    final allKeys = {...a.keys, ...b.keys};
    
    for (final key in allKeys) {
      final valueA = a[key] ?? 0.0;
      final valueB = b[key] ?? 0.0;
      result[key] = _lerpDouble(valueA, valueB, t) ?? valueA;
    }
    
    return result;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CustomSpacing &&
        other.base == base &&
        other.sm == sm &&
        other.md == md &&
        other.lg == lg &&
        _mapEquals(other.extras, extras);
  }

  @override
  int get hashCode {
    return Object.hash(base, sm, md, lg, extras);
  }

  /// Helper to compare maps
  bool _mapEquals(Map<String, double> a, Map<String, double> b) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (a[key] != b[key]) return false;
    }
    return true;
  }

  /// Helper to interpolate double values
  double? _lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }
}

import '../src/theme.dart';

/// Base spacing token class with typed fields and extras map
class FlySpacingBase implements FlyToken<double> {
  const FlySpacingBase({
    required this.base,
    required this.sm,
    required this.md,
    required this.lg,
    this.extras = const {},
  });

  /// Base spacing value
  final double base;
  
  /// Small spacing value
  final double sm;
  
  /// Medium spacing value
  final double md;
  
  /// Large spacing value
  final double lg;
  
  /// Additional custom spacing values
  final Map<String, double> extras;

  /// Access spacing value by key (canonical or extra)
  @override
  double? operator[](String key) {
    switch (key) {
      case 'base':
        return base;
      case 'sm':
        return sm;
      case 'md':
        return md;
      case 'lg':
        return lg;
      default:
        return extras[key];
    }
  }

  /// Get all available keys (canonical + extras)
  @override
  Iterable<String> get keys {
    return ['base', 'sm', 'md', 'lg', ...extras.keys];
  }

  /// Put a new value for the given key
  @override
  FlySpacingBase put(String key, double value) {
    switch (key) {
      case 'base':
        return copyWith(base: value);
      case 'sm':
        return copyWith(sm: value);
      case 'md':
        return copyWith(md: value);
      case 'lg':
        return copyWith(lg: value);
      default:
        final newExtras = Map<String, double>.from(extras);
        newExtras[key] = value;
        return copyWith(extras: newExtras);
    }
  }

  /// Merge another spacing token into this one (right side wins)
  @override
  FlySpacingBase merge(FlyToken<double> other) {
    if (other is! FlySpacingBase) return this;
    
    return copyWith(
      base: other.base,
      sm: other.sm,
      md: other.md,
      lg: other.lg,
      extras: {...extras, ...other.extras},
    );
  }

  /// Create a copy with updated values
  FlySpacingBase copyWith({
    double? base,
    double? sm,
    double? md,
    double? lg,
    Map<String, double>? extras,
  }) {
    return FlySpacingBase(
      base: base ?? this.base,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      extras: extras ?? this.extras,
    );
  }

  /// Linear interpolation between two spacing tokens
  FlySpacingBase lerp(FlySpacingBase other, double t) {
    return FlySpacingBase(
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

  /// Create default spacing
  static FlySpacingBase defaultSpacing() {
    return const FlySpacingBase(
      base: 4.0,
      sm: 8.0,
      md: 16.0,
      lg: 24.0,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FlySpacingBase &&
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

import 'package:flutter/material.dart';
import '../src/theme.dart';

/// Base colors token class with typed fields and extras map
class FlyColorsBase implements FlyToken<Color> {
  const FlyColorsBase({
    required this.primary,
    required this.secondary,
    required this.surface,
    required this.background,
    this.extras = const {},
  });

  /// Primary color
  final Color primary;
  
  /// Secondary color
  final Color secondary;
  
  /// Surface color
  final Color surface;
  
  /// Background color
  final Color background;
  
  /// Additional custom color values
  final Map<String, Color> extras;

  /// Access color value by key (canonical or extra)
  @override
  Color? operator[](String key) {
    switch (key) {
      case 'primary':
        return primary;
      case 'secondary':
        return secondary;
      case 'surface':
        return surface;
      case 'background':
        return background;
      default:
        return extras[key];
    }
  }

  /// Get all available keys (canonical + extras)
  @override
  Iterable<String> get keys {
    return ['primary', 'secondary', 'surface', 'background', ...extras.keys];
  }

  /// Put a new value for the given key
  @override
  FlyColorsBase put(String key, Color value) {
    switch (key) {
      case 'primary':
        return copyWith(primary: value);
      case 'secondary':
        return copyWith(secondary: value);
      case 'surface':
        return copyWith(surface: value);
      case 'background':
        return copyWith(background: value);
      default:
        final newExtras = Map<String, Color>.from(extras);
        newExtras[key] = value;
        return copyWith(extras: newExtras);
    }
  }

  /// Merge another colors token into this one (right side wins)
  @override
  FlyColorsBase merge(FlyToken<Color> other) {
    if (other is! FlyColorsBase) return this;
    
    return copyWith(
      primary: other.primary,
      secondary: other.secondary,
      surface: other.surface,
      background: other.background,
      extras: {...extras, ...other.extras},
    );
  }

  /// Create a copy with updated values
  FlyColorsBase copyWith({
    Color? primary,
    Color? secondary,
    Color? surface,
    Color? background,
    Map<String, Color>? extras,
  }) {
    return FlyColorsBase(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      surface: surface ?? this.surface,
      background: background ?? this.background,
      extras: extras ?? this.extras,
    );
  }

  /// Linear interpolation between two colors tokens
  FlyColorsBase lerp(FlyColorsBase other, double t) {
    return FlyColorsBase(
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      background: Color.lerp(background, other.background, t) ?? background,
      extras: _lerpExtras(extras, other.extras, t),
    );
  }

  /// Helper to interpolate extras maps
  Map<String, Color> _lerpExtras(Map<String, Color> a, Map<String, Color> b, double t) {
    final result = <String, Color>{};
    final allKeys = {...a.keys, ...b.keys};
    
    for (final key in allKeys) {
      final valueA = a[key] ?? Colors.transparent;
      final valueB = b[key] ?? Colors.transparent;
      result[key] = Color.lerp(valueA, valueB, t) ?? valueA;
    }
    
    return result;
  }

  /// Create default colors
  static FlyColorsBase defaultColors() {
    return const FlyColorsBase(
      primary: Colors.blue,
      secondary: Colors.orange,
      surface: Colors.white,
      background: Color(0xFFF5F5F5),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FlyColorsBase &&
        other.primary == primary &&
        other.secondary == secondary &&
        other.surface == surface &&
        other.background == background &&
        _mapEquals(other.extras, extras);
  }

  @override
  int get hashCode {
    return Object.hash(primary, secondary, surface, background, extras);
  }

  /// Helper to compare maps
  bool _mapEquals(Map<String, Color> a, Map<String, Color> b) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (a[key] != b[key]) return false;
    }
    return true;
  }
}

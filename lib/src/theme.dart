import 'package:flutter/material.dart';
import '../tokens/tokens.dart';

/// Base interface for all Fly tokens
/// 
/// Provides a consistent API for accessing, modifying, and merging design tokens.
/// All token types (spacing, colors, etc.) must implement this interface.
/// 
/// Example usage:
/// ```dart
/// final spacing = FlySpacingBase.defaultSpacing();
/// final value = spacing['medium']; // Access token
/// final updated = spacing.put('large', 32.0); // Create new instance with update
/// final merged = spacing.merge(otherSpacing); // Merge with another token
/// ```
abstract class FlyToken<T> {
  /// Access token value by key using bracket notation
  /// 
  /// Returns the token value for the given key, or null if not found.
  /// Supports both canonical keys (defined in the token class) and custom keys.
  T? operator[](String key);
  
  /// Get all available keys
  /// 
  /// Returns an iterable of all keys available in this token,
  /// including both canonical and custom keys.
  Iterable<String> get keys;
  
  /// Put a new value for the given key
  /// 
  /// Creates a new token instance with the updated value.
  /// The original token remains unchanged (immutable pattern).
  FlyToken<T> put(String key, T value);
  
  /// Merge another token into this one (right side wins)
  /// 
  /// Creates a new token instance by merging this token with another.
  /// Values from the other token take precedence over this token's values.
  FlyToken<T> merge(FlyToken<T> other);
}

/// Main theme data container that holds all tokens
class FlyThemeData extends ThemeExtension<FlyThemeData> {
  const FlyThemeData({
    required this.spacing,
    required this.colors,
    required this.radius,
    required this.breakpoints,
  });

  final FlySpacingToken spacing;
  final FlyColorToken colors;
  final FlyRadiusToken radius;
  final FlyBreakpointToken breakpoints;

  /// Create a copy with updated values
  @override
  FlyThemeData copyWith({
    FlySpacingToken? spacing,
    FlyColorToken? colors,
    FlyRadiusToken? radius,
    FlyBreakpointToken? breakpoints,
  }) {
    return FlyThemeData(
      spacing: spacing ?? this.spacing,
      colors: colors ?? this.colors,
      radius: radius ?? this.radius,
      breakpoints: breakpoints ?? this.breakpoints,
    );
  }

  /// Merge another theme data into this one
  FlyThemeData merge(FlyThemeData? other) {
    if (other == null) return this;
    
    return FlyThemeData(
      spacing: spacing.merge(other.spacing),
      colors: colors.merge(other.colors),
      radius: radius.merge(other.radius),
      breakpoints: breakpoints.merge(other.breakpoints),
    );
  }

  /// Create default theme data
  static FlyThemeData fallback() {
    return FlyThemeData(
      spacing: FlySpacingToken.defaultSpacing(),
      colors: FlyColorToken.defaultColor(),
      radius: FlyRadiusToken.defaultRadius(),
      breakpoints: FlyBreakpointToken.defaultBreakpoint(),
    );
  }

  /// Linear interpolation between two theme data instances
  @override
  FlyThemeData lerp(ThemeExtension<FlyThemeData>? other, double t) {
    if (other is! FlyThemeData) return this;
    
    return FlyThemeData(
      spacing: spacing.lerp(other.spacing, t),
      colors: colors.lerp(other.colors, t),
      radius: radius.lerp(other.radius, t),
      breakpoints: breakpoints.lerp(other.breakpoints, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FlyThemeData &&
        other.spacing == spacing &&
        other.colors == colors &&
        other.radius == radius &&
        other.breakpoints == breakpoints;
  }

  @override
  int get hashCode => Object.hash(spacing, colors, radius, breakpoints);
}

import 'package:flutter/material.dart';
import 'tokens.dart';

/// Simplified Tailwind theme extension for Flutter's ThemeData
/// Uses your existing token classes for full autocomplete support
class FlyTheme extends ThemeExtension<FlyTheme> {
  const FlyTheme({
    required this.spacing,
    required this.colors,
    required this.borderRadius,
  });

  final FlySpacing spacing;
  final FlyColors colors;
  final FlyBorderRadius borderRadius;

  /// Default Tailwind theme
  static const FlyTheme defaultTheme = FlyTheme(
    spacing: FlySpacing.defaultSpacing,
    colors: FlyColors.defaultColors,
    borderRadius: FlyBorderRadius.defaultBorderRadius,
  );

  /// Create a theme with custom colors and spacing
  static FlyTheme withCustom({
    Map<String, Color>? customColors,
    Map<String, double>? customSpacing,
  }) {
    return FlyTheme(
      spacing: FlySpacing.defaultSpacing.copyWith(
        customSpacing: customSpacing,
      ),
      colors: FlyColors.defaultColors.copyWith(
        customColors: customColors,
      ),
      borderRadius: FlyBorderRadius.defaultBorderRadius,
    );
  }

  @override
  FlyTheme copyWith({
    FlySpacing? spacing,
    FlyColors? colors,
    FlyBorderRadius? borderRadius,
  }) {
    return FlyTheme(
      spacing: spacing ?? this.spacing,
      colors: colors ?? this.colors,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  FlyTheme lerp(FlyTheme? other, double t) {
    if (other is! FlyTheme) return this;
    
    // For simplicity, just return the current theme
    // In a real implementation, you'd interpolate between values
    return this;
  }
}

/// Extension on BuildContext for easy access to Tailwind theme
/// Provides both dot notation and convenience methods
extension FlyContext on BuildContext {
  /// Get the Tailwind theme from the current context
  FlyTheme get tw => Theme.of(this).extension<FlyTheme>()!;
  
  /// Convenience method for spacing values
  double spacing(int value) => tw.spacing[value] ?? 0.0;
  
  /// Convenience method for color values
  Color color(String name) => tw.colors[name] ?? Colors.black;
  
  /// Convenience method for border radius values
  double radius(String name) => tw.borderRadius[name] ?? 0.0;
}

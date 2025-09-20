import 'package:flutter/material.dart';
import 'tw_tokens.dart';

/// Simplified Tailwind theme extension for Flutter's ThemeData
/// Uses your existing token classes for full autocomplete support
class TwTheme extends ThemeExtension<TwTheme> {
  const TwTheme({
    required this.spacing,
    required this.colors,
    required this.borderRadius,
  });

  final TwSpacing spacing;
  final TwColors colors;
  final TwBorderRadius borderRadius;

  /// Default Tailwind theme
  static const TwTheme defaultTheme = TwTheme(
    spacing: TwSpacing.defaultSpacing,
    colors: TwColors.defaultColors,
    borderRadius: TwBorderRadius.defaultBorderRadius,
  );

  @override
  TwTheme copyWith({
    TwSpacing? spacing,
    TwColors? colors,
    TwBorderRadius? borderRadius,
  }) {
    return TwTheme(
      spacing: spacing ?? this.spacing,
      colors: colors ?? this.colors,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  TwTheme lerp(TwTheme? other, double t) {
    if (other is! TwTheme) return this;
    
    // For simplicity, just return the current theme
    // In a real implementation, you'd interpolate between values
    return this;
  }
}

/// Extension on BuildContext for easy access to Tailwind theme
/// Provides both dot notation and convenience methods
extension TwContext on BuildContext {
  /// Get the Tailwind theme from the current context
  TwTheme get tw => Theme.of(this).extension<TwTheme>()!;
  
  /// Convenience method for spacing values
  double spacing(int value) => tw.spacing[value] ?? 0.0;
  
  /// Convenience method for color values
  Color color(String name) => tw.colors[name] ?? Colors.black;
  
  /// Convenience method for border radius values
  double radius(String name) => tw.borderRadius[name] ?? 0.0;
}

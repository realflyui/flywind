import 'package:flutter/material.dart';
import 'tokens.dart';
import 'color_parser.dart';

/// Simplified Flywind theme extension for Flutter's ThemeData
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

  /// Default Flywind theme
  static const FlyTheme defaultTheme = FlyTheme(
    spacing: FlySpacing.defaultSpacing,
    colors: FlyColors.defaultColors,
    borderRadius: FlyBorderRadius.defaultBorderRadius,
  );

  /// Create a theme with custom colors, spacing, and border radius
  static FlyTheme withCustom({
    Map<String, String>? customColors,
    Map<String, String>? customSpacing,
    Map<String, double>? customBorderRadius,
  }) {
    // Parse string colors to Color objects
    Map<String, Color> parsedColors = {};
    if (customColors != null) {
      for (final entry in customColors.entries) {
        final color = FlyColorParser.parse(entry.value);
        if (color != null) {
          parsedColors[entry.key] = color;
        }
      }
    }
    
    return FlyTheme(
      spacing: FlySpacing.defaultSpacing.copyWith(
        customSpacing: customSpacing ?? {},
      ),
      colors: FlyColors.defaultColors.copyWith(
        customColors: parsedColors,
      ),
      borderRadius: FlyBorderRadius.defaultBorderRadius.copyWith(
        customBorderRadius: customBorderRadius ?? {},
      ),
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

/// Extension on BuildContext for easy access to Flywind theme
/// Provides both dot notation and convenience methods
extension FlyContext on BuildContext {
  /// Get the Flywind theme from the current context
  FlyTheme get flywind => Theme.of(this).extension<FlyTheme>()!;
  
  /// Convenience method for spacing values
  String spacing(int value) => flywind.spacing[value] ?? '0';
  
  /// Convenience method for color values
  Color color(String name) => flywind.colors[name] ?? Colors.black;
  
  /// Convenience method for border radius values
  double radius(String name) => flywind.borderRadius[name] ?? 0.0;
}

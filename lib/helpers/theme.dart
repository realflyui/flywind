import 'package:flutter/material.dart';
import '../tokens/colors.dart';
import '../tokens/spacing.dart';
import '../tokens/border_radius.dart';
import '../parsers/color_parser.dart';

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
    Map<String, String>? customBorderRadius,
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
      colors: FlyColors.defaultColors.copyWith(customColors: parsedColors),
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

  /// Get the FlyTheme from the current context
  /// This follows the standard Flutter pattern for accessing theme extensions
  static FlyTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<FlyTheme>();
    if (theme == null) {
      throw FlutterError(
        'FlyTheme.of() called with a context that does not contain a FlyTheme.\n'
        'No ancestor could be found starting from the context that was passed to FlyTheme.of().\n'
        'This can happen when the context you use comes from a widget above the MaterialApp or WidgetsApp.\n'
        'The context used was:\n'
        '  $context',
      );
    }
    return theme;
  }

  /// Get the FlyTheme from the current context, or return null if not found
  static FlyTheme? maybeOf(BuildContext context) {
    return Theme.of(context).extension<FlyTheme>();
  }
}

/// Extension on BuildContext for easy access to Flywind theme
/// Provides both dot notation and convenience methods
extension FlyContext on BuildContext {
  /// Convenience method for spacing values
  String spacing(int value) => FlyTheme.of(this).spacing[value] ?? '0';

  /// Convenience method for color values
  Color color(String name) => FlyTheme.of(this).colors[name] ?? Colors.black;

  /// Convenience method for border radius values
  double radius(String name) =>
      FlyTheme.of(this).borderRadius.getValue(name) ?? 0.0;
}

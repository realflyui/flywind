import 'package:flutter/material.dart';
import '../tokens/tokens.dart';
import '../parsers/color_parser.dart';

/// Simplified Flywind theme extension for Flutter's ThemeData
/// Uses your existing token classes for full autocomplete support
class FlyTheme extends ThemeExtension<FlyTheme> {
  const FlyTheme({
    required this.spacing,
    required this.colors,
    required this.radius,
    required this.fontWeights,
    required this.textSizes,
    required this.letterSpacing,
    required this.shadows,
    required this.blurs,
    required this.fontFamilies,
    required this.containers,
    required this.breakpoints,
    required this.dropShadows,
    required this.lineHeights,
    required this.perspectives,
    required this.textShadows,
    required this.insetShadows,
    required this.textLineHeights,
  });

  final FlySpacing spacing;
  final FlyColors colors;
  final FlyBorderRadius radius;
  final FlyFontWeights fontWeights;
  final FlyTextSizes textSizes;
  final FlyLetterSpacing letterSpacing;
  final FlyShadows shadows;
  final FlyBlurs blurs;
  final FlyFontFamilies fontFamilies;
  final FlyContainers containers;
  final FlyBreakpoints breakpoints;
  final FlyDropShadows dropShadows;
  final FlyLineHeights lineHeights;
  final FlyPerspectives perspectives;
  final FlyTextShadows textShadows;
  final FlyInsetShadows insetShadows;
  final FlyTextLineHeights textLineHeights;

  /// Default Flywind theme
  static const FlyTheme defaultTheme = FlyTheme(
    spacing: FlySpacing.defaultSpacing,
    colors: FlyColors.defaultColors,
    radius: FlyBorderRadius.defaultBorderRadius,
    fontWeights: FlyFontWeights.defaultFontWeights,
    textSizes: FlyTextSizes.defaultTextSizes,
    letterSpacing: FlyLetterSpacing.defaultLetterSpacing,
    shadows: FlyShadows.defaultShadows,
    blurs: FlyBlurs.defaultBlurs,
    fontFamilies: FlyFontFamilies.defaultFontFamilies,
    containers: FlyContainers.defaultContainers,
    breakpoints: FlyBreakpoints.defaultBreakpoints,
    dropShadows: FlyDropShadows.defaultDropShadows,
    lineHeights: FlyLineHeights.defaultLineHeights,
    perspectives: FlyPerspectives.defaultPerspectives,
    textShadows: FlyTextShadows.defaultTextShadows,
    insetShadows: FlyInsetShadows.defaultInsetShadows,
    textLineHeights: FlyTextLineHeights.defaultTextLineHeights,
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
      spacing: FlySpacing.defaultSpacing,
      colors: FlyColors.defaultColors,
      radius: FlyBorderRadius.defaultBorderRadius,
      fontWeights: FlyFontWeights.defaultFontWeights,
      textSizes: FlyTextSizes.defaultTextSizes,
      letterSpacing: FlyLetterSpacing.defaultLetterSpacing,
      shadows: FlyShadows.defaultShadows,
      blurs: FlyBlurs.defaultBlurs,
      fontFamilies: FlyFontFamilies.defaultFontFamilies,
      containers: FlyContainers.defaultContainers,
      breakpoints: FlyBreakpoints.defaultBreakpoints,
      dropShadows: FlyDropShadows.defaultDropShadows,
      lineHeights: FlyLineHeights.defaultLineHeights,
      perspectives: FlyPerspectives.defaultPerspectives,
      textShadows: FlyTextShadows.defaultTextShadows,
      insetShadows: FlyInsetShadows.defaultInsetShadows,
      textLineHeights: FlyTextLineHeights.defaultTextLineHeights,
    );
  }

  @override
  FlyTheme copyWith({
    FlySpacing? spacing,
    FlyColors? colors,
    FlyBorderRadius? radius,
    FlyFontWeights? fontWeights,
    FlyTextSizes? textSizes,
    FlyLetterSpacing? letterSpacing,
    FlyShadows? shadows,
    FlyBlurs? blurs,
    FlyFontFamilies? fontFamilies,
    FlyContainers? containers,
    FlyBreakpoints? breakpoints,
    FlyDropShadows? dropShadows,
    FlyLineHeights? lineHeights,
    FlyPerspectives? perspectives,
    FlyTextShadows? textShadows,
    FlyInsetShadows? insetShadows,
    FlyTextLineHeights? textLineHeights,
  }) {
    return FlyTheme(
      spacing: spacing ?? this.spacing,
      colors: colors ?? this.colors,
      radius: radius ?? this.radius,
      fontWeights: fontWeights ?? this.fontWeights,
      textSizes: textSizes ?? this.textSizes,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      shadows: shadows ?? this.shadows,
      blurs: blurs ?? this.blurs,
      fontFamilies: fontFamilies ?? this.fontFamilies,
      containers: containers ?? this.containers,
      breakpoints: breakpoints ?? this.breakpoints,
      dropShadows: dropShadows ?? this.dropShadows,
      lineHeights: lineHeights ?? this.lineHeights,
      perspectives: perspectives ?? this.perspectives,
      textShadows: textShadows ?? this.textShadows,
      insetShadows: insetShadows ?? this.insetShadows,
      textLineHeights: textLineHeights ?? this.textLineHeights,
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
  String spacing(String value) => FlyTheme.of(this).spacing[value] ?? '0';

  /// Convenience method for color values
  Color color(String name) {
    final colorString = FlyTheme.of(this).colors[name];
    if (colorString != null) {
      final color = FlyColorParser.parse(colorString);
      if (color != null) {
        return color;
      }
    }
    return Colors.black;
  }

  /// Convenience method for border radius values
  double radius(String name) {
    final valueString = FlyTheme.of(this).radius[name];
    if (valueString != null) {
      return double.tryParse(valueString) ?? 0.0;
    }
    return 0.0;
  }
}

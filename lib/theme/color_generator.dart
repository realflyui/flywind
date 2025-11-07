import 'dart:math';

import 'package:flutter/material.dart';
import 'package:okcolor/models/extensions.dart';
import 'package:okcolor/models/oklch.dart';

import 'radix_color_scales.dart';

/// Helper class for color with distance
class _ColorWithDistance {
  final String scale;
  final OkLch color;
  final double distance;

  _ColorWithDistance({
    required this.scale,
    required this.color,
    required this.distance,
  });
}

/// Helper class for step 9 result (matching TypeScript tuple return)
/// TypeScript returns: [Color, Color] - we use a helper class for clarity
class _Step9Result {
  final OkLch step9;
  final OkLch contrast;

  _Step9Result({required this.step9, required this.contrast});
}

/// Radix color generator using OKLCH color space
///
/// Generates 12-step color scales from base colors, matching the TypeScript
/// Radix color generation algorithm.
class RadixColorGenerator {
  // Constants for color mixing and adjustment
  static const double _kMixingFactor = 0.5; // Scale mixing ratio multiplier
  static const double _kChromaCapMultiplier =
      1.5; // Maximum chroma scaling factor
  static const double _kButtonHoverChromaMultiplier =
      0.93; // Button hover chroma reduction
  /// Generate Radix colors from base colors
  ///
  /// [appearance] - "light" or "dark" mode
  /// [accent] - Accent color (Color object or hex string like "#3D63DD")
  ///   Can also use RadixColors.blue.step9, RadixColors.dark.blue.step9, etc.
  /// [gray] - Gray color (Color object or hex string like "#8B8D98")
  ///   Can also use RadixColors.gray.step9, RadixColors.dark.gray.step9, etc.
  /// [background] - Background color (Color object or hex string like "#111111")
  ///   Can also use RadixColors.gray.step1, RadixColors.dark.gray.step1, etc.
  static RadixGeneratedColors generate({
    required String appearance,
    required dynamic accent,
    required dynamic gray,
    required dynamic background,
  }) {
    final isLight = appearance == 'light';
    final accentColor = accent is Color
        ? accent
        : _hexToColor(accent as String);
    final grayColor = gray is Color ? gray : _hexToColor(gray as String);
    final backgroundColor = background is Color
        ? background
        : _hexToColor(background as String);

    // Load pre-built scales and convert to OKLCH
    final scales = _loadScales(isLight);

    // Generate 12-step scales using template matching
    var accentScale = _getScaleFromColor(
      sourceColor: accentColor,
      scales: scales,
      backgroundColor: backgroundColor,
    );

    final grayScale = _getScaleFromColor(
      sourceColor: grayColor,
      scales: scales,
      backgroundColor: backgroundColor,
    );

    // Make sure we use the tint from the gray scale for when base is pure white or black
    // (matching TypeScript lines 110-115)
    final accentBaseHex = _colorToHex(accentColor).toLowerCase();
    if (accentBaseHex == '#000' ||
        accentBaseHex == '#fff' ||
        accentBaseHex == '#000000' ||
        accentBaseHex == '#ffffff') {
      accentScale = grayScale.map((c) => Color(c.value)).toList();
    }

    // Apply post-processing adjustments (matching TypeScript)
    final accentOklch = accentColor.toOkLch();
    final accent9AndContrast = _getStep9Colors(accentScale, accentOklch);
    accentScale[8] = accent9AndContrast.step9.toColor();
    accentScale[9] = _getButtonHoverColor(accent9AndContrast.step9, [
      accentScale,
    ]);

    // Limit saturation of text colors (steps 10-11)
    final accentScaleOklch = accentScale.map((c) => c.toOkLch()).toList();
    final minChroma = max(accentScaleOklch[8].c, accentScaleOklch[7].c);
    final step10Oklch = accentScaleOklch[10];
    final step11Oklch = accentScaleOklch[11];
    accentScale[10] = OkLch(
      step10Oklch.l,
      min(minChroma, step10Oklch.c),
      step10Oklch.h,
    ).toColor();
    accentScale[11] = OkLch(
      step11Oklch.l,
      min(minChroma, step11Oklch.c),
      step11Oklch.h,
    ).toColor();

    // Generate contrast color
    final contrastColor = accent9AndContrast.contrast.toColor();

    // Generate alpha variants for both scales
    final accentScaleAlpha = accentScale
        .map((color) => _getAlphaColorSrgb(color, backgroundColor))
        .toList();

    final grayScaleAlpha = grayScale
        .map((color) => _getAlphaColorSrgb(color, backgroundColor))
        .toList();

    // Generate surface color (uses sRGB step 1 with alpha)
    // Matches TS: getAlphaColorSrgb(accentScaleHex[1], backgroundHex, 0.8/0.5)
    // We use accentScale[1] (sRGB Color object) instead of hex string
    final surfaceColor = _getAlphaColorSrgb(
      accentScale[1], // sRGB step 1 color (matches TS accentScaleHex[1])
      backgroundColor,
      targetAlpha: isLight ? 0.8 : 0.5,
    );

    return RadixGeneratedColors(
      accentScale: accentScale,
      accentScaleAlpha: accentScaleAlpha,
      grayScale: grayScale,
      grayScaleAlpha: grayScaleAlpha,
      accentContrast: contrastColor,
      accentSurface: surfaceColor,
      background: backgroundColor,
    );
  }

  /// Parse P3 color string to Color object
  /// Format: "color(display-p3 r g b)" where r, g, b are in 0-1 range
  static Color _parseP3Color(String p3String) {
    // Parse "color(display-p3 0.988 0.988 0.988)"
    final match = RegExp(
      r'color\(display-p3\s+([\d.]+)\s+([\d.]+)\s+([\d.]+)\)',
    ).firstMatch(p3String);
    if (match == null) {
      throw FormatException('Invalid P3 color format: $p3String');
    }

    final r = (double.parse(match.group(1)!) * 255).round().clamp(0, 255);
    final g = (double.parse(match.group(2)!) * 255).round().clamp(0, 255);
    final b = (double.parse(match.group(3)!) * 255).round().clamp(0, 255);

    return Color.fromRGBO(r, g, b, 1.0);
  }

  /// Load pre-built Radix scales and convert to OKLCH
  /// Uses P3 colors for template matching (matching TypeScript implementation)
  static Map<String, List<OkLch>> _loadScales(bool isLight) {
    final sourceScales = isLight ? radixLightScalesP3 : radixDarkScalesP3;
    final scales = <String, List<OkLch>>{};

    for (final entry in sourceScales.entries) {
      scales[entry.key] = entry.value
          .map((p3String) => _parseP3Color(p3String).toOkLch())
          .toList();
    }

    return scales;
  }

  /// Mix two OKLCH colors (matching TypeScript Color.mix for OKLCH colors)
  /// TypeScript: new Color(Color.mix(scaleA[i], scaleB[i], ratio)).to("oklch")
  /// where scaleA[i] and scaleB[i] are already OKLCH Color objects
  /// Color.mix in colorjs.io mixes colors in their current color space (OKLCH here)
  static OkLch _mixOklch(OkLch a, OkLch b, double ratio) {
    // Mix lightness, chroma, and hue separately
    // For hue, handle NaN and wrapping
    double mixedH;
    if (a.h.isNaN && b.h.isNaN) {
      mixedH = double.nan;
    } else if (a.h.isNaN) {
      mixedH = b.h;
    } else if (b.h.isNaN) {
      mixedH = a.h;
    } else {
      // Handle hue wrapping (0-360 degrees)
      double hDiff = b.h - a.h;
      if (hDiff.abs() > 180) {
        if (hDiff > 0) {
          hDiff -= 360;
        } else {
          hDiff += 360;
        }
      }
      mixedH = a.h + hDiff * ratio;
      // Normalize to 0-360
      while (mixedH < 0) mixedH += 360;
      while (mixedH >= 360) mixedH -= 360;
    }

    return OkLch(
      a.l + (b.l - a.l) * ratio, // Mix lightness
      a.c + (b.c - a.c) * ratio, // Mix chroma
      mixedH, // Mixed hue
    );
  }

  /// Get scale from color using template matching (matching TypeScript getScaleFromColor)
  static List<Color> _getScaleFromColor({
    required Color sourceColor,
    required Map<String, List<OkLch>> scales,
    required Color backgroundColor,
  }) {
    final sourceOklch = sourceColor.toOkLch();
    final backgroundOklch = backgroundColor.toOkLch();

    // Find all colors from all scales with their distances
    final allColors = <_ColorWithDistance>[];
    for (final entry in scales.entries) {
      for (final color in entry.value) {
        final distance = _deltaEOK(sourceOklch, color);
        allColors.add(
          _ColorWithDistance(
            scale: entry.key,
            color: color,
            distance: distance,
          ),
        );
      }
    }

    // Sort by distance
    allColors.sort((a, b) => a.distance.compareTo(b.distance));

    // Remove non-unique scales (keep first occurrence of each scale)
    final closestColors = <_ColorWithDistance>[];
    final seenScales = <String>{};
    for (final color in allColors) {
      if (!seenScales.contains(color.scale)) {
        closestColors.add(color);
        seenScales.add(color.scale);
      }
    }

    // If the next two closest colors are both grays, remove the second one
    final allAreGrays = closestColors.every(
      (c) => grayScaleNames.contains(c.scale),
    );
    if (!allAreGrays && grayScaleNames.contains(closestColors[0].scale)) {
      while (closestColors.length > 1 &&
          grayScaleNames.contains(closestColors[1].scale)) {
        closestColors.removeAt(1);
      }
    }

    if (closestColors.length < 2) {
      // Fallback: use the closest scale as-is
      final scale = scales[closestColors[0].scale]!;
      return scale.map((c) => c.toColor()).toList();
    }

    final colorA = closestColors[0];
    final colorB = closestColors[1];

    // Trigonometry to determine mixing ratio
    final a = colorB.distance;
    final b = colorA.distance;
    final c = _deltaEOK(colorA.color, colorB.color);

    // Calculate angles using law of cosines
    final cosA = (b * b + c * c - a * a) / (2 * b * c);
    final radA = acos(cosA.clamp(-1.0, 1.0));
    final sinA = sin(radA);

    final cosB = (a * a + c * c - b * b) / (2 * a * c);
    final radB = acos(cosB.clamp(-1.0, 1.0));
    final sinB = sin(radB);

    // Avoid division by zero
    if (sinA == 0 || sinB == 0) {
      final scale = scales[colorA.scale]!;
      return scale.map((c) => c.toColor()).toList();
    }

    final tanC1 = cosA / sinA;
    final tanC2 = cosB / sinB;

    // Mix ratio (0 = use only scale A, >0 = mix with scale B)
    final ratio = max(0.0, tanC1 / tanC2) * _kMixingFactor;

    // Mix the two closest scales
    // IMPORTANT: Mix in OKLCH space directly (matching TypeScript)
    // TypeScript: new Color(Color.mix(scaleA[i], scaleB[i], ratio)).to("oklch")
    // where scaleA[i] and scaleB[i] are already OKLCH Color objects
    final scaleA = scales[colorA.scale]!;
    final scaleB = scales[colorB.scale]!;
    final mixedScale = List.generate(12, (i) {
      // Mix OKLCH colors directly (matching TypeScript Color.mix behavior)
      return _mixOklch(scaleA[i], scaleB[i], ratio);
    });

    // Find closest color from mixed scale
    final baseColor = mixedScale.reduce(
      (a, b) => _deltaEOK(sourceOklch, a) < _deltaEOK(sourceOklch, b) ? a : b,
    );

    // Adjust chroma and hue to match source (matching TypeScript exactly)
    final ratioC = sourceOklch.c / (baseColor.c == 0 ? 0.001 : baseColor.c);
    final adjustedScale = mixedScale.map((color) {
      final newC = min(sourceOklch.c * _kChromaCapMultiplier, color.c * ratioC);
      // TypeScript just sets hue directly: color.coords[2] = source.coords[2]
      return OkLch(
        color.l,
        newC,
        sourceOklch.h, // Set hue directly from source, even if NaN
      );
    }).toList();

    // Apply Bezier easing for lightness progression
    final isLight = adjustedScale[0].l > 0.5;
    final lightModeEasing = [0.0, 2.0, 0.0, 2.0];
    final darkModeEasing = [1.0, 0.0, 1.0, 0.0];

    if (isLight) {
      final lightnessScale = adjustedScale.map((c) => c.l).toList();
      final bgL = backgroundOklch.l.clamp(0.0, 1.0);
      final newLightness = _transposeProgressionStart(bgL, [
        1.0,
        ...lightnessScale,
      ], lightModeEasing);
      newLightness.removeAt(0); // Remove the white step

      return List.generate(12, (i) {
        return OkLch(
          newLightness[i].clamp(0.0, 1.0),
          adjustedScale[i].c,
          adjustedScale[i].h,
        ).toColor();
      });
    } else {
      // Dark mode
      var ease = List<double>.from(darkModeEasing);
      final referenceBgL = adjustedScale[0].l;
      final bgL = backgroundOklch.l.clamp(0.0, 1.0);
      final ratioL = bgL / (referenceBgL == 0 ? 0.001 : referenceBgL);

      if (ratioL > 1.0) {
        const maxRatio = 1.5;
        for (int i = 0; i < ease.length; i++) {
          final metaRatio = (ratioL - 1.0) * (maxRatio / (maxRatio - 1.0));
          ease[i] = ratioL > maxRatio
              ? 0.0
              : (ease[i] * (1.0 - metaRatio)).clamp(0.0, 1.0);
        }
      }

      final lightnessScale = adjustedScale.map((c) => c.l).toList();
      final newLightness = _transposeProgressionStart(
        bgL,
        lightnessScale,
        ease,
      );

      return List.generate(12, (i) {
        return OkLch(
          newLightness[i].clamp(0.0, 1.0),
          adjustedScale[i].c,
          adjustedScale[i].h,
        ).toColor();
      });
    }
  }

  /// Calculate delta E in OKLCH space (perceptual distance)
  static double _deltaEOK(OkLch a, OkLch b) {
    // Euclidean distance in OKLCH with proper hue wrapping
    final dL = a.l - b.l;
    final dC = a.c - b.c;

    // Handle hue wrapping (hue is in degrees, 0-360)
    double dH = a.h - b.h;
    if (dH.isNaN) {
      dH = 0.0;
    } else if (dH.abs() > 180) {
      if (dH > 0) {
        dH -= 360;
      } else {
        dH += 360;
      }
    }
    // Convert hue difference to chroma units (approximate)
    final dHChroma = 2 * sqrt(a.c * b.c) * sin(dH * pi / 360);

    return sqrt(dL * dL + dC * dC + dHChroma * dHChroma);
  }

  /// Get step 9 color and contrast color (matching TypeScript getStep9Colors)
  static _Step9Result _getStep9Colors(
    List<Color> scale,
    OkLch accentBaseColor,
  ) {
    final referenceBackgroundColor = scale[0].toOkLch();
    final distance = _deltaEOK(accentBaseColor, referenceBackgroundColor) * 100;

    // If the accent base color is close to the page background color, it's likely
    // white on white or black on black, so we want to return something that makes sense instead
    if (distance < 25) {
      final step9Oklch = scale[8].toOkLch();
      return _Step9Result(
        step9: step9Oklch,
        contrast: _getTextColor(step9Oklch),
      );
    }

    return _Step9Result(
      step9: accentBaseColor,
      contrast: _getTextColor(accentBaseColor),
    );
  }

  /// Get APCA Luminance (Y) with Soft Clamp
  /// Converts Color to APCA luminance using linearized sRGB and soft clamp
  static double _getAPCALuminance(Color color) {
    // Get sRGB values in 0-1 range
    final r = color.r;
    final g = color.g;
    final b = color.b;

    // Linearize (using sRGB trc = 2.4)
    double linearize(double c) => pow(c, 2.4).toDouble();
    final rLin = linearize(r);
    final gLin = linearize(g);
    final bLin = linearize(b);

    // Apply BT.709 coefficients to get Relative Luminance (Y)
    final Y = 0.2126 * rLin + 0.7152 * gLin + 0.0722 * bLin;

    // Soft Clamp (for near-black colors, APCA 0.98G-4g constants)
    const blkThrs = 0.022; // Black threshold
    const blkClmp = 1.414; // Black clamp exponent

    if (Y < blkThrs) {
      return Y +
          pow(blkThrs - Y, blkClmp) * 0.000000001; // Tiny correction factor
    }

    return Y;
  }

  /// Calculate APCA Contrast (Lc value)
  /// Returns the APCA contrast value between text and background colors
  static double _calculateAPCA(Color text, Color background) {
    final Ytxt = _getAPCALuminance(text);
    final Ybg = _getAPCALuminance(background);

    // Polarity dependent constants (G-4g)
    const normTXT = 0.57; // Dark text on light background
    const normBG = 0.56;
    const revTXT = 0.65; // Light text on dark background
    const revBG = 0.62;

    // Check polarity: Dark on Light (Positive Contrast)
    if (Ybg > Ytxt) {
      final contrast = pow(Ybg, normBG) - pow(Ytxt, normTXT);
      if (contrast < 0.1) return 0.0;
      return (contrast * 100.0) - 2.7; // Final scaling
    }
    // Light on Dark (Negative Contrast)
    else {
      final contrast = pow(Ybg, revBG) - pow(Ytxt, revTXT);
      final absContrast = contrast.abs();
      if (absContrast < 0.1) return 0.0;
      return -(absContrast * 100.0) + 2.7; // Final scaling (negative Lc)
    }
  }

  /// Get text color (matching TypeScript getTextColor)
  static OkLch _getTextColor(OkLch background) {
    final white = OkLch(1.0, 0.0, 0.0);
    final whiteColor = white.toColor();
    final backgroundLchColor = background.toColor(); // Background in sRGB Color

    // FIX: Use APCA contrast check (matching TS logic)
    final contrastValue = _calculateAPCA(whiteColor, backgroundLchColor);

    // TS check: Math.abs(white.contrastAPCA(background)) < 40
    if (contrastValue.abs() < 40) {
      final C = background.c;
      final H = background.h.isNaN ? 0.0 : background.h;
      // Dark text (as defined in TS)
      return OkLch(0.25, max(0.08 * C, 0.04), H);
    }

    // Pure white text
    return white;
  }

  /// Get button hover color (matching TypeScript getButtonHoverColor)
  static Color _getButtonHoverColor(OkLch source, List<List<Color>> scales) {
    final L = source.l;
    final C = source.c;
    final H = source.h;

    final newL = L > 0.4 ? L - 0.03 / (L + 0.1) : L + 0.03 / (L + 0.1);
    final newC = L > 0.4 && !H.isNaN ? C * _kButtonHoverChromaMultiplier : C;
    var buttonHoverColor = OkLch(newL, newC, H);

    // Find closest in-scale color to donate the chroma and hue
    var closestColor = buttonHoverColor;
    var minDistance = double.infinity;

    for (final scale in scales) {
      for (final color in scale) {
        final colorOklch = color.toOkLch();
        final distance = _deltaEOK(buttonHoverColor, colorOklch);
        if (distance < minDistance) {
          minDistance = distance;
          closestColor = colorOklch;
        }
      }
    }

    buttonHoverColor = OkLch(
      buttonHoverColor.l,
      closestColor.c,
      closestColor.h,
    );

    return buttonHoverColor.toColor();
  }

  /// Blend color with background using alpha
  static Color _blendWithBackground(
    Color color,
    Color background,
    double alpha,
  ) {
    final r =
        ((color.r * 255.0).round() * alpha +
                (background.r * 255.0).round() * (1 - alpha))
            .round();
    final g =
        ((color.g * 255.0).round() * alpha +
                (background.g * 255.0).round() * (1 - alpha))
            .round();
    final b =
        ((color.b * 255.0).round() * alpha +
                (background.b * 255.0).round() * (1 - alpha))
            .round();
    return Color.fromRGBO(r, g, b, 1.0);
  }

  /// Get alpha color in sRGB format (8-character hex with alpha)
  /// Ported from TypeScript getAlphaColorSrgb
  static Color _getAlphaColorSrgb(
    Color targetColor,
    Color backgroundColor, {
    double? targetAlpha,
  }) {
    // Convert colors to 0-255 RGB
    final tr = (targetColor.r * 255.0).round();
    final tg = (targetColor.g * 255.0).round();
    final tb = (targetColor.b * 255.0).round();
    final br = (backgroundColor.r * 255.0).round();
    final bg = (backgroundColor.g * 255.0).round();
    final bb = (backgroundColor.b * 255.0).round();

    // Determine if we need to lighten (255) or darken (0)
    final desiredRgb = (tr > br || tg > bg || tb > bb) ? 255 : 0;

    // Calculate alpha for each channel
    double alphaR = 0.0;
    double alphaG = 0.0;
    double alphaB = 0.0;

    if (desiredRgb - br != 0) {
      alphaR = (tr - br) / (desiredRgb - br);
    } else if (tr == br) {
      alphaR = 0.0; // No change needed
    }
    if (desiredRgb - bg != 0) {
      alphaG = (tg - bg) / (desiredRgb - bg);
    } else if (tg == bg) {
      alphaG = 0.0; // No change needed
    }
    if (desiredRgb - bb != 0) {
      alphaB = (tb - bb) / (desiredRgb - bb);
    } else if (tb == bb) {
      alphaB = 0.0; // No change needed
    }

    // Handle edge cases where target equals background
    if (tr == br && tg == bg && tb == bb) {
      // Target is same as background, return transparent
      return Color.fromRGBO(0, 0, 0, 0.0);
    }

    // Check if pure gray
    final isPureGray = (alphaR == alphaG && alphaG == alphaB);

    if (isPureGray) {
      // For pure gray, use the alpha value directly
      final v = desiredRgb / 255.0;
      final alpha = alphaR.clamp(0.0, 1.0);
      return Color.fromRGBO(
        (v * 255).round(),
        (v * 255).round(),
        (v * 255).round(),
        alpha,
      );
    }

    // Use target alpha if provided, otherwise use maximum alpha
    final maxAlpha =
        targetAlpha ??
        [
          alphaR,
          alphaG,
          alphaB,
        ].reduce((a, b) => a > b ? a : b).clamp(0.0, 1.0);

    // Calculate RGB values that when blended with background give target
    final r = ((br * (1 - maxAlpha) - tr) / maxAlpha * -1).round().clamp(
      0,
      255,
    );
    final g = ((bg * (1 - maxAlpha) - tg) / maxAlpha * -1).round().clamp(
      0,
      255,
    );
    final b = ((bb * (1 - maxAlpha) - tb) / maxAlpha * -1).round().clamp(
      0,
      255,
    );

    // Verify blending
    final blendedR = _blendAlpha(r, maxAlpha, br);
    final blendedG = _blendAlpha(g, maxAlpha, bg);
    final blendedB = _blendAlpha(b, maxAlpha, bb);

    // Correct for rounding errors
    int finalR = r;
    int finalG = g;
    int finalB = b;

    if (desiredRgb == 0) {
      if (tr <= br && tr != blendedR) {
        finalR = tr > blendedR ? r + 1 : r - 1;
      }
      if (tg <= bg && tg != blendedG) {
        finalG = tg > blendedG ? g + 1 : g - 1;
      }
      if (tb <= bb && tb != blendedB) {
        finalB = tb > blendedB ? b + 1 : b - 1;
      }
    } else {
      if (tr >= br && tr != blendedR) {
        finalR = tr > blendedR ? r + 1 : r - 1;
      }
      if (tg >= bg && tg != blendedG) {
        finalG = tg > blendedG ? g + 1 : g - 1;
      }
      if (tb >= bb && tb != blendedB) {
        finalB = tb > blendedB ? b + 1 : b - 1;
      }
    }

    return Color.fromRGBO(
      finalR.clamp(0, 255),
      finalG.clamp(0, 255),
      finalB.clamp(0, 255),
      maxAlpha,
    );
  }

  /// Blend alpha with rounding (matching browser behavior)
  static int _blendAlpha(int foreground, double alpha, int background) {
    return (background * (1 - alpha)).round() + (foreground * alpha).round();
  }

  /// Convert hex string to Color
  /// Handles both full form (#RRGGBB) and short form (#RGB) hex strings
  static Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    // Expand short form (#RGB -> #RRGGBB)
    if (hex.length == 3) {
      hex = hex.split('').map((c) => c + c).join('');
    }
    if (hex.length != 6) {
      throw ArgumentError('Invalid hex color: $hex');
    }
    return Color(int.parse(hex, radix: 16) | 0xFF000000);
  }

  /// Convert Color to hex string (RRGGBB format)
  /// Uses Flutter's standard Color.value (ARGB format) and extracts RGB
  static String _colorToHex(Color color) {
    final argb = color.value;
    final hex = argb.toRadixString(16).padLeft(8, '0');
    // Extract RGB (skip alpha channel, first 2 chars)
    return '#${hex.substring(2).toUpperCase()}';
  }

  // ========== OKLCH Helper Functions ==========

  /// Convert Flutter Color to OkLch
  static OkLch _colorToOklch(Color color) {
    return color.toOkLch();
  }

  /// Convert OkLch to Flutter Color
  static Color _oklchToColor(OkLch oklch) {
    return oklch.toColor();
  }

  // Removed duplicate _deltaEOK - using the one defined earlier

  /// Bezier easing function
  /// Implements cubic Bezier curve easing
  static double _bezierEasing(
    double t,
    double p1x,
    double p1y,
    double p2x,
    double p2y,
  ) {
    // Clamp t to [0, 1]
    t = t.clamp(0.0, 1.0);

    // Cubic Bezier formula
    final cx = 3.0 * p1x;
    final bx = 3.0 * (p2x - p1x) - cx;
    final ax = 1.0 - cx - bx;

    final cy = 3.0 * p1y;
    final by = 3.0 * (p2y - p1y) - cy;
    final ay = 1.0 - cy - by;

    // Find x(t) using Newton-Raphson method
    double currentT = t;
    for (int i = 0; i < 8; i++) {
      final currentX = _bezierX(currentT, ax, bx, cx);
      final currentDx = _bezierXDerivative(currentT, ax, bx, cx);
      if (currentDx.abs() < 1e-6) break;
      currentT = currentT - (currentX - t) / currentDx;
      currentT = currentT.clamp(0.0, 1.0);
    }

    return _bezierY(currentT, ay, by, cy);
  }

  static double _bezierX(double t, double ax, double bx, double cx) {
    return ((ax * t + bx) * t + cx) * t;
  }

  static double _bezierY(double t, double ay, double by, double cy) {
    return ((ay * t + by) * t + cy) * t;
  }

  static double _bezierXDerivative(double t, double ax, double bx, double cx) {
    return (3.0 * ax * t + 2.0 * bx) * t + cx;
  }

  /// Transpose progression start (from TypeScript transposeProgressionStart)
  static List<double> _transposeProgressionStart(
    double to,
    List<double> arr,
    List<double> curve, // [x1, y1, x2, y2]
  ) {
    return arr.asMap().entries.map((entry) {
      final i = entry.key;
      final n = entry.value;
      final lastIndex = arr.length - 1;
      final diff = arr[0] - to;
      double fn(double t) =>
          _bezierEasing(t, curve[0], curve[1], curve[2], curve[3]);
      return n - diff * fn(1 - i / lastIndex);
    }).toList();
  }
}

/// Generated Radix colors
class RadixGeneratedColors {
  final List<Color> accentScale; // 12 steps
  final List<Color> accentScaleAlpha; // 12 steps with alpha
  final List<Color> grayScale; // 12 steps
  final List<Color> grayScaleAlpha; // 12 steps with alpha
  final Color accentContrast;
  final Color accentSurface;
  final Color background;

  RadixGeneratedColors({
    required this.accentScale,
    required this.accentScaleAlpha,
    required this.grayScale,
    required this.grayScaleAlpha,
    required this.accentContrast,
    required this.accentSurface,
    required this.background,
  });

  /// Get hex string for a color
  String colorToHex(Color color) {
    final argb = color.value;
    final hex = argb.toRadixString(16).padLeft(8, '0');
    return '#${hex.substring(2).toUpperCase()}';
  }

  /// Get hex string for a color with alpha (8-character format: #RRGGBBAA)
  String colorToHexWithAlpha(Color color) {
    // Color.value is ARGB format: 0xAARRGGBB
    final argb = color.value;
    final r = (argb >> 16) & 0xFF;
    final g = (argb >> 8) & 0xFF;
    final b = argb & 0xFF;
    final a = (argb >> 24) & 0xFF;

    // Format as #RRGGBBAA
    return '#${r.toRadixString(16).padLeft(2, '0')}'
        '${g.toRadixString(16).padLeft(2, '0')}'
        '${b.toRadixString(16).padLeft(2, '0')}'
        '${a.toRadixString(16).padLeft(2, '0')}';
  }

  /// Get all colors as a map for easy access
  Map<String, dynamic> toMap() {
    return {
      'accentScale': accentScale.map((c) => colorToHex(c)).toList(),
      'accentScaleAlpha': accentScaleAlpha.map((c) => colorToHex(c)).toList(),
      'grayScale': grayScale.map((c) => colorToHex(c)).toList(),
      'grayScaleAlpha': grayScaleAlpha.map((c) => colorToHex(c)).toList(),
      'accentContrast': colorToHex(accentContrast),
      'accentSurface': colorToHex(accentSurface),
      'background': colorToHex(background),
    };
  }
}

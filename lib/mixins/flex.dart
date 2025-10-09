import 'package:flutter/material.dart';

import '../core/style.dart';
import '../core/theme.dart';
import 'value.dart';

/// Utility class for handling Tailwind-like flex logic
class FlyFlexUtils {
  /// Resolves flex value from FlyStyle
  static int? resolveFlex(BuildContext context, FlyStyle style) {
    if (style.flex == null) return null;

    // Handle string values
    if (style.flex is String) {
      switch (style.flex) {
        case 'auto':
          return 1; // Flexible(flex: 1, fit: FlexFit.loose)
        case 'initial':
          return 0; // Flexible(flex: 0, fit: FlexFit.loose)
        case 'none':
          return null; // No flex wrapper (fixed size)
        default:
          // Try to parse as number
          final parsed = int.tryParse(style.flex);
          return parsed;
      }
    }

    // Handle numeric values
    if (style.flex is int) {
      return style.flex;
    }

    return null;
  }

  /// Resolves flex grow value from FlyStyle
  static int? resolveFlexGrow(BuildContext context, FlyStyle style) {
    if (style.grow == null) return null;

    if (style.grow is int) {
      return style.grow;
    }

    if (style.grow is String) {
      return int.tryParse(style.grow);
    }

    return null;
  }

  /// Resolves flex shrink value from FlyStyle
  static int? resolveFlexShrink(BuildContext context, FlyStyle style) {
    if (style.shrink == null) return null;

    if (style.shrink is int) {
      return style.shrink;
    }

    if (style.shrink is String) {
      return int.tryParse(style.shrink);
    }

    return null;
  }

  /// Resolves flex basis value from FlyStyle
  static double? resolveFlexBasis(BuildContext context, FlyStyle style) {
    if (style.basis == null) return null;

    final spacing = FlyTheme.of(context).spacing;
    return FlyValue.resolveDouble(style.basis, context, spacing);
  }

  /// Resolves FlexFit from flex value
  static FlexFit resolveFlexFit(BuildContext context, FlyStyle style) {
    if (style.flex == 'auto' || style.flex == 'initial') {
      return FlexFit.loose;
    }
    return FlexFit.tight;
  }

  /// Applies flex properties to a widget
  static Widget apply(BuildContext context, FlyStyle style, Widget child) {
    final flex = resolveFlex(context, style);
    final flexGrow = resolveFlexGrow(context, style);
    final flexShrink = resolveFlexShrink(context, style);
    final flexBasis = resolveFlexBasis(context, style);

    // If grow is specified, use Expanded
    if (flexGrow != null && flexGrow > 0) {
      return Expanded(flex: flexGrow, child: child);
    }

    // If flex is specified, use Flexible
    if (flex != null) {
      // Handle 'none' case - return child without flex wrapper
      if (style.flex == 'none') {
        return child;
      }

      final fit = resolveFlexFit(context, style);

      return Flexible(flex: flex, fit: fit, child: child);
    }

    // If only shrink or basis is specified, use Flexible with default flex
    if (flexShrink != null || flexBasis != null) {
      return Flexible(flex: flexShrink ?? 1, fit: FlexFit.loose, child: child);
    }

    // No flex properties, return child as-is
    return child;
  }

  /// Check if any flex properties are set
  static bool hasFlexProperties(FlyStyle style) {
    return style.flex != null ||
        style.grow != null ||
        style.shrink != null ||
        style.basis != null;
  }
}

/// Mixin that provides Tailwind-like flex methods for any widget
mixin FlyFlex<T> {
  FlyStyle get flyStyle;

  T Function(FlyStyle newStyle) get copyWith;

  /// Set flex value - accepts int (1-12) or String ('auto', 'initial', 'none')
  /// This method can be chained with other flex methods, with later calls overriding earlier ones
  T flex(dynamic value) {
    return copyWith(flyStyle.copyWith(flex: value));
  }

  /// Set flex grow - accepts int (0-2)
  /// This method can be chained with other flex methods, with later calls overriding earlier ones
  T grow(int value) {
    return copyWith(flyStyle.copyWith(grow: value));
  }

  /// Set flex shrink - accepts int (0-1)
  /// This method can be chained with other flex methods, with later calls overriding earlier ones
  T shrink(int value) {
    return copyWith(flyStyle.copyWith(shrink: value));
  }

  /// Set flex basis - accepts String ('s32', 's40', 's48', etc.)
  /// This method can be chained with other flex methods, with later calls overriding earlier ones
  T basis(String value) {
    return copyWith(flyStyle.copyWith(basis: value));
  }

  /// Check if any flex properties are set
  bool get hasFlexProperties {
    return FlyFlexUtils.hasFlexProperties(flyStyle);
  }

  /// Apply flex properties to a widget
  Widget applyFlex(BuildContext context, Widget child) {
    return FlyFlexUtils.apply(context, flyStyle, child);
  }
}

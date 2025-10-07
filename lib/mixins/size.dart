import 'package:flutter/material.dart';

import '../core/style.dart';
import '../core/theme.dart';
import '../tokens/spacing.dart';
import 'value.dart';

/// Utility class for handling Tailwind-like size logic
class FlySizeUtils {
  /// Resolves height from FlyStyle and FlyTheme into double
  static double? resolveHeight(BuildContext context, FlyStyle style) {
    if (style.h == null) return null;

    try {
      final spacing = FlyTheme.of(context).spacing;
      return _resolveValue(style.h, context, spacing);
    } catch (e) {
      throw ArgumentError('Failed to resolve height: $e');
    }
  }

  /// Resolves width from FlyStyle and FlyTheme into double
  static double? resolveWidth(BuildContext context, FlyStyle style) {
    if (style.w == null) return null;

    try {
      final spacing = FlyTheme.of(context).spacing;
      return _resolveValue(style.w, context, spacing);
    } catch (e) {
      throw ArgumentError('Failed to resolve width: $e');
    }
  }

  /// Resolves max height from FlyStyle and FlyTheme into double
  static double? resolveMaxHeight(BuildContext context, FlyStyle style) {
    if (style.maxH == null) return null;

    try {
      final spacing = FlyTheme.of(context).spacing;
      return _resolveValue(style.maxH, context, spacing);
    } catch (e) {
      throw ArgumentError('Failed to resolve max height: $e');
    }
  }

  /// Resolves max width from FlyStyle and FlyTheme into double
  static double? resolveMaxWidth(BuildContext context, FlyStyle style) {
    if (style.maxW == null) return null;

    try {
      final spacing = FlyTheme.of(context).spacing;
      return _resolveValue(style.maxW, context, spacing);
    } catch (e) {
      throw ArgumentError('Failed to resolve max width: $e');
    }
  }

  /// Resolves min height from FlyStyle and FlyTheme into double
  static double? resolveMinHeight(BuildContext context, FlyStyle style) {
    if (style.minH == null) return null;

    try {
      final spacing = FlyTheme.of(context).spacing;
      return _resolveValue(style.minH, context, spacing);
    } catch (e) {
      throw ArgumentError('Failed to resolve min height: $e');
    }
  }

  /// Resolves min width from FlyStyle and FlyTheme into double
  static double? resolveMinWidth(BuildContext context, FlyStyle style) {
    if (style.minW == null) return null;

    try {
      final spacing = FlyTheme.of(context).spacing;
      return _resolveValue(style.minW, context, spacing);
    } catch (e) {
      throw ArgumentError('Failed to resolve min width: $e');
    }
  }

  /// Resolves a dynamic value to double using the numeric value resolver
  static double _resolveValue(
    dynamic value,
    BuildContext context,
    FlySpacingToken tokens,
  ) {
    if (value == null) return 0;
    return FlyValue.resolveDouble(value, context, tokens);
  }

  /// Applies size constraints to a widget using the resolved values
  static Widget apply(BuildContext context, FlyStyle style, Widget child) {
    final height = resolveHeight(context, style);
    final width = resolveWidth(context, style);
    final maxHeight = resolveMaxHeight(context, style);
    final maxWidth = resolveMaxWidth(context, style);
    final minHeight = resolveMinHeight(context, style);
    final minWidth = resolveMinWidth(context, style);

    // If no size constraints are set, return the child as-is
    if (height == null &&
        width == null &&
        maxHeight == null &&
        maxWidth == null &&
        minHeight == null &&
        minWidth == null) {
      return child;
    }

    // If we have max/min constraints, use ConstrainedBox
    if (maxHeight != null ||
        maxWidth != null ||
        minHeight != null ||
        minWidth != null) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth ?? 0,
          maxWidth: maxWidth ?? double.infinity,
          minHeight: minHeight ?? 0,
          maxHeight: maxHeight ?? double.infinity,
        ),
        child: SizedBox(height: height, width: width, child: child),
      );
    }

    // If only fixed size constraints, use SizedBox
    return SizedBox(height: height, width: width, child: child);
  }
}

/// Mixin that provides Tailwind-like size methods for any widget
mixin FlySize<T> {
  FlyStyle get flyStyle;

  T Function(FlyStyle newStyle) get copyWith;

  /// Set height - accepts int, double, or String (token name/unit)
  T h(dynamic value) {
    return copyWith(flyStyle.copyWith(h: value));
  }

  /// Set width - accepts int, double, or String (token name/unit)
  T w(dynamic value) {
    return copyWith(flyStyle.copyWith(w: value));
  }

  /// Set max height - accepts int, double, or String (token name/unit)
  T maxH(dynamic value) {
    return copyWith(flyStyle.copyWith(maxH: value));
  }

  /// Set max width - accepts int, double, or String (token name/unit)
  T maxW(dynamic value) {
    return copyWith(flyStyle.copyWith(maxW: value));
  }

  /// Set min height - accepts int, double, or String (token name/unit)
  T minH(dynamic value) {
    return copyWith(flyStyle.copyWith(minH: value));
  }

  /// Set min width - accepts int, double, or String (token name/unit)
  T minW(dynamic value) {
    return copyWith(flyStyle.copyWith(minW: value));
  }

  /// Resolves height from FlyStyle and FlyTheme into double
  double? resolveHeight(BuildContext context) {
    return FlySizeUtils.resolveHeight(context, flyStyle);
  }

  /// Resolves width from FlyStyle and FlyTheme into double
  double? resolveWidth(BuildContext context) {
    return FlySizeUtils.resolveWidth(context, flyStyle);
  }

  /// Resolves max height from FlyStyle and FlyTheme into double
  double? resolveMaxHeight(BuildContext context) {
    return FlySizeUtils.resolveMaxHeight(context, flyStyle);
  }

  /// Resolves max width from FlyStyle and FlyTheme into double
  double? resolveMaxWidth(BuildContext context) {
    return FlySizeUtils.resolveMaxWidth(context, flyStyle);
  }

  /// Resolves min height from FlyStyle and FlyTheme into double
  double? resolveMinHeight(BuildContext context) {
    return FlySizeUtils.resolveMinHeight(context, flyStyle);
  }

  /// Resolves min width from FlyStyle and FlyTheme into double
  double? resolveMinWidth(BuildContext context) {
    return FlySizeUtils.resolveMinWidth(context, flyStyle);
  }

  /// Applies size constraints to a widget using the resolved values
  Widget applySize(BuildContext context, Widget child) {
    return FlySizeUtils.apply(context, flyStyle, child);
  }
}

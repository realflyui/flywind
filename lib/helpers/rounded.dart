import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../tokens/radius.dart';
import 'style.dart';
import 'value.dart';

/// Utility class for handling Tailwind-like rounded logic
class FlyRoundedUtils {
  /// Resolves rounded values from FlyStyle and FlyThemeData into BorderRadius
  static BorderRadius resolve(BuildContext context, FlyStyle style) {
    try {
      final radius = FlyTheme.of(context).radius;

      return BorderRadius.only(
        topLeft: Radius.circular(
          _resolveValue(
            style.roundedTl ??
                style.roundedT ??
                style.roundedL ??
                style.rounded,
            context,
            radius,
          ),
        ),
        topRight: Radius.circular(
          _resolveValue(
            style.roundedTr ??
                style.roundedT ??
                style.roundedR ??
                style.rounded,
            context,
            radius,
          ),
        ),
        bottomLeft: Radius.circular(
          _resolveValue(
            style.roundedBl ??
                style.roundedB ??
                style.roundedL ??
                style.rounded,
            context,
            radius,
          ),
        ),
        bottomRight: Radius.circular(
          _resolveValue(
            style.roundedBr ??
                style.roundedB ??
                style.roundedR ??
                style.rounded,
            context,
            radius,
          ),
        ),
      );
    } catch (e) {
      throw ArgumentError('Failed to resolve border radius: $e');
    }
  }

  /// Resolves a dynamic value to double using the numeric value resolver
  static double _resolveValue(
    dynamic value,
    BuildContext context,
    FlyRadiusToken tokens,
  ) {
    if (value == null) return 0;
    return FlyValue.resolveDouble(value, context, tokens);
  }

  /// Applies rounded styling to a widget using the resolved BorderRadius
  static Widget apply(BuildContext context, FlyStyle style, Widget child) {
    final borderRadius = resolve(context, style);

    // If no border radius is set, return the child as-is
    if (borderRadius == BorderRadius.zero) {
      return child;
    }

    // Apply border radius using ClipRRect
    return ClipRRect(borderRadius: borderRadius, child: child);
  }
}

/// Mixin that provides Tailwind-like rounded methods for any widget
mixin FlyRounded<T> {
  FlyStyle get flyStyle;

  T Function(FlyStyle newStyle) get copyWith;

  /// Set uniform rounded styling - accepts int, double, or String (token name/unit)
  T rounded(dynamic value) {
    return copyWith(flyStyle.copyWith(rounded: value));
  }

  /// Set top rounded styling (top-left + top-right) - accepts int, double, or String (token name/unit)
  T roundedT(dynamic value) {
    return copyWith(flyStyle.copyWith(roundedT: value));
  }

  /// Set right rounded styling (top-right + bottom-right) - accepts int, double, or String (token name/unit)
  T roundedR(dynamic value) {
    return copyWith(flyStyle.copyWith(roundedR: value));
  }

  /// Set bottom rounded styling (bottom-left + bottom-right) - accepts int, double, or String (token name/unit)
  T roundedB(dynamic value) {
    return copyWith(flyStyle.copyWith(roundedB: value));
  }

  /// Set left rounded styling (top-left + bottom-left) - accepts int, double, or String (token name/unit)
  T roundedL(dynamic value) {
    return copyWith(flyStyle.copyWith(roundedL: value));
  }

  /// Set top-left rounded styling - accepts int, double, or String (token name/unit)
  T roundedTl(dynamic value) {
    return copyWith(flyStyle.copyWith(roundedTl: value));
  }

  /// Set top-right rounded styling - accepts int, double, or String (token name/unit)
  T roundedTr(dynamic value) {
    return copyWith(flyStyle.copyWith(roundedTr: value));
  }

  /// Set bottom-left rounded styling - accepts int, double, or String (token name/unit)
  T roundedBl(dynamic value) {
    return copyWith(flyStyle.copyWith(roundedBl: value));
  }

  /// Set bottom-right rounded styling - accepts int, double, or String (token name/unit)
  T roundedBr(dynamic value) {
    return copyWith(flyStyle.copyWith(roundedBr: value));
  }

  /// Resolves rounded styling from FlyStyle and FlyConfig into BorderRadius
  BorderRadius resolveRounded(BuildContext context) {
    return FlyRoundedUtils.resolve(context, flyStyle);
  }

  /// Applies rounded styling to a widget using the resolved BorderRadius
  Widget applyRounded(BuildContext context, Widget child) {
    return FlyRoundedUtils.apply(context, flyStyle, child);
  }
}

import 'package:flutter/material.dart';
import 'style.dart';

/// Utility class for handling Tailwind-like rounded logic
class FlyRoundedUtils {
  /// Resolves rounded values from FlyStyle and FlyThemeData into BorderRadius
  static BorderRadius resolve(BuildContext context, FlyStyle style) {
    // Calculate border radius values
    double topLeft = 0;
    double topRight = 0;
    double bottomLeft = 0;
    double bottomRight = 0;

    // Apply uniform border radius
    final uniformValue = style.rounded;
    if (uniformValue != null) {
      topLeft = topRight = bottomLeft = bottomRight = uniformValue;
    }

    // Apply directional border radius (these override uniform border radius)
    final topValue = style.roundedT;
    if (topValue != null) {
      topLeft = topRight = topValue;
    }
    final rightValue = style.roundedR;
    if (rightValue != null) {
      topRight = bottomRight = rightValue;
    }
    final bottomValue = style.roundedB;
    if (bottomValue != null) {
      bottomLeft = bottomRight = bottomValue;
    }
    final leftValue = style.roundedL;
    if (leftValue != null) {
      topLeft = bottomLeft = leftValue;
    }

    // Apply individual corner border radius (these override directional border radius)
    final topLeftValue = style.roundedTl;
    if (topLeftValue != null) {
      topLeft = topLeftValue;
    }
    final topRightValue = style.roundedTr;
    if (topRightValue != null) {
      topRight = topRightValue;
    }
    final bottomLeftValue = style.roundedBl;
    if (bottomLeftValue != null) {
      bottomLeft = bottomLeftValue;
    }
    final bottomRightValue = style.roundedBr;
    if (bottomRightValue != null) {
      bottomRight = bottomRightValue;
    }

    return BorderRadius.only(
      topLeft: Radius.circular(topLeft),
      topRight: Radius.circular(topRight),
      bottomLeft: Radius.circular(bottomLeft),
      bottomRight: Radius.circular(bottomRight),
    );
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
  FlyStyle get style;

  T Function(FlyStyle newStyle) get copyWith;

  /// Set uniform rounded styling using double values
  T rounded(double value) {
    return copyWith(style.copyWith(rounded: value));
  }

  /// Set top rounded styling (top-left + top-right) using double values
  T roundedT(double value) {
    return copyWith(style.copyWith(roundedT: value));
  }

  /// Set right rounded styling (top-right + bottom-right) using double values
  T roundedR(double value) {
    return copyWith(style.copyWith(roundedR: value));
  }

  /// Set bottom rounded styling (bottom-left + bottom-right) using double values
  T roundedB(double value) {
    return copyWith(style.copyWith(roundedB: value));
  }

  /// Set left rounded styling (top-left + bottom-left) using double values
  T roundedL(double value) {
    return copyWith(style.copyWith(roundedL: value));
  }

  /// Set top-left rounded styling using double values
  T roundedTl(double value) {
    return copyWith(style.copyWith(roundedTl: value));
  }

  /// Set top-right rounded styling using double values
  T roundedTr(double value) {
    return copyWith(style.copyWith(roundedTr: value));
  }

  /// Set bottom-left rounded styling using double values
  T roundedBl(double value) {
    return copyWith(style.copyWith(roundedBl: value));
  }

  /// Set bottom-right rounded styling using double values
  T roundedBr(double value) {
    return copyWith(style.copyWith(roundedBr: value));
  }

  /// Resolves rounded styling from FlyStyle and FlyConfig into BorderRadius
  BorderRadius resolveRounded(BuildContext context) {
    return FlyRoundedUtils.resolve(context, style);
  }

  /// Applies rounded styling to a widget using the resolved BorderRadius
  Widget applyRounded(BuildContext context, Widget child) {
    return FlyRoundedUtils.apply(context, style, child);
  }
}

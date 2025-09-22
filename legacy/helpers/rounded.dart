import 'package:flutter/material.dart';
import '../tokens/radius.dart';
import 'style.dart';
import 'theme.dart';

/// Utility class for handling Tailwind-like rounded logic
class FlyRoundedUtils {
  /// Resolves rounded values from FlyStyle and FlyConfig into BorderRadius
  static BorderRadius resolve(BuildContext context, FlyStyle style) {
    final theme = Theme.of(context);
    final flywind = theme.extension<FlyTheme>();
    if (flywind == null) {
      throw FlutterError(
        'FlyTheme extension not found. Make sure to add FlyTheme to your ThemeData.extensions',
      );
    }
    final config = flywind;
    final borderRadius = config.radius;

    // Calculate border radius values
    double topLeft = 0;
    double topRight = 0;
    double bottomLeft = 0;
    double bottomRight = 0;

    // Apply uniform border radius
    final uniformValue = style.rounded;
    if (uniformValue != null) {
      final value = _getRoundedValue(borderRadius, uniformValue, 'uniform');
      topLeft = topRight = bottomLeft = bottomRight = value;
    }

    // Apply directional border radius (these override uniform border radius)
    final topValue = style.roundedT;
    if (topValue != null) {
      final value = _getRoundedValue(borderRadius, topValue, 'top');
      topLeft = topRight = value;
    }
    final rightValue = style.roundedR;
    if (rightValue != null) {
      final value = _getRoundedValue(borderRadius, rightValue, 'right');
      topRight = bottomRight = value;
    }
    final bottomValue = style.roundedB;
    if (bottomValue != null) {
      final value = _getRoundedValue(borderRadius, bottomValue, 'bottom');
      bottomLeft = bottomRight = value;
    }
    final leftValue = style.roundedL;
    if (leftValue != null) {
      final value = _getRoundedValue(borderRadius, leftValue, 'left');
      topLeft = bottomLeft = value;
    }

    // Apply individual corner border radius (these override directional border radius)
    final topLeftValue = style.roundedTl;
    if (topLeftValue != null) {
      topLeft = _getRoundedValue(borderRadius, topLeftValue, 'top-left');
    }
    final topRightValue = style.roundedTr;
    if (topRightValue != null) {
      topRight = _getRoundedValue(borderRadius, topRightValue, 'top-right');
    }
    final bottomLeftValue = style.roundedBl;
    if (bottomLeftValue != null) {
      bottomLeft = _getRoundedValue(
        borderRadius,
        bottomLeftValue,
        'bottom-left',
      );
    }
    final bottomRightValue = style.roundedBr;
    if (bottomRightValue != null) {
      bottomRight = _getRoundedValue(
        borderRadius,
        bottomRightValue,
        'bottom-right',
      );
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

  /// Gets rounded value with error handling for invalid keys
  static double _getRoundedValue(
    FlyBorderRadius borderRadius,
    String input,
    String direction,
  ) {
    // First try to look up as a key
    final valueString = borderRadius[input];
    if (valueString != null) {
      final value = double.tryParse(valueString);
      if (value != null) {
        return value;
      }
    }

    // If not found as key, try to parse as direct value
    final directValue = double.tryParse(input);
    if (directValue != null) {
      return directValue;
    }

    // If neither works, show error
    _handleMissingRounded(input, direction, borderRadius.values.keys.toList());
    return 0.0;
  }

  /// Handles missing rounded errors with helpful messages
  static void _handleMissingRounded(
    String roundedKey,
    String direction,
    List<String> availableKeys,
  ) {
    final sortedKeys = availableKeys.toList()..sort();

    String errorMessage =
        'Rounded key "$roundedKey" not found in FlyConfig for $direction rounded. Available rounded keys: ${sortedKeys.join(', ')}.';

    // In debug mode, throw an assertion error with helpful message
    assert(false, errorMessage);

    // In release mode, print a warning
    print('⚠️ FlyRounded Warning: $errorMessage');
  }
}

/// Mixin that provides Tailwind-like rounded methods for any widget
mixin FlyRounded<T> {
  FlyStyle get style;

  T Function(FlyStyle newStyle) get copyWith;

  /// Set uniform rounded styling using Tailwind scale
  T rounded([String? size]) {
    return copyWith(style.copyWith(rounded: size));
  }

  /// Set top rounded styling (top-left + top-right) using Tailwind scale
  T roundedT([String size = '']) {
    return copyWith(style.copyWith(roundedT: size));
  }

  /// Set right rounded styling (top-right + bottom-right) using Tailwind scale
  T roundedR([String size = '']) {
    return copyWith(style.copyWith(roundedR: size));
  }

  /// Set bottom rounded styling (bottom-left + bottom-right) using Tailwind scale
  T roundedB([String size = '']) {
    return copyWith(style.copyWith(roundedB: size));
  }

  /// Set left rounded styling (top-left + bottom-left) using Tailwind scale
  T roundedL([String size = '']) {
    return copyWith(style.copyWith(roundedL: size));
  }

  /// Set top-left rounded styling using Tailwind scale
  T roundedTl([String size = '']) {
    return copyWith(style.copyWith(roundedTl: size));
  }

  /// Set top-right rounded styling using Tailwind scale
  T roundedTr([String size = '']) {
    return copyWith(style.copyWith(roundedTr: size));
  }

  /// Set bottom-left rounded styling using Tailwind scale
  T roundedBl([String size = '']) {
    return copyWith(style.copyWith(roundedBl: size));
  }

  /// Set bottom-right rounded styling using Tailwind scale
  T roundedBr([String size = '']) {
    return copyWith(style.copyWith(roundedBr: size));
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

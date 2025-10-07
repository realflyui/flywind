import 'package:flutter/material.dart';

import '../core/style.dart';
import '../core/theme.dart';
import 'value.dart';

/// Utility class for handling Tailwind-like position logic
class FlyPositionUtils {
  /// Resolves position value from FlyStyle
  static double? resolvePosition(
    BuildContext context,
    FlyStyle style,
    String property,
  ) {
    dynamic value;

    switch (property) {
      case 'top':
        value = style.top;
        break;
      case 'right':
        value = style.right;
        break;
      case 'bottom':
        value = style.bottom;
        break;
      case 'left':
        value = style.left;
        break;
      default:
        return null;
    }

    if (value == null) return null;

    // Handle string values (spacing tokens)
    if (value is String) {
      final spacing = FlyTheme.of(context).spacing;
      return FlyValue.resolveDouble(value, context, spacing);
    }

    // Handle numeric values
    if (value is num) {
      return value.toDouble();
    }

    return null;
  }

  /// Resolves inset value from FlyStyle
  static double? resolveInset(BuildContext context, FlyStyle style) {
    if (style.inset == null) return null;

    // Handle string values (spacing tokens)
    if (style.inset is String) {
      final spacing = FlyTheme.of(context).spacing;
      return FlyValue.resolveDouble(style.inset, context, spacing);
    }

    // Handle numeric values
    if (style.inset is num) {
      return style.inset.toDouble();
    }

    return null;
  }

  /// Resolves insetX value from FlyStyle
  static double? resolveInsetX(BuildContext context, FlyStyle style) {
    if (style.insetX == null) return null;

    // Handle string values (spacing tokens)
    if (style.insetX is String) {
      final spacing = FlyTheme.of(context).spacing;
      return FlyValue.resolveDouble(style.insetX, context, spacing);
    }

    // Handle numeric values
    if (style.insetX is num) {
      return style.insetX.toDouble();
    }

    return null;
  }

  /// Resolves insetY value from FlyStyle
  static double? resolveInsetY(BuildContext context, FlyStyle style) {
    if (style.insetY == null) return null;

    // Handle string values (spacing tokens)
    if (style.insetY is String) {
      final spacing = FlyTheme.of(context).spacing;
      return FlyValue.resolveDouble(style.insetY, context, spacing);
    }

    // Handle numeric values
    if (style.insetY is num) {
      return style.insetY.toDouble();
    }

    return null;
  }

  /// Applies position properties to a widget
  static Widget apply(BuildContext context, FlyStyle style, Widget child) {
    final top = resolvePosition(context, style, 'top');
    final right = resolvePosition(context, style, 'right');
    final bottom = resolvePosition(context, style, 'bottom');
    final left = resolvePosition(context, style, 'left');
    final inset = resolveInset(context, style);
    final insetX = resolveInsetX(context, style);
    final insetY = resolveInsetY(context, style);

    // If inset is specified, apply to all sides
    if (inset != null) {
      return Positioned(
        top: inset,
        right: inset,
        bottom: inset,
        left: inset,
        child: child,
      );
    }

    // If insetX is specified, apply to left and right
    if (insetX != null) {
      return Positioned(
        left: insetX,
        right: insetX,
        top: top,
        bottom: bottom,
        child: child,
      );
    }

    // If insetY is specified, apply to top and bottom
    if (insetY != null) {
      return Positioned(
        top: insetY,
        bottom: insetY,
        left: left,
        right: right,
        child: child,
      );
    }

    // Apply individual position values
    if (top != null || right != null || bottom != null || left != null) {
      return Positioned(
        top: top,
        right: right,
        bottom: bottom,
        left: left,
        child: child,
      );
    }

    // No position properties, return child as-is
    return child;
  }

  /// Check if any position properties are set
  static bool hasPositionProperties(FlyStyle style) {
    return style.top != null ||
        style.right != null ||
        style.bottom != null ||
        style.left != null ||
        style.inset != null ||
        style.insetX != null ||
        style.insetY != null;
  }
}

/// Mixin that provides Tailwind-like position methods for any widget
mixin FlyPosition<T> {
  FlyStyle get flyStyle;

  T Function(FlyStyle newStyle) get copyWith;

  /// Set top position - accepts int, double, or String (token name like 's2', 's4', etc.)
  T top(dynamic value) {
    return copyWith(flyStyle.copyWith(top: value));
  }

  /// Set right position - accepts int, double, or String (token name like 's2', 's4', etc.)
  T right(dynamic value) {
    return copyWith(flyStyle.copyWith(right: value));
  }

  /// Set bottom position - accepts int, double, or String (token name like 's2', 's4', etc.)
  T bottom(dynamic value) {
    return copyWith(flyStyle.copyWith(bottom: value));
  }

  /// Set left position - accepts int, double, or String (token name like 's2', 's4', etc.)
  T left(dynamic value) {
    return copyWith(flyStyle.copyWith(left: value));
  }

  /// Set inset (all sides) - accepts int, double, or String (token name like 's2', 's4', etc.)
  T inset(dynamic value) {
    return copyWith(flyStyle.copyWith(inset: value));
  }

  /// Set insetX (left and right) - accepts int, double, or String (token name like 's2', 's4', etc.)
  T insetX(dynamic value) {
    return copyWith(flyStyle.copyWith(insetX: value));
  }

  /// Set insetY (top and bottom) - accepts int, double, or String (token name like 's2', 's4', etc.)
  T insetY(dynamic value) {
    return copyWith(flyStyle.copyWith(insetY: value));
  }

  /// Check if any position properties are set
  bool get hasPositionProperties {
    return FlyPositionUtils.hasPositionProperties(flyStyle);
  }

  /// Apply position properties to a widget
  Widget applyPosition(BuildContext context, Widget child) {
    return FlyPositionUtils.apply(context, flyStyle, child);
  }
}

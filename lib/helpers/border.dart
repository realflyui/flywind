import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../core/style.dart';
import '../core/theme.dart';
import '../tokens/color.dart';
import '../tokens/spacing.dart';
import 'rounded.dart';
import 'value.dart';

/// Utility class for handling Tailwind-like border logic
class FlyBorderUtils {
  /// Resolves border from FlyStyle and FlyTheme into Border
  static Border resolve(BuildContext context, FlyStyle style) {
    try {
      final spacing = FlyTheme.of(context).spacing;
      final colors = FlyTheme.of(context).colors;

      // Check if any border is set
      if (!_hasBorder(style)) return Border.all(width: 0);

      // Resolve border color
      final borderColor = _resolveBorderColor(style, context, colors);
      if (borderColor == null) return Border.all(width: 0);

      // Resolve border style
      final borderStyle = _resolveBorderStyle(style);

      // Resolve individual border sides
      final topWidth = _resolveBorderSideWidth(
        style.borderT ?? style.border,
        context,
        spacing,
      );
      final rightWidth = _resolveBorderSideWidth(
        style.borderR ?? style.border,
        context,
        spacing,
      );
      final bottomWidth = _resolveBorderSideWidth(
        style.borderB ?? style.border,
        context,
        spacing,
      );
      final leftWidth = _resolveBorderSideWidth(
        style.borderL ?? style.border,
        context,
        spacing,
      );

      return Border(
        top: topWidth > 0
            ? BorderSide(
                width: topWidth,
                color: borderColor,
                style: borderStyle,
              )
            : BorderSide.none,
        right: rightWidth > 0
            ? BorderSide(
                width: rightWidth,
                color: borderColor,
                style: borderStyle,
              )
            : BorderSide.none,
        bottom: bottomWidth > 0
            ? BorderSide(
                width: bottomWidth,
                color: borderColor,
                style: borderStyle,
              )
            : BorderSide.none,
        left: leftWidth > 0
            ? BorderSide(
                width: leftWidth,
                color: borderColor,
                style: borderStyle,
              )
            : BorderSide.none,
      );
    } catch (e) {
      throw ArgumentError('Failed to resolve border: $e');
    }
  }

  /// Resolves border width for a specific side
  static double _resolveBorderSideWidth(
    dynamic value,
    BuildContext context,
    FlySpacingToken tokens,
  ) {
    if (value == null) return 0;
    return FlyValue.resolveDouble(value, context, tokens);
  }

  /// Resolves border color from style properties
  static Color? _resolveBorderColor(
    FlyStyle style,
    BuildContext context,
    FlyColorToken tokens,
  ) {
    if (style.borderColor == null) return Colors.black; // Default border color
    return FlyValue.resolveColor(style.borderColor, context, tokens);
  }

  /// Resolves border style from style properties
  static BorderStyle _resolveBorderStyle(FlyStyle style) {
    if (style.borderStyle == null) return BorderStyle.solid;

    switch (style.borderStyle.toString().toLowerCase()) {
      case 'dashed':
        return BorderStyle.solid; // Flutter doesn't have dashed, use solid
      case 'dotted':
        return BorderStyle.solid; // Flutter doesn't have dotted, use solid
      case 'none':
        return BorderStyle.none;
      case 'hidden':
        return BorderStyle.none;
      default:
        return BorderStyle.solid;
    }
  }

  /// Checks if custom border rendering is needed (dashed, dotted)
  static bool needsCustomBorder(FlyStyle style) {
    if (style.borderStyle == null) return false;

    final borderStyle = style.borderStyle.toString().toLowerCase();
    return borderStyle == 'dashed' || borderStyle == 'dotted';
  }

  /// Gets the dash pattern for custom borders
  static List<double> getDashPattern(FlyStyle style) {
    if (style.borderStyle == null) return [5, 5];

    switch (style.borderStyle.toString().toLowerCase()) {
      case 'dashed':
        return [10, 5]; // Longer dashes
      case 'dotted':
        return [2, 2]; // Small dots
      default:
        return [5, 5];
    }
  }

  /// Check if any border properties are set
  static bool _hasBorder(FlyStyle style) {
    return style.border != null ||
        style.borderT != null ||
        style.borderR != null ||
        style.borderB != null ||
        style.borderL != null;
  }

  /// Creates a border widget that handles custom borders (dashed, dotted)
  static Widget createBorderWidget(
    BuildContext context,
    FlyStyle style,
    Widget child,
  ) {
    return _createCustomBorder(context, style, child);
  }

  /// Creates custom border using DottedBorder for dashed and dotted styles
  static Widget _createCustomBorder(
    BuildContext context,
    FlyStyle style,
    Widget child,
  ) {
    final spacing = FlyTheme.of(context).spacing;
    final colors = FlyTheme.of(context).colors;

    // Resolve border properties
    final borderWidth = _resolveBorderSideWidth(
      style.borderT ??
          style.borderR ??
          style.borderB ??
          style.borderL ??
          style.border,
      context,
      spacing,
    );
    final borderColor = _resolveBorderColor(style, context, colors);
    final dashPattern = getDashPattern(style);

    if (borderWidth <= 0 || borderColor == null) return child;

    // Get border radius for rounded corners
    final borderRadius = _getBorderRadius(context, style);

    // Regular dashed or dotted border
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        dashPattern: dashPattern,
        strokeWidth: borderWidth,
        radius: borderRadius,
        color: borderColor,
        padding: EdgeInsets.zero,
      ),
      child: child,
    );
  }

  /// Gets border radius for custom borders
  static Radius _getBorderRadius(BuildContext context, FlyStyle style) {
    // Use FlyRoundedUtils to get the proper border radius
    final borderRadius = FlyRoundedUtils.resolve(context, style);

    // Return the top-left radius as the representative radius
    // DottedBorder will use this for all corners
    return borderRadius.topLeft;
  }

  /// Applies border styling to a widget using the resolved Border
  static Widget apply(BuildContext context, FlyStyle style, Widget child) {
    // Check if any border is set
    if (!_hasBorder(style)) {
      return child;
    }

    // Handle custom borders (dashed, dotted, double)
    if (needsCustomBorder(style)) {
      return createBorderWidget(context, style, child);
    }

    // For solid borders, return child as-is since border will be applied via decoration
    // The container will handle the border through BoxDecoration
    return child;
  }
}

/// Mixin that provides Tailwind-like border methods for any widget
mixin FlyBorder<T> {
  FlyStyle get flyStyle;

  T Function(FlyStyle newStyle) get copyWith;

  /// Set uniform border width - accepts int, double, or String (token name/unit)
  T border(dynamic value) {
    return copyWith(flyStyle.copyWith(border: value));
  }

  /// Set top border width - accepts int, double, or String (token name/unit)
  T borderT(dynamic value) {
    return copyWith(flyStyle.copyWith(borderT: value));
  }

  /// Set right border width - accepts int, double, or String (token name/unit)
  T borderR(dynamic value) {
    return copyWith(flyStyle.copyWith(borderR: value));
  }

  /// Set bottom border width - accepts int, double, or String (token name/unit)
  T borderB(dynamic value) {
    return copyWith(flyStyle.copyWith(borderB: value));
  }

  /// Set left border width - accepts int, double, or String (token name/unit)
  T borderL(dynamic value) {
    return copyWith(flyStyle.copyWith(borderL: value));
  }

  /// Set border color - accepts Color object or String (token name/hex)
  T borderColor(dynamic value) {
    return copyWith(flyStyle.copyWith(borderColor: value));
  }

  /// Set border style - accepts String ('solid', 'dashed', 'dotted', 'none', 'hidden')
  T borderStyle(String value) {
    return copyWith(flyStyle.copyWith(borderStyle: value));
  }

  /// Resolves border from FlyStyle and FlyTheme into Border
  Border resolveBorder(BuildContext context) {
    return FlyBorderUtils.resolve(context, flyStyle);
  }

  /// Applies border styling to a widget using the resolved Border
  Widget applyBorder(BuildContext context, Widget child) {
    return FlyBorderUtils.apply(context, flyStyle, child);
  }
}

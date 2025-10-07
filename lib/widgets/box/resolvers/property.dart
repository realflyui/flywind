import 'package:flutter/material.dart';

import '../../../helpers/border.dart';
import '../../../helpers/color.dart';
import '../../../helpers/margin.dart';
import '../../../helpers/padding.dart';
import '../../../helpers/rounded.dart';
import '../../../helpers/size.dart';
import '../../../helpers/style.dart';
import '../../../helpers/style_applier.dart';

/// Handles property resolution for FlyBox widgets
class BoxProperty {
  /// Build resolved padding from FlyStyle utilities
  static EdgeInsetsGeometry? resolvePadding(
    BuildContext context,
    FlyStyle flyStyle,
  ) {
    if (flyStyle.hasPadding) {
      return FlyPaddingUtils.resolve(context, flyStyle);
    }
    return null;
  }

  /// Build resolved margin from FlyStyle utilities
  static EdgeInsetsGeometry? resolveMargin(
    BuildContext context,
    FlyStyle flyStyle,
  ) {
    if (flyStyle.hasMargin) {
      return FlyMarginUtils.resolve(context, flyStyle);
    }
    return null;
  }

  /// Build resolved decoration from FlyStyle utilities
  static Decoration? resolveDecoration(
    BuildContext context,
    FlyStyle flyStyle,
  ) {
    final backgroundColor = flyStyle.bg != null
        ? FlyColorUtils.applyToContainer(
            context,
            flyStyle.copyWith(color: flyStyle.bg),
          )
        : null;

    final borderRadius = flyStyle.hasBorderRadius
        ? FlyRoundedUtils.resolve(context, flyStyle)
        : null;

    // Only create decoration for solid borders - custom borders (dashed/dotted) are handled separately
    final border =
        flyStyle.hasBorder && !FlyBorderUtils.needsCustomBorder(flyStyle)
        ? FlyBorderUtils.resolve(context, flyStyle)
        : null;

    // Only create decoration if we have something to decorate
    if (backgroundColor != null || borderRadius != null || border != null) {
      return BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        border: border,
      );
    }

    return null;
  }

  /// Build resolved width from FlyStyle utilities
  static double? resolveWidth(BuildContext context, FlyStyle flyStyle) {
    return FlySizeUtils.resolveWidth(context, flyStyle);
  }

  /// Build resolved height from FlyStyle utilities
  static double? resolveHeight(BuildContext context, FlyStyle flyStyle) {
    return FlySizeUtils.resolveHeight(context, flyStyle);
  }

  /// Resolve background color for custom borders
  static Color? resolveBackgroundColor(
    BuildContext context,
    FlyStyle flyStyle,
  ) {
    return flyStyle.bg != null
        ? FlyColorUtils.applyToContainer(
            context,
            flyStyle.copyWith(color: flyStyle.bg),
          )
        : null;
  }

  /// Resolve border radius for custom borders
  static BorderRadius resolveBorderRadius(
    BuildContext context,
    FlyStyle flyStyle,
  ) {
    return flyStyle.hasBorderRadius
        ? FlyRoundedUtils.resolve(context, flyStyle)
        : BorderRadius.zero;
  }
}

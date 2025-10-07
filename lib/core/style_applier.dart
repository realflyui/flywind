import 'package:flutter/material.dart';

// TODO: circular dependency?
import '../helpers/margin.dart';
import '../helpers/padding.dart';
import '../helpers/rounded.dart';
import 'style.dart';

/// Service for applying FlyWind utilities to widgets
///
/// This class handles the utility application logic that was previously
/// embedded in the FlyStyle class, following the Single Responsibility Principle.
class FlyStyleApplier {
  /// Apply utilities to any widget in the correct order
  ///
  /// The order is important for proper layering:
  /// 1. Padding (innermost - applied to content)
  /// 2. Border Radius (applied to background container)
  /// 3. Margin (outermost - wraps the decoration)
  ///
  /// Future utilities would be added here in the correct order.
  static Widget apply(BuildContext context, FlyStyle flyStyle, Widget child) {
    Widget result = child;

    // Apply utilities in the correct order (inner to outer)
    // Core widget creation and color handling is done by individual widgets

    // 1. Padding (applied to the content)
    if (flyStyle.hasPadding) {
      result = FlyPaddingUtils.apply(context, flyStyle, result);
    }

    // 2. Border Radius (applied to the background container)
    if (flyStyle.hasBorderRadius) {
      result = FlyRoundedUtils.apply(context, flyStyle, result);
    }

    // 3. Margin (outermost - wraps the decoration)
    if (flyStyle.hasMargin) {
      result = FlyMarginUtils.apply(context, flyStyle, result);
    }

    // Future utilities would go here:
    // 4. Shadow (wraps margin)
    // 5. Border (handled by individual widgets like FlyContainer)

    return result;
  }
}

/// Extension on FlyStyle to provide property checking methods
///
/// This keeps the property checking logic separate from the data class
/// while maintaining the same API for existing code.
extension FlyStyleChecks on FlyStyle {
  /// Check if any padding is set
  bool get hasPadding =>
      p != null ||
      px != null ||
      py != null ||
      pl != null ||
      pr != null ||
      pb != null ||
      pt != null;

  /// Check if any margin is set
  bool get hasMargin =>
      m != null ||
      mx != null ||
      my != null ||
      ml != null ||
      mr != null ||
      mb != null ||
      mt != null;

  /// Check if any border radius is set
  bool get hasBorderRadius =>
      rounded != null ||
      roundedT != null ||
      roundedR != null ||
      roundedB != null ||
      roundedL != null ||
      roundedTl != null ||
      roundedTr != null ||
      roundedBl != null ||
      roundedBr != null;

  /// Check if any border is set
  bool get hasBorder =>
      border != null ||
      borderT != null ||
      borderR != null ||
      borderB != null ||
      borderL != null;

  /// Check if any size is set
  bool get hasSize =>
      h != null ||
      w != null ||
      maxH != null ||
      maxW != null ||
      minH != null ||
      minW != null;

  /// Check if any layout properties are set
  bool get hasLayoutProperties =>
      layoutType != null ||
      justify != null ||
      items != null ||
      gap != null ||
      gapX != null ||
      gapY != null ||
      reverse != null ||
      inline != null ||
      col != null ||
      row != null ||
      wrap != null;

  /// Check if any flex properties are set
  bool get hasFlexProperties =>
      flex != null || grow != null || shrink != null || basis != null;

  /// Check if any position properties are set
  bool get hasPositionProperties =>
      top != null ||
      right != null ||
      bottom != null ||
      left != null ||
      inset != null ||
      insetX != null ||
      insetY != null;

  /// Check if this style has any text properties that could be inherited
  bool get hasTextProperties {
    return color != null ||
        text != null ||
        font != null ||
        fontWeight != null ||
        leading != null ||
        tracking != null ||
        textAlign != null ||
        textTransform != null ||
        textDecoration != null;
  }
}

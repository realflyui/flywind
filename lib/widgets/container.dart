import 'package:flutter/material.dart';
import '../helpers/style.dart';
import '../helpers/padding.dart';
import '../helpers/margin.dart';
import '../helpers/color.dart';
import '../helpers/rounded.dart';
import '../helpers/border.dart';
import '../helpers/size.dart';
import '../helpers/flex.dart';

/// A builder-style widget that mimics Tailwind-like utilities for containers
class FlyContainer extends StatelessWidget
    with
        FlyPadding<FlyContainer>,
        FlyMargin<FlyContainer>,
        FlyColor<FlyContainer>,
        FlyRounded<FlyContainer>,
        FlyBorder<FlyContainer>,
        FlySize<FlyContainer>,
        FlyFlex<FlyContainer> {
  const FlyContainer({
    super.key,
    required this.child,
    FlyStyle style = const FlyStyle(),
  }) : _style = style;

  final Widget child;
  final FlyStyle _style;

  @override
  FlyStyle get style => _style;

  @override
  FlyContainer Function(FlyStyle newStyle) get copyWith =>
      (newStyle) => FlyContainer(style: newStyle, child: child);

  @override
  Widget build(BuildContext context) {
    // Apply all style utilities directly to a single Container
    return _buildStyledContainer(context);
  }

  /// Build a single Container with all decorations applied
  Widget _buildStyledContainer(BuildContext context) {
    // Resolve all decoration properties once
    final backgroundColor = _style.color != null
        ? FlyColorUtils.applyToContainer(context, _style)
        : null;

    final borderRadius = _style.hasBorderRadius
        ? FlyRoundedUtils.resolve(context, _style)
        : BorderRadius.zero;

    final padding = _style.hasPadding
        ? FlyPaddingUtils.resolve(context, _style)
        : EdgeInsets.zero;

    final margin = _style.hasMargin
        ? FlyMarginUtils.resolve(context, _style)
        : EdgeInsets.zero;

    // Size constraints will be handled by FlySizeUtils.apply

    // Start with the child
    Widget container = child;

    // Apply padding if needed
    if (padding != EdgeInsets.zero) {
      container = Padding(padding: padding, child: container);
    }

    // Handle borders and background color
    if (_style.hasBorder) {
      if (FlyBorderUtils.needsCustomBorder(_style)) {
        // Custom borders (dashed, dotted, double)
        container = FlyBorderUtils.createBorderWidget(
          context,
          _style,
          container,
        );

        // Apply background color for custom borders
        if (backgroundColor != null) {
          container = _createBackgroundContainer(
            backgroundColor,
            borderRadius,
            container,
          );
        }
      } else {
        // Solid borders - include border in decoration
        final border = FlyBorderUtils.resolve(context, _style);
        container = _createBackgroundContainer(
          backgroundColor,
          borderRadius,
          container,
          border,
        );
      }
    } else if (backgroundColor != null) {
      // No borders, just background color
      container = _createBackgroundContainer(
        backgroundColor,
        borderRadius,
        container,
      );
    }

    // Apply size constraints if needed (before margin to avoid nesting)
    if (_style.hasSize) {
      container = FlySizeUtils.apply(context, _style, container);
    }

    // Apply margin if needed
    if (margin != EdgeInsets.zero) {
      container = Container(margin: margin, child: container);
    }

    return container;
  }

  /// Creates a background container with optional border
  Widget _createBackgroundContainer(
    Color? backgroundColor,
    BorderRadius borderRadius,
    Widget child, [
    Border? border,
  ]) {
    final decoration = BoxDecoration(
      color: backgroundColor,
      border: border,
      borderRadius: borderRadius != BorderRadius.zero ? borderRadius : null,
    );
    return Container(decoration: decoration, child: child);
  }
}

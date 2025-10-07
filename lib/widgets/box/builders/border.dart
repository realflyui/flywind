import 'package:flutter/material.dart';

import '../../../core/style.dart';
import '../../../mixins/border.dart';
import '../resolvers/property.dart';

/// Handles custom border building for FlyBox widgets
class BoxBorderBuilder {
  /// Build widget with custom borders (dashed/dotted)
  static Widget buildCustomBorder(
    BuildContext context,
    Widget child,
    FlyStyle flyStyle,
    AlignmentGeometry? alignment,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Decoration? foregroundDecoration,
    double? width,
    double? height,
    BoxConstraints? constraints,
    Matrix4? transform,
    AlignmentGeometry? transformAlignment,
    Clip clipBehavior,
  ) {
    // Resolve background color and border radius
    final backgroundColor = BoxProperty.resolveBackgroundColor(
      context,
      flyStyle,
    );
    final borderRadius = BoxProperty.resolveBorderRadius(context, flyStyle);

    // Start with the child
    Widget container = child;

    // Apply padding if needed
    if (padding != null) {
      container = Padding(padding: padding, child: container);
    }

    // Apply custom border to padded content
    container = FlyBorderUtils.createBorderWidget(context, flyStyle, container);

    // Apply background color for custom borders
    if (backgroundColor != null) {
      container = _createBackgroundContainer(
        backgroundColor,
        borderRadius,
        container,
      );
    }

    // Apply size constraints if needed
    if (width != null || height != null) {
      container = SizedBox(width: width, height: height, child: container);
    }

    // Apply margin if needed
    if (margin != null) {
      container = Container(margin: margin, child: container);
    }

    return container;
  }

  /// Creates a background container with optional border (from old implementation)
  static Widget _createBackgroundContainer(
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

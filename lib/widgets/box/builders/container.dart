import 'package:flutter/material.dart';

import '../../../core/style.dart';
import '../../../core/style_applier.dart';
import '../../../mixins/border.dart';
import '../../../mixins/size.dart';
import '../resolvers/alignment.dart';
import '../resolvers/property.dart';
import 'border.dart';

/// Handles container building for FlyBox widgets
class BoxContainer {
  /// Build container (with or without child)
  static Widget build(
    BuildContext context,
    Widget? child,
    FlyStyle flyStyle,
    Key? key,
    AlignmentGeometry? alignment,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Decoration? decoration,
    Decoration? foregroundDecoration,
    double? width,
    double? height,
    BoxConstraints? constraints,
    Matrix4? transform,
    AlignmentGeometry? transformAlignment,
    Clip? clipBehavior,
  ) {
    // Resolve alignment - prioritize explicit alignment, then layout utilities
    final resolvedAlignment = child != null
        ? (alignment ?? BoxAlignment.resolveFromLayoutUtilities(flyStyle))
        : alignment;
    final resolvedPadding =
        padding ?? BoxProperty.resolvePadding(context, flyStyle);
    final resolvedMargin =
        margin ?? BoxProperty.resolveMargin(context, flyStyle);
    final resolvedDecoration =
        decoration ?? BoxProperty.resolveDecoration(context, flyStyle);
    final resolvedForegroundDecoration = foregroundDecoration;
    final resolvedWidth = width ?? BoxProperty.resolveWidth(context, flyStyle);
    final resolvedHeight =
        height ?? BoxProperty.resolveHeight(context, flyStyle);
    final resolvedConstraints = constraints;
    final resolvedTransform = transform;
    final resolvedTransformAlignment = transformAlignment;
    final resolvedClipBehavior = clipBehavior ?? Clip.none;

    // Handle custom borders (dashed/dotted) with special logic
    if (flyStyle.hasBorder && FlyBorderUtils.needsCustomBorder(flyStyle)) {
      return BoxBorderBuilder.buildCustomBorder(
        context,
        child ?? const SizedBox.shrink(), // Fallback for null child
        flyStyle,
        resolvedAlignment,
        resolvedPadding,
        resolvedMargin,
        resolvedForegroundDecoration,
        resolvedWidth,
        resolvedHeight,
        resolvedConstraints,
        resolvedTransform,
        resolvedTransformAlignment,
        resolvedClipBehavior,
      );
    }

    // Create Container with resolved properties for solid borders
    Widget containerWidget = Container(
      key: key,
      alignment: resolvedAlignment,
      padding: resolvedPadding,
      margin: resolvedMargin,
      decoration: resolvedDecoration,
      foregroundDecoration: resolvedForegroundDecoration,
      width: resolvedWidth,
      height: resolvedHeight,
      constraints: resolvedConstraints,
      transform: resolvedTransform,
      transformAlignment: resolvedTransformAlignment,
      clipBehavior: resolvedClipBehavior,
      child: child,
    );

    // Apply intrinsic width constraints if needed
    return FlySizeUtils.apply(context, flyStyle, containerWidget);
  }
}

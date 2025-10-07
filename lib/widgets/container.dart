import 'package:flutter/material.dart';

import '../helpers/border.dart';
import '../helpers/color.dart';
import '../helpers/flex.dart';
import '../helpers/margin.dart';
import '../helpers/padding.dart';
import '../helpers/position.dart';
import '../helpers/rounded.dart';
import '../helpers/size.dart';
import '../helpers/style.dart';
import '../helpers/style_applier.dart';

/// A builder-style widget that mimics Tailwind-like utilities for containers
class FlyContainer extends StatelessWidget
    with
        FlyPadding<FlyContainer>,
        FlyMargin<FlyContainer>,
        FlyColor<FlyContainer>,
        FlyRounded<FlyContainer>,
        FlyBorder<FlyContainer>,
        FlySize<FlyContainer>,
        FlyFlex<FlyContainer>,
        FlyPosition<FlyContainer> {
  FlyContainer({
    super.key,
    required this.child,
    this.alignment,
    this.padding,
    this.margin,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.clipBehavior,
    FlyStyle flyStyle = const FlyStyle(),
  }) : _flyStyle = _buildStyleWithDefaults(flyStyle);

  static FlyStyle _buildStyleWithDefaults(FlyStyle style) {
    return style.copyWith(
      // No default values for container - let it be transparent by default
      // Users can explicitly set background color, padding, etc.
    );
  }

  final Widget child;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final Clip? clipBehavior;
  final FlyStyle _flyStyle;

  @override
  FlyStyle get flyStyle => _flyStyle;

  @override
  FlyContainer Function(FlyStyle newStyle) get copyWith =>
      (newStyle) => FlyContainer(
        key: key,
        alignment: alignment,
        padding: padding,
        margin: margin,
        decoration: decoration,
        foregroundDecoration: foregroundDecoration,
        width: width,
        height: height,
        constraints: constraints,
        transform: transform,
        transformAlignment: transformAlignment,
        clipBehavior: clipBehavior,
        flyStyle: newStyle,
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    // Always resolve the container properties first
    final resolvedAlignment = alignment;
    final resolvedPadding = padding ?? _buildResolvedPadding(context);
    final resolvedMargin = margin ?? _buildResolvedMargin(context);
    final resolvedDecoration = decoration ?? _buildResolvedDecoration(context);
    final resolvedForegroundDecoration = foregroundDecoration;
    final resolvedWidth = width ?? _buildResolvedWidth(context);
    final resolvedHeight = height ?? _buildResolvedHeight(context);
    final resolvedConstraints = constraints;
    final resolvedTransform = transform;
    final resolvedTransformAlignment = transformAlignment;
    final resolvedClipBehavior = clipBehavior ?? Clip.none;

    // Handle custom borders (dashed/dotted) with special logic
    if (_flyStyle.hasBorder && FlyBorderUtils.needsCustomBorder(_flyStyle)) {
      return _buildCustomBorderContainer(
        context,
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

    return containerWidget;
  }

  /// Build resolved padding from FlyStyle utilities
  EdgeInsetsGeometry? _buildResolvedPadding(BuildContext context) {
    if (_flyStyle.hasPadding) {
      return FlyPaddingUtils.resolve(context, _flyStyle);
    }
    return null;
  }

  /// Build resolved margin from FlyStyle utilities
  EdgeInsetsGeometry? _buildResolvedMargin(BuildContext context) {
    if (_flyStyle.hasMargin) {
      return FlyMarginUtils.resolve(context, _flyStyle);
    }
    return null;
  }

  /// Build resolved decoration from FlyStyle utilities
  Decoration? _buildResolvedDecoration(BuildContext context) {
    final backgroundColor = _flyStyle.color != null
        ? FlyColorUtils.applyToContainer(context, _flyStyle)
        : null;

    final borderRadius = _flyStyle.hasBorderRadius
        ? FlyRoundedUtils.resolve(context, _flyStyle)
        : null;

    // Only create decoration for solid borders - custom borders (dashed/dotted) are handled separately
    final border =
        _flyStyle.hasBorder && !FlyBorderUtils.needsCustomBorder(_flyStyle)
        ? FlyBorderUtils.resolve(context, _flyStyle)
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
  double? _buildResolvedWidth(BuildContext context) {
    return FlySizeUtils.resolveWidth(context, _flyStyle);
  }

  /// Build resolved height from FlyStyle utilities
  double? _buildResolvedHeight(BuildContext context) {
    return FlySizeUtils.resolveHeight(context, _flyStyle);
  }

  /// Build container with custom borders (dashed/dotted) using old implementation approach
  Widget _buildCustomBorderContainer(
    BuildContext context,
    AlignmentGeometry? resolvedAlignment,
    EdgeInsetsGeometry? resolvedPadding,
    EdgeInsetsGeometry? resolvedMargin,
    Decoration? resolvedForegroundDecoration,
    double? resolvedWidth,
    double? resolvedHeight,
    BoxConstraints? resolvedConstraints,
    Matrix4? resolvedTransform,
    AlignmentGeometry? resolvedTransformAlignment,
    Clip resolvedClipBehavior,
  ) {
    // Resolve background color and border radius
    final backgroundColor = _flyStyle.color != null
        ? FlyColorUtils.applyToContainer(context, _flyStyle)
        : null;

    final borderRadius = _flyStyle.hasBorderRadius
        ? FlyRoundedUtils.resolve(context, _flyStyle)
        : BorderRadius.zero;

    // Start with the child
    Widget container = child;

    // Apply padding if needed (like old implementation)
    if (resolvedPadding != null) {
      container = Padding(padding: resolvedPadding, child: container);
    }

    // Apply custom border to padded content (like old implementation)
    container = FlyBorderUtils.createBorderWidget(
      context,
      _flyStyle,
      container,
    );

    // Apply background color for custom borders (like old implementation)
    if (backgroundColor != null) {
      container = _createBackgroundContainer(
        backgroundColor,
        borderRadius,
        container,
      );
    }

    // Apply size constraints if needed
    if (resolvedWidth != null || resolvedHeight != null) {
      container = SizedBox(
        width: resolvedWidth,
        height: resolvedHeight,
        child: container,
      );
    }

    // Apply margin if needed
    if (resolvedMargin != null) {
      container = Container(margin: resolvedMargin, child: container);
    }

    return container;
  }

  /// Creates a background container with optional border (from old implementation)
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

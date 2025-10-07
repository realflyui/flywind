import 'package:flutter/material.dart';

import '../helpers/border.dart';
import '../helpers/color.dart';
import '../helpers/flex.dart';
import '../helpers/layout.dart';
import '../helpers/margin.dart';
import '../helpers/padding.dart';
import '../helpers/position.dart';
import '../helpers/rounded.dart';
import '../helpers/size.dart';
import '../helpers/style.dart';
import '../helpers/style_applier.dart';

/// A unified widget that intelligently renders as either a container or layout
///
/// The widget automatically determines its behavior based on the properties provided:
/// - If `child` is provided, it renders as a container
/// - If `children` is provided, it renders as a layout widget
/// - If both are provided, `child` takes precedence
/// - If neither is provided, it renders as an empty container
class FlyBox extends StatelessWidget
    with
        FlyPadding<FlyBox>,
        FlyMargin<FlyBox>,
        FlyColor<FlyBox>,
        FlyRounded<FlyBox>,
        FlyBorder<FlyBox>,
        FlySize<FlyBox>,
        FlyFlex<FlyBox>,
        FlyPosition<FlyBox>,
        FlyLayoutUtilities<FlyBox> {
  FlyBox({
    super.key,
    this.child,
    this.children,
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
      // No default values - let it be transparent by default
      // Users can explicitly set background color, padding, etc.
    );
  }

  // Container-specific properties
  final Widget? child;
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

  // Layout-specific properties
  final List<Widget>? children;

  final FlyStyle _flyStyle;

  @override
  FlyStyle get flyStyle => _flyStyle;

  @override
  FlyBox Function(FlyStyle newStyle) get copyWith => (newStyle) {
    return FlyBox(
      key: key,
      child: child,
      children: children,
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
    );
  };

  /// Determine if this should render as a container
  bool get _isContainer => child != null;

  /// Determine if this should render as a layout
  bool get _isLayout => children != null && child == null;

  @override
  Widget build(BuildContext context) {
    if (_isContainer) {
      return _buildContainer(context);
    } else if (_isLayout) {
      return _buildLayout(context);
    } else {
      // Fallback: render as empty container
      return _buildEmptyContainer(context);
    }
  }

  /// Build as container (single child)
  Widget _buildContainer(BuildContext context) {
    // Resolve alignment - prioritize explicit alignment, then layout utilities
    final resolvedAlignment =
        alignment ?? _resolveAlignmentFromLayoutUtilities();
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
      child: child!,
    );

    return containerWidget;
  }

  /// Build as layout (multiple children)
  Widget _buildLayout(BuildContext context) {
    // If no layout type is specified, return children in a column by default
    final layoutType = _flyStyle.layoutType ?? 'col';

    // Build the layout widget
    Widget layoutWidget;
    switch (layoutType) {
      case 'col':
        layoutWidget = FlyLayoutUtils.buildColumn(
          context,
          _flyStyle,
          children!,
        );
        break;
      case 'row':
        layoutWidget = FlyLayoutUtils.buildRow(context, _flyStyle, children!);
        break;
      case 'wrap':
        layoutWidget = FlyLayoutUtils.buildWrap(context, _flyStyle, children!);
        break;
      case 'stack':
        layoutWidget = FlyLayoutUtils.buildStack(context, _flyStyle, children!);
        break;
      default:
        layoutWidget = FlyLayoutUtils.buildColumn(
          context,
          _flyStyle,
          children!,
        );
    }

    // If there are container properties, wrap the layout in a container
    if (_flyStyle.color != null ||
        _flyStyle.hasBorderRadius ||
        _flyStyle.hasBorder ||
        _flyStyle.hasPadding ||
        _flyStyle.hasMargin ||
        _flyStyle.hasSize) {
      return _buildLayoutContainer(context, layoutWidget);
    }

    return layoutWidget;
  }

  /// Build a container wrapper for layout widgets when container properties are present
  Widget _buildLayoutContainer(BuildContext context, Widget layoutWidget) {
    // Resolve container properties
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
      return _buildCustomBorderLayoutContainer(
        context,
        layoutWidget,
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
      child: layoutWidget,
    );

    return containerWidget;
  }

  /// Build as empty container (fallback)
  Widget _buildEmptyContainer(BuildContext context) {
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

    return Container(
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
      child: null,
    );
  }

  // Container-specific helper methods (copied from FlyContainer)
  EdgeInsetsGeometry? _buildResolvedPadding(BuildContext context) {
    if (_flyStyle.hasPadding) {
      return FlyPaddingUtils.resolve(context, _flyStyle);
    }
    return null;
  }

  EdgeInsetsGeometry? _buildResolvedMargin(BuildContext context) {
    if (_flyStyle.hasMargin) {
      return FlyMarginUtils.resolve(context, _flyStyle);
    }
    return null;
  }

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

  double? _buildResolvedWidth(BuildContext context) {
    return FlySizeUtils.resolveWidth(context, _flyStyle);
  }

  double? _buildResolvedHeight(BuildContext context) {
    return FlySizeUtils.resolveHeight(context, _flyStyle);
  }

  /// Resolve alignment from layout utilities (justify and items)
  AlignmentGeometry? _resolveAlignmentFromLayoutUtilities() {
    // Only resolve if both justify and items are set to 'center'
    if (_flyStyle.justify == 'center' && _flyStyle.items == 'center') {
      return Alignment.center;
    }

    // Handle other combinations
    if (_flyStyle.justify == 'center' && _flyStyle.items == 'start') {
      return Alignment.centerLeft;
    }

    if (_flyStyle.justify == 'center' && _flyStyle.items == 'end') {
      return Alignment.centerRight;
    }

    if (_flyStyle.justify == 'start' && _flyStyle.items == 'center') {
      return Alignment.topCenter;
    }

    if (_flyStyle.justify == 'end' && _flyStyle.items == 'center') {
      return Alignment.bottomCenter;
    }

    if (_flyStyle.justify == 'start' && _flyStyle.items == 'start') {
      return Alignment.topLeft;
    }

    if (_flyStyle.justify == 'start' && _flyStyle.items == 'end') {
      return Alignment.topRight;
    }

    if (_flyStyle.justify == 'end' && _flyStyle.items == 'start') {
      return Alignment.bottomLeft;
    }

    if (_flyStyle.justify == 'end' && _flyStyle.items == 'end') {
      return Alignment.bottomRight;
    }

    // Default to no alignment if utilities don't map to a single alignment
    return null;
  }

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
    Widget container = child!;

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

  Widget _buildCustomBorderLayoutContainer(
    BuildContext context,
    Widget layoutWidget,
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

    // Start with the layout widget
    Widget container = layoutWidget;

    // Apply padding if needed
    if (resolvedPadding != null) {
      container = Padding(padding: resolvedPadding, child: container);
    }

    // Apply custom border to padded content
    container = FlyBorderUtils.createBorderWidget(
      context,
      _flyStyle,
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

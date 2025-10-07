import 'package:flutter/material.dart';

import '../../helpers/border.dart';
import '../../helpers/color.dart';
import '../../helpers/flex.dart';
import '../../helpers/layout.dart';
import '../../helpers/margin.dart';
import '../../helpers/padding.dart';
import '../../helpers/position.dart';
import '../../helpers/rounded.dart';
import '../../helpers/size.dart';
import '../../helpers/style.dart';
import '../../helpers/style_applier.dart';
import 'builders/container.dart';
import 'builders/layout.dart';

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
      return BoxContainer.build(
        context,
        child!,
        _flyStyle,
        key,
        alignment,
        padding,
        margin,
        decoration,
        foregroundDecoration,
        width,
        height,
        constraints,
        transform,
        transformAlignment,
        clipBehavior,
      );
    } else if (_isLayout) {
      // Check if we need container properties
      if (_flyStyle.color != null ||
          _flyStyle.hasBorderRadius ||
          _flyStyle.hasBorder ||
          _flyStyle.hasPadding ||
          _flyStyle.hasMargin ||
          _flyStyle.hasSize ||
          alignment != null ||
          padding != null ||
          margin != null ||
          decoration != null ||
          foregroundDecoration != null ||
          width != null ||
          height != null ||
          constraints != null ||
          transform != null ||
          transformAlignment != null ||
          clipBehavior != null) {
        // Build the layout widget
        final layoutWidget = BoxLayout.build(context, children!, _flyStyle);

        // Wrap layout in container
        return BoxContainer.build(
          context,
          layoutWidget, // Use layout as the "child"
          _flyStyle,
          key,
          alignment,
          padding,
          margin,
          decoration,
          foregroundDecoration,
          width,
          height,
          constraints,
          transform,
          transformAlignment,
          clipBehavior,
        );
      } else {
        return BoxLayout.build(context, children!, _flyStyle);
      }
    } else {
      // Fallback: render as empty container
      return BoxContainer.build(
        context,
        null, // No child
        _flyStyle,
        key,
        alignment,
        padding,
        margin,
        decoration,
        foregroundDecoration,
        width,
        height,
        constraints,
        transform,
        transformAlignment,
        clipBehavior,
      );
    }
  }
}

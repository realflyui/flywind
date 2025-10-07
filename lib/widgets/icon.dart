import 'package:flutter/material.dart';

import '../core/style.dart';
import '../core/style_applier.dart';
import '../core/style_context.dart';
import '../helpers/color.dart';
import '../helpers/flex.dart';
import '../helpers/margin.dart';
import '../helpers/padding.dart';
import '../helpers/position.dart';
import '../helpers/size.dart';
import '../helpers/text_color.dart';

/// A builder-style widget that mimics Tailwind-like utilities for icons
class FlyIcon extends StatelessWidget
    with
        FlyPadding<FlyIcon>,
        FlyMargin<FlyIcon>,
        FlyTextColor<FlyIcon>,
        FlySize<FlyIcon>,
        FlyFlex<FlyIcon>,
        FlyPosition<FlyIcon> {
  FlyIcon(
    this.icon, {
    super.key,
    this.iconSize, // Direct IconData size
    this.iconColor, // Direct Color override
    this.semanticLabel, // Direct semantic label
    this.textDirection, // Direct text direction
    FlyStyle flyStyle = const FlyStyle(),
  }) : _flyStyle = flyStyle; // Don't apply defaults in constructor

  /// Build style with inherited context applied
  static FlyStyle _buildStyleWithInheritance(
    FlyStyle style,
    BuildContext context,
  ) {
    // Look up inherited style from FlyStyleContext
    final inheritedStyle = FlyStyleContext.of(context);

    return style.copyWith(
      // Priority: explicit style → inherited context style → widget default
      // Only inherit color for icons
      color:
          style.color ??
          inheritedStyle?.color ??
          'gray900', // Default icon color (Tailwind-like)
      w: style.w ?? 's6', // Default icon size (24px)
      h: style.h ?? 's6', // Default icon size (24px)
    );
  }

  final dynamic icon; // IconData, Widget, or String
  final double? iconSize;
  final Color? iconColor;
  final String? semanticLabel;
  final TextDirection? textDirection;
  final FlyStyle _flyStyle;

  @override
  FlyStyle get flyStyle => _flyStyle;

  /// Override this to provide component-specific default styles
  /// The incoming flyStyle will be merged with these defaults
  @protected
  FlyStyle getDefaultStyle(FlyStyle incomingStyle) => incomingStyle;

  @override
  FlyIcon Function(FlyStyle newStyle) get copyWith =>
      (newStyle) => FlyIcon(
        icon,
        key: key,
        iconSize: iconSize,
        iconColor: iconColor,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
        flyStyle: newStyle,
      );

  @override
  Widget build(BuildContext context) {
    // Apply inheritance and defaults in one step
    final mergedStyle = _buildStyleWithInheritance(_flyStyle, context);

    // Always resolve the icon properties first
    final resolvedSize =
        iconSize ??
        FlySizeUtils.resolveWidth(context, mergedStyle) ??
        FlySizeUtils.resolveHeight(context, mergedStyle);

    final resolvedColor =
        iconColor ?? FlyColorUtils.resolve(context, mergedStyle);

    // Create Icon with resolved properties
    Widget iconWidget = Icon(
      icon,
      size: resolvedSize,
      color: resolvedColor,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );

    // Always apply other utilities (padding, margin, etc.) if any are set
    if (mergedStyle.hasPadding ||
        mergedStyle.hasMargin ||
        mergedStyle.hasBorderRadius) {
      return FlyStyleApplier.apply(context, mergedStyle, iconWidget);
    }

    // If no utilities are set, return the Icon directly
    return iconWidget;
  }
}

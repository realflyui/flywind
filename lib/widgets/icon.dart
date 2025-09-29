import 'package:flutter/material.dart';

import '../helpers/color.dart';
import '../helpers/flex.dart';
import '../helpers/margin.dart';
import '../helpers/padding.dart';
import '../helpers/position.dart';
import '../helpers/size.dart';
import '../helpers/style.dart';

/// A builder-style widget that mimics Tailwind-like utilities for icons
class FlyIcon extends StatelessWidget
    with
        FlyPadding<FlyIcon>,
        FlyMargin<FlyIcon>,
        FlyColor<FlyIcon>,
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
  }) : _flyStyle = _buildStyleWithDefaults(flyStyle);

  static FlyStyle _buildStyleWithDefaults(FlyStyle style) {
    return style.copyWith(
      color: style.color ?? 'gray900', // Default icon color (Tailwind-like)
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
  FlyStyle get style => _flyStyle;

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
    // If direct properties are provided, use them with a simple Icon widget
    if (iconSize != null ||
        iconColor != null ||
        semanticLabel != null ||
        textDirection != null) {
      return Icon(
        icon,
        key: key,
        size: iconSize,
        color: iconColor,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    }

    // Otherwise, apply all style utilities using FlyStyle.apply()
    return _flyStyle.apply(context, Icon(icon));
  }
}

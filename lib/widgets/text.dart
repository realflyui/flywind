import 'package:flutter/material.dart';

import '../helpers/color.dart';
import '../helpers/flex.dart';
import '../helpers/margin.dart';
import '../helpers/padding.dart';
import '../helpers/position.dart';
import '../helpers/rounded.dart';
import '../helpers/style.dart';
import '../helpers/text.dart';
import '../helpers/tracking.dart';

/// A builder-style widget that mimics Tailwind-like utilities for text
class FlyText extends StatelessWidget
    with
        FlyPadding<FlyText>,
        FlyMargin<FlyText>,
        FlyColor<FlyText>,
        FlyRounded<FlyText>,
        FlyTextHelper<FlyText>,
        FlyTracking<FlyText>,
        FlyFlex<FlyText>,
        FlyPosition<FlyText> {
  FlyText(this.data, {style = const FlyStyle(), super.key})
    : _style = _buildStyleWithDefaults(style);

  static FlyStyle _buildStyleWithDefaults(FlyStyle style) {
    return style.copyWith(
      text: style.text ?? 'base', // Default to base text style
      color: style.color ?? 'gray900', // Default text color (Tailwind-like)
      leading: style.leading ?? 'normal', // Default line height (Tailwind-like)
      textAlign: style.textAlign ?? 'left', // Default to left alignment
      font: style.font ?? 'sans', // Default to sans font
      fontWeight: style.fontWeight ?? 'normal', // Default to normal weight
      tracking: style.tracking ?? 'normal', // Default to normal letter spacing
      textTransform:
          style.textTransform ?? 'none', // Default to no transformation
      textDecoration:
          style.textDecoration ?? 'none', // Default to no decoration
    );
  }

  final String data;
  final FlyStyle _style;

  @override
  FlyStyle get style => _style;

  @override
  FlyText Function(FlyStyle newStyle) get copyWith =>
      (newStyle) => FlyText(data, style: newStyle);

  @override
  Widget build(BuildContext context) {
    // Create the base Text widget
    Widget textWidget = Text(data);

    // Apply all style utilities (color, padding, etc.) using FlyStyle.apply()
    return _style.apply(context, textWidget);
  }
}

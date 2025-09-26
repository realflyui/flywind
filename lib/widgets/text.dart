import 'package:flutter/material.dart';
import '../helpers/style.dart';
import '../helpers/padding.dart';
import '../helpers/margin.dart';
import '../helpers/color.dart';
import '../helpers/rounded.dart';
import '../helpers/text.dart';

/// A builder-style widget that mimics Tailwind-like utilities for text
class FlyText extends StatelessWidget
    with
        FlyPadding<FlyText>,
        FlyMargin<FlyText>,
        FlyColor<FlyText>,
        FlyRounded<FlyText>,
        FlyTextHelper<FlyText> {
  const FlyText(this.data, {style = const FlyStyle(), super.key})
    : _style = style;

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

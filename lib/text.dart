import 'package:flutter/material.dart';
import 'style.dart';
import 'padding.dart';
import 'margin.dart';
import 'color.dart';
import 'rounded.dart';

/// A builder-style widget that mimics Tailwind-like utilities for text
class FlyText extends StatelessWidget with FlyPadding<FlyText>, FlyMargin<FlyText>, FlyColor<FlyText>, FlyRounded<FlyText> {
  const FlyText(this.text, [this._style = const FlyStyle()]);

  final String text;
  final FlyStyle _style;

  @override
  FlyStyle get style => _style;

  @override
  FlyText Function(FlyStyle newStyle) get copyWith => (newStyle) => FlyText(text, newStyle);

  @override
  Widget build(BuildContext context) {
    // Create the base Text widget
    Widget textWidget = Text(text);

    // Apply all style utilities (color, padding, etc.) using FlyStyle.apply()
    return _style.apply(context, textWidget);
  }
}

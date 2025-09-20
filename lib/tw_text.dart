import 'package:flutter/material.dart';
import 'tw_style.dart';
import 'tw_padding_mixin.dart';
import 'tw_margin_mixin.dart';
import 'tw_color_mixin.dart';

/// A builder-style widget that mimics Tailwind-like utilities for text
class TwText extends StatelessWidget with TwPaddingMixin<TwText>, TwMarginMixin<TwText>, TwColorMixin<TwText> {
  const TwText(this.text, [this._style = const TwStyle()]);

  final String text;
  final TwStyle _style;

  @override
  TwStyle get style => _style;

  @override
  TwText Function(TwStyle newStyle) get copyWith => (newStyle) => TwText(text, newStyle);

  @override
  Widget build(BuildContext context) {
    // Create the base Text widget
    Widget textWidget = Text(text);

    // Apply all style utilities (color, padding, etc.) using TwStyle.apply()
    return _style.apply(context, textWidget);
  }
}

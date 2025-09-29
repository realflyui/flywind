import 'package:flutter/material.dart';

import '../helpers/color.dart';
import '../helpers/flex.dart';
import '../helpers/margin.dart';
import '../helpers/padding.dart';
import '../helpers/position.dart';
import '../helpers/style.dart';
import '../helpers/text.dart';
import '../helpers/tracking.dart';

/// A builder-style widget that mimics Tailwind-like utilities for text
class FlyText extends StatelessWidget
    with
        FlyPadding<FlyText>,
        FlyMargin<FlyText>,
        FlyColor<FlyText>,
        FlyTextHelper<FlyText>,
        FlyTracking<FlyText>,
        FlyFlex<FlyText>,
        FlyPosition<FlyText> {
  FlyText(
    this.data, {
    super.key,
    this.textStyle, // TODO: this should be style but conflicts with FlyStyle
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    FlyStyle flyStyle = const FlyStyle(),
  }) : _flyStyle = _buildStyleWithDefaults(flyStyle);

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
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final FlyStyle _flyStyle;

  @override
  FlyStyle get style => _flyStyle;

  @override
  FlyText Function(FlyStyle newStyle) get copyWith =>
      (newStyle) => FlyText(
        data,
        key: key,
        textStyle: textStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaler: textScaler,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        flyStyle: newStyle,
      );

  @override
  Widget build(BuildContext context) {
    // If direct properties are provided, use them with a simple Text widget
    if (textStyle != null ||
        textAlign != null ||
        textDirection != null ||
        locale != null ||
        softWrap != null ||
        overflow != null ||
        textScaler != null ||
        maxLines != null ||
        semanticsLabel != null ||
        textWidthBasis != null ||
        textHeightBehavior != null) {
      return Text(
        data,
        key: key,
        style: textStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaler: textScaler,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
      );
    }

    // Otherwise, apply all style utilities using FlyStyle.apply()
    return _flyStyle.apply(context, Text(data));
  }
}

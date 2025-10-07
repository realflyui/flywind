import 'package:flutter/material.dart';

import '../helpers/color.dart';
import '../helpers/flex.dart';
import '../helpers/margin.dart';
import '../helpers/padding.dart';
import '../helpers/position.dart';
import '../helpers/style.dart';
import '../helpers/style_applier.dart';
import '../helpers/text.dart';
import '../helpers/text_color.dart';
import '../helpers/tracking.dart';

/// A builder-style widget that mimics Tailwind-like utilities for text
class FlyText extends StatelessWidget
    with
        FlyPadding<FlyText>,
        FlyMargin<FlyText>,
        FlyTextColor<FlyText>,
        FlyTextHelper<FlyText>,
        FlyTracking<FlyText>,
        FlyFlex<FlyText>,
        FlyPosition<FlyText> {
  FlyText(
    this.data, {
    super.key,
    this.style,
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
  final TextStyle? style;
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
  FlyStyle get flyStyle => _flyStyle;

  /// Override this to provide component-specific default styles
  /// The incoming flyStyle will be merged with these defaults
  @protected
  FlyStyle getDefaultStyle(FlyStyle incomingStyle) => incomingStyle;

  @override
  FlyText Function(FlyStyle newStyle) get copyWith =>
      (newStyle) => FlyText(
        data,
        key: key,
        style: style,
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
    final mergedStyle = getDefaultStyle(_flyStyle);

    // Always resolve the text properties first
    final resolvedTextStyle = _buildResolvedTextStyle(context, mergedStyle);
    final resolvedTextAlign = textAlign ?? _buildResolvedTextAlign(mergedStyle);
    final resolvedText = _buildResolvedText(mergedStyle);

    // Create Text with resolved properties
    Widget textWidget = Text(
      resolvedText,
      key: key,
      style: resolvedTextStyle,
      textAlign: resolvedTextAlign,
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

    // Always apply other utilities (padding, margin, etc.) if any are set
    if (mergedStyle.hasPadding ||
        mergedStyle.hasMargin ||
        mergedStyle.hasBorderRadius) {
      return FlyStyleApplier.apply(context, mergedStyle, textWidget);
    }

    // If no utilities are set, return the Text directly
    return textWidget;
  }

  /// Build resolved text style from FlyStyle utilities
  TextStyle _buildResolvedTextStyle(
    BuildContext context,
    FlyStyle mergedStyle,
  ) {
    // Start with direct style if provided, otherwise use styled text style
    TextStyle finalStyle =
        style ??
        (FlyTextUtils.resolve(context, mergedStyle) ?? const TextStyle());

    // Apply text-related utilities (font, weight, leading, tracking, etc.)
    finalStyle = FlyTextUtils.applyToTextStyle(
      context,
      mergedStyle,
      finalStyle,
    );

    // Apply color if set (this will override the color from the text style token or direct style)
    if (mergedStyle.color != null) {
      finalStyle = FlyColorUtils.applyToTextStyle(
        context,
        mergedStyle,
        finalStyle,
      );
    }

    return finalStyle;
  }

  /// Build resolved text alignment from FlyStyle utilities
  TextAlign? _buildResolvedTextAlign(FlyStyle mergedStyle) {
    if (mergedStyle.textAlign != null) {
      return FlyTextUtils.resolveTextAlign(mergedStyle.textAlign);
    }
    return null;
  }

  /// Build resolved text with transformations applied
  String _buildResolvedText(FlyStyle mergedStyle) {
    if (mergedStyle.textTransform != null) {
      return FlyTextUtils.transformText(data, mergedStyle.textTransform);
    }
    return data;
  }
}

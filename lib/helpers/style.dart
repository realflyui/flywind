import 'package:flutter/material.dart';
import 'padding.dart';
import 'margin.dart';
import 'color.dart';
import 'rounded.dart';

/// Internal style storage for FlyText widget
class FlyStyle {
  const FlyStyle({
    this.p,
    this.px,
    this.py,
    this.pl,
    this.pr,
    this.pb,
    this.pt,
    this.m,
    this.mx,
    this.my,
    this.ml,
    this.mr,
    this.mb,
    this.mt,
    this.color,
    this.rounded,
    this.roundedT,
    this.roundedR,
    this.roundedB,
    this.roundedL,
    this.roundedTl,
    this.roundedTr,
    this.roundedBl,
    this.roundedBr,
  });

  final dynamic p; // Uniform padding (all sides) - can be int, double, String
  final dynamic px; // Horizontal padding (left + right) - can be int, double, String
  final dynamic py; // Vertical padding (top + bottom) - can be int, double, String
  final dynamic pl; // Left padding - can be int, double, String
  final dynamic pr; // Right padding - can be int, double, String
  final dynamic pb; // Bottom padding - can be int, double, String
  final dynamic pt; // Top padding - can be int, double, String
  final dynamic m; // Uniform margin (all sides) - can be int, double, String
  final dynamic mx; // Horizontal margin (left + right) - can be int, double, String
  final dynamic my; // Vertical margin (top + bottom) - can be int, double, String
  final dynamic ml; // Left margin - can be int, double, String
  final dynamic mr; // Right margin - can be int, double, String
  final dynamic mb; // Bottom margin - can be int, double, String
  final dynamic mt; // Top margin - can be int, double, String
  final dynamic color; // Color - can be Color, String
  final dynamic rounded; // Uniform border radius (all corners) - can be int, double, String
  final dynamic roundedT; // Top border radius (top-left + top-right) - can be int, double, String
  final dynamic roundedR; // Right border radius (top-right + bottom-right) - can be int, double, String
  final dynamic roundedB; // Bottom border radius (bottom-left + bottom-right) - can be int, double, String
  final dynamic roundedL; // Left border radius (top-left + bottom-left) - can be int, double, String
  final dynamic roundedTl; // Top-left border radius - can be int, double, String
  final dynamic roundedTr; // Top-right border radius - can be int, double, String
  final dynamic roundedBl; // Bottom-left border radius - can be int, double, String
  final dynamic roundedBr; // Bottom-right border radius - can be int, double, String

  /// Create a copy of this style with updated values
  FlyStyle copyWith({
    dynamic p,
    dynamic px,
    dynamic py,
    dynamic pl,
    dynamic pr,
    dynamic pb,
    dynamic pt,
    dynamic m,
    dynamic mx,
    dynamic my,
    dynamic ml,
    dynamic mr,
    dynamic mb,
    dynamic mt,
    dynamic color,
    dynamic rounded,
    dynamic roundedT,
    dynamic roundedR,
    dynamic roundedB,
    dynamic roundedL,
    dynamic roundedTl,
    dynamic roundedTr,
    dynamic roundedBl,
    dynamic roundedBr,
  }) {
    return FlyStyle(
      p: p ?? this.p,
      px: px ?? this.px,
      py: py ?? this.py,
      pl: pl ?? this.pl,
      pr: pr ?? this.pr,
      pb: pb ?? this.pb,
      pt: pt ?? this.pt,
      m: m ?? this.m,
      mx: mx ?? this.mx,
      my: my ?? this.my,
      ml: ml ?? this.ml,
      mr: mr ?? this.mr,
      mb: mb ?? this.mb,
      mt: mt ?? this.mt,
      color: color ?? this.color,
      rounded: rounded ?? this.rounded,
      roundedT: roundedT ?? this.roundedT,
      roundedR: roundedR ?? this.roundedR,
      roundedB: roundedB ?? this.roundedB,
      roundedL: roundedL ?? this.roundedL,
      roundedTl: roundedTl ?? this.roundedTl,
      roundedTr: roundedTr ?? this.roundedTr,
      roundedBl: roundedBl ?? this.roundedBl,
      roundedBr: roundedBr ?? this.roundedBr,
    );
  }

  /// Apply all style utilities to a widget in the correct order
  Widget apply(BuildContext context, Widget child) {
    Widget result = child;

    // Apply utilities in the correct order (inner to outer)
    // For text widgets, we need to apply color first to preserve text styling
    if (child is Text && color != null) {
      result = _applyTextColorDirect(context, child);
    }

    // 1. Padding (applied to the content)
    if (hasPadding) {
      result = FlyPaddingUtils.apply(context, this, result);
    }

    // 2. Background Color (for non-text widgets or containers)
    if (color != null && child is! Text) {
      result = _applyBackgroundColor(context, result);
    }

    // 3. Border Radius (applied to the background container)
    if (hasBorderRadius) {
      result = FlyRoundedUtils.apply(context, this, result);
    }

    // 4. Margin (outermost - wraps the background)
    if (hasMargin) {
      result = FlyMarginUtils.apply(context, this, result);
    }

    // Future utilities would go here:
    // 5. Border (wraps margin)
    // 6. Shadow (wraps border)

    return result;
  }

  /// Check if any padding is set
  bool get hasPadding =>
      p != null ||
      px != null ||
      py != null ||
      pl != null ||
      pr != null ||
      pb != null ||
      pt != null;

  /// Check if any margin is set
  bool get hasMargin =>
      m != null ||
      mx != null ||
      my != null ||
      ml != null ||
      mr != null ||
      mb != null ||
      mt != null;

  /// Check if any border radius is set
  bool get hasBorderRadius =>
      rounded != null ||
      roundedT != null ||
      roundedR != null ||
      roundedB != null ||
      roundedL != null ||
      roundedTl != null ||
      roundedTr != null ||
      roundedBl != null ||
      roundedBr != null;

  /// Apply text color directly to a Text widget
  Widget _applyTextColorDirect(BuildContext context, Text textWidget) {
    return Text(
      textWidget.data ?? '',
      style: FlyColorUtils.applyToTextStyle(context, this, textWidget.style),
      textAlign: textWidget.textAlign,
      textDirection: textWidget.textDirection,
      locale: textWidget.locale,
      softWrap: textWidget.softWrap,
      overflow: textWidget.overflow,
      textScaler: textWidget.textScaler,
      maxLines: textWidget.maxLines,
      semanticsLabel: textWidget.semanticsLabel,
      textWidthBasis: textWidget.textWidthBasis,
      textHeightBehavior: textWidget.textHeightBehavior,
    );
  }

  /// Apply background color to a widget
  Widget _applyBackgroundColor(BuildContext context, Widget child) {
    return Container(
      color: FlyColorUtils.applyToContainer(context, this),
      child: child,
    );
  }
}

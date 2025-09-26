import 'package:flutter/material.dart';
import 'padding.dart';
import 'margin.dart';
import 'color.dart';
import 'rounded.dart';
import 'text.dart';

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
    this.border,
    this.borderT,
    this.borderR,
    this.borderB,
    this.borderL,
    this.borderColor,
    this.borderStyle,
    this.h,
    this.w,
    this.maxH,
    this.maxW,
    this.minH,
    this.minW,
    this.text,
    this.textAlign,
    this.textTransform,
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
  final dynamic border; // Uniform border width (all sides) - can be int, double, String
  final dynamic borderT; // Top border width - can be int, double, String
  final dynamic borderR; // Right border width - can be int, double, String
  final dynamic borderB; // Bottom border width - can be int, double, String
  final dynamic borderL; // Left border width - can be int, double, String
  final dynamic borderColor; // Border color - can be Color, String
  final dynamic borderStyle; // Border style - can be String ('solid', 'dashed', 'dotted', 'none', 'hidden')
  final dynamic h; // Height - can be int, double, String (token name/unit)
  final dynamic w; // Width - can be int, double, String (token name/unit)
  final dynamic maxH; // Max height - can be int, double, String (token name/unit)
  final dynamic maxW; // Max width - can be int, double, String (token name/unit)
  final dynamic minH; // Min height - can be int, double, String (token name/unit)
  final dynamic minW; // Min width - can be int, double, String (token name/unit)
  final dynamic text; // Text style token name - can be String ('xs', 'sm', 'base', 'lg', etc.) or TextStyle
  final dynamic textAlign; // Text alignment - can be String ('left', 'right', 'center', 'justify', 'start', 'end') or TextAlign
  final dynamic textTransform; // Text transformation - can be String ('uppercase', 'lowercase', 'capitalize', 'none')

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
    dynamic border,
    dynamic borderT,
    dynamic borderR,
    dynamic borderB,
    dynamic borderL,
    dynamic borderColor,
    dynamic borderStyle,
    dynamic h,
    dynamic w,
    dynamic maxH,
    dynamic maxW,
    dynamic minH,
    dynamic minW,
    dynamic text,
    dynamic textAlign,
    dynamic textTransform,
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
      border: border ?? this.border,
      borderT: borderT ?? this.borderT,
      borderR: borderR ?? this.borderR,
      borderB: borderB ?? this.borderB,
      borderL: borderL ?? this.borderL,
      borderColor: borderColor ?? this.borderColor,
      borderStyle: borderStyle ?? this.borderStyle,
      h: h ?? this.h,
      w: w ?? this.w,
      maxH: maxH ?? this.maxH,
      maxW: maxW ?? this.maxW,
      minH: minH ?? this.minH,
      minW: minW ?? this.minW,
      text: text ?? this.text,
      textAlign: textAlign ?? this.textAlign,
      textTransform: textTransform ?? this.textTransform,
    );
  }

  /// Apply all style utilities to a widget in the correct order
  Widget apply(BuildContext context, Widget child) {
    Widget result = child;

    // Apply utilities in the correct order (inner to outer)
    // For text widgets, we need to apply text style first, then color
    if (child is Text) {
      result = _applyTextStyleDirect(context, child);
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

    // 3. Margin (outermost - wraps the decoration)
    if (hasMargin) {
      result = FlyMarginUtils.apply(context, this, result);
    }

    // Future utilities would go here:
    // 4. Shadow (wraps margin)

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

  /// Check if any border is set
  bool get hasBorder =>
      border != null ||
      borderT != null ||
      borderR != null ||
      borderB != null ||
      borderL != null;

  /// Check if any size is set
  bool get hasSize =>
      h != null ||
      w != null ||
      maxH != null ||
      maxW != null ||
      minH != null ||
      minW != null;

  /// Check if any background color, border, or border radius is set
  bool get hasBackgroundOrBorder =>
      color != null ||
      hasBorder ||
      hasBorderRadius;

  /// Apply text style directly to a Text widget
  Widget _applyTextStyleDirect(BuildContext context, Text textWidget) {
    // Start with the existing text widget style
    TextStyle finalStyle = textWidget.style ?? const TextStyle();
    
    // Apply text style token if set
    if (text != null) {
      finalStyle = FlyTextUtils.applyToTextStyle(context, this, finalStyle);
    }
    
    // Then apply color if set (this will override the color from the text style token)
    if (color != null) {
      finalStyle = FlyColorUtils.applyToTextStyle(context, this, finalStyle);
    }
    
    // Resolve text alignment
    TextAlign? finalTextAlign = textWidget.textAlign;
    if (textAlign != null) {
      finalTextAlign = FlyTextUtils.resolveTextAlign(textAlign);
    }
    
    // Transform text if needed
    String finalText = textWidget.data ?? '';
    if (textTransform != null) {
      finalText = FlyTextUtils.transformText(finalText, textTransform);
    }
    
    return Text(
      finalText,
      style: finalStyle,
      textAlign: finalTextAlign,
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

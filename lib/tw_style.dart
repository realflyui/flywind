import 'package:flutter/material.dart';
import 'tw_padding.dart';
import 'tw_margin.dart';
import 'tw_color.dart';

/// Internal style storage for TwText widget
class TwStyle {
  const TwStyle({
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
  });

  final int? p;        // Uniform padding (all sides)
  final int? px;       // Horizontal padding (left + right)
  final int? py;       // Vertical padding (top + bottom)
  final int? pl;       // Left padding
  final int? pr;       // Right padding
  final int? pb;       // Bottom padding
  final int? pt;       // Top padding
  final int? m;        // Uniform margin (all sides)
  final int? mx;       // Horizontal margin (left + right)
  final int? my;       // Vertical margin (top + bottom)
  final int? ml;       // Left margin
  final int? mr;       // Right margin
  final int? mb;       // Bottom margin
  final int? mt;       // Top margin
  final String? color;

  /// Create a copy of this style with updated values
  TwStyle copyWith({
    int? p,
    int? px,
    int? py,
    int? pl,
    int? pr,
    int? pb,
    int? pt,
    int? m,
    int? mx,
    int? my,
    int? ml,
    int? mr,
    int? mb,
    int? mt,
    String? color,
  }) {
    return TwStyle(
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
      result = TwPadding.apply(context, this, result);
    }
    
    // 2. Background Color (for non-text widgets or containers)
    if (color != null && child is! Text) {
      result = _applyBackgroundColor(context, result);
    }
    
    // 3. Margin (outermost - wraps the background)
    if (hasMargin) {
      result = TwMargin.apply(context, this, result);
    }
    
    // Future utilities would go here:
    // 4. Border (wraps margin)
    // 5. Shadow (wraps border)
    
    return result;
  }

  /// Check if any padding is set
  bool get hasPadding => p != null || px != null || py != null || 
                        pl != null || pr != null || pb != null || pt != null;

  /// Check if any margin is set
  bool get hasMargin => m != null || mx != null || my != null || 
                       ml != null || mr != null || mb != null || mt != null;

  /// Apply text color directly to a Text widget
  Widget _applyTextColorDirect(BuildContext context, Text textWidget) {
    return Text(
      textWidget.data ?? '',
      style: TwColor.applyToTextStyle(context, this, textWidget.style),
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
      color: TwColor.applyToContainer(context, this),
      child: child,
    );
  }

}

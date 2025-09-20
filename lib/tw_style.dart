import 'package:flutter/material.dart';
import 'tw_padding.dart';
import 'tw_color.dart';

/// Internal style storage for TwText widget
class TwStyle {
  const TwStyle({
    this.padding,
    this.px,
    this.py,
    this.pl,
    this.pr,
    this.pb,
    this.pt,
    this.color,
  });

  final int? padding;  // Uniform padding (all sides)
  final int? px;       // Horizontal padding (left + right)
  final int? py;       // Vertical padding (top + bottom)
  final int? pl;       // Left padding
  final int? pr;       // Right padding
  final int? pb;       // Bottom padding
  final int? pt;       // Top padding
  final String? color;

  /// Create a copy of this style with updated values
  TwStyle copyWith({
    int? padding,
    int? px,
    int? py,
    int? pl,
    int? pr,
    int? pb,
    int? pt,
    String? color,
  }) {
    return TwStyle(
      padding: padding ?? this.padding,
      px: px ?? this.px,
      py: py ?? this.py,
      pl: pl ?? this.pl,
      pr: pr ?? this.pr,
      pb: pb ?? this.pb,
      pt: pt ?? this.pt,
      color: color ?? this.color,
    );
  }

  /// Apply all style utilities to a widget in the correct order
  Widget apply(BuildContext context, Widget child) {
    Widget result = child;
    
    // Apply utilities in the correct order (inner to outer)
    // 1. Color (applied to the widget itself)
    if (color != null) {
      result = _applyColor(context, result);
    }
    
    // 2. Padding (wraps the widget)
    if (hasPadding) {
      result = TwPadding.apply(context, this, result);
    }
    
    // Future utilities would go here:
    // 3. Margin (wraps padding)
    // 4. Border (wraps margin)
    // 5. Shadow (wraps border)
    
    return result;
  }

  /// Check if any padding is set
  bool get hasPadding => padding != null || px != null || py != null || 
                        pl != null || pr != null || pb != null || pt != null;

  /// Apply color to a widget (handles different widget types)
  Widget _applyColor(BuildContext context, Widget child) {
    if (child is Text) {
      return Text(
        child.data ?? '',
        style: TwColor.applyToTextStyle(context, this, child.style),
        textAlign: child.textAlign,
        textDirection: child.textDirection,
        locale: child.locale,
        softWrap: child.softWrap,
        overflow: child.overflow,
        textScaler: child.textScaler,
        maxLines: child.maxLines,
        semanticsLabel: child.semanticsLabel,
        textWidthBasis: child.textWidthBasis,
        textHeightBehavior: child.textHeightBehavior,
      );
    } else if (child is Container) {
      // For Container widgets, we can't easily modify the color property
      // So we wrap it in another Container with the background color
      return Container(
        color: TwColor.applyToContainer(context, this),
        child: child,
      );
    }
    
    // For other widget types, wrap in a Container with background color
    return Container(
      color: TwColor.applyToContainer(context, this),
      child: child,
    );
  }
}

import 'package:flutter/material.dart';
import 'style.dart';
import 'value.dart';
import '../core/theme.dart';

/// Parameters for Column widget direct Flutter API access
class ColParams {
  const ColParams({
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.mainAxisSize,
    this.textBaseline,
    this.textDirection,
    this.verticalDirection,
  });

  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final TextBaseline? textBaseline;
  final TextDirection? textDirection;
  final VerticalDirection? verticalDirection;
}

/// Parameters for Row widget direct Flutter API access
class RowParams {
  const RowParams({
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.mainAxisSize,
    this.textBaseline,
    this.textDirection,
    this.verticalDirection,
  });

  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final TextBaseline? textBaseline;
  final TextDirection? textDirection;
  final VerticalDirection? verticalDirection;
}

/// Utility class for handling Tailwind-like layout logic
class FlyLayoutUtils {
  /// Resolve MainAxisAlignment from string
  static MainAxisAlignment resolveMainAxisAlignment(String? value) {
    switch (value) {
      case 'start':
        return MainAxisAlignment.start;
      case 'end':
        return MainAxisAlignment.end;
      case 'center':
        return MainAxisAlignment.center;
      case 'between':
        return MainAxisAlignment.spaceBetween;
      case 'around':
        return MainAxisAlignment.spaceAround;
      case 'evenly':
        return MainAxisAlignment.spaceEvenly;
      default:
        return MainAxisAlignment.start;
    }
  }

  /// Resolve CrossAxisAlignment from string
  static CrossAxisAlignment resolveCrossAxisAlignment(String? value) {
    switch (value) {
      case 'start':
        return CrossAxisAlignment.start;
      case 'end':
        return CrossAxisAlignment.end;
      case 'center':
        return CrossAxisAlignment.center;
      case 'stretch':
        return CrossAxisAlignment.stretch;
      case 'baseline':
        return CrossAxisAlignment.baseline;
      default:
        return CrossAxisAlignment.start;
    }
  }

  /// Resolve spacing value from string token
  static double resolveSpacing(BuildContext context, String? value) {
    if (value == null) return 0.0;
    
    try {
      final spacing = FlyTheme.of(context).spacing;
      return FlyValue.resolveDouble(value, context, spacing);
    } catch (e) {
      // Fallback to simple parsing if theme resolution fails
      // Handle 'px' for 1 pixel
      if (value == 'px') return 1.0;
      
      // Handle spacing tokens (s0, s1, s2, etc.)
      if (value.startsWith('s')) {
        final tokenValue = value.substring(1);
        final spacingValue = int.tryParse(tokenValue);
        if (spacingValue != null) {
          // Convert to logical pixels (assuming 4px per unit like Tailwind)
          return spacingValue * 4.0;
        }
      }
      
      // Handle direct numeric values
      final numericValue = double.tryParse(value);
      if (numericValue != null) {
        return numericValue;
      }
      
      return 0.0;
    }
  }

  /// Apply gap spacing to children
  static List<Widget> applyGap(List<Widget> children, double gap) {
    if (gap <= 0 || children.length <= 1) return children;
    
    final result = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      result.add(children[i]);
      if (i < children.length - 1) {
        result.add(SizedBox(width: gap, height: gap));
      }
    }
    return result;
  }

  /// Build a Column widget with layout properties from FlyStyle
  static Widget buildColumn(BuildContext context, FlyStyle style, List<Widget> children) {
    // Check if direct Flutter API parameters are provided
    final colParams = style.col as ColParams?;
    
    MainAxisAlignment mainAxisAlignment;
    CrossAxisAlignment crossAxisAlignment;
    MainAxisSize mainAxisSize;
    TextBaseline? textBaseline;
    TextDirection? textDirection;
    VerticalDirection verticalDirection;
    
    if (colParams != null) {
      // Use direct Flutter API parameters
      mainAxisAlignment = colParams.mainAxisAlignment ?? resolveMainAxisAlignment(style.justify);
      crossAxisAlignment = colParams.crossAxisAlignment ?? resolveCrossAxisAlignment(style.items);
      mainAxisSize = colParams.mainAxisSize ?? (style.inline == true ? MainAxisSize.min : MainAxisSize.max);
      textBaseline = colParams.textBaseline;
      textDirection = colParams.textDirection;
      verticalDirection = colParams.verticalDirection ?? (style.reverse == true ? VerticalDirection.up : VerticalDirection.down);
    } else {
      // Use utility method parameters
      mainAxisAlignment = resolveMainAxisAlignment(style.justify);
      crossAxisAlignment = resolveCrossAxisAlignment(style.items);
      mainAxisSize = style.inline == true ? MainAxisSize.min : MainAxisSize.max;
      textBaseline = null;
      textDirection = null;
      verticalDirection = style.reverse == true ? VerticalDirection.up : VerticalDirection.down;
    }
    
    // Apply gap if specified
    final gap = resolveSpacing(context, style.gap);
    final childrenWithGap = gap > 0 
        ? applyGap(children, gap)
        : children;
    
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textBaseline: textBaseline,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      children: childrenWithGap,
    );
  }

  /// Build a Row widget with layout properties from FlyStyle
  static Widget buildRow(BuildContext context, FlyStyle style, List<Widget> children) {
    // Check if direct Flutter API parameters are provided
    final rowParams = style.row as RowParams?;
    
    MainAxisAlignment mainAxisAlignment;
    CrossAxisAlignment crossAxisAlignment;
    MainAxisSize mainAxisSize;
    TextBaseline? textBaseline;
    TextDirection? textDirection;
    VerticalDirection verticalDirection;
    
    if (rowParams != null) {
      // Use direct Flutter API parameters
      mainAxisAlignment = rowParams.mainAxisAlignment ?? resolveMainAxisAlignment(style.justify);
      crossAxisAlignment = rowParams.crossAxisAlignment ?? resolveCrossAxisAlignment(style.items);
      mainAxisSize = rowParams.mainAxisSize ?? (style.inline == true ? MainAxisSize.min : MainAxisSize.max);
      textBaseline = rowParams.textBaseline;
      textDirection = rowParams.textDirection ?? (style.reverse == true ? TextDirection.rtl : TextDirection.ltr);
      verticalDirection = rowParams.verticalDirection ?? VerticalDirection.down;
    } else {
      // Use utility method parameters
      mainAxisAlignment = resolveMainAxisAlignment(style.justify);
      crossAxisAlignment = resolveCrossAxisAlignment(style.items);
      mainAxisSize = style.inline == true ? MainAxisSize.min : MainAxisSize.max;
      textBaseline = null;
      textDirection = style.reverse == true ? TextDirection.rtl : TextDirection.ltr;
      verticalDirection = VerticalDirection.down;
    }
    
    // Apply gap if specified
    final gap = resolveSpacing(context, style.gap);
    final childrenWithGap = gap > 0 
        ? applyGap(children, gap)
        : children;
    
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textBaseline: textBaseline,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      children: childrenWithGap,
    );
  }
}

/// Mixin that provides Tailwind-like layout methods for any widget
mixin FlyLayoutUtilities<T> {
  FlyStyle get style;

  T Function(FlyStyle newStyle) get copyWith;

  /// Set layout type to column with optional direct Flutter API access
  T col({
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    MainAxisSize? mainAxisSize,
    TextBaseline? textBaseline,
    TextDirection? textDirection,
    VerticalDirection? verticalDirection,
  }) {
    if (mainAxisAlignment != null || 
        crossAxisAlignment != null || 
        mainAxisSize != null || 
        textBaseline != null || 
        textDirection != null || 
        verticalDirection != null) {
      // Use direct Flutter API access
      return copyWith(style.copyWith(
        layoutType: 'col',
        col: ColParams(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: mainAxisSize,
          textBaseline: textBaseline,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
        ),
      ));
    } else {
      // Use utility method (no parameters)
      return copyWith(style.copyWith(layoutType: 'col'));
    }
  }

  /// Set layout type to row with optional direct Flutter API access
  T row({
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    MainAxisSize? mainAxisSize,
    TextBaseline? textBaseline,
    TextDirection? textDirection,
    VerticalDirection? verticalDirection,
  }) {
    if (mainAxisAlignment != null || 
        crossAxisAlignment != null || 
        mainAxisSize != null || 
        textBaseline != null || 
        textDirection != null || 
        verticalDirection != null) {
      // Use direct Flutter API access
      return copyWith(style.copyWith(
        layoutType: 'row',
        row: RowParams(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: mainAxisSize,
          textBaseline: textBaseline,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
        ),
      ));
    } else {
      // Use utility method (no parameters)
      return copyWith(style.copyWith(layoutType: 'row'));
    }
  }

  /// Set cross-axis alignment - accepts String ('start', 'end', 'center', 'stretch', 'baseline')
  T items(String value) {
    return copyWith(style.copyWith(items: value));
  }

  /// Set main-axis alignment - accepts String ('start', 'end', 'center', 'between', 'around', 'evenly')
  T justify(String value) {
    return copyWith(style.copyWith(justify: value));
  }

  /// Set gap spacing - accepts String ('s0' to 's96', 'px')
  T gap(String value) {
    return copyWith(style.copyWith(gap: value));
  }

  /// Set horizontal gap spacing - accepts String ('s0' to 's96', 'px')
  T gapX(String value) {
    return copyWith(style.copyWith(gapX: value));
  }

  /// Set vertical gap spacing - accepts String ('s0' to 's96', 'px')
  T gapY(String value) {
    return copyWith(style.copyWith(gapY: value));
  }

  /// Set reverse direction - accepts bool
  T reverse() {
    return copyWith(style.copyWith(reverse: true));
  }

  /// Set inline layout - accepts bool
  T inline() {
    return copyWith(style.copyWith(inline: true));
  }
}

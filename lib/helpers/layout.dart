import 'package:flutter/material.dart';

import '../core/theme.dart';
import 'flex.dart';
import 'style.dart';
import 'value.dart';

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

/// Parameters for Wrap widget direct Flutter API access
class WrapParams {
  const WrapParams({
    this.direction,
    this.alignment,
    this.spacing,
    this.runAlignment,
    this.runSpacing,
    this.crossAxisAlignment,
    this.textDirection,
    this.verticalDirection,
    this.clipBehavior,
  });

  final Axis? direction;
  final WrapAlignment? alignment;
  final double? spacing;
  final WrapAlignment? runAlignment;
  final double? runSpacing;
  final WrapCrossAlignment? crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection? verticalDirection;
  final Clip? clipBehavior;
}

/// Parameters for Stack widget direct Flutter API access
class StackParams {
  const StackParams({
    this.alignment,
    this.textDirection,
    this.fit,
    this.clipBehavior,
  });

  final AlignmentGeometry? alignment;
  final TextDirection? textDirection;
  final StackFit? fit;
  final Clip? clipBehavior;
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

    final spacing = FlyTheme.of(context).spacing;
    return FlyValue.resolveDouble(value, context, spacing);
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

  /// Apply flex properties to children if they have flex utilities
  static List<Widget> applyFlexToChildren(
    BuildContext context,
    List<Widget> children,
  ) {
    return children.map((child) {
      // Check if the child has flex properties by looking for FlyFlexUtilities mixin
      if (child is StatelessWidget) {
        // Try to access the style property through reflection or type checking
        try {
          // Check if it's a FlyText or FlyContainer with flex properties
          if (child.runtimeType.toString().contains('FlyText') ||
              child.runtimeType.toString().contains('FlyContainer')) {
            // Use reflection to get the style property
            final dynamic widget = child;
            if (widget.style != null && widget.style is FlyStyle) {
              final FlyStyle style = widget.style;
              if (FlyFlexUtils.hasFlexProperties(style)) {
                return FlyFlexUtils.apply(context, style, child);
              }
            }
          }
        } catch (e) {
          // If reflection fails, just return the child as-is
        }
      }
      return child;
    }).toList();
  }

  /// Build a Column widget with layout properties from FlyStyle
  static Widget buildColumn(
    BuildContext context,
    FlyStyle style,
    List<Widget> children,
  ) {
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
      mainAxisAlignment =
          colParams.mainAxisAlignment ??
          resolveMainAxisAlignment(style.justify);
      crossAxisAlignment =
          colParams.crossAxisAlignment ??
          resolveCrossAxisAlignment(style.items);
      mainAxisSize =
          colParams.mainAxisSize ??
          (style.inline == true ? MainAxisSize.min : MainAxisSize.max);
      textBaseline = colParams.textBaseline;
      textDirection = colParams.textDirection;
      verticalDirection =
          colParams.verticalDirection ??
          (style.reverse == true
              ? VerticalDirection.up
              : VerticalDirection.down);
    } else {
      // Use utility method parameters
      mainAxisAlignment = resolveMainAxisAlignment(style.justify);
      crossAxisAlignment = resolveCrossAxisAlignment(style.items);
      mainAxisSize = style.inline == true ? MainAxisSize.min : MainAxisSize.max;
      textBaseline = null;
      textDirection = null;
      verticalDirection = style.reverse == true
          ? VerticalDirection.up
          : VerticalDirection.down;
    }

    // Apply flex properties to children first
    final childrenWithFlex = applyFlexToChildren(context, children);

    // Apply gap if specified
    final gap = resolveSpacing(context, style.gap);
    final childrenWithGap = gap > 0
        ? applyGap(childrenWithFlex, gap)
        : childrenWithFlex;

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
  static Widget buildRow(
    BuildContext context,
    FlyStyle style,
    List<Widget> children,
  ) {
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
      mainAxisAlignment =
          rowParams.mainAxisAlignment ??
          resolveMainAxisAlignment(style.justify);
      crossAxisAlignment =
          rowParams.crossAxisAlignment ??
          resolveCrossAxisAlignment(style.items);
      mainAxisSize =
          rowParams.mainAxisSize ??
          (style.inline == true ? MainAxisSize.min : MainAxisSize.max);
      textBaseline = rowParams.textBaseline;
      textDirection =
          rowParams.textDirection ??
          (style.reverse == true ? TextDirection.rtl : TextDirection.ltr);
      verticalDirection = rowParams.verticalDirection ?? VerticalDirection.down;
    } else {
      // Use utility method parameters
      mainAxisAlignment = resolveMainAxisAlignment(style.justify);
      crossAxisAlignment = resolveCrossAxisAlignment(style.items);
      mainAxisSize = style.inline == true ? MainAxisSize.min : MainAxisSize.max;
      textBaseline = null;
      textDirection = style.reverse == true
          ? TextDirection.rtl
          : TextDirection.ltr;
      verticalDirection = VerticalDirection.down;
    }

    // Apply flex properties to children first
    final childrenWithFlex = applyFlexToChildren(context, children);

    // Apply gap if specified
    final gap = resolveSpacing(context, style.gap);
    final childrenWithGap = gap > 0
        ? applyGap(childrenWithFlex, gap)
        : childrenWithFlex;

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

  /// Build a Wrap widget with layout properties from FlyStyle
  static Widget buildWrap(
    BuildContext context,
    FlyStyle style,
    List<Widget> children,
  ) {
    // Check if direct Flutter API parameters are provided
    final wrapParams = style.wrap as WrapParams?;

    Axis direction;
    WrapAlignment alignment;
    double spacing;
    WrapAlignment runAlignment;
    double runSpacing;
    WrapCrossAlignment crossAxisAlignment;
    TextDirection? textDirection;
    VerticalDirection verticalDirection;
    Clip clipBehavior;

    if (wrapParams != null) {
      // Use direct Flutter API parameters
      direction = wrapParams.direction ?? Axis.horizontal;
      alignment = wrapParams.alignment ?? WrapAlignment.start;
      spacing = wrapParams.spacing ?? resolveSpacing(context, style.gap);
      runAlignment = wrapParams.runAlignment ?? WrapAlignment.start;
      runSpacing = wrapParams.runSpacing ?? 0.0;
      crossAxisAlignment =
          wrapParams.crossAxisAlignment ?? WrapCrossAlignment.start;
      textDirection = wrapParams.textDirection;
      verticalDirection =
          wrapParams.verticalDirection ??
          (style.reverse == true
              ? VerticalDirection.up
              : VerticalDirection.down);
      clipBehavior = wrapParams.clipBehavior ?? Clip.none;
    } else {
      // Use utility method parameters - only supported properties
      direction = Axis.horizontal;
      alignment = WrapAlignment.start;
      spacing = resolveSpacing(context, style.gap);
      runAlignment = WrapAlignment.start;
      runSpacing = 0.0;
      crossAxisAlignment = WrapCrossAlignment.start;
      textDirection = null;
      verticalDirection = style.reverse == true
          ? VerticalDirection.up
          : VerticalDirection.down;
      clipBehavior = Clip.none;
    }

    // Apply flex properties to children first
    final childrenWithFlex = applyFlexToChildren(context, children);

    // Note: For Wrap, we don't apply gap using SizedBox like Column/Row
    // The spacing is handled directly by the Wrap widget's spacing parameter

    return Wrap(
      direction: direction,
      alignment: alignment,
      spacing: spacing,
      runAlignment: runAlignment,
      runSpacing: runSpacing,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      clipBehavior: clipBehavior,
      children: childrenWithFlex,
    );
  }

  /// Build a Stack widget with layout properties from FlyStyle
  static Widget buildStack(
    BuildContext context,
    FlyStyle style,
    List<Widget> children,
  ) {
    // Check if direct Flutter API parameters are provided
    final stackParams = style.stack as StackParams?;

    AlignmentGeometry alignment;
    TextDirection? textDirection;
    StackFit fit;
    Clip clipBehavior;

    if (stackParams != null) {
      // Use direct Flutter API parameters
      alignment = stackParams.alignment ?? AlignmentDirectional.topStart;
      textDirection = stackParams.textDirection;
      fit = stackParams.fit ?? StackFit.loose;
      clipBehavior = stackParams.clipBehavior ?? Clip.hardEdge;
    } else {
      // Use default values when no direct API parameters provided
      alignment = AlignmentDirectional.topStart;
      textDirection = null;
      fit = StackFit.loose;
      clipBehavior = Clip.hardEdge;
    }

    // Apply flex properties to children first
    final childrenWithFlex = applyFlexToChildren(context, children);

    // Note: For Stack, we don't apply gap using SizedBox like Column/Row
    // Stack children are positioned absolutely or use the stack's alignment

    return Stack(
      alignment: alignment,
      textDirection: textDirection,
      fit: fit,
      clipBehavior: clipBehavior,
      children: childrenWithFlex,
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
      return copyWith(
        style.copyWith(
          layoutType: 'col',
          col: ColParams(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            mainAxisSize: mainAxisSize,
            textBaseline: textBaseline,
            textDirection: textDirection,
            verticalDirection: verticalDirection,
          ),
        ),
      );
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
      return copyWith(
        style.copyWith(
          layoutType: 'row',
          row: RowParams(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            mainAxisSize: mainAxisSize,
            textBaseline: textBaseline,
            textDirection: textDirection,
            verticalDirection: verticalDirection,
          ),
        ),
      );
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

  /// Set layout type to wrap with optional direct Flutter API access
  T wrap({
    Axis? direction,
    WrapAlignment? alignment,
    double? spacing,
    WrapAlignment? runAlignment,
    double? runSpacing,
    WrapCrossAlignment? crossAxisAlignment,
    TextDirection? textDirection,
    VerticalDirection? verticalDirection,
    Clip? clipBehavior,
  }) {
    if (direction != null ||
        alignment != null ||
        spacing != null ||
        runAlignment != null ||
        runSpacing != null ||
        crossAxisAlignment != null ||
        textDirection != null ||
        verticalDirection != null ||
        clipBehavior != null) {
      // Use direct Flutter API access
      return copyWith(
        style.copyWith(
          layoutType: 'wrap',
          wrap: WrapParams(
            direction: direction,
            alignment: alignment,
            spacing: spacing,
            runAlignment: runAlignment,
            runSpacing: runSpacing,
            crossAxisAlignment: crossAxisAlignment,
            textDirection: textDirection,
            verticalDirection: verticalDirection,
            clipBehavior: clipBehavior,
          ),
        ),
      );
    } else {
      // Use utility method (no parameters)
      return copyWith(style.copyWith(layoutType: 'wrap'));
    }
  }

  /// Set layout type to stack with optional direct Flutter API access
  T stack({
    AlignmentGeometry? alignment,
    TextDirection? textDirection,
    StackFit? fit,
    Clip? clipBehavior,
  }) {
    if (alignment != null ||
        textDirection != null ||
        fit != null ||
        clipBehavior != null) {
      // Use direct Flutter API access
      return copyWith(
        style.copyWith(
          layoutType: 'stack',
          stack: StackParams(
            alignment: alignment,
            textDirection: textDirection,
            fit: fit,
            clipBehavior: clipBehavior,
          ),
        ),
      );
    } else {
      // Use utility method (no parameters)
      return copyWith(style.copyWith(layoutType: 'stack'));
    }
  }
}

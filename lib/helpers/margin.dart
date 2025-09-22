import 'package:flutter/material.dart';
import 'style.dart';
import 'value.dart';
import '../core/theme.dart';
import '../tokens/spacing.dart';

/// Utility class for handling Tailwind-like margin logic
class FlyMarginUtils {
  /// Resolves margin from FlyStyle and FlyTheme into EdgeInsets
  static EdgeInsets resolve(BuildContext context, FlyStyle style) {
    try {
      final spacing = FlyTheme.of(context).spacing;
      
      return EdgeInsets.only(
        left: _resolveValue(style.ml ?? style.mx ?? style.m, context, spacing),
        right: _resolveValue(style.mr ?? style.mx ?? style.m, context, spacing),
        top: _resolveValue(style.mt ?? style.my ?? style.m, context, spacing),
        bottom: _resolveValue(style.mb ?? style.my ?? style.m, context, spacing),
      );
    } catch (e) {
      throw ArgumentError('Failed to resolve margin: $e');
    }
  }
  
  /// Resolves a dynamic value to double using the numeric value resolver
  static double _resolveValue(dynamic value, BuildContext context, FlySpacingToken tokens) {
    if (value == null) return 0;
    return FlyValue.resolveDouble(value, context, tokens);
  }

  /// Applies margin to a widget using the resolved EdgeInsets
  static Widget apply(BuildContext context, FlyStyle style, Widget child) {
    final margin = resolve(context, style);

    // If no margin is set, return the child as-is
    if (margin == EdgeInsets.zero) {
      return child;
    }

    // Apply margin using Container
    return Container(margin: margin, child: child);
  }
}

/// Mixin that provides Tailwind-like margin methods for any widget
mixin FlyMargin<T> {
  FlyStyle get style;

  T Function(FlyStyle newStyle) get copyWith;

  /// Set uniform margin - accepts int, double, or String (token name/unit)
  T m(dynamic value) {
    return copyWith(style.copyWith(m: value));
  }

  /// Set horizontal margin (left + right) - accepts int, double, or String (token name/unit)
  T mx(dynamic value) {
    return copyWith(style.copyWith(mx: value));
  }

  /// Set vertical margin (top + bottom) - accepts int, double, or String (token name/unit)
  T my(dynamic value) {
    return copyWith(style.copyWith(my: value));
  }

  /// Set top margin - accepts int, double, or String (token name/unit)
  T mt(dynamic value) {
    return copyWith(style.copyWith(mt: value));
  }

  /// Set right margin - accepts int, double, or String (token name/unit)
  T mr(dynamic value) {
    return copyWith(style.copyWith(mr: value));
  }

  /// Set bottom margin - accepts int, double, or String (token name/unit)
  T mb(dynamic value) {
    return copyWith(style.copyWith(mb: value));
  }

  /// Set left margin - accepts int, double, or String (token name/unit)
  T ml(dynamic value) {
    return copyWith(style.copyWith(ml: value));
  }

  /// Resolves margin from FlyStyle and FlyTheme into EdgeInsets
  EdgeInsets resolveMargin(BuildContext context) {
    return FlyMarginUtils.resolve(context, style);
  }

  /// Applies margin to a widget using the resolved EdgeInsets
  Widget applyMargin(BuildContext context, Widget child) {
    return FlyMarginUtils.apply(context, style, child);
  }
}

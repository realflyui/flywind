import 'package:flutter/material.dart';
import 'tw_style.dart';
import 'tw_padding.dart';
import 'tw_margin.dart';
import 'tw_color.dart';

/// A builder-style widget that mimics Tailwind-like utilities for containers
class TwContainer extends StatelessWidget with TwPadding<TwContainer>, TwMargin<TwContainer>, TwColor<TwContainer> {
  const TwContainer({
    super.key,
    required this.child,
    TwStyle style = const TwStyle(),
  }) : _style = style;

  final Widget child;
  final TwStyle _style;

  @override
  TwStyle get style => _style;

  @override
  TwContainer Function(TwStyle newStyle) get copyWith => (newStyle) => TwContainer(
    child: child,
    style: newStyle,
  );

  /// Set background color using named token (alias for color)
  TwContainer bg(String key) {
    return TwContainer(
      child: child,
      style: _style.copyWith(color: key),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Create the base Container widget
    Widget containerWidget = Container(child: child);

    // Apply all style utilities (color, padding, etc.) using TwStyle.apply()
    return _style.apply(context, containerWidget);
  }
}

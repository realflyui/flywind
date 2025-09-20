import 'package:flutter/material.dart';
import 'style.dart';
import 'padding.dart';
import 'margin.dart';
import 'color.dart';
import 'rounded.dart';

/// A builder-style widget that mimics Tailwind-like utilities for containers
class FlyContainer extends StatelessWidget with FlyPadding<FlyContainer>, FlyMargin<FlyContainer>, FlyColor<FlyContainer>, FlyRounded<FlyContainer> {
  const FlyContainer({
    super.key,
    required this.child,
    FlyStyle style = const FlyStyle(),
  }) : _style = style;

  final Widget child;
  final FlyStyle _style;

  @override
  FlyStyle get style => _style;

  @override
  FlyContainer Function(FlyStyle newStyle) get copyWith => (newStyle) => FlyContainer(
    child: child,
    style: newStyle,
  );

  /// Set background color using named token (alias for color)
  FlyContainer bg(String key) {
    return FlyContainer(
      child: child,
      style: _style.copyWith(color: key),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Create the base Container widget
    Widget containerWidget = Container(child: child);

    // Apply all style utilities (color, padding, etc.) using FlyStyle.apply()
    return _style.apply(context, containerWidget);
  }
}

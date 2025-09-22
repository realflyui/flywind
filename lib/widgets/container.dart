import 'package:flutter/material.dart';
import '../helpers/style.dart';
import '../helpers/padding.dart';
import '../helpers/margin.dart';
import '../helpers/color.dart';
import '../helpers/rounded.dart';

/// A builder-style widget that mimics Tailwind-like utilities for containers
class FlyContainer extends StatelessWidget
    with
        FlyPadding<FlyContainer>,
        FlyMargin<FlyContainer>,
        FlyColor<FlyContainer>,
        FlyRounded<FlyContainer> {
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
  FlyContainer Function(FlyStyle newStyle) get copyWith =>
      (newStyle) => FlyContainer(style: newStyle, child: child);

  @override
  Widget build(BuildContext context) {
    // Create the base Container widget
    Widget containerWidget = Container(child: child);

    // Apply all style utilities (color, padding, etc.) using FlyStyle.apply()
    return _style.apply(context, containerWidget);
  }
}

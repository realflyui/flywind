import 'package:flutter/material.dart';
import '../helpers/style.dart';
import '../helpers/padding.dart';
import '../helpers/margin.dart';
import '../helpers/color.dart';
import '../helpers/rounded.dart';

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

  /// Set background color using named token or direct Color object
  FlyContainer bg(dynamic colorValue) {
    // Convert to string for storage - let FlyColorParser handle the conversion
    String? colorKey;
    if (colorValue is String) {
      colorKey = colorValue;
    } else if (colorValue is Color) {
      // Convert Color to hex string for storage
      colorKey = '#${colorValue.value.toRadixString(16).padLeft(8, '0')}';
    }
    
    return FlyContainer(
      child: child,
      style: _style.copyWith(color: colorKey),
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

import 'package:flutter/material.dart';
import '../helpers/layout.dart';
import '../helpers/style.dart';

/// A layout widget that provides Tailwind-like layout utilities
class FlyLayout extends StatelessWidget with FlyLayoutUtilities<FlyLayout> {
  const FlyLayout(
    this.children, {
    super.key,
    FlyStyle style = const FlyStyle(),
  }) : _style = style;

  final List<Widget> children;
  final FlyStyle _style;

  @override
  FlyStyle get style => _style;

  @override
  FlyLayout Function(FlyStyle newStyle) get copyWith =>
      (newStyle) => FlyLayout(children, style: newStyle);

  @override
  Widget build(BuildContext context) {
    // If no layout type is specified, return children in a column by default
    final layoutType = _style.layoutType ?? 'col';
    
    switch (layoutType) {
      case 'col':
        return FlyLayoutUtils.buildColumn(context, _style, children);
      case 'row':
        return FlyLayoutUtils.buildRow(context, _style, children);
      case 'wrap':
        return FlyLayoutUtils.buildWrap(context, _style, children);
      default:
        return FlyLayoutUtils.buildColumn(context, _style, children);
    }
  }
}

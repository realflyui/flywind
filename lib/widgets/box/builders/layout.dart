import 'package:flutter/material.dart';

import '../../../core/style.dart';
import '../../../helpers/layout.dart';

/// Handles layout building for FlyBox widgets
class BoxLayout {
  /// Build pure layout (no container wrapper)
  static Widget build(
    BuildContext context,
    List<Widget> children,
    FlyStyle flyStyle,
  ) {
    final layoutType = flyStyle.layoutType ?? 'col';

    switch (layoutType) {
      case 'col':
        return FlyLayoutUtils.buildColumn(context, flyStyle, children);
      case 'row':
        return FlyLayoutUtils.buildRow(context, flyStyle, children);
      case 'wrap':
        return FlyLayoutUtils.buildWrap(context, flyStyle, children);
      case 'stack':
        return FlyLayoutUtils.buildStack(context, flyStyle, children);
      default:
        return FlyLayoutUtils.buildColumn(context, flyStyle, children);
    }
  }
}

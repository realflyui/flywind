import 'package:flutter/material.dart';

import 'style.dart';

/// InheritedWidget that provides FlyStyle context to descendant widgets
///
/// This allows widgets to inherit style properties from their nearest
/// FlyBox ancestor without explicit prop drilling.
class FlyStyleContext extends InheritedWidget {
  const FlyStyleContext({super.key, required this.style, required super.child});

  /// The FlyStyle to provide to descendants
  final FlyStyle style;

  /// Get the nearest FlyStyleContext from the widget tree
  ///
  /// Returns null if no FlyStyleContext is found in the tree.
  static FlyStyle? of(BuildContext context) {
    final inherited = context
        .dependOnInheritedWidgetOfExactType<FlyStyleContext>();
    return inherited?.style;
  }

  @override
  bool updateShouldNotify(FlyStyleContext oldWidget) {
    return style != oldWidget.style;
  }
}

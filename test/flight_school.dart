import 'package:flutter/material.dart';
import 'package:flywind/helpers/theme.dart';

/// Helper function to create test widgets with FlyTheme
Widget createTestWidget(Widget child) {
  return MaterialApp(
    theme: ThemeData(
      extensions: [FlyTheme.defaultTheme],
    ),
    home: Scaffold(
      body: child,
    ),
  );
}

/// Helper function to create test widgets with custom FlyTheme
Widget createTestWidgetWithTheme(Widget child, FlyTheme theme) {
  return MaterialApp(
    theme: ThemeData(
      extensions: [theme],
    ),
    home: Scaffold(
      body: child,
    ),
  );
}

/// Helper function to create test widgets that need BuildContext access
Widget createTestWidgetWithContext(Widget Function(BuildContext) builder) {
  return MaterialApp(
    theme: ThemeData(
      extensions: [FlyTheme.defaultTheme],
    ),
    home: Builder(
      builder: builder,
    ),
  );
}

/// Helper function to create test widgets with custom theme that need BuildContext access
Widget createTestWidgetWithContextAndTheme(Widget Function(BuildContext) builder, FlyTheme theme) {
  return MaterialApp(
    theme: ThemeData(
      extensions: [theme],
    ),
    home: Builder(
      builder: builder,
    ),
  );
}

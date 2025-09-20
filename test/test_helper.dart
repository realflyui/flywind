import 'package:flutter/material.dart';
import 'package:flywind/tw_theme.dart';

/// Helper function to create test widgets with TwTheme
Widget createTestWidget(Widget child) {
  return MaterialApp(
    theme: ThemeData(
      extensions: [TwTheme.defaultTheme],
    ),
    home: Scaffold(
      body: child,
    ),
  );
}

/// Helper function to create test widgets with custom TwTheme
Widget createTestWidgetWithTheme(Widget child, TwTheme theme) {
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
      extensions: [TwTheme.defaultTheme],
    ),
    home: Builder(
      builder: builder,
    ),
  );
}

/// Helper function to create test widgets with custom theme that need BuildContext access
Widget createTestWidgetWithContextAndTheme(Widget Function(BuildContext) builder, TwTheme theme) {
  return MaterialApp(
    theme: ThemeData(
      extensions: [theme],
    ),
    home: Builder(
      builder: builder,
    ),
  );
}

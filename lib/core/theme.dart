import 'package:flutter/material.dart';
import 'notifier.dart';
import '../tokens/tokens.dart';

/// InheritedNotifier widget that provides Fly theme data to the widget tree
class FlyTheme extends InheritedNotifier<FlyNotifier> {
  const FlyTheme({
    super.key,
    required FlyNotifier notifier,
    required super.child,
  }) : super(notifier: notifier);

  /// Get the current Fly theme data from the context
  static FlyThemeData of(BuildContext context) {
    final data = context.dependOnInheritedWidgetOfExactType<FlyTheme>();
    if (data != null && data.notifier != null) {
      return data.notifier!.data;
    }

    // Fallback to Material theme extension if available
    final materialTheme = Theme.of(context);
    final extension = materialTheme.extension<FlyThemeData>();
    if (extension != null) {
      return extension;
    }

    // Return fallback theme data
    return FlyThemeData.fallback();
  }

  /// Get the notifier for direct access to all theme methods
  /// 
  /// This provides access to all notifier methods while maintaining
  /// the convenience of context-based access.
  /// 
  /// Example:
  /// ```dart
  /// FlyTheme.data(context)?.putSpacing('large', 32.0);
  /// FlyTheme.data(context)?.updateColors((colors) => colors.put('primary', Colors.blue));
  /// ```
  static FlyNotifier? data(BuildContext context) {
    return _getNotifier(context);
  }

  /// Update the theme using a function
  static void update(BuildContext context, FlyThemeData Function(FlyThemeData current) updater) {
    _getNotifier(context)?.update(updater);
  }

  /// Update spacing token
  static void updateSpacing(BuildContext context, FlySpacingToken Function(FlySpacingToken current) updater) {
    _getNotifier(context)?.updateSpacing(updater);
  }

  /// Update colors token
  static void updateColors(BuildContext context, FlyColorToken Function(FlyColorToken current) updater) {
    _getNotifier(context)?.updateColors(updater);
  }

  /// Update radius token
  static void updateRadius(BuildContext context, FlyRadiusToken Function(FlyRadiusToken current) updater) {
    _getNotifier(context)?.updateRadius(updater);
  }

  /// Update text style token
  static void updateTextStyle(BuildContext context, FlyTextStyleToken Function(FlyTextStyleToken current) updater) {
    _getNotifier(context)?.updateTextStyle(updater);
  }

  /// Update font token
  static void updateFont(BuildContext context, FlyFontToken Function(FlyFontToken current) updater) {
    _getNotifier(context)?.updateFont(updater);
  }

  /// Update font weight token
  static void updateFontWeight(BuildContext context, FlyFontWeightToken Function(FlyFontWeightToken current) updater) {
    _getNotifier(context)?.updateFontWeight(updater);
  }

  /// Update leading token
  static void updateLeading(BuildContext context, FlyLeadingToken Function(FlyLeadingToken current) updater) {
    _getNotifier(context)?.updateLeading(updater);
  }

  /// Put a spacing value
  static void putSpacing(BuildContext context, String key, num value) {
    _getNotifier(context)?.putSpacing(key, value);
  }

  /// Put a color value
  static void putColor(BuildContext context, String key, Color value) {
    _getNotifier(context)?.putColor(key, value);
  }

  /// Put a radius value
  static void putRadius(BuildContext context, String key, double value) {
    _getNotifier(context)?.putRadius(key, value);
  }

  /// Put a text style value
  static void putTextStyle(BuildContext context, String key, TextStyle value) {
    _getNotifier(context)?.putTextStyle(key, value);
  }

  /// Put a font value
  static void putFont(BuildContext context, String key, List<String> value) {
    _getNotifier(context)?.putFont(key, value);
  }

  /// Put a font weight value
  static void putFontWeight(BuildContext context, String key, FontWeight value) {
    _getNotifier(context)?.putFontWeight(key, value);
  }

  /// Put a leading value
  static void putLeading(BuildContext context, String key, double value) {
    _getNotifier(context)?.putLeading(key, value);
  }

  /// Update tracking token
  static void updateTracking(BuildContext context, FlyTrackingToken Function(FlyTrackingToken current) updater) {
    _getNotifier(context)?.updateTracking(updater);
  }

  /// Update breakpoint token
  static void updateBreakpoint(BuildContext context, FlyBreakpointToken Function(FlyBreakpointToken current) updater) {
    _getNotifier(context)?.updateBreakpoint(updater);
  }

  /// Put a tracking value
  static void putTracking(BuildContext context, String key, double value) {
    _getNotifier(context)?.putTracking(key, value);
  }

  /// Put a breakpoint value
  static void putBreakpoint(BuildContext context, String key, double value) {
    _getNotifier(context)?.putBreakpoint(key, value);
  }

  /// Check if FlyTheme is available in the context
  static bool hasFlyTheme(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FlyTheme>() != null;
  }

  /// Helper method to get the data from context
  static FlyNotifier? _getNotifier(BuildContext context) {
    final data = context.dependOnInheritedWidgetOfExactType<FlyTheme>();
    return data?.notifier;
  }
}

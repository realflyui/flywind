import 'package:flutter/material.dart';
import 'data.dart';
import '../tokens/tokens.dart';

/// InheritedNotifier widget that provides Fly theme data to the widget tree
class FlyTheme extends InheritedNotifier<FlyData> {
  const FlyTheme({
    super.key,
    required FlyData notifier,
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
  static FlyData? data(BuildContext context) {
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

  /// Update breakpoints token
  static void updateBreakpoints(BuildContext context, FlyBreakpointToken Function(FlyBreakpointToken current) updater) {
    _getNotifier(context)?.updateBreakpoints(updater);
  }

  /// Update container token
  static void updateContainer(BuildContext context, FlyContainerToken Function(FlyContainerToken current) updater) {
    _getNotifier(context)?.updateContainer(updater);
  }

  /// Update text token
  static void updateText(BuildContext context, FlyTextToken Function(FlyTextToken current) updater) {
    _getNotifier(context)?.updateText(updater);
  }

  /// Update text line height token
  static void updateTextLineHeight(BuildContext context, FlyTextLineHeightToken Function(FlyTextLineHeightToken current) updater) {
    _getNotifier(context)?.updateTextLineHeight(updater);
  }

  /// Update font weight token
  static void updateFontWeight(BuildContext context, FlyFontWeightToken Function(FlyFontWeightToken current) updater) {
    _getNotifier(context)?.updateFontWeight(updater);
  }

  /// Update tracking token
  static void updateTracking(BuildContext context, FlyTrackingToken Function(FlyTrackingToken current) updater) {
    _getNotifier(context)?.updateTracking(updater);
  }

  /// Update blur token
  static void updateBlur(BuildContext context, FlyBlurToken Function(FlyBlurToken current) updater) {
    _getNotifier(context)?.updateBlur(updater);
  }

  /// Update perspective token
  static void updatePerspective(BuildContext context, FlyPerspectiveToken Function(FlyPerspectiveToken current) updater) {
    _getNotifier(context)?.updatePerspective(updater);
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

  /// Put a breakpoint value
  static void putBreakpoint(BuildContext context, String key, double value) {
    _getNotifier(context)?.putBreakpoint(key, value);
  }

  /// Put a container value
  static void putContainer(BuildContext context, String key, double value) {
    _getNotifier(context)?.putContainer(key, value);
  }

  /// Put a text value
  static void putText(BuildContext context, String key, double value) {
    _getNotifier(context)?.putText(key, value);
  }

  /// Put a text line height value
  static void putTextLineHeight(BuildContext context, String key, double value) {
    _getNotifier(context)?.putTextLineHeight(key, value);
  }

  /// Put a font weight value
  static void putFontWeight(BuildContext context, String key, FontWeight value) {
    _getNotifier(context)?.putFontWeight(key, value);
  }

  /// Put a tracking value
  static void putTracking(BuildContext context, String key, double value) {
    _getNotifier(context)?.putTracking(key, value);
  }

  /// Put a blur value
  static void putBlur(BuildContext context, String key, double value) {
    _getNotifier(context)?.putBlur(key, value);
  }

  /// Put a perspective value
  static void putPerspective(BuildContext context, String key, double value) {
    _getNotifier(context)?.putPerspective(key, value);
  }

  /// Put a leading value
  static void putLeading(BuildContext context, String key, double value) {
    _getNotifier(context)?.putLeading(key, value);
  }

  /// Check if FlyTheme is available in the context
  static bool hasFlyTheme(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FlyTheme>() != null;
  }

  /// Helper method to get the data from context
  static FlyData? _getNotifier(BuildContext context) {
    final data = context.dependOnInheritedWidgetOfExactType<FlyTheme>();
    return data?.notifier;
  }
}

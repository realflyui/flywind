import 'package:flutter/material.dart';
import 'controller.dart';
import 'theme.dart';
import '../tokens/tokens.dart';

/// InheritedNotifier widget that provides Fly theme data to the widget tree
class FlyTheme extends InheritedNotifier<FlyThemeController> {
  const FlyTheme({
    super.key,
    required FlyThemeController controller,
    required super.child,
  }) : super(notifier: controller);

  /// Get the current Fly theme data from the context
  static FlyThemeData of(BuildContext context) {
    final inherited = context.dependOnInheritedWidgetOfExactType<FlyTheme>();
    if (inherited != null && inherited.notifier != null) {
      return inherited.notifier!.data;
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

  /// Get the controller for direct access to all theme methods
  /// 
  /// This provides access to all controller methods while maintaining
  /// the convenience of context-based access.
  /// 
  /// Example:
  /// ```dart
  /// FlyTheme.controller(context)?.putSpacing('large', 32.0);
  /// FlyTheme.controller(context)?.updateColors((colors) => colors.put('primary', Colors.blue));
  /// ```
  static FlyThemeController? controller(BuildContext context) {
    return _getController(context);
  }

  /// Update the theme using a function
  static void update(BuildContext context, FlyThemeData Function(FlyThemeData current) updater) {
    _getController(context)?.update(updater);
  }

  /// Update spacing token
  static void updateSpacing(BuildContext context, FlySpacingToken Function(FlySpacingToken current) updater) {
    _getController(context)?.updateSpacing(updater);
  }

  /// Update colors token
  static void updateColors(BuildContext context, FlyColorToken Function(FlyColorToken current) updater) {
    _getController(context)?.updateColors(updater);
  }

  /// Update radius token
  static void updateRadius(BuildContext context, FlyRadiusToken Function(FlyRadiusToken current) updater) {
    _getController(context)?.updateRadius(updater);
  }

  /// Update breakpoints token
  static void updateBreakpoints(BuildContext context, FlyBreakpointToken Function(FlyBreakpointToken current) updater) {
    _getController(context)?.updateBreakpoints(updater);
  }

  /// Put a spacing value
  static void putSpacing(BuildContext context, String key, num value) {
    _getController(context)?.putSpacing(key, value);
  }

  /// Put a color value
  static void putColor(BuildContext context, String key, Color value) {
    _getController(context)?.putColor(key, value);
  }

  /// Put a radius value
  static void putRadius(BuildContext context, String key, double value) {
    _getController(context)?.putRadius(key, value);
  }

  /// Put a breakpoint value
  static void putBreakpoint(BuildContext context, String key, double value) {
    _getController(context)?.putBreakpoint(key, value);
  }

  /// Check if FlyTheme is available in the context
  static bool hasFlyTheme(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FlyTheme>() != null;
  }

  /// Helper method to get the controller from context
  static FlyThemeController? _getController(BuildContext context) {
    final inherited = context.dependOnInheritedWidgetOfExactType<FlyTheme>();
    return inherited?.notifier;
  }
}

/// Extension to make FlyTheme work with Material ThemeData
extension FlyThemeDataExtension on ThemeData {
  /// Get Fly theme data from Material theme extensions
  FlyThemeData? get flyTheme => extension<FlyThemeData>();
}


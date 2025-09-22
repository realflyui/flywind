import 'package:flutter/material.dart';
import 'theme.dart';
import '../tokens/tokens.dart';

/// Controller for managing Fly theme data with runtime updates
class FlyThemeController extends ChangeNotifier {
  FlyThemeController({FlyThemeData? initialData}) 
      : _data = initialData ?? FlyThemeData.fallback();

  FlyThemeData _data;

  /// Current theme data
  FlyThemeData get data => _data;

  /// Set new theme data
  void set(FlyThemeData newData) {
    if (_data != newData) {
      _data = newData;
      notifyListeners();
    }
  }

  /// Merge new theme data with current data
  void merge(FlyThemeData other) {
    final merged = _data.merge(other);
    if (_data != merged) {
      _data = merged;
      notifyListeners();
    }
  }

  /// Update theme data using a function
  void update(FlyThemeData Function(FlyThemeData current) updater) {
    final updated = updater(_data);
    if (_data != updated) {
      _data = updated;
      notifyListeners();
    }
  }

  /// Update spacing token
  void updateSpacing(FlySpacingToken Function(FlySpacingToken current) updater) {
    update((data) => data.copyWith(spacing: updater(data.spacing)));
  }

  /// Update colors token
  void updateColors(FlyColorToken Function(FlyColorToken current) updater) {
    update((data) => data.copyWith(colors: updater(data.colors)));
  }

  /// Update radius token
  void updateRadius(FlyRadiusToken Function(FlyRadiusToken current) updater) {
    update((data) => data.copyWith(radius: updater(data.radius)));
  }

  /// Update breakpoints token
  void updateBreakpoints(FlyBreakpointToken Function(FlyBreakpointToken current) updater) {
    update((data) => data.copyWith(breakpoints: updater(data.breakpoints)));
  }

  /// Put a spacing value
  void putSpacing(String key, num value) {
    if (key.isEmpty) {
      throw ArgumentError('Spacing key cannot be empty');
    }
    if (value < 0) {
      throw ArgumentError('Spacing value cannot be negative: $value');
    }
    updateSpacing((spacing) => spacing.put(key, value.toDouble()));
  }

  /// Put a color value
  void putColor(String key, Color value) {
    if (key.isEmpty) {
      throw ArgumentError('Color key cannot be empty');
    }
    updateColors((colors) => colors.put(key, value));
  }

  /// Put a radius value
  void putRadius(String key, double value) {
    if (key.isEmpty) {
      throw ArgumentError('Radius key cannot be empty');
    }
    if (value < 0) {
      throw ArgumentError('Radius value cannot be negative: $value');
    }
    updateRadius((radius) => radius.put(key, value));
  }

  /// Put a breakpoint value
  void putBreakpoint(String key, double value) {
    if (key.isEmpty) {
      throw ArgumentError('Breakpoint key cannot be empty');
    }
    if (value < 0) {
      throw ArgumentError('Breakpoint value cannot be negative: $value');
    }
    updateBreakpoints((breakpoints) => breakpoints.put(key, value));
  }

}

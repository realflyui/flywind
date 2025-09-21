import 'package:flutter/material.dart';
import 'theme.dart';
import '../tokens/spacing_base.dart';
import '../tokens/colors_base.dart';

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
  void updateSpacing(FlySpacingBase Function(FlySpacingBase current) updater) {
    update((data) => data.copyWith(spacing: updater(data.spacing)));
  }

  /// Update colors token
  void updateColors(FlyColorsBase Function(FlyColorsBase current) updater) {
    update((data) => data.copyWith(colors: updater(data.colors)));
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

}

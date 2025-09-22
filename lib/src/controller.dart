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

  /// Update container token
  void updateContainer(FlyContainerToken Function(FlyContainerToken current) updater) {
    update((data) => data.copyWith(container: updater(data.container)));
  }

  /// Update text token
  void updateText(FlyTextToken Function(FlyTextToken current) updater) {
    update((data) => data.copyWith(text: updater(data.text)));
  }

  /// Update text line height token
  void updateTextLineHeight(FlyTextLineHeightToken Function(FlyTextLineHeightToken current) updater) {
    update((data) => data.copyWith(textLineHeight: updater(data.textLineHeight)));
  }

  /// Update font weight token
  void updateFontWeight(FlyFontWeightToken Function(FlyFontWeightToken current) updater) {
    update((data) => data.copyWith(fontWeight: updater(data.fontWeight)));
  }

  /// Update tracking token
  void updateTracking(FlyTrackingToken Function(FlyTrackingToken current) updater) {
    update((data) => data.copyWith(tracking: updater(data.tracking)));
  }

  /// Update blur token
  void updateBlur(FlyBlurToken Function(FlyBlurToken current) updater) {
    update((data) => data.copyWith(blur: updater(data.blur)));
  }

  /// Update perspective token
  void updatePerspective(FlyPerspectiveToken Function(FlyPerspectiveToken current) updater) {
    update((data) => data.copyWith(perspective: updater(data.perspective)));
  }

  /// Update leading token
  void updateLeading(FlyLeadingToken Function(FlyLeadingToken current) updater) {
    update((data) => data.copyWith(leading: updater(data.leading)));
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

  /// Put a container value
  void putContainer(String key, double value) {
    if (key.isEmpty) {
      throw ArgumentError('Container key cannot be empty');
    }
    if (value < 0) {
      throw ArgumentError('Container value cannot be negative: $value');
    }
    updateContainer((container) => container.put(key, value));
  }

  /// Put a text value
  void putText(String key, double value) {
    if (key.isEmpty) {
      throw ArgumentError('Text key cannot be empty');
    }
    if (value < 0) {
      throw ArgumentError('Text value cannot be negative: $value');
    }
    updateText((text) => text.put(key, value));
  }

  /// Put a text line height value
  void putTextLineHeight(String key, double value) {
    if (key.isEmpty) {
      throw ArgumentError('Text line height key cannot be empty');
    }
    if (value < 0) {
      throw ArgumentError('Text line height value cannot be negative: $value');
    }
    updateTextLineHeight((textLineHeight) => textLineHeight.put(key, value));
  }

  /// Put a font weight value
  void putFontWeight(String key, FontWeight value) {
    if (key.isEmpty) {
      throw ArgumentError('Font weight key cannot be empty');
    }
    updateFontWeight((fontWeight) => fontWeight.put(key, value));
  }

  /// Put a tracking value
  void putTracking(String key, double value) {
    if (key.isEmpty) {
      throw ArgumentError('Tracking key cannot be empty');
    }
    updateTracking((tracking) => tracking.put(key, value));
  }

  /// Put a blur value
  void putBlur(String key, double value) {
    if (key.isEmpty) {
      throw ArgumentError('Blur key cannot be empty');
    }
    if (value < 0) {
      throw ArgumentError('Blur value cannot be negative: $value');
    }
    updateBlur((blur) => blur.put(key, value));
  }

  /// Put a perspective value
  void putPerspective(String key, double value) {
    if (key.isEmpty) {
      throw ArgumentError('Perspective key cannot be empty');
    }
    if (value < 0) {
      throw ArgumentError('Perspective value cannot be negative: $value');
    }
    updatePerspective((perspective) => perspective.put(key, value));
  }

  /// Put a leading value
  void putLeading(String key, double value) {
    if (key.isEmpty) {
      throw ArgumentError('Leading key cannot be empty');
    }
    if (value < 0) {
      throw ArgumentError('Leading value cannot be negative: $value');
    }
    updateLeading((leading) => leading.put(key, value));
  }

}

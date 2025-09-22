import 'package:flutter/material.dart';
import '../tokens/tokens.dart';

/// Controller for managing Fly theme data with runtime updates
class FlyData extends ChangeNotifier {
  FlyData({FlyThemeData? initialData}) 
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

/// Main theme data container that holds all tokens
class FlyThemeData extends ThemeExtension<FlyThemeData> {
  const FlyThemeData({
    required this.spacing,
    required this.colors,
    required this.radius,
    required this.breakpoints,
    required this.container,
    required this.text,
    required this.textLineHeight,
    required this.fontWeight,
    required this.tracking,
    required this.blur,
    required this.perspective,
    required this.leading,
  });

  /// Factory constructor with optional parameters and defaults
  factory FlyThemeData.withDefaults({
    FlySpacingToken? spacing,
    FlyColorToken? colors,
    FlyRadiusToken? radius,
    FlyBreakpointToken? breakpoints,
    FlyContainerToken? container,
    FlyTextToken? text,
    FlyTextLineHeightToken? textLineHeight,
    FlyFontWeightToken? fontWeight,
    FlyTrackingToken? tracking,
    FlyBlurToken? blur,
    FlyPerspectiveToken? perspective,
    FlyLeadingToken? leading,
  }) {
    return FlyThemeData(
      spacing: spacing ?? FlySpacingToken.defaultSpacing(),
      colors: colors ?? FlyColorToken.defaultColor(),
      radius: radius ?? FlyRadiusToken.defaultRadius(),
      breakpoints: breakpoints ?? FlyBreakpointToken.defaultBreakpoint(),
      container: container ?? FlyContainerToken.defaultContainer(),
      text: text ?? FlyTextToken.defaultText(),
      textLineHeight: textLineHeight ?? FlyTextLineHeightToken.defaultTextLineHeight(),
      fontWeight: fontWeight ?? FlyFontWeightToken.defaultFontWeight(),
      tracking: tracking ?? FlyTrackingToken.defaultTracking(),
      blur: blur ?? FlyBlurToken.defaultBlur(),
      perspective: perspective ?? FlyPerspectiveToken.defaultPerspective(),
      leading: leading ?? FlyLeadingToken.defaultLeading(),
    );
  }

  final FlySpacingToken spacing;
  final FlyColorToken colors;
  final FlyRadiusToken radius;
  final FlyBreakpointToken breakpoints;
  final FlyContainerToken container;
  final FlyTextToken text;
  final FlyTextLineHeightToken textLineHeight;
  final FlyFontWeightToken fontWeight;
  final FlyTrackingToken tracking;
  final FlyBlurToken blur;
  final FlyPerspectiveToken perspective;
  final FlyLeadingToken leading;

  /// Create a copy with updated values
  @override
  FlyThemeData copyWith({
    FlySpacingToken? spacing,
    FlyColorToken? colors,
    FlyRadiusToken? radius,
    FlyBreakpointToken? breakpoints,
    FlyContainerToken? container,
    FlyTextToken? text,
    FlyTextLineHeightToken? textLineHeight,
    FlyFontWeightToken? fontWeight,
    FlyTrackingToken? tracking,
    FlyBlurToken? blur,
    FlyPerspectiveToken? perspective,
    FlyLeadingToken? leading,
  }) {
    return FlyThemeData(
      spacing: spacing ?? this.spacing,
      colors: colors ?? this.colors,
      radius: radius ?? this.radius,
      breakpoints: breakpoints ?? this.breakpoints,
      container: container ?? this.container,
      text: text ?? this.text,
      textLineHeight: textLineHeight ?? this.textLineHeight,
      fontWeight: fontWeight ?? this.fontWeight,
      tracking: tracking ?? this.tracking,
      blur: blur ?? this.blur,
      perspective: perspective ?? this.perspective,
      leading: leading ?? this.leading,
    );
  }

  /// Merge another theme data into this one
  FlyThemeData merge(FlyThemeData? other) {
    if (other == null) return this;
    
    return FlyThemeData(
      spacing: spacing.merge(other.spacing),
      colors: colors.merge(other.colors),
      radius: radius.merge(other.radius),
      breakpoints: breakpoints.merge(other.breakpoints),
      container: container.merge(other.container),
      text: text.merge(other.text),
      textLineHeight: textLineHeight.merge(other.textLineHeight),
      fontWeight: fontWeight.merge(other.fontWeight),
      tracking: tracking.merge(other.tracking),
      blur: blur.merge(other.blur),
      perspective: perspective.merge(other.perspective),
      leading: leading.merge(other.leading),
    );
  }

  /// Create default theme data
  static FlyThemeData fallback() {
    return FlyThemeData(
      spacing: FlySpacingToken.defaultSpacing(),
      colors: FlyColorToken.defaultColor(),
      radius: FlyRadiusToken.defaultRadius(),
      breakpoints: FlyBreakpointToken.defaultBreakpoint(),
      container: FlyContainerToken.defaultContainer(),
      text: FlyTextToken.defaultText(),
      textLineHeight: FlyTextLineHeightToken.defaultTextLineHeight(),
      fontWeight: FlyFontWeightToken.defaultFontWeight(),
      tracking: FlyTrackingToken.defaultTracking(),
      blur: FlyBlurToken.defaultBlur(),
      perspective: FlyPerspectiveToken.defaultPerspective(),
      leading: FlyLeadingToken.defaultLeading(),
    );
  }

  /// Linear interpolation between two theme data instances
  @override
  FlyThemeData lerp(ThemeExtension<FlyThemeData>? other, double t) {
    if (other is! FlyThemeData) return this;
    
    return FlyThemeData(
      spacing: spacing.lerp(other.spacing, t),
      colors: colors.lerp(other.colors, t),
      radius: radius.lerp(other.radius, t),
      breakpoints: breakpoints.lerp(other.breakpoints, t),
      container: container.lerp(other.container, t),
      text: text.lerp(other.text, t),
      textLineHeight: textLineHeight.lerp(other.textLineHeight, t),
      fontWeight: fontWeight.lerp(other.fontWeight, t),
      tracking: tracking.lerp(other.tracking, t),
      blur: blur.lerp(other.blur, t),
      perspective: perspective.lerp(other.perspective, t),
      leading: leading.lerp(other.leading, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FlyThemeData &&
        other.spacing == spacing &&
        other.colors == colors &&
        other.radius == radius &&
        other.breakpoints == breakpoints &&
        other.container == container &&
        other.text == text &&
        other.textLineHeight == textLineHeight &&
        other.fontWeight == fontWeight &&
        other.tracking == tracking &&
        other.blur == blur &&
        other.perspective == perspective &&
        other.leading == leading;
  }

  @override
  int get hashCode => Object.hash(
    spacing, colors, radius, breakpoints, container, text, 
    textLineHeight, fontWeight, tracking, blur, perspective, leading
  );
}

/// Extension to make FlyTheme work with Material ThemeData
extension FlyThemeDataExtension on ThemeData {
  /// Get Fly theme data from Material theme extensions
  FlyThemeData? get flyTheme => extension<FlyThemeData>();
}



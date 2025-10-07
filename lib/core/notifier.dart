import 'package:flutter/material.dart';
import '../tokens/tokens.dart';

/// Controller for managing Fly theme data with runtime updates
class FlyNotifier extends ChangeNotifier {
  FlyNotifier({FlyThemeData? initialData})
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
  void updateSpacing(
    FlySpacingToken Function(FlySpacingToken current) updater,
  ) {
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

  /// Update text style token
  void updateTextStyle(
    FlyTextStyleToken Function(FlyTextStyleToken current) updater,
  ) {
    update((data) => data.copyWith(textStyle: updater(data.textStyle)));
  }

  /// Update font token
  void updateFont(FlyFontToken Function(FlyFontToken current) updater) {
    update((data) => data.copyWith(font: updater(data.font)));
  }

  /// Update font weight token
  void updateFontWeight(
    FlyFontWeightToken Function(FlyFontWeightToken current) updater,
  ) {
    update((data) => data.copyWith(fontWeight: updater(data.fontWeight)));
  }

  /// Update leading token
  void updateLeading(
    FlyLeadingToken Function(FlyLeadingToken current) updater,
  ) {
    update((data) => data.copyWith(leading: updater(data.leading)));
  }

  /// Update tracking token
  void updateTracking(
    FlyTrackingToken Function(FlyTrackingToken current) updater,
  ) {
    update((data) => data.copyWith(tracking: updater(data.tracking)));
  }

  /// Update breakpoint token
  void updateBreakpoint(
    FlyBreakpointToken Function(FlyBreakpointToken current) updater,
  ) {
    update((data) => data.copyWith(breakpoint: updater(data.breakpoint)));
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

  /// Put a text style value
  void putTextStyle(String key, TextStyle value) {
    if (key.isEmpty) {
      throw ArgumentError('Text style key cannot be empty');
    }
    updateTextStyle((textStyle) => textStyle.put(key, value));
  }

  /// Put a font value
  void putFont(String key, List<String> value) {
    if (key.isEmpty) {
      throw ArgumentError('Font key cannot be empty');
    }
    updateFont((font) => font.put(key, value));
  }

  /// Put a font weight value
  void putFontWeight(String key, FontWeight value) {
    if (key.isEmpty) {
      throw ArgumentError('Font weight key cannot be empty');
    }
    updateFontWeight((fontWeight) => fontWeight.put(key, value));
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

  /// Put a tracking value
  void putTracking(String key, double value) {
    if (key.isEmpty) {
      throw ArgumentError('Tracking key cannot be empty');
    }
    updateTracking((tracking) => tracking.put(key, value));
  }

  /// Put a breakpoint value
  void putBreakpoint(String key, double value) {
    if (key.isEmpty) {
      throw ArgumentError('Breakpoint key cannot be empty');
    }
    if (value < 0) {
      throw ArgumentError('Breakpoint value cannot be negative: $value');
    }
    updateBreakpoint((breakpoint) => breakpoint.put(key, value));
  }
}

/// Main theme data container that holds all tokens
class FlyThemeData extends ThemeExtension<FlyThemeData> {
  const FlyThemeData({
    required this.spacing,
    required this.colors,
    required this.radius,
    required this.textStyle,
    required this.font,
    required this.fontWeight,
    required this.leading,
    required this.tracking,
    required this.breakpoint,
  });

  /// Factory constructor with optional parameters and defaults
  factory FlyThemeData.withDefaults({
    FlySpacingToken? spacing,
    FlyColorToken? colors,
    FlyRadiusToken? radius,
    FlyTextStyleToken? textStyle,
    FlyFontToken? font,
    FlyFontWeightToken? fontWeight,
    FlyLeadingToken? leading,
    FlyTrackingToken? tracking,
    FlyBreakpointToken? breakpoint,
  }) {
    return FlyThemeData(
      spacing: spacing ?? FlySpacingToken.defaultSpacing(),
      colors: colors ?? FlyColorToken.defaultColor(),
      radius: radius ?? FlyRadiusToken.defaultRadius(),
      textStyle: textStyle ?? FlyTextStyleToken.defaultTextStyle(),
      font: font ?? FlyFontToken.defaultFont(),
      fontWeight: fontWeight ?? FlyFontWeightToken.defaultFontWeight(),
      leading: leading ?? FlyLeadingToken.defaultLeading(),
      tracking: tracking ?? FlyTrackingToken.defaultTracking(),
      breakpoint: breakpoint ?? FlyBreakpointToken.defaultBreakpoint(),
    );
  }

  final FlySpacingToken spacing;
  final FlyColorToken colors;
  final FlyRadiusToken radius;
  final FlyTextStyleToken textStyle;
  final FlyFontToken font;
  final FlyFontWeightToken fontWeight;
  final FlyLeadingToken leading;
  final FlyTrackingToken tracking;
  final FlyBreakpointToken breakpoint;

  /// Create a copy with updated values
  @override
  FlyThemeData copyWith({
    FlySpacingToken? spacing,
    FlyColorToken? colors,
    FlyRadiusToken? radius,
    FlyTextStyleToken? textStyle,
    FlyFontToken? font,
    FlyFontWeightToken? fontWeight,
    FlyLeadingToken? leading,
    FlyTrackingToken? tracking,
    FlyBreakpointToken? breakpoint,
  }) {
    return FlyThemeData(
      spacing: spacing ?? this.spacing,
      colors: colors ?? this.colors,
      radius: radius ?? this.radius,
      textStyle: textStyle ?? this.textStyle,
      font: font ?? this.font,
      fontWeight: fontWeight ?? this.fontWeight,
      leading: leading ?? this.leading,
      tracking: tracking ?? this.tracking,
      breakpoint: breakpoint ?? this.breakpoint,
    );
  }

  /// Merge another theme data into this one
  FlyThemeData merge(FlyThemeData? other) {
    if (other == null) return this;

    return FlyThemeData(
      spacing: spacing.merge(other.spacing),
      colors: colors.merge(other.colors),
      radius: radius.merge(other.radius),
      textStyle: textStyle.merge(other.textStyle),
      font: font.merge(other.font),
      fontWeight: fontWeight.merge(other.fontWeight),
      leading: leading.merge(other.leading),
      tracking: tracking.merge(other.tracking),
      breakpoint: breakpoint.merge(other.breakpoint),
    );
  }

  /// Create default theme data
  static FlyThemeData fallback() {
    return FlyThemeData(
      spacing: FlySpacingToken.defaultSpacing(),
      colors: FlyColorToken.defaultColor(),
      radius: FlyRadiusToken.defaultRadius(),
      textStyle: FlyTextStyleToken.defaultTextStyle(),
      font: FlyFontToken.defaultFont(),
      fontWeight: FlyFontWeightToken.defaultFontWeight(),
      leading: FlyLeadingToken.defaultLeading(),
      tracking: FlyTrackingToken.defaultTracking(),
      breakpoint: FlyBreakpointToken.defaultBreakpoint(),
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
      textStyle: textStyle.lerp(other.textStyle, t),
      font: t < 0.5 ? font : other.font,
      fontWeight: fontWeight.lerp(other.fontWeight, t),
      leading: leading.lerp(other.leading, t),
      tracking: tracking.lerp(other.tracking, t),
      breakpoint: breakpoint.lerp(other.breakpoint, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FlyThemeData &&
        other.spacing == spacing &&
        other.colors == colors &&
        other.radius == radius &&
        other.textStyle == textStyle &&
        other.font == font &&
        other.fontWeight == fontWeight &&
        other.leading == leading &&
        other.tracking == tracking &&
        other.breakpoint == breakpoint;
  }

  @override
  int get hashCode => Object.hash(
    spacing,
    colors,
    radius,
    textStyle,
    font,
    fontWeight,
    leading,
    tracking,
    breakpoint,
  );
}

/// Extension to make FlyTheme work with Material ThemeData
extension FlyThemeDataExtension on ThemeData {
  /// Get Fly theme data from Material theme extensions
  FlyThemeData? get flyTheme => extension<FlyThemeData>();
}

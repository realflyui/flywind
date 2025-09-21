/// Border radius scale class with type-safe access to radius values
class FlyBorderRadius {
  const FlyBorderRadius({
    required this.none,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xl2,
    required this.xl3,
    required this.full,
    required this.defaultRadius,
    this.customBorderRadius = const {},
  });

  final String none, sm, md, lg, xl, xl2, xl3, full, defaultRadius;
  final Map<String, String> customBorderRadius;

  /// Get all border radius values as a map
  Map<String, String> get values => {
    'none': none,
    'sm': sm,
    'md': md,
    'lg': lg,
    'xl': xl,
    '2xl': xl2,
    '3xl': xl3,
    'full': full,
    '': defaultRadius,
    ...customBorderRadius,
  };

  /// Access border radius values by key
  String? operator [](String key) => values[key];

  /// Get the actual double value for a given key
  double? getValue(String key) {
    final stringValue = values[key];
    if (stringValue == null) return null;
    return double.tryParse(stringValue);
  }

  /// Create a copy with updated values
  FlyBorderRadius copyWith({
    String? none,
    String? sm,
    String? md,
    String? lg,
    String? xl,
    String? xl2,
    String? xl3,
    String? full,
    String? defaultRadius,
    Map<String, String>? customBorderRadius,
  }) {
    return FlyBorderRadius(
      none: none ?? this.none,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xl2: xl2 ?? this.xl2,
      xl3: xl3 ?? this.xl3,
      full: full ?? this.full,
      defaultRadius: defaultRadius ?? this.defaultRadius,
      customBorderRadius: customBorderRadius ?? this.customBorderRadius,
    );
  }

  /// Default border radius scale matching Tailwind CSS
  static const FlyBorderRadius defaultBorderRadius = FlyBorderRadius(
    none: '0',
    sm: '2',
    md: '6',
    lg: '8',
    xl: '12',
    xl2: '16',
    xl3: '24',
    full: '9999',
    defaultRadius: '4',
  );
}

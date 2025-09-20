import 'package:flutter/material.dart';

/// Spacing scale class with type-safe access to spacing values
class TwSpacing {
  const TwSpacing({
    required this.s0,
    required this.s1,
    required this.s2,
    required this.s3,
    required this.s4,
    required this.s5,
    required this.s6,
    required this.s7,
    required this.s8,
    required this.s9,
    required this.s10,
    required this.s11,
    required this.s12,
  });

  final double s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12;

  /// Get all spacing values as a map
  Map<int, double> get values => {
    0: s0, 1: s1, 2: s2, 3: s3, 4: s4, 5: s5,
    6: s6, 7: s7, 8: s8, 9: s9, 10: s10, 11: s11, 12: s12,
  };
  
  /// Access spacing values by index (0-12)
  double? operator [](int index) => values[index];

  /// Default spacing scale (0-12 steps)
  static const TwSpacing defaultSpacing = TwSpacing(
    s0: 0.0,
    s1: 4.0,
    s2: 8.0,
    s3: 12.0,
    s4: 16.0,
    s5: 20.0,
    s6: 24.0,
    s7: 28.0,
    s8: 32.0,
    s9: 36.0,
    s10: 40.0,
    s11: 44.0,
    s12: 48.0,
  );
}

/// Color palette class with type-safe access to color values
class TwColors {
  const TwColors({
    // Grays
    required this.gray800,
    required this.gray700,
    required this.gray600,
    required this.gray500,
    required this.gray400,
    required this.gray300,
    required this.gray200,
    required this.gray100,
    required this.gray50,
    
    // Blues
    required this.blue600,
    required this.blue500,
    required this.blue400,
    
    // Reds
    required this.red600,
    required this.red500,
    
    // Greens
    required this.green600,
    required this.green500,
    
    // Yellows
    required this.yellow600,
    required this.yellow500,
    
    // Purples
    required this.purple600,
    required this.purple500,
    
    // Teals
    required this.teal600,
    required this.teal500,
    
    // Oranges
    required this.orange600,
    required this.orange500,
    
    // Basic colors
    required this.white,
    required this.black,
  });

  // Grays
  final Color gray800, gray700, gray600, gray500, gray400, gray300, gray200, gray100, gray50;
  
  // Blues
  final Color blue600, blue500, blue400;
  
  // Reds
  final Color red600, red500;
  
  // Greens
  final Color green600, green500;
  
  // Yellows
  final Color yellow600, yellow500;
  
  // Purples
  final Color purple600, purple500;
  
  // Teals
  final Color teal600, teal500;
  
  // Oranges
  final Color orange600, orange500;
  
  // Basic colors
  final Color white, black;

  /// Get all color values as a map
  Map<String, Color> get values => {
    // Grays
    'gray800': gray800, 'gray700': gray700, 'gray600': gray600, 'gray500': gray500, 'gray400': gray400,
    'gray300': gray300, 'gray200': gray200, 'gray100': gray100, 'gray50': gray50,
    
    // Blues
    'blue600': blue600, 'blue500': blue500, 'blue400': blue400,
    
    // Reds
    'red600': red600, 'red500': red500,
    
    // Greens
    'green600': green600, 'green500': green500,
    
    // Yellows
    'yellow600': yellow600, 'yellow500': yellow500,
    
    // Purples
    'purple600': purple600, 'purple500': purple500,
    
    // Teals
    'teal600': teal600, 'teal500': teal500,
    
    // Oranges
    'orange600': orange600, 'orange500': orange500,
    
    // Basic colors
    'white': white, 'black': black,
  };
  
  /// Access color values by key
  Color? operator [](String key) => values[key];

  /// Default color palette
  static const TwColors defaultColors = TwColors(
    // Grays
    gray800: Color(0xFF1F2937),
    gray700: Color(0xFF374151),
    gray600: Color(0xFF4B5563),
    gray500: Color(0xFF6B7280),
    gray400: Color(0xFF9CA3AF),
    gray300: Color(0xFFD1D5DB),
    gray200: Color(0xFFE5E7EB),
    gray100: Color(0xFFF3F4F6),
    gray50: Color(0xFFF9FAFB),
    
    // Blues
    blue600: Color(0xFF2563EB),
    blue500: Color(0xFF3B82F6),
    blue400: Color(0xFF60A5FA),
    
    // Reds
    red600: Color(0xFFDC2626),
    red500: Color(0xFFEF4444),
    
    // Greens
    green600: Color(0xFF16A34A),
    green500: Color(0xFF22C55E),
    
    // Yellows
    yellow600: Color(0xFFCA8A04),
    yellow500: Color(0xFFEAB308),
    
    // Purples
    purple600: Color(0xFF9333EA),
    purple500: Color(0xFFA855F7),
    
    // Teals
    teal600: Color(0xFF0D9488),
    teal500: Color(0xFF14B8A6),
    
    // Oranges
    orange600: Color(0xFFEA580C),
    orange500: Color(0xFFF97316),
    
    // Basic colors
    white: Color(0xFFFFFFFF),
    black: Color(0xFF000000),
  );
}

/// Border radius scale class with type-safe access to radius values
class TwBorderRadius {
  const TwBorderRadius({
    required this.none,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xl2,
    required this.xl3,
    required this.full,
    required this.defaultRadius, // For the empty string key
  });

  final double none, sm, md, lg, xl, xl2, xl3, full, defaultRadius;

  /// Get all border radius values as a map
  Map<String, double> get values => {
    'none': none,
    'sm': sm,
    'md': md,
    'lg': lg,
    'xl': xl,
    '2xl': xl2,
    '3xl': xl3,
    'full': full,
    '': defaultRadius, // Empty string is default
  };
  
  /// Access border radius values by key
  double? operator [](String key) => values[key];

  /// Default border radius scale matching Tailwind CSS
  static const TwBorderRadius defaultBorderRadius = TwBorderRadius(
    none: 0.0,
    sm: 2.0,      // 0.125rem
    md: 6.0,      // 0.375rem
    lg: 8.0,      // 0.5rem
    xl: 12.0,     // 0.75rem
    xl2: 16.0,    // 1rem
    xl3: 24.0,    // 1.5rem
    full: 9999.0, // 9999px
    defaultRadius: 4.0, // 0.25rem (default)
  );
}

/// Inherited widget that provides Tailwind-like design tokens
class TwConfig extends InheritedWidget {
  const TwConfig({
    super.key,
    required this.spacing,
    required this.colors,
    required this.borderRadius,
    required super.child,
  });

  final TwSpacing spacing;
  final TwColors colors;
  final TwBorderRadius borderRadius;

  /// Get the current TwConfig from the widget tree
  static TwConfig of(BuildContext context) {
    final TwConfig? result = context.dependOnInheritedWidgetOfExactType<TwConfig>();
    assert(result != null, 'No TwConfig found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TwConfig oldWidget) {
    return spacing != oldWidget.spacing || colors != oldWidget.colors || borderRadius != oldWidget.borderRadius;
  }
}

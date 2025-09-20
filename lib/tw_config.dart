import 'package:flutter/material.dart';

/// Inherited widget that provides Tailwind-like design tokens
class TwConfig extends InheritedWidget {
  const TwConfig({
    super.key,
    required this.spacing,
    required this.colors,
    required this.borderRadius,
    required super.child,
  });

  final Map<int, double> spacing;
  final Map<String, Color> colors;
  final Map<String, double> borderRadius;

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

/// Default spacing scale (0-12 steps)
const Map<int, double> defaultSpacing = {
  0: 0.0,
  1: 4.0,
  2: 8.0,
  3: 12.0,
  4: 16.0,
  5: 20.0,
  6: 24.0,
  7: 28.0,
  8: 32.0,
  9: 36.0,
  10: 40.0,
  11: 44.0,
  12: 48.0,
};

/// Default border radius scale matching Tailwind CSS
const Map<String, double> defaultBorderRadius = {
  'none': 0.0,
  'sm': 2.0,      // 0.125rem
  '': 4.0,        // 0.25rem (default)
  'md': 6.0,      // 0.375rem
  'lg': 8.0,      // 0.5rem
  'xl': 12.0,     // 0.75rem
  '2xl': 16.0,    // 1rem
  '3xl': 24.0,    // 1.5rem
  'full': 9999.0, // 9999px
};

/// Default color palette
const Map<String, Color> defaultColors = {
  // Grays
  'gray800': Color(0xFF1F2937),
  'gray700': Color(0xFF374151),
  'gray600': Color(0xFF4B5563),
  'gray500': Color(0xFF6B7280),
  'gray400': Color(0xFF9CA3AF),
  'gray300': Color(0xFFD1D5DB),
  'gray200': Color(0xFFE5E7EB),
  'gray100': Color(0xFFF3F4F6),
  'gray50': Color(0xFFF9FAFB),
  
  // Blues
  'blue600': Color(0xFF2563EB),
  'blue500': Color(0xFF3B82F6),
  'blue400': Color(0xFF60A5FA),
  
  // Reds
  'red600': Color(0xFFDC2626),
  'red500': Color(0xFFEF4444),
  
  // Greens
  'green600': Color(0xFF16A34A),
  'green500': Color(0xFF22C55E),
  
  // Yellows
  'yellow600': Color(0xFFCA8A04),
  'yellow500': Color(0xFFEAB308),
  
  // Purples
  'purple600': Color(0xFF9333EA),
  'purple500': Color(0xFFA855F7),
  
  // Teals
  'teal600': Color(0xFF0D9488),
  'teal500': Color(0xFF14B8A6),
  
  // Oranges
  'orange600': Color(0xFFEA580C),
  'orange500': Color(0xFFF97316),
  
  // Basic colors
  'white': Color(0xFFFFFFFF),
  'black': Color(0xFF000000),
};

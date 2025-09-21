// GENERATED FILE - DO NOT EDIT
// This file demonstrates how custom color tokens would be generated

import 'package:flutter/material.dart';
import '../tokens/colors_base.dart';

/// Brand A colors token class generated from design system
/// 
/// This class extends FlyColorsBase and overrides default values
/// while adding new custom color values as typed fields.
class BrandAColors extends FlyColorsBase {
  const BrandAColors({
    super.primary = const Color(0xFF6366F1),    // Indigo-500
    super.secondary = const Color(0xFFEC4899),  // Pink-500
    super.surface = const Color(0xFFFFFFFF),    // White
    super.background = const Color(0xFFF8FAFC), // Slate-50
    super.extras = const {
      'accent': Color(0xFF10B981),      // Emerald-500
      'warning': Color(0xFFF59E0B),     // Amber-500
      'error': Color(0xFFEF4444),       // Red-500
      'success': Color(0xFF10B981),     // Emerald-500
      'info': Color(0xFF3B82F6),        // Blue-500
      'neutral': Color(0xFF6B7280),     // Gray-500
      'text': Color(0xFF1F2937),        // Gray-800
      'textSecondary': Color(0xFF6B7280), // Gray-500
      'border': Color(0xFFE5E7EB),      // Gray-200
      'divider': Color(0xFFF3F4F6),     // Gray-100
    },
  });

  /// Accent color (Emerald-500)
  Color get accent => extras['accent'] as Color;
  
  /// Warning color (Amber-500)
  Color get warning => extras['warning'] as Color;
  
  /// Error color (Red-500)
  Color get error => extras['error'] as Color;
  
  /// Success color (Emerald-500)
  Color get success => extras['success'] as Color;
  
  /// Info color (Blue-500)
  Color get info => extras['info'] as Color;
  
  /// Neutral color (Gray-500)
  Color get neutral => extras['neutral'] as Color;
  
  /// Text color (Gray-800)
  Color get text => extras['text'] as Color;
  
  /// Secondary text color (Gray-500)
  Color get textSecondary => extras['textSecondary'] as Color;
  
  /// Border color (Gray-200)
  Color get border => extras['border'] as Color;
  
  /// Divider color (Gray-100)
  Color get divider => extras['divider'] as Color;

  /// Create a copy with updated values
  @override
  BrandAColors copyWith({
    Color? primary,
    Color? secondary,
    Color? surface,
    Color? background,
    Map<String, Color>? extras,
  }) {
    return BrandAColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      surface: surface ?? this.surface,
      background: background ?? this.background,
      extras: extras ?? this.extras,
    );
  }

  /// Linear interpolation between two brand A color tokens
  @override
  BrandAColors lerp(FlyColorsBase other, double t) {
    if (other is! BrandAColors) {
      return BrandAColors(
        primary: Color.lerp(primary, other.primary, t) ?? primary,
        secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
        surface: Color.lerp(surface, other.surface, t) ?? surface,
        background: Color.lerp(background, other.background, t) ?? background,
        extras: _lerpExtras(extras, other.extras, t),
      );
    }
    
    return BrandAColors(
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      background: Color.lerp(background, other.background, t) ?? background,
      extras: _lerpExtras(extras, other.extras, t),
    );
  }

  /// Helper to interpolate extras maps
  Map<String, Color> _lerpExtras(Map<String, Color> a, Map<String, Color> b, double t) {
    final result = <String, Color>{};
    final allKeys = {...a.keys, ...b.keys};
    
    for (final key in allKeys) {
      final valueA = a[key] ?? Colors.transparent;
      final valueB = b[key] ?? Colors.transparent;
      result[key] = Color.lerp(valueA, valueB, t) ?? valueA;
    }
    
    return result;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BrandAColors &&
        other.primary == primary &&
        other.secondary == secondary &&
        other.surface == surface &&
        other.background == background &&
        _mapEquals(other.extras, extras);
  }

  @override
  int get hashCode {
    return Object.hash(primary, secondary, surface, background, extras);
  }

  /// Helper to compare maps
  bool _mapEquals(Map<String, Color> a, Map<String, Color> b) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (a[key] != b[key]) return false;
    }
    return true;
  }
}

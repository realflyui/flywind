import 'package:flutter/material.dart';
import '../core/theme.dart';

/// Utility class for handling font family resolution
class FlyFontUtils {
  /// Resolves various inputs to a pair of primary family and fallback list.
  ///
  /// Supported `.font(...)` inputs:
  /// - Token key (String): 'sans', 'serif', 'mono', or any extra in FlyFontToken
  /// - Raw family (String): e.g., 'Inter'
  /// - Font stack (List<String>): e.g., ['Inter', 'system-ui', 'sans-serif']
  /// - TextStyle:
  ///   - Google fonts: GoogleFonts.inter()
  ///   - Material Theme: Theme.of(context).textTheme.bodyMedium
  ///   - Material Typography: Typography.material2021().black.bodyMedium
  ///   - Cupertino Theme: CupertinoTheme.of(context).textTheme.textStyle
  ///   - Custom: const TextStyle(fontFamily: 'Inter', fontFamilyFallback: [...])
  ///
  /// Notes:
  /// - Only fontFamily and fontFamilyFallback are extracted from a TextStyle.
  /// - Empty List<String> is a no-op.
  /// - Unknown types throw ArgumentError.
  static FlyFontFamilies? resolve(BuildContext context, dynamic value) {
    if (value == null) return null;

    // If already a TextStyle, extract family and fallback
    if (value is TextStyle) {
      final family = value.fontFamily;
      final fallback = value.fontFamilyFallback;
      if (family == null && (fallback == null || fallback.isEmpty)) {
        return null;
      }
      return FlyFontFamilies(
        primary: family ?? (fallback != null && fallback.isNotEmpty ? fallback.first : null),
        fallback: family != null ? (fallback ?? const <String>[]) : (fallback?.skip(1).toList() ?? const <String>[]),
      );
    }

    // If a List<String>, treat as full stack
    if (value is List<String>) {
      if (value.isEmpty) return null;
      return FlyFontFamilies(
        primary: value.first,
        fallback: value.length > 1 ? value.sublist(1) : const <String>[],
      );
    }

    // If a String, attempt token lookup then fall back to raw family
    if (value is String) {
      try {
        final fonts = FlyTheme.of(context).font;
        final stack = fonts[value];
        if (stack != null && stack.isNotEmpty) {
          return FlyFontFamilies(
            primary: stack.first,
            fallback: stack.length > 1 ? stack.sublist(1) : const <String>[],
          );
        }
      } catch (_) {
        // Ignore and treat as raw family below
      }
      // Treat as raw family name
      if (value.trim().isEmpty) return null;
      return FlyFontFamilies(primary: value, fallback: const <String>[]);
    }

    throw ArgumentError('Font must be a String, List<String>, or TextStyle, got ${value.runtimeType}');
  }
}

class FlyFontFamilies {
  FlyFontFamilies({required this.primary, required this.fallback});
  final String? primary;
  final List<String> fallback;
}



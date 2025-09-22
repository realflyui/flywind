import 'package:flutter/material.dart';
import '../core/token.dart';

/// Value resolver that handles type conversion for Flywind utilities
class FlyValue {
  /// Resolves values to double (int, double, string tokens, CSS units) for spacing and radius
  static double resolveDouble(dynamic value, BuildContext context, FlyToken<double> tokens) {
    double result;
    
    if (value is double) {
      result = value;
    } else if (value is int) {
      result = value.toDouble();
    } else if (value is String) {
      // Try token lookup first
      final tokenValue = tokens[value];
      if (tokenValue != null) {
        result = tokenValue;
      } else {
        // Then try unit parsing
        result = _parseUnit(value);
      }
    } else {
      final availableTokens = tokens.keys.take(5).join(', ');
      throw ArgumentError('Cannot resolve value "$value": expected int, double, or String (token name/unit). Available tokens: $availableTokens${tokens.keys.length > 5 ? '...' : ''}');
    }
    
    // Validate that the result is not negative
    if (result < 0) {
      throw ArgumentError('Value "$value" resolved to negative number ($result). Spacing and radius values must be non-negative.');
    }
    
    return result;
  }
  
  /// Resolves color values (Color, string tokens, hex)
  static Color resolveColor(dynamic value, BuildContext context, FlyToken<Color> tokens) {
    if (value is Color) return value;
    
    if (value is String) {
      // Try token lookup first
      final tokenValue = tokens[value];
      if (tokenValue != null) return tokenValue;
      
      // Then try hex parsing
      return _parseColor(value, context);
    }
    
    final availableTokens = tokens.keys.take(5).join(', ');
    throw ArgumentError('Cannot resolve color value "$value": expected Color object, hex string (#RRGGBB), or token name. Available tokens: $availableTokens${tokens.keys.length > 5 ? '...' : ''}');
  }
  
  /// Parses CSS-like units (px, em, rem, %)
  static double _parseUnit(String value) {
    // Handle "10px", "1.5em", "50%", etc.
    final regex = RegExp(r'^(\d+(?:\.\d+)?)(px|em|rem|%)?$');
    final match = regex.firstMatch(value);
    if (match == null) {
      throw ArgumentError('Invalid unit "$value": expected format like "10px", "1.5em", "50%", or "16"');
    }
    
    double numValue;
    try {
      numValue = double.parse(match.group(1)!);
    } catch (e) {
      throw ArgumentError('Invalid number in unit "$value": ${match.group(1)}');
    }
    final unit = match.group(2) ?? 'px';
    
    switch (unit) {
      case 'px': 
        return numValue;
      case 'em': 
        return numValue * 16; // Assuming 16px base
      case 'rem': 
        return numValue * 16;
      case '%': 
        // Validate percentage range
        if (numValue < 0 || numValue > 100) {
          throw ArgumentError('Invalid percentage "$value": must be between 0% and 100%');
        }
        return numValue / 100; // Convert to decimal
      default: 
        return numValue;
    }
  }
  
  /// Parses color strings (hex, named colors, etc.)
  static Color _parseColor(String value, BuildContext context) {
    // Handle hex colors
    if (value.startsWith('#')) {
      final hex = value.substring(1).toUpperCase();
      
      // Validate hex characters
      if (!RegExp(r'^[0-9A-F]+$').hasMatch(hex)) {
        throw ArgumentError('Invalid hex color "$value": contains non-hex characters. Use format #RRGGBB or #AARRGGBB');
      }
      
      try {
        if (hex.length == 6) {
          return Color(int.parse(hex, radix: 16) + 0xFF000000);
        } else if (hex.length == 8) {
          return Color(int.parse(hex, radix: 16));
        } else {
          throw ArgumentError('Invalid hex color "$value": must be 6 (#RRGGBB) or 8 (#AARRGGBB) characters after #');
        }
      } catch (e) {
        if (e is ArgumentError) rethrow;
        throw ArgumentError('Failed to parse hex color "$value": $e');
      }
    }
    
    throw ArgumentError('Invalid color "$value": expected hex color (#RRGGBB or #AARRGGBB) or valid token name');
  }
}

/// Generic unit parser for handling various CSS-like unit strings
class FlyUnitParser {
  /// Parse a string value into a double with proper unit handling
  ///
  /// Supported formats:
  /// - "10" -> 10.0 (assumes logical pixels)
  /// - "10px" -> 10.0 (pixels)
  /// - "1rem" -> 16.0 (assumes 16px base font size)
  /// - "1em" -> 16.0 (assumes 16px base font size)
  /// - "50%" -> 0.5 (returns as decimal for percentage calculations)
  /// - "0.5" -> 0.5 (decimal values)
  ///
  /// Returns null for invalid input
  static double? parse(String value) {
    if (value.isEmpty) return null;

    // Remove whitespace
    final trimmed = value.trim();

    // Handle percentage values
    if (trimmed.endsWith('%')) {
      final numberPart = trimmed.substring(0, trimmed.length - 1);
      final number = double.tryParse(numberPart);
      if (number != null) {
        return number / 100.0; // Return as decimal (0.5 for 50%)
      }
      return null;
    }

    // Handle rem values (assume 16px base)
    if (trimmed.endsWith('rem')) {
      final numberPart = trimmed.substring(0, trimmed.length - 3);
      final number = double.tryParse(numberPart);
      if (number != null) {
        return number * 16.0; // Convert to pixels
      }
      return null;
    }

    // Handle em values (assume 16px base)
    if (trimmed.endsWith('em')) {
      final numberPart = trimmed.substring(0, trimmed.length - 2);
      final number = double.tryParse(numberPart);
      if (number != null) {
        return number * 16.0; // Convert to pixels
      }
      return null;
    }

    // Handle pixel values
    if (trimmed.endsWith('px')) {
      final numberPart = trimmed.substring(0, trimmed.length - 2);
      final number = double.tryParse(numberPart);
      if (number != null) {
        return number;
      }
      return null;
    }

    // Handle plain numbers (assume pixels)
    final number = double.tryParse(trimmed);
    if (number != null) {
      return number;
    }

    return null;
  }

  /// Parse a string value and return a double, with fallback to 0.0
  static double parseOrZero(String value) {
    return parse(value) ?? 0.0;
  }

  /// Check if a string represents a percentage value
  static bool isPercentage(String value) {
    return value.trim().endsWith('%');
  }

  /// Check if a string represents a rem/em value
  static bool isRelativeUnit(String value) {
    final trimmed = value.trim();
    return trimmed.endsWith('rem') || trimmed.endsWith('em');
  }

  /// Check if a string represents a pixel value
  static bool isPixelValue(String value) {
    return value.trim().endsWith('px');
  }

  /// Check if a string represents a plain number
  static bool isPlainNumber(String value) {
    final trimmed = value.trim();
    return double.tryParse(trimmed) != null &&
        !trimmed.endsWith('px') &&
        !trimmed.endsWith('rem') &&
        !trimmed.endsWith('em') &&
        !trimmed.endsWith('%');
  }

  /// Get the unit type of a string value
  static FlyUnitType getUnitType(String value) {
    if (isPercentage(value)) return FlyUnitType.percentage;
    if (isRelativeUnit(value)) return FlyUnitType.relative;
    if (isPixelValue(value)) return FlyUnitType.pixel;
    if (isPlainNumber(value)) return FlyUnitType.number;
    return FlyUnitType.invalid;
  }
}

/// Enum representing different unit types
enum FlyUnitType { percentage, relative, pixel, number, invalid }

/// Extension on String to provide convenient parsing methods
extension FlyUnitParserExtension on String {
  /// Parse this string as a unit value
  double? toUnit() => FlyUnitParser.parse(this);

  /// Parse this string as a unit value with fallback to 0.0
  double toUnitOrZero() => FlyUnitParser.parseOrZero(this);

  /// Check if this string is a percentage
  bool get isPercentage => FlyUnitParser.isPercentage(this);

  /// Check if this string is a relative unit (rem/em)
  bool get isRelativeUnit => FlyUnitParser.isRelativeUnit(this);

  /// Check if this string is a pixel value
  bool get isPixelValue => FlyUnitParser.isPixelValue(this);

  /// Check if this string is a plain number
  bool get isPlainNumber => FlyUnitParser.isPlainNumber(this);

  /// Get the unit type of this string
  FlyUnitType get unitType => FlyUnitParser.getUnitType(this);
}

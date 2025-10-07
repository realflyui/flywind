/// Unit conversion utilities for CSS to Flutter
class UnitConverter {
  /// Convert rem value to Flutter double format (pixels)
  static String remToDouble(String remValue) {
    final remString = remValue.replaceAll('rem', '').trim();
    final remDouble = double.parse(remString);
    // Convert rem to pixels (assuming 1rem = 16px, which is standard)
    final pixels = (remDouble * 16).round();
    return pixels.toString();
  }

  /// Convert px value to Flutter double format
  static String pxToDouble(String pxValue) {
    final pxString = pxValue.replaceAll('px', '').trim();
    final pxDouble = double.parse(pxString);
    return pxDouble.round().toString();
  }

  /// Convert em value to Flutter double format (pixels)
  static String emToDouble(String emValue) {
    final emString = emValue.replaceAll('em', '').trim();
    final emDouble = double.parse(emString);
    // Convert em to pixels (assuming 1em = 16px, which is standard)
    final pixels = (emDouble * 16).round();
    return pixels.toString();
  }

  /// Convert percentage to Flutter double format (0.0 to 1.0)
  static String percentToDouble(String percentValue) {
    final percentString = percentValue.replaceAll('%', '').trim();
    final percentDouble = double.parse(percentString);
    final decimal = percentDouble / 100;
    return decimal.toString();
  }

  /// Convert any unit to Flutter double format
  static String convertToDouble(String value) {
    final trimmedValue = value.trim();

    if (trimmedValue.contains('calc(')) {
      // Handle calc() expressions like calc(1.25 / 0.875)
      return _resolveCalcExpression(trimmedValue);
    } else if (trimmedValue.contains('/') && !trimmedValue.contains(' ')) {
      // Handle direct division expressions like 1.25 / 0.875
      final parts = trimmedValue.split('/');
      if (parts.length == 2) {
        final numerator = double.parse(parts[0].trim());
        final denominator = double.parse(parts[1].trim());
        return (numerator / denominator).toString();
      }
    } else if (trimmedValue.endsWith('rem')) {
      return remToDouble(trimmedValue);
    } else if (trimmedValue.endsWith('px')) {
      return pxToDouble(trimmedValue);
    } else if (trimmedValue.endsWith('em')) {
      return emToDouble(trimmedValue);
    } else if (trimmedValue.endsWith('%')) {
      return percentToDouble(trimmedValue);
    } else if (trimmedValue == '0' ||
        RegExp(r'^\d+(\.\d+)?$').hasMatch(trimmedValue)) {
      // Pure number
      return trimmedValue;
    }

    throw Exception('Unsupported unit format: $value');
  }

  /// Resolve CSS calc() expressions
  static String _resolveCalcExpression(String calcValue) {
    // Remove calc() wrapper
    final content = calcValue.replaceAll(RegExp(r'calc\(|\)'), '').trim();

    if (content.contains('/')) {
      // Handle division: calc(1.25 / 0.875)
      final parts = content.split('/');
      if (parts.length == 2) {
        final numerator = double.parse(parts[0].trim());
        final denominator = double.parse(parts[1].trim());
        return (numerator / denominator).toString();
      }
    } else if (content.contains('+')) {
      // Handle addition: calc(1rem + 2px)
      final parts = content.split('+');
      if (parts.length == 2) {
        final left = _parseValue(parts[0].trim());
        final right = _parseValue(parts[1].trim());
        return (left + right).toString();
      }
    } else if (content.contains('-')) {
      // Handle subtraction: calc(1rem - 2px)
      final parts = content.split('-');
      if (parts.length == 2) {
        final left = _parseValue(parts[0].trim());
        final right = _parseValue(parts[1].trim());
        return (left - right).toString();
      }
    } else if (content.contains('*')) {
      // Handle multiplication: calc(1rem * 2)
      final parts = content.split('*');
      if (parts.length == 2) {
        final left = _parseValue(parts[0].trim());
        final right = _parseValue(parts[1].trim());
        return (left * right).toString();
      }
    }

    // If no operators found, try to parse as a single value
    return _parseValue(content).toString();
  }

  /// Parse a single value (with or without units)
  static double _parseValue(String value) {
    if (value.endsWith('rem')) {
      final remValue = double.parse(value.replaceAll('rem', ''));
      return remValue * 16; // Convert rem to pixels
    } else if (value.endsWith('px')) {
      return double.parse(value.replaceAll('px', ''));
    } else if (value.endsWith('em')) {
      final emValue = double.parse(value.replaceAll('em', ''));
      return emValue * 16; // Convert em to pixels
    } else {
      return double.parse(value);
    }
  }

  /// Convert to Flutter string format (for spacing, etc.)
  static String convertToString(String value) {
    return convertToDouble(value);
  }

  /// Convert to Flutter int format
  static String convertToInt(String value) {
    final doubleValue = convertToDouble(value);
    return double.parse(doubleValue).round().toString();
  }
}

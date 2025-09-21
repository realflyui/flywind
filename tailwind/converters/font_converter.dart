/// Font conversion utilities for CSS to Flutter
class FontConverter {
  /// Convert CSS font family to Flutter-compatible format
  static String convertFontFamily(String fontValue) {
    // Remove quotes and split by comma
    final fonts = fontValue
        .replaceAll('"', '')
        .replaceAll("'", '')
        .split(',')
        .map((f) => f.trim())
        .toList();
    
    // Convert to Flutter format
    if (fonts.length == 1) {
      return '"${fonts.first}"';
    } else {
      return '[${fonts.map((f) => '"$f"').join(', ')}]';
    }
  }

  /// Convert CSS font weight to Flutter FontWeight
  static String convertFontWeight(String weightValue) {
    switch (weightValue.toLowerCase()) {
      case '100':
      case 'thin':
        return 'FontWeight.w100';
      case '200':
      case 'extralight':
        return 'FontWeight.w200';
      case '300':
      case 'light':
        return 'FontWeight.w300';
      case '400':
      case 'normal':
      case 'regular':
        return 'FontWeight.w400';
      case '500':
      case 'medium':
        return 'FontWeight.w500';
      case '600':
      case 'semibold':
        return 'FontWeight.w600';
      case '700':
      case 'bold':
        return 'FontWeight.w700';
      case '800':
      case 'extrabold':
        return 'FontWeight.w800';
      case '900':
      case 'black':
        return 'FontWeight.w900';
      default:
        return 'FontWeight.w400';
    }
  }

  /// Convert CSS font size to Flutter double
  static String convertFontSize(String sizeValue) {
    if (sizeValue.endsWith('rem')) {
      final remString = sizeValue.replaceAll('rem', '').trim();
      final remDouble = double.parse(remString);
      final pixels = (remDouble * 16).round();
      return pixels.toString();
    } else if (sizeValue.endsWith('px')) {
      final pxString = sizeValue.replaceAll('px', '').trim();
      return double.parse(pxString).round().toString();
    } else if (sizeValue.endsWith('em')) {
      final emString = sizeValue.replaceAll('em', '').trim();
      final emDouble = double.parse(emString);
      final pixels = (emDouble * 16).round();
      return pixels.toString();
    } else {
      // Assume it's already a number
      return sizeValue;
    }
  }

  /// Convert CSS line height to Flutter double
  static String convertLineHeight(String lineHeightValue) {
    if (lineHeightValue == 'normal') {
      return '1.0';
    } else if (lineHeightValue.endsWith('%')) {
      final percentString = lineHeightValue.replaceAll('%', '').trim();
      final percentDouble = double.parse(percentString);
      return (percentDouble / 100).toString();
    } else if (lineHeightValue.contains('calc(')) {
      // Handle calc() expressions like calc(1.25 / 0.875)
      return _resolveCalcExpression(lineHeightValue);
    } else if (lineHeightValue.contains('/')) {
      // Handle direct division expressions like 1.25 / 0.875
      final parts = lineHeightValue.split('/');
      if (parts.length == 2) {
        final numerator = double.parse(parts[0].trim());
        final denominator = double.parse(parts[1].trim());
        return (numerator / denominator).toString();
      }
    } else {
      // Assume it's a direct number
      return lineHeightValue;
    }
    return '1.0';
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

  /// Convert CSS letter spacing to Flutter double
  static String convertLetterSpacing(String spacingValue) {
    if (spacingValue.endsWith('em')) {
      final emString = spacingValue.replaceAll('em', '').trim();
      final emDouble = double.parse(emString);
      // Convert em to pixels (assuming 1em = 16px)
      final pixels = (emDouble * 16).round();
      return pixels.toString();
    } else if (spacingValue.endsWith('px')) {
      final pxString = spacingValue.replaceAll('px', '').trim();
      return double.parse(pxString).round().toString();
    } else if (spacingValue == 'normal') {
      return '0.0';
    } else {
      // Assume it's already a number
      return spacingValue;
    }
  }
}

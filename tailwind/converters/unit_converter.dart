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
    
    if (trimmedValue.endsWith('rem')) {
      return remToDouble(trimmedValue);
    } else if (trimmedValue.endsWith('px')) {
      return pxToDouble(trimmedValue);
    } else if (trimmedValue.endsWith('em')) {
      return emToDouble(trimmedValue);
    } else if (trimmedValue.endsWith('%')) {
      return percentToDouble(trimmedValue);
    } else if (trimmedValue == '0' || RegExp(r'^\d+(\.\d+)?$').hasMatch(trimmedValue)) {
      // Pure number
      return trimmedValue;
    } else {
      throw Exception('Unsupported unit format: $value');
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

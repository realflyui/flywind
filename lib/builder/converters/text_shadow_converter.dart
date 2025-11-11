/// Text shadow conversion utilities for CSS to Flutter
class TextShadowConverter {
  /// Convert CSS text shadow string to Flutter Shadow
  static String cssTextShadowToFlutter(String cssTextShadow) {
    // Handle multiple shadows (comma-separated)
    if (cssTextShadow.contains(',')) {
      final shadows = cssTextShadow.split(',').map((s) => s.trim()).toList();
      final flutterShadows = shadows
          .map((shadow) => _parseSingleTextShadow(shadow))
          .toList();
      return '[${flutterShadows.join(', ')}]';
    }

    // Single shadow
    return _parseSingleTextShadow(cssTextShadow);
  }

  /// Parse a single CSS text shadow and convert to Flutter Shadow
  static String _parseSingleTextShadow(String shadow) {
    // Remove any extra whitespace
    shadow = shadow.trim();

    // Find the color part (usually at the end, starts with rgb, #, or color name)
    final colorRegex = RegExp(r'(rgb\([^)]+\)|#[0-9a-fA-F]+|\w+)$');
    final colorMatch = colorRegex.firstMatch(shadow);

    String colorString = 'Colors.black.withOpacity(0.1)';
    String shadowWithoutColor = shadow;

    if (colorMatch != null) {
      colorString = _parseColor(colorMatch.group(1)!);
      shadowWithoutColor = shadow.substring(0, colorMatch.start).trim();
    }

    // Parse the numeric parts - handle both px and unitless values
    final parts = shadowWithoutColor.split(RegExp(r'\s+'));
    final numericParts = <double>[];

    for (final part in parts) {
      if (part.endsWith('px')) {
        numericParts.add(double.parse(part.replaceAll('px', '')));
      } else if (_isNumeric(part)) {
        numericParts.add(double.parse(part));
      }
    }

    if (numericParts.length < 2) {
      return 'Shadow(color: $colorString, offset: Offset(0, 1), blurRadius: 0)';
    }

    final offsetX = numericParts[0];
    final offsetY = numericParts[1];
    final blurRadius = numericParts.length > 2 ? numericParts[2] : 0.0;

    return 'Shadow('
        'color: $colorString, '
        'offset: Offset($offsetX, $offsetY), '
        'blurRadius: $blurRadius'
        ')';
  }

  /// Parse CSS color string to Flutter Color
  static String _parseColor(String colorString) {
    if (colorString.startsWith('rgb(')) {
      return _parseRgbColor(colorString);
    } else if (colorString.startsWith('#')) {
      return _parseHexColor(colorString);
    } else if (colorString == 'transparent') {
      return 'Colors.transparent';
    } else {
      // Try to match common color names
      return _parseNamedColor(colorString);
    }
  }

  /// Parse RGB color string
  static String _parseRgbColor(String rgbString) {
    // Parse "rgb(0 0 0 / 0.1)" or "rgb(0, 0, 0, 0.1)"
    final regex = RegExp(r'rgb\(([^)]+)\)');
    final match = regex.firstMatch(rgbString);

    if (match == null) return 'Colors.black.withOpacity(0.1)';

    final values = match
        .group(1)!
        .split(RegExp(r'[,\s/]+'))
        .where((s) => s.isNotEmpty)
        .toList();

    if (values.length >= 3) {
      final r = int.parse(values[0]);
      final g = int.parse(values[1]);
      final b = int.parse(values[2]);
      final opacity = values.length > 3 ? double.parse(values[3]) : 1.0;

      return 'Color.fromRGBO($r, $g, $b, $opacity)';
    }

    return 'Colors.black.withOpacity(0.1)';
  }

  /// Parse hex color string
  static String _parseHexColor(String hexString) {
    String hex = hexString.replaceAll('#', '');

    if (hex.length == 3) {
      hex = hex.split('').map((c) => c + c).join('');
    }

    if (hex.length == 6) {
      return 'Color(0xFF${hex.toUpperCase()})';
    }

    return 'Colors.black';
  }

  /// Parse named colors
  static String _parseNamedColor(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'black':
        return 'Colors.black';
      case 'white':
        return 'Colors.white';
      case 'red':
        return 'Colors.red';
      case 'green':
        return 'Colors.green';
      case 'blue':
        return 'Colors.blue';
      default:
        return 'Colors.black.withOpacity(0.1)';
    }
  }

  /// Check if string is numeric
  static bool _isNumeric(String str) {
    return double.tryParse(str) != null;
  }
}

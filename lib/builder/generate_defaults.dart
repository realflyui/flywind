#!/usr/bin/env dart

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'converters/color_converter.dart';
import 'converters/unit_converter.dart';
import 'converters/font_converter.dart';

/// Unified token generator for FlyWind design tokens
/// Downloads Tailwind CSS theme and extracts specific properties
class TokenGenerator {
  final String cssContent;
  
  TokenGenerator(this.cssContent);

  /// Token configuration for what to extract
  static const Map<String, Map<String, String>> _tokenConfigs = {
    // 'breakpoint': {
    //   'prefix': 'breakpoint',
    //   'className': 'FlyBreakpointToken',
    //   'dartType': 'double',
    //   'description': 'Breakpoint values for responsive design',
    //   'conversionType': 'breakpoint',
    // },
    'spacing': {
      'prefix': 'spacing',
      'className': 'FlySpacingToken',
      'dartType': 'double',
      'description': 'Spacing values for margins and padding',
      'conversionType': 'unit',
    },
    'radius': {
      'prefix': 'radius',
      'className': 'FlyRadiusToken',
      'dartType': 'double',
      'description': 'Border radius values for rounded corners',
      'conversionType': 'radius',
    },
    'color': {
      'prefix': 'color',
      'className': 'FlyColorToken',
      'dartType': 'Color',
      'description': 'Color values from Tailwind CSS theme',
      'conversionType': 'color',
    },
    // 'container': {
    //   'prefix': 'container',
    //   'className': 'FlyContainerToken',
    //   'dartType': 'double',
    //   'description': 'Container width values',
    //   'conversionType': 'unit',
    // },
    'text-style': {
      'prefix': 'text-style',
      'className': 'FlyTextStyleToken',
      'dartType': 'TextStyle',
      'description': 'Text style values with fontSize and height',
      'conversionType': 'textStyle',
    },
    'font-weight': {
      'prefix': 'font-weight',
      'className': 'FlyFontWeightToken',
      'dartType': 'FontWeight',
      'description': 'Font weight values',
      'conversionType': 'fontWeight',
    },
    'tracking': {
      'prefix': 'tracking',
      'className': 'FlyTrackingToken',
      'dartType': 'double',
      'description': 'Letter spacing values',
      'conversionType': 'unit',
    },
    // 'blur': {
    //   'prefix': 'blur',
    //   'className': 'FlyBlurToken',
    //   'dartType': 'double',
    //   'description': 'Blur effect values',
    //   'conversionType': 'unit',
    // },
    // 'perspective': {
    //   'prefix': 'perspective',
    //   'className': 'FlyPerspectiveToken',
    //   'dartType': 'double',
    //   'description': 'Perspective transform values',
    //   'conversionType': 'unit',
    // },
    'leading': {
      'prefix': 'leading',
      'className': 'FlyLeadingToken',
      'dartType': 'double',
      'description': 'Line height values',
      'conversionType': 'unit',
    },
  };

  /// Extract tokens by property prefix
  Map<String, String> extractTokens(String propertyPrefix, String conversionType) {
    final tokens = <String, String>{};
    
    // Create regex pattern for the property
    RegExp regex;
    if (propertyPrefix == 'spacing') {
      // Handle spacing without suffix (--spacing: value)
      regex = RegExp('--spacing:\\s*([^;]+);', multiLine: true, dotAll: true);
    } else if (propertyPrefix == 'color') {
      // Handle color tokens (--color-red-500: #ef4444;)
      regex = RegExp('--color-([^:]+):\\s*([^;]+);', multiLine: true, dotAll: true);
    } else if (propertyPrefix == 'text-style') {
      // Handle text-style tokens by combining text size and line height
      return _extractTextStyleTokens();
    } else if (propertyPrefix == 'aspect-video') {
      // Handle aspect-video token (--aspect-video: 16 / 9;)
      regex = RegExp('--aspect-video:\\s*([^;]+);', multiLine: true, dotAll: true);
    } else if (propertyPrefix == 'text') {
      // Handle text tokens (--text-xs: 0.75rem;) but exclude line-height variables
      regex = RegExp('--text-([^:]+):\\s*([^;]+);', multiLine: true, dotAll: true);
    } else {
      regex = RegExp('--$propertyPrefix-([^:]+):\\s*([^;]+);', multiLine: true, dotAll: true);
    }
    final matches = regex.allMatches(cssContent);
    
    for (final match in matches) {
      // Skip line-height variables when extracting text tokens
      if (propertyPrefix == 'text' && match.group(1)!.contains('--line-height')) {
        continue;
      }
      String tokenName;
      String tokenValue;
      
      if (propertyPrefix == 'spacing') {
        // For spacing, there's no token name, just use 'base' as the default
        tokenName = 'base';
        tokenValue = match.group(1)!.trim().replaceAll(RegExp(r'\s+'), ' ');
      } else if (propertyPrefix == 'aspect-video') {
        // For aspect-video, there's no token name, just use 'base' as the default
        tokenName = 'base';
        tokenValue = match.group(1)!.trim().replaceAll(RegExp(r'\s+'), ' ');
      } else {
        tokenName = match.group(1)!.trim();
        tokenValue = match.group(2)!.trim().replaceAll(RegExp(r'\s+'), ' ');
      }
      
      try {
        String flutterValue = _convertValue(tokenValue, conversionType);
        String cleanName = _cleanTokenName(tokenName);
        tokens[cleanName] = flutterValue;
      } catch (e) {
        print('Warning: Could not convert $propertyPrefix $tokenName ($tokenValue): $e');
      }
    }
    
    // For spacing, always include default values
    if (propertyPrefix == 'spacing') {
      final defaultSpacing = _getDefaultSpacingValues();
      // Merge default values, but don't override existing ones from theme
      for (final entry in defaultSpacing.entries) {
        if (!tokens.containsKey(entry.key)) {
          tokens[entry.key] = entry.value;
        }
      }
    }
    
    return tokens;
  }

  /// Extract text style tokens by combining text size and line height
  Map<String, String> _extractTextStyleTokens() {
    final tokens = <String, String>{};
    
    // Extract text size tokens
    final textSizeRegex = RegExp('--text-([^:]+):\\s*([^;]+);', multiLine: true, dotAll: true);
    final textSizeMatches = textSizeRegex.allMatches(cssContent);
    final textSizes = <String, String>{};
    
    for (final match in textSizeMatches) {
      if (match.group(1)!.contains('--line-height')) continue;
      final tokenName = match.group(1)!.trim();
      final tokenValue = match.group(2)!.trim().replaceAll(RegExp(r'\s+'), ' ');
      textSizes[tokenName] = tokenValue;
    }
    
    // Extract line height tokens
    final lineHeightRegex = RegExp('--text-([^:]+)--line-height:\\s*([^;]+);', multiLine: true, dotAll: true);
    final lineHeightMatches = lineHeightRegex.allMatches(cssContent);
    final lineHeights = <String, String>{};
    
    for (final match in lineHeightMatches) {
      final tokenName = match.group(1)!.trim();
      final tokenValue = match.group(2)!.trim().replaceAll(RegExp(r'\s+'), ' ');
      lineHeights[tokenName] = tokenValue;
    }
    
    // Combine text sizes and line heights into TextStyle objects
    final allKeys = {...textSizes.keys, ...lineHeights.keys};
    
    for (final key in allKeys) {
      final fontSize = textSizes[key];
      final lineHeight = lineHeights[key];
      
      if (fontSize != null) {
        try {
          final fontSizeValue = UnitConverter.convertToDouble(fontSize);
          final lineHeightValue = lineHeight != null 
              ? UnitConverter.convertToDouble(lineHeight)
              : '1.0'; // Default line height
          
          final cleanName = _cleanTokenName(key);
          tokens[cleanName] = 'TextStyle(fontSize: $fontSizeValue, height: $lineHeightValue)';
        } catch (e) {
          print('Warning: Could not convert text-style $key: $e');
        }
      }
    }
    
    return tokens;
  }

  /// Get default spacing values when theme doesn't provide them
  Map<String, String> _getDefaultSpacingValues() {
    return {
      'px': '1.0',
      's0': '0.0',
      's0_5': '2.0', // 0.125rem = 2px
      's1': '4.0',   // 0.25rem = 4px
      's1_5': '6.0', // 0.375rem = 6px
      's2': '8.0',   // 0.5rem = 8px
      's2_5': '10.0', // 0.625rem = 10px
      's3': '12.0',  // 0.75rem = 12px
      's3_5': '14.0', // 0.875rem = 14px
      's4': '16.0',  // 1rem = 16px
      's5': '20.0',  // 1.25rem = 20px
      's6': '24.0',  // 1.5rem = 24px
      's7': '28.0',  // 1.75rem = 28px
      's8': '32.0',  // 2rem = 32px
      's9': '36.0',  // 2.25rem = 36px
      's10': '40.0', // 2.5rem = 40px
      's11': '44.0', // 2.75rem = 44px
      's12': '48.0', // 3rem = 48px
      's14': '56.0', // 3.5rem = 56px
      's16': '64.0', // 4rem = 64px
      's20': '80.0', // 5rem = 80px
      's24': '96.0', // 6rem = 96px
      's28': '112.0', // 7rem = 112px
      's32': '128.0', // 8rem = 128px
      's36': '144.0', // 9rem = 144px
      's40': '160.0', // 10rem = 160px
      's44': '176.0', // 11rem = 176px
      's48': '192.0', // 12rem = 192px
      's52': '208.0', // 13rem = 208px
      's56': '224.0', // 14rem = 224px
      's60': '240.0', // 15rem = 240px
      's64': '256.0', // 16rem = 256px
      's72': '288.0', // 18rem = 288px
      's80': '320.0', // 20rem = 320px
      's96': '384.0', // 24rem = 384px
      'base': '16.0', // Base spacing unit (1rem = 16px)
    };
  }

  /// Convert CSS value to Flutter format based on type
  String _convertValue(String value, String type) {
    switch (type.toLowerCase()) {
      case 'breakpoint':
      case 'unit':
      case 'spacing':
      case 'radius':
      case 'tracking':
      case 'blur':
      case 'perspective':
      case 'leading':
        return UnitConverter.convertToDouble(value);
      case 'aspectRatio':
        // Handle aspect ratio expressions like "16 / 9"
        if (value.contains('/')) {
          final parts = value.split('/');
          if (parts.length == 2) {
            final numerator = double.parse(parts[0].trim());
            final denominator = double.parse(parts[1].trim());
            return (numerator / denominator).toString();
          }
        }
        return UnitConverter.convertToDouble(value);
      case 'text-line-height':
        // Handle calc() expressions for line height using UnitConverter
        return UnitConverter.convertToDouble(value);
      case 'color':
        if (value.startsWith('oklch(')) {
          return ColorConverter.oklchToFlutterColor(value);
        } else if (value.startsWith('#')) {
          return ColorConverter.hexToFlutterColor(value);
        } else {
          // For other color formats, wrap in quotes
          return '"$value"';
        }
      case 'string':
        // For string values like font families
        return FontConverter.convertFontFamily(value);
      case 'fontweight':
        // Convert font weight values to FontWeight
        return FontConverter.convertFontWeight(value);
      case 'textstyle':
        // TextStyle values are already formatted in _extractTextStyleTokens
        return value;
      default:
        return '"$value"';
    }
  }

  /// Clean up token names (remove double dashes, etc.)
  String _cleanTokenName(String name) {
    // Replace double dashes with single dash
    String cleaned = name.replaceAll('--', '-');
    
    // For color tokens, convert to camelCase for field names
    if (cleaned.contains('-')) {
      final parts = cleaned.split('-');
      if (parts.isEmpty) return 'value';
      
      final firstPart = parts[0].toLowerCase();
      final remainingParts = parts.skip(1).map((part) {
        if (part.isEmpty) return '';
        return part[0].toUpperCase() + part.substring(1).toLowerCase();
      });
      
      return firstPart + remainingParts.join('');
    }
    
    return cleaned;
  }


  /// Generate all token classes
  static Future<void> generateAll([String? customUrl]) async {
    final outputDir = 'lib/tokens/';
    
    // Download the latest theme.css from GitHub
    String cssContent;
    try {
      cssContent = await downloadThemeCss(customUrl);
    } catch (e) {
      print('Error: $e');
      exit(1);
    }
    
    final generator = TokenGenerator(cssContent);
    
    // Create output directory if it doesn't exist
    final outputDirFile = Directory(outputDir);
    if (!outputDirFile.existsSync()) {
      outputDirFile.createSync(recursive: true);
    }

    print('Generating FlyWind design tokens...\n');

    // Generate each token type
    for (final entry in _tokenConfigs.entries) {
      final tokenType = entry.key;
      final config = entry.value;
      
      print('Extracting ${config['prefix']} tokens...');
      
      final tokens = generator.extractTokens(config['prefix']!, config['conversionType']!);
      
      if (tokens.isEmpty) {
        print('No ${config['prefix']} tokens found');
        continue;
      }
      print('Found ${tokens.length} ${config['prefix']} tokens');
      
      final generatedCode = _generateClass(
        className: config['className']!,
        dartType: config['dartType']!,
        description: config['description']!,
        values: tokens,
      );
      
      final fileName = tokenType.replaceAll('-', '_');
      final outputFile = File('${outputDir}${fileName}.dart');
      outputFile.writeAsStringSync(generatedCode);
      
      print('Generated: ${outputFile.path}');
      
      // Print some examples
      print('Sample ${config['prefix']} tokens:');
      final sampleTokens = tokens.entries.take(3).toList();
      for (final entry in sampleTokens) {
        print('  ${entry.key}: ${entry.value}');
      }
      print('');
    }

    // Generate tokens.dart export file
    _generateTokensExport(outputDir);
    
    print('Token generation completed!');
  }

  /// Generate a single token class
  static String _generateClass({
    required String className,
    required String dartType,
    required String description,
    required Map<String, dynamic> values,
  }) {
    final buffer = StringBuffer();
    
    // Add header
    buffer.writeln('// GENERATED FILE - DO NOT EDIT MANUALLY');
    buffer.writeln('// To regenerate, run: dart cli/generate_defaults.dart');

    buffer.writeln();
    
    // Add imports
    if (dartType == 'Color' || dartType == 'FontWeight' || dartType == 'TextStyle') {
      buffer.writeln("import 'package:flutter/material.dart';");
    }
    buffer.writeln("import '../core/token.dart';");
    buffer.writeln();
    
    // Add class documentation
    buffer.writeln('/// $description');
    buffer.writeln('class $className implements FlyToken<$dartType> {');
    buffer.writeln('  const $className({');
    
    // Generate constructor parameters
    final fieldNames = <String>[];
    for (final entry in values.entries) {
      final key = entry.key;
      final fieldName = _getFieldName(key);
      fieldNames.add(fieldName);
      buffer.writeln('    required this.$fieldName,');
    }
    
    // Add extras parameter
    buffer.writeln('    this.extras = const {},');
    buffer.writeln('  });');
    buffer.writeln();
    
    // Generate field declarations
    for (int i = 0; i < values.length; i++) {
      final entry = values.entries.elementAt(i);
      final key = entry.key;
      final fieldName = _getFieldName(key);
      buffer.writeln('  /// $key $description');
      buffer.writeln('  final $dartType $fieldName;');
    }
    
    // Add extras field
    buffer.writeln();
    buffer.writeln('  /// Additional custom values');
    buffer.writeln('  final Map<String, $dartType> extras;');
    buffer.writeln();
    
    // Generate _allValues getter
    buffer.writeln('  /// All values in a single map for easier iteration');
    buffer.writeln('  Map<String, $dartType> get _allValues => {');
    for (int i = 0; i < values.length; i++) {
      final entry = values.entries.elementAt(i);
      final key = entry.key;
      final fieldName = _getFieldName(key);
      // Use the field name as the key for consistency
      buffer.writeln("    '$fieldName': $fieldName,");
    }
    buffer.writeln('    ...extras,');
    buffer.writeln('  };');
    buffer.writeln();
    
    // Generate operator[] method
    buffer.writeln('  /// Access value by key (canonical or extra)');
    buffer.writeln('  @override');
    buffer.writeln('  $dartType? operator[](String key) => _allValues[key];');
    buffer.writeln();
    
    // Generate keys getter
    buffer.writeln('  /// Get all available keys (canonical + extras)');
    buffer.writeln('  @override');
    buffer.writeln('  Iterable<String> get keys => _allValues.keys;');
    buffer.writeln();
    
    // Generate put method
    buffer.writeln('  /// Put a new value for the given key');
    buffer.writeln('  @override');
    buffer.writeln('  $className put(String key, $dartType value) {');
    buffer.writeln('    switch (key) {');
    for (int i = 0; i < values.length; i++) {
      final entry = values.entries.elementAt(i);
      final key = entry.key;
      final fieldName = _getFieldName(key);
      buffer.writeln("      case '$fieldName':");
      buffer.writeln('        return copyWith($fieldName: value);');
    }
    buffer.writeln('      default:');
    buffer.writeln('        final newExtras = Map<String, $dartType>.from(extras);');
    buffer.writeln('        newExtras[key] = value;');
    buffer.writeln('        return copyWith(extras: newExtras);');
    buffer.writeln('    }');
    buffer.writeln('  }');
    buffer.writeln();
    
    // Generate merge method
    buffer.writeln('  /// Merge another token into this one (right side wins)');
    buffer.writeln('  @override');
    buffer.writeln('  $className merge(FlyToken<$dartType> other) {');
    buffer.writeln('    if (other is! $className) return this;');
    buffer.writeln('    ');
    buffer.writeln('    return copyWith(');
    for (int i = 0; i < values.length; i++) {
      final entry = values.entries.elementAt(i);
      final key = entry.key;
      final fieldName = _getFieldName(key);
      buffer.writeln('      $fieldName: other.$fieldName,');
    }
    buffer.writeln('      extras: {...extras, ...other.extras},');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();
    
    // Generate copyWith method
    buffer.writeln('  /// Create a copy with updated values');
    buffer.writeln('  $className copyWith({');
    for (int i = 0; i < values.length; i++) {
      final entry = values.entries.elementAt(i);
      final key = entry.key;
      final fieldName = _getFieldName(key);
      buffer.writeln('    $dartType? $fieldName,');
    }
    buffer.writeln('    Map<String, $dartType>? extras,');
    buffer.writeln('  }) {');
    buffer.writeln('    return $className(');
    for (int i = 0; i < values.length; i++) {
      final entry = values.entries.elementAt(i);
      final key = entry.key;
      final fieldName = _getFieldName(key);
      buffer.writeln('      $fieldName: $fieldName ?? this.$fieldName,');
    }
    buffer.writeln('      extras: extras ?? this.extras,');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();
    
    // Generate lerp method (for numeric types, Color, FontWeight, and TextStyle)
    if (dartType == 'double' || dartType == 'int' || dartType == 'Color' || dartType == 'FontWeight' || dartType == 'TextStyle') {
      buffer.writeln('  /// Linear interpolation between two tokens');
      buffer.writeln('  $className lerp($className other, double t) {');
      buffer.writeln('    final result = <String, $dartType>{};');
      buffer.writeln('    final allKeys = {..._allValues.keys, ...other._allValues.keys};');
      buffer.writeln('    ');
      buffer.writeln('    for (final key in allKeys) {');
      buffer.writeln('      final valueA = _allValues[key];');
      buffer.writeln('      final valueB = other._allValues[key];');
      
      if (dartType == 'Color') {
        buffer.writeln('      if (valueA != null && valueB != null) {');
        buffer.writeln('        result[key] = Color.lerp(valueA, valueB, t) ?? valueA;');
        buffer.writeln('      } else if (valueA != null) {');
        buffer.writeln('        result[key] = valueA;');
        buffer.writeln('      } else if (valueB != null) {');
        buffer.writeln('        result[key] = valueB;');
        buffer.writeln('      }');
      } else if (dartType == 'FontWeight') {
        buffer.writeln('      if (valueA != null && valueB != null) {');
        buffer.writeln('        final weightA = valueA.index;');
        buffer.writeln('        final weightB = valueB.index;');
        buffer.writeln('        final interpolatedIndex = (weightA + (weightB - weightA) * t).round();');
        buffer.writeln('        result[key] = FontWeight.values[interpolatedIndex.clamp(0, FontWeight.values.length - 1)];');
        buffer.writeln('      } else if (valueA != null) {');
        buffer.writeln('        result[key] = valueA;');
        buffer.writeln('      } else if (valueB != null) {');
        buffer.writeln('        result[key] = valueB;');
        buffer.writeln('      }');
      } else if (dartType == 'TextStyle') {
        buffer.writeln('      if (valueA != null && valueB != null) {');
        buffer.writeln('        result[key] = TextStyle.lerp(valueA, valueB, t) ?? valueA;');
        buffer.writeln('      } else if (valueA != null) {');
        buffer.writeln('        result[key] = valueA;');
        buffer.writeln('      } else if (valueB != null) {');
        buffer.writeln('        result[key] = valueB;');
        buffer.writeln('      }');
      } else if (dartType == 'double') {
        buffer.writeln('      final numA = valueA ?? 0.0;');
        buffer.writeln('      final numB = valueB ?? 0.0;');
        buffer.writeln('      result[key] = numA + (numB - numA) * t;');
      } else {
        buffer.writeln('      final numA = valueA ?? 0;');
        buffer.writeln('      final numB = valueB ?? 0;');
        buffer.writeln('      result[key] = (numA + (numB - numA) * t).round();');
      }
      buffer.writeln('    }');
      buffer.writeln('    ');
      buffer.writeln('    return $className(');
      for (int i = 0; i < values.length; i++) {
        final entry = values.entries.elementAt(i);
        final key = entry.key;
        final fieldName = _getFieldName(key);
        buffer.writeln("      $fieldName: result['$fieldName']!,");
      }
      final fieldNames = values.keys.map((k) => _getFieldName(k)).toList();
      buffer.writeln("      extras: Map.fromEntries(result.entries.where((e) => !['${fieldNames.join("', '")}'].contains(e.key))),");
      buffer.writeln('    );');
      buffer.writeln('  }');
      buffer.writeln();
    }
    
    // Generate default method
    buffer.writeln('  /// Create default values');
    String methodName = 'default${className.replaceAll('Fly', '').replaceAll('Token', '')}';
    buffer.writeln('  static $className $methodName() {');
    buffer.writeln('    return const $className(');
    for (int i = 0; i < values.length; i++) {
      final entry = values.entries.elementAt(i);
      final key = entry.key;
      final value = entry.value;
      final fieldName = _getFieldName(key);
      final formattedValue = _formatValue(value, dartType);
      buffer.writeln('      $fieldName: $formattedValue,');
    }
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();
    
    // Generate equality operators
    buffer.writeln('  @override');
    buffer.writeln('  bool operator ==(Object other) {');
    buffer.writeln('    if (identical(this, other)) return true;');
    buffer.writeln('    return other is $className && _allValues.toString() == other._allValues.toString();');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln('  int get hashCode => _allValues.hashCode;');
    buffer.writeln('}');
    
    return buffer.toString();
  }


  /// Convert key to valid Dart field name (camelCase)
  static String _getFieldName(String key) {
    if (key.isEmpty) {
      return 'defaultValue';
    }

    // Handle purely numeric keys (e.g., "4" -> "s4")
    if (RegExp(r'^\d+$').hasMatch(key)) {
      return 's$key';
    }

    // Handle keys that start with numbers (e.g., "2xl" -> "xl2", "3xs" -> "xs3")
    final numberPrefixMatch = RegExp(r'^(\d+)([a-zA-Z]+)$').firstMatch(key);
    if (numberPrefixMatch != null) {
      final number = numberPrefixMatch.group(1)!;
      final letters = numberPrefixMatch.group(2)!;
      return '${letters.toLowerCase()}$number';
    }

    // Convert to camelCase and handle other patterns
    final parts = key.split(RegExp(r'[^a-zA-Z0-9]+'));
    if (parts.isEmpty) return 'value';

    final firstPart = parts[0].toLowerCase();
    final remainingParts = parts.skip(1).map((part) {
      if (part.isEmpty) return '';
      return part[0].toUpperCase() + part.substring(1).toLowerCase();
    });

    return firstPart + remainingParts.join('');
  }

  /// Format value based on type
  static String _formatValue(dynamic value, String type) {
    if (type == 'int') {
      return value.toString();
    } else if (type == 'double') {
      final stringValue = value.toString();
      // If it already has a decimal point, don't add .0
      if (stringValue.contains('.')) {
        return stringValue;
      } else {
        return '${stringValue}.0';
      }
    } else {
      return value.toString();
    }
  }

  /// Download the latest Tailwind CSS theme file from GitHub
  static Future<String> downloadThemeCss([String? customUrl]) async {
    // Use the latest Tailwind CSS theme URL by default
    const defaultThemeUrl = 'https://raw.githubusercontent.com/tailwindlabs/tailwindcss/6c30d5ea3a221837ff55f6c425fb4f00f72b0941/packages/tailwindcss/theme.css';
    final themeUrl = customUrl ?? defaultThemeUrl;
    
    print('Downloading Tailwind CSS theme from GitHub...');
    print('URL: $themeUrl');
    
    try {
      final client = HttpClient();
      final request = await client.getUrl(Uri.parse(themeUrl));
      final response = await request.close();
      
      if (response.statusCode == 200) {
        final bytes = await response.fold<Uint8List>(
          Uint8List(0),
          (previous, element) => Uint8List.fromList([...previous, ...element]),
        );
        
        final cssContent = utf8.decode(bytes);
        print('Successfully downloaded theme.css (${bytes.length} bytes)');
        return cssContent;
      } else {
        throw Exception('Failed to download theme.css: HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error downloading theme.css: $e');
    }
  }

  /// Generate tokens.dart export file
  static void _generateTokensExport(String outputDir) {
    final buffer = StringBuffer();
    
    // Add warning header
    buffer.writeln('// GENERATED FILE - DO NOT EDIT MANUALLY');
    buffer.writeln('// To regenerate, run: dart cli/generate_defaults.dart');
    
    buffer.writeln();
    
    // Add exports for each token file
    for (final tokenType in _tokenConfigs.keys) {
      final fileName = tokenType.replaceAll('-', '_');
      buffer.writeln("export '${fileName}.dart';");
    }
    
    // Write the export file
    final exportFile = File('${outputDir}tokens.dart');
    exportFile.writeAsStringSync(buffer.toString());
    
    print('Generated: ${exportFile.path}');
  }
}

Future<void> main(List<String> args) async {
  // Parse command line arguments
  String? customThemeUrl;
  if (args.isNotEmpty) {
    if (args[0] == '--help' || args[0] == '-h') {
      print('Usage: dart cli/generate_defaults.dart [--url <custom-theme-url>]');
      print('');
      print('This script generates FlyWind design token classes for:');
      // print('  - breakpoints (responsive design)');
      print('  - spacing (margins and padding)');
      print('  - radius (border radius)');
      print('  - colors (color palette)');
      print('  - font (font families)');
      // print('  - container (container widths)');
      print('  - text-style (text styles with fontSize and height)');
      print('  - font-weight (font weights)');
      // print('  - tracking (letter spacing)');
      // print('  - blur (blur effects)');
      // print('  - perspective (perspective transforms)');
      print('  - aspect-video (aspect ratios)');
      print('  - leading (line heights)');
      print('');
      print('Options:');
      print('  --url, -u    Custom Tailwind CSS theme URL');
      print('  --help, -h   Show this help message');
      print('');
      print('Examples:');
      print('  dart cli/generate_defaults.dart');
      print('  dart cli/generate_defaults.dart --url https://raw.githubusercontent.com/tailwindlabs/tailwindcss/main/packages/tailwindcss/theme.css');
      print('');
      print('Generated files will be placed in lib/tokens/');
      return;
    } else if (args[0] == '--url' || args[0] == '-u') {
      if (args.length > 1) {
        customThemeUrl = args[1];
      } else {
        print('Error: --url requires a URL argument');
        exit(1);
      }
    }
  }
  
  await TokenGenerator.generateAll(customThemeUrl);
}

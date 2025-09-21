#!/usr/bin/env dart

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'converters/color_converter.dart';
import 'converters/unit_converter.dart';
import 'converters/font_converter.dart';
import 'converters/shadow_converter.dart';
import 'converters/text_shadow_converter.dart';

/// Generic token extractor that can handle any CSS property type
class TokenExtractor {
  final String cssContent;
  
  TokenExtractor(this.cssContent);

  /// Extract tokens by property prefix
  Map<String, String> extractTokens(String propertyPrefix, String conversionType, [String? filter]) {
    final tokens = <String, String>{};
    
    // Create regex pattern for the property - handle multi-line values
    // For font families, use a more specific pattern to avoid capturing complex CSS expressions
    RegExp regex;
    if (propertyPrefix == 'font' && filter == null) {
      // Only capture simple font family definitions (sans, serif, mono)
      regex = RegExp('--font-(sans|serif|mono):\\s*([^;]+);', multiLine: true, dotAll: true);
    } else if (propertyPrefix == 'spacing') {
      // Handle spacing without suffix (--spacing: value)
      regex = RegExp('--spacing:\\s*([^;]+);', multiLine: true, dotAll: true);
    } else {
      regex = RegExp('--$propertyPrefix-([^:]+):\\s*([^;]+);', multiLine: true, dotAll: true);
    }
    final matches = regex.allMatches(cssContent);
    
    for (final match in matches) {
      String tokenName;
      String tokenValue;
      
      if (propertyPrefix == 'spacing') {
        // For spacing, there's no token name, just use 'base' as the default
        tokenName = 'base';
        tokenValue = match.group(1)!.trim().replaceAll(RegExp(r'\s+'), ' ');
      } else {
        tokenName = match.group(1)!.trim();
        tokenValue = match.group(2)!.trim().replaceAll(RegExp(r'\s+'), ' ');
      }
      
      // Skip text-shadow properties when extracting text tokens
      if (propertyPrefix == 'text' && tokenName.startsWith('shadow')) {
        continue;
      }
      
      // Skip font-weight properties when extracting font tokens (they'll be handled separately)
      if (propertyPrefix == 'font' && tokenName.startsWith('weight')) {
        continue;
      }
      
      // Skip default-* properties when extracting font tokens
      if (propertyPrefix == 'font' && tokenName.startsWith('default')) {
        continue;
      }
      
      // Apply filter if specified
      if (filter != null && !tokenName.contains(filter)) {
        continue;
      }
      
      // Skip line-height properties when extracting text tokens (they'll be handled separately)
      if (propertyPrefix == 'text' && tokenName.contains('--line-height') && filter == null) {
        continue;
      }
      
      try {
        String flutterValue = _convertValue(tokenValue, conversionType);
        String cleanName = _cleanTokenName(tokenName);
        tokens[cleanName] = flutterValue;
      } catch (e) {
        print('Warning: Could not convert $propertyPrefix $tokenName ($tokenValue): $e');
      }
    }
    
    return tokens;
  }

  /// Convert CSS value to Flutter format based on type
  String _convertValue(String value, String type) {
    switch (type.toLowerCase()) {
      case 'color':
        return _convertColor(value);
      case 'unit':
      case 'spacing':
      case 'breakpoint':
      case 'container':
      case 'radius':
      case 'blur':
      case 'perspective':
        return UnitConverter.convertToDouble(value);
      case 'font':
        return FontConverter.convertFontFamily(value);
      case 'font-weight':
        return FontConverter.convertFontWeight(value);
      case 'font-size':
        return FontConverter.convertFontSize(value);
      case 'line-height':
        return FontConverter.convertLineHeight(value);
      case 'letter-spacing':
      case 'tracking':
        return FontConverter.convertLetterSpacing(value);
      case 'shadow':
      case 'inset-shadow':
      case 'drop-shadow':
        return ShadowConverter.cssShadowToFlutter(value);
      case 'text-shadow':
        return TextShadowConverter.cssTextShadowToFlutter(value);
      case 'aspect-ratio':
        return _convertAspectRatio(value);
      case 'string':
      default:
        return '"$value"';
    }
  }

  /// Convert color values
  String _convertColor(String value) {
    if (value.startsWith('oklch(')) {
      return ColorConverter.oklchToFlutterColor(value);
    } else if (value.startsWith('#')) {
      return ColorConverter.hexToFlutterColor(value);
    } else {
      return '"$value"';
    }
  }


  /// Convert aspect ratio values
  String _convertAspectRatio(String value) {
    if (value.contains('/')) {
      final parts = value.split('/');
      if (parts.length == 2) {
        final width = double.parse(parts[0].trim());
        final height = double.parse(parts[1].trim());
        return (width / height).toString();
      }
    }
    return value;
  }

  /// Clean up token names (remove double dashes, etc.)
  String _cleanTokenName(String name) {
    // Replace double dashes with single dash
    String cleaned = name.replaceAll('--', '-');
    
    // Remove "-line-height" suffix since it's redundant in line height files
    if (cleaned.endsWith('-line-height')) {
      cleaned = cleaned.replaceAll('-line-height', '');
    }
    
    return cleaned;
  }
}

/// Generate JSON content for tokens
String generateTokenJson(String name, String type, String description, Map<String, String> values) {
  final json = {
    'name': name,
    'type': type,
    'description': description,
    'imports': _getImportsForType(type),
    'values': values,
    'customValues': true,
    'customFieldName': 'custom${name.replaceAll('Fly', '')}',
    'extension': true
  };
  
  const encoder = JsonEncoder.withIndent('    ');
  return encoder.convert(json);
}

/// Get appropriate imports for token type
List<String> _getImportsForType(String type) {
  switch (type.toLowerCase()) {
    case 'color':
      return ['package:flutter/material.dart'];
    case 'font':
    case 'font-weight':
    case 'font-size':
    case 'line-height':
    case 'letter-spacing':
      return ['package:flutter/material.dart'];
    case 'boxshadow':
    case 'shadow':
      return ['package:flutter/material.dart'];
    default:
      return [];
  }
}

/// Download the latest Tailwind CSS theme file from GitHub
Future<String> downloadThemeCss([String? customUrl]) async {
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

/// Token configuration
class TokenConfig {
  final String prefix;
  final String name;
  final String type;
  final String description;
  final String conversionType;
  final String? filter;

  const TokenConfig({
    required this.prefix,
    required this.name,
    required this.type,
    required this.description,
    required this.conversionType,
    this.filter,
  });
}

Future<void> main(List<String> args) async {
  final outputDir = 'tailwind/tokens/';
  
  // Parse command line arguments
  String? customThemeUrl;
  if (args.isNotEmpty) {
    if (args[0] == '--help' || args[0] == '-h') {
      print('Usage: dart extract_tokens.dart [--url <custom-theme-url>]');
      print('');
      print('Options:');
      print('  --url, -u    Custom Tailwind CSS theme URL');
      print('  --help, -h   Show this help message');
      print('');
      print('Examples:');
      print('  dart extract_tokens.dart');
      print('  dart extract_tokens.dart --url https://raw.githubusercontent.com/tailwindlabs/tailwindcss/main/packages/tailwindcss/theme.css');
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
  
  // Define all token types to extract
  final tokenConfigs = [
    TokenConfig(
      prefix: 'color',
      name: 'FlyColors',
      type: 'Color',
      description: 'Color palette class with type-safe access to color values',
      conversionType: 'color',
    ),
    TokenConfig(
      prefix: 'breakpoint',
      name: 'FlyBreakpoints',
      type: 'double',
      description: 'Breakpoint scale class with type-safe access to breakpoint values',
      conversionType: 'breakpoint',
    ),
    TokenConfig(
      prefix: 'container',
      name: 'FlyContainers',
      type: 'double',
      description: 'Container size class with type-safe access to container values',
      conversionType: 'container',
    ),
    TokenConfig(
      prefix: 'spacing',
      name: 'FlySpacing',
      type: 'double',
      description: 'Spacing class with type-safe access to spacing values',
      conversionType: 'unit',
    ),
    TokenConfig(
      prefix: 'text',
      name: 'FlyTextSizes',
      type: 'double',
      description: 'Text size class with type-safe access to text size values',
      conversionType: 'font-size',
    ),
    TokenConfig(
      prefix: 'text',
      name: 'FlyTextLineHeights',
      type: 'double',
      description: 'Text line height class with type-safe access to line height values',
      conversionType: 'line-height',
      filter: '--line-height',
    ),
    TokenConfig(
      prefix: 'text-shadow',
      name: 'FlyTextShadows',
      type: 'Shadow',
      description: 'Text shadow class with type-safe access to text shadow values',
      conversionType: 'text-shadow',
    ),
    TokenConfig(
      prefix: 'font',
      name: 'FlyFontFamilies',
      type: 'String',
      description: 'Font family class with type-safe access to font family values',
      conversionType: 'font',
    ),
    TokenConfig(
      prefix: 'font-weight',
      name: 'FlyFontWeights',
      type: 'FontWeight',
      description: 'Font weight class with type-safe access to font weight values',
      conversionType: 'font-weight',
    ),
    TokenConfig(
      prefix: 'tracking',
      name: 'FlyLetterSpacing',
      type: 'double',
      description: 'Letter spacing class with type-safe access to letter spacing values',
      conversionType: 'tracking',
    ),
    TokenConfig(
      prefix: 'leading',
      name: 'FlyLineHeights',
      type: 'double',
      description: 'Line height class with type-safe access to line height values',
      conversionType: 'line-height',
    ),
    TokenConfig(
      prefix: 'radius',
      name: 'FlyBorderRadius',
      type: 'double',
      description: 'Border radius class with type-safe access to border radius values',
      conversionType: 'radius',
    ),
    TokenConfig(
      prefix: 'shadow',
      name: 'FlyShadows',
      type: 'BoxShadow',
      description: 'Shadow class with type-safe access to shadow values',
      conversionType: 'shadow',
    ),
    TokenConfig(
      prefix: 'inset-shadow',
      name: 'FlyInsetShadows',
      type: 'BoxShadow',
      description: 'Inset shadow class with type-safe access to inset shadow values',
      conversionType: 'inset-shadow',
    ),
    TokenConfig(
      prefix: 'drop-shadow',
      name: 'FlyDropShadows',
      type: 'BoxShadow',
      description: 'Drop shadow class with type-safe access to drop shadow values',
      conversionType: 'drop-shadow',
    ),
    TokenConfig(
      prefix: 'blur',
      name: 'FlyBlurs',
      type: 'double',
      description: 'Blur class with type-safe access to blur values',
      conversionType: 'blur',
    ),
    TokenConfig(
      prefix: 'perspective',
      name: 'FlyPerspectives',
      type: 'double',
      description: 'Perspective class with type-safe access to perspective values',
      conversionType: 'perspective',
    ),
    TokenConfig(
      prefix: 'aspect-video',
      name: 'FlyAspectRatios',
      type: 'double',
      description: 'Aspect ratio class with type-safe access to aspect ratio values',
      conversionType: 'aspect-ratio',
    ),
  ];

  // Download the latest theme.css from GitHub
  String cssContent;
  try {
    cssContent = await downloadThemeCss(customThemeUrl);
  } catch (e) {
    print('Error: $e');
    exit(1);
  }
  
  final extractor = TokenExtractor(cssContent);

  // Create output directory if it doesn't exist
  final outputDirFile = Directory(outputDir);
  if (!outputDirFile.existsSync()) {
    outputDirFile.createSync(recursive: true);
  }

  int totalTokens = 0;
  
  for (final config in tokenConfigs) {
    print('Extracting ${config.prefix} tokens...');
    final tokens = extractor.extractTokens(config.prefix, config.conversionType, config.filter);
    
    if (tokens.isNotEmpty) {
      print('Found ${tokens.length} ${config.prefix} tokens');
      
      // Generate JSON content
      final jsonContent = generateTokenJson(
        config.name,
        config.type,
        config.description,
        tokens,
      );
      
      // Write to output file
      String outputPath = '${outputDir}${config.prefix}.json';
      if (config.filter != null) {
        // Use a more descriptive name for filtered tokens
        outputPath = '${outputDir}${config.prefix}-${config.filter!.replaceAll('--', '')}.json';
      }
      final outputFile = File(outputPath);
      outputFile.writeAsStringSync(jsonContent);
      
      print('Generated: $outputPath');
      totalTokens += tokens.length;
      
      // Print some examples
      print('Sample ${config.prefix} tokens:');
      final sampleTokens = tokens.entries.take(3).toList();
      for (final entry in sampleTokens) {
        print('  ${entry.key}: ${entry.value}');
      }
      print('');
    } else {
      print('No ${config.prefix} tokens found');
    }
  }

  print('Token generation completed!');
  print('Total tokens generated: $totalTokens');
  
  // Generate fly_config.json file
  await generateFlyConfig(tokenConfigs, outputDir);
}

/// Generate fly_config.json file for token overrides
Future<void> generateFlyConfig(List<TokenConfig> tokenConfigs, String outputDir) async {
  print('Generating fly_config.json...');
  
  final configMap = <String, Map<String, dynamic>>{};
  
  // Create config structure for each token type
  for (final config in tokenConfigs) {
    configMap[config.prefix] = {
      'type': config.type,
      'values': <String, dynamic>{},
    };
  }
  
  final flyConfig = {
    'app_name': 'Flywind',
    'tokens': configMap,
  };
  
  // Generate JSON content
  const encoder = JsonEncoder.withIndent('    ');
  final jsonContent = encoder.convert(flyConfig);
  
  // Write the JSON file
  final configFile = File('${outputDir}config.json');
  configFile.writeAsStringSync(jsonContent);
  
  print('Generated: ${outputDir}config.json');
  print('You can now override default token values by adding them to the "values" object for each token type');
  print('');
  print('Example usage:');
  print('  "color": {');
  print('    "type": "Color",');
  print('    "values": {');
  print('      "brand-primary": "Color(0xFF007AFF)",');
  print('      "brand-secondary": "Color(0xFF34C759)"');
  print('    }');
  print('  }');
}

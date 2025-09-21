#!/usr/bin/env dart

import 'dart:convert';
import 'dart:io';

/// Custom token generator for FlyWind
///
/// This script generates custom tokens that extend the default FlyWind tokens
/// with dot notation and array lookup support.
void main(List<String> args) async {
  print('🎨 Generating custom FlyWind tokens...');

  // Check if we're in a Flutter project
  if (!File('pubspec.yaml').existsSync()) {
    print('❌ Error: Not in a Flutter project directory');
    print('   Please run this command from your Flutter project root');
    exit(1);
  }

  // Check if fly-config.yaml exists
  final configFile = File('fly-config.yaml');
  if (!configFile.existsSync()) {
    print('❌ Error: fly-config.yaml not found');
    print('   Please create a fly-config.yaml file in your project root');
    print('');
    print('Example fly-config.yaml:');
    print('''
extend:
  colors:
    brand-primary: '#FF6B35'
    brand-secondary: '#004E89'
    semantic-success: '#10B981'
  
  spacing:
    xs: '2'
    sm: '4'
    md: '8'
''');
    exit(1);
  }

  // Ensure custom_tokens directory exists
  final customTokensDir = Directory('lib/custom_tokens');
  if (!customTokensDir.existsSync()) {
    customTokensDir.createSync(recursive: true);
    print('📁 Created lib/custom_tokens directory');
  }

  // Load configuration
  final config = await _loadConfig(configFile);
  if (config == null) {
    print('❌ Error: Could not load configuration from fly-config.dart');
    exit(1);
  }

  // Generate custom tokens
  final extendConfig = config['extend'] as Map<String, dynamic>? ?? {};
  int generatedFiles = 0;

  for (final entry in extendConfig.entries) {
    final tokenType = entry.key;
    final customValues = entry.value as Map<String, dynamic>;

    if (customValues.isEmpty) continue;

    try {
      final generatedCode = _generateCustomTokenClass(tokenType, customValues);
      final outputFile = File('lib/custom_tokens/custom_${tokenType}.dart');
      outputFile.writeAsStringSync(generatedCode);
      generatedFiles++;
      print('✅ Generated lib/custom_tokens/custom_${tokenType}.dart');
    } catch (e) {
      print('❌ Error generating custom_${tokenType}.dart: $e');
    }
  }

  // Generate custom_tokens.dart export file
  if (generatedFiles > 0) {
    _generateCustomTokensExport(customTokensDir, extendConfig.keys.toList());
    print('✅ Generated lib/custom_tokens/custom_tokens.dart');
  }

  print('');
  if (generatedFiles > 0) {
    print('🎉 Successfully generated $generatedFiles custom token file(s)!');
    print('');
    print('Usage in your Flutter app:');
    print('  import \'package:your_app/custom_tokens/custom_tokens.dart\';');
    print('');
    print('Example usage:');
    print('  final colors = FlyColors.defaultColors;');
    print('  colors.brandPrimary;  // Dot notation');
    print('  colors[\'brand-primary\'];  // Array lookup');
  } else {
    print('⚠️  No custom tokens were generated');
    print('   Make sure your fly-config.yaml has an \'extend\' section with values');
  }
}

/// Load configuration from fly-config.yaml
Future<Map<String, dynamic>?> _loadConfig(File configFile) async {
  try {
    final content = await configFile.readAsString();
    
    // Simple YAML parsing - look for the extend section
    final lines = content.split('\n');
    final Map<String, dynamic> extend = {};
    
    String? currentSection;
    Map<String, String>? currentValues;
    
    for (final line in lines) {
      final trimmed = line.trim();
      
      // Skip empty lines and comments
      if (trimmed.isEmpty || trimmed.startsWith('#')) continue;
      
      // Check for section headers (colors:, spacing:, etc.)
      if (trimmed.endsWith(':')) {
        // Save previous section
        if (currentSection != null && currentValues != null) {
          extend[currentSection] = currentValues;
        }
        
        // Start new section (skip 'extend:' as it's the root)
        final sectionName = trimmed.substring(0, trimmed.length - 1).trim();
        if (sectionName != 'extend') {
          currentSection = sectionName;
          currentValues = <String, String>{};
        }
        continue;
      }
      
      // Parse key-value pairs
      if (currentSection != null && currentValues != null) {
        final colonIndex = trimmed.indexOf(':');
        if (colonIndex > 0) {
          final key = trimmed.substring(0, colonIndex).trim();
          final value = trimmed.substring(colonIndex + 1).trim();
          // Use value as-is (quotes will be handled in generation)
          currentValues[key] = value;
        }
      }
    }
    
    // Save last section
    if (currentSection != null && currentValues != null) {
      extend[currentSection] = currentValues;
    }
    
    print('📄 Parsed YAML config:');
    print('📄 Extend map: $extend');
    return {'extend': extend};
  } catch (e) {
    print('❌ Error parsing fly-config.yaml: $e');
    return null;
  }
}

/// Generate custom token class with dot notation and array lookup
String _generateCustomTokenClass(String tokenType, Map<String, dynamic> customValues) {
  final className = 'Custom${_capitalize(tokenType)}';
  
  final buffer = StringBuffer();

  // Add warning header
  buffer.writeln('// GENERATED FILE - DO NOT EDIT MANUALLY');
  buffer.writeln('// This file was generated by FlyWind Custom Token Generator');
  buffer.writeln('// To modify this file, edit fly-config.dart and run: dart tailwind/generate_custom_tokens.dart');
  buffer.writeln('//');
  buffer.writeln('// Generated on: ${DateTime.now().toIso8601String()}');
  buffer.writeln();

  // Add imports
  // Handle special cases for file names and class names
  final importFile = tokenType == 'colors' ? 'color' : tokenType;
  final defaultClassName = tokenType == 'radius' ? 'FlyBorderRadius' : 'Fly${_capitalize(tokenType)}';
  buffer.writeln("import '../tokens/${importFile}.dart';");
  buffer.writeln();

  // Generate CustomColors class
  buffer.writeln('/// Custom $tokenType tokens with direct property access');
  buffer.writeln('class $className {');
  buffer.writeln('  const $className._();');
  buffer.writeln();

  // Generate static properties for each custom value
  for (final entry in customValues.entries) {
    final propertyName = _getPropertyName(entry.key);
    final value = entry.value;
    buffer.writeln('  /// Custom $tokenType: ${entry.key}');
    buffer.writeln('  static const String $propertyName = $value;');
  }

  buffer.writeln();

  // Generate values map
  buffer.writeln('  /// All custom $tokenType values as a map');
  buffer.writeln('  static const Map<String, String> values = {');
  for (final entry in customValues.entries) {
    final propertyName = _getPropertyName(entry.key);
    final key = entry.key;
    buffer.writeln("    '$key': $propertyName,");
  }
  buffer.writeln('  };');
  buffer.writeln('}');
  buffer.writeln();

  // Generate extension for dot notation
  buffer.writeln('/// Extension that adds custom $tokenType tokens to default $defaultClassName');
  buffer.writeln('extension Custom${_capitalize(tokenType)}Extension on $defaultClassName {');
  buffer.writeln();

  // Generate property getters for dot notation
  for (final entry in customValues.entries) {
    final propertyName = _getPropertyName(entry.key);
    buffer.writeln('  /// Custom $tokenType: ${entry.key}');
    buffer.writeln('  String get $propertyName => $className.$propertyName;');
  }

  buffer.writeln();

  // Generate allValues getter that includes both default and custom
  buffer.writeln('  /// Get all $tokenType values (default + custom) as a map');
  buffer.writeln('  Map<String, String> get all${_capitalize(tokenType)} => {');
  buffer.writeln('    ...this.values,');
  buffer.writeln('    ...$className.values,');
  buffer.writeln('  };');
  buffer.writeln();

  // Generate array lookup operator that includes custom values
  buffer.writeln('  /// Access any $tokenType value by key (default or custom)');
  buffer.writeln('  String? operator [](String key) => all${_capitalize(tokenType)}[key];');
  buffer.writeln('}');

  return buffer.toString();
}

/// Generate custom_tokens.dart export file
void _generateCustomTokensExport(Directory outputDir, List<String> tokenTypes) {
  final buffer = StringBuffer();
  
  // Add warning header
  buffer.writeln('// GENERATED FILE - DO NOT EDIT MANUALLY');
  buffer.writeln('// This file was generated by FlyWind Custom Token Generator');
  buffer.writeln('// To modify this file, edit fly-config.dart and run: dart tailwind/generate_custom_tokens.dart');
  buffer.writeln('//');
  buffer.writeln('// Generated on: ${DateTime.now().toIso8601String()}');
  buffer.writeln();
  
  // Add exports for each custom token file
  for (final tokenType in tokenTypes) {
    buffer.writeln("export 'custom_${tokenType}.dart';");
  }
  
  // Write the export file
  final exportFile = File('${outputDir.path}/custom_tokens.dart');
  exportFile.writeAsStringSync(buffer.toString());
}

/// Convert key to valid Dart property name (camelCase)
String _getPropertyName(String key) {
  if (key.isEmpty) return 'value';

  // Handle special cases
  if (key == '2xl') return 'xl2';
  if (key == '3xl') return 'xl3';

  // Handle numeric keys
  if (RegExp(r'^\d+$').hasMatch(key)) {
    return 's$key';
  }

  // Convert kebab-case to camelCase
  final parts = key.split('-');
  if (parts.isEmpty) return 'value';
  
  final firstPart = parts[0].toLowerCase();
  final remainingParts = parts.skip(1).map((part) {
    if (part.isEmpty) return '';
    return part[0].toUpperCase() + part.substring(1).toLowerCase();
  });
  
  return firstPart + remainingParts.join('');
}

/// Capitalize first letter of string
String _capitalize(String str) {
  if (str.isEmpty) return str;
  return str[0].toUpperCase() + str.substring(1);
}

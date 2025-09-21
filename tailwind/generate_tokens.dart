#!/usr/bin/env dart

import 'dart:convert';
import 'dart:io';

/// Code generator for FlyWind design tokens
///
/// This script reads JSON configuration files and generates Dart classes
/// for design tokens like colors, spacing, and border radius.
void main(List<String> args) {
  final tokensDir = Directory('tailwind/tokens');
  final outputDir = Directory('lib/tokens');

  // Ensure output directory exists
  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }

  // Load master config file
  final configFile = File('${tokensDir.path}/config.json');
  Map<String, dynamic> masterConfig = {};
  
  if (configFile.existsSync()) {
    try {
      masterConfig = _loadConfig(configFile);
      print('Loaded master config from: ${configFile.path}');
    } catch (e) {
      print('Warning: Could not load config.json: $e');
    }
  } else {
    print('Warning: No config.json found, proceeding without config overrides');
  }

  // Find all JSON files in tokens directory (excluding config.json)
  final jsonFiles = tokensDir
      .listSync()
      .whereType<File>()
      .where((file) => file.path.endsWith('.json') && !file.path.endsWith('config.json'))
      .toList();

  if (jsonFiles.isEmpty) {
    print('No JSON configuration files found in tokens/ directory');
    return;
  }

  print('Found ${jsonFiles.length} token configuration files:');
  for (final file in jsonFiles) {
    print('  - ${file.path}');
  }

  // Generate classes for each token file
  for (final jsonFile in jsonFiles) {
    try {
      final tokenConfig = _loadConfig(jsonFile);
      final mergedConfig = _mergeWithConfig(tokenConfig, masterConfig);
      final generatedCode = _generateClass(mergedConfig);

      final outputFile = File(
        '${outputDir.path}/${_getOutputFileName(jsonFile)}',
      );
      outputFile.writeAsStringSync(generatedCode);

      print('Generated: ${outputFile.path}');
    } catch (e) {
      print('Error processing ${jsonFile.path}: $e');
    }
  }

  // Generate tokens.dart export file
  _generateTokensExport(outputDir, jsonFiles);

  print('\nToken generation complete!');
}

/// Load and parse JSON configuration
Map<String, dynamic> _loadConfig(File jsonFile) {
  final content = jsonFile.readAsStringSync();
  return jsonDecode(content) as Map<String, dynamic>;
}

/// Merge token configuration with master config overrides
Map<String, dynamic> _mergeWithConfig(
  Map<String, dynamic> tokenConfig,
  Map<String, dynamic> masterConfig,
) {
  // Start with the token config as base
  final merged = Map<String, dynamic>.from(tokenConfig);
  
  // Get the token name to look up in master config
  final tokenName = tokenConfig['name'] as String?;
  if (tokenName == null) return merged;
  
  // Extract the token type from the name (e.g., "FlyColors" -> "color")
  final tokenType = _extractTokenType(tokenName);
  
  // Look up the token type in master config
  final tokens = masterConfig['tokens'] as Map<String, dynamic>?;
  if (tokens == null) return merged;
  
  final configOverride = tokens[tokenType] as Map<String, dynamic>?;
  if (configOverride == null) return merged;
  
  // Apply overrides from config
  for (final entry in configOverride.entries) {
    final key = entry.key;
    final value = entry.value;
    
    // Special handling for 'values' - merge them instead of replacing
    if (key == 'values' && value is Map<String, dynamic>) {
      final existingValues = merged['values'] as Map<String, dynamic>? ?? {};
      merged['values'] = {...existingValues, ...value};
    } else {
      // For other properties, override if they exist in config
      merged[key] = value;
    }
  }
  
  return merged;
}

/// Extract token type from class name (e.g., "FlyColors" -> "color")
String _extractTokenType(String className) {
  // Remove "Fly" prefix and convert to lowercase
  final withoutFly = className.startsWith('Fly') 
      ? className.substring(3) 
      : className;
  
  // Convert PascalCase to kebab-case
  final result = withoutFly
      .replaceAllMapped(RegExp(r'([A-Z])'), (match) => '-${match.group(1)!.toLowerCase()}')
      .replaceFirst(RegExp(r'^-'), '');
  
  return result;
}

/// Get output file name from input JSON file
String _getOutputFileName(File jsonFile) {
  final baseName = jsonFile.path.split('/').last.split('.').first;
  return '${baseName}.dart';
}

/// Generate Dart class from configuration
String _generateClass(Map<String, dynamic> config) {
  final className = config['name'] as String;
  // Force all types to be String regardless of what's specified in the config
  final type = 'String';
  final description = config['description'] as String? ?? '';
  final values = config['values'] as Map<String, dynamic>;
  final customValues = config['customValues'] as bool? ?? false;
  final customFieldName =
      config['customFieldName'] as String? ?? 'customValues';
  final indexedAccess = config['indexedAccess'] as bool? ?? false;
  final indexType = config['indexType'] as String? ?? 'String';
  final imports =
      (config['imports'] as List<dynamic>?)?.cast<String>() ?? <String>[];
  final methods = config['methods'] as Map<String, dynamic>? ?? {};
  final extension = config['extension'] as bool? ?? false;

  final buffer = StringBuffer();

  // Add warning header
  buffer.writeln('// GENERATED FILE - DO NOT EDIT MANUALLY');
  buffer.writeln('// This file was generated by FlyWind CLI');
  buffer.writeln(
    '// To modify this file, edit the JSON configuration in tokens/ directory and run: dart tool/generate_tokens.dart',
  );
  buffer.writeln('//');
  buffer.writeln();

  // Add imports (but skip Flutter Material imports since we're using String types)
  for (final import in imports) {
    if (!import.contains('package:flutter/material.dart')) {
      buffer.writeln("import '$import';");
    }
  }
  if (imports.any((import) => !import.contains('package:flutter/material.dart'))) {
    buffer.writeln();
  }

  // Add class documentation
  if (description.isNotEmpty) {
    buffer.writeln('/// $description');
  }

  // Generate class
  buffer.writeln('class $className {');
  buffer.writeln('  const $className({');

  // Generate constructor parameters
  final fieldNames = <String>[];
  for (final entry in values.entries) {
    final key = entry.key;
    final fieldName = _getFieldName(key);
    fieldNames.add(fieldName);

    buffer.writeln('    required this.$fieldName,');
  }

  if (customValues) {
    buffer.writeln('    this.$customFieldName = const {},');
  }

  buffer.writeln('  });');
  buffer.writeln();

  // Generate field declarations
  for (int i = 0; i < values.length; i++) {
    final entry = values.entries.elementAt(i);
    final key = entry.key;
    final fieldName = _getFieldName(key);
    buffer.writeln('  final $type $fieldName;');
  }

  if (customValues) {
    final customType = indexedAccess
        ? 'Map<$indexType, $type>'
        : 'Map<String, $type>';
    buffer.writeln('  final $customType $customFieldName;');
  }

  buffer.writeln();

  // Generate values getter
  if (indexedAccess) {
    buffer.writeln('  /// Get all values as a map');
    buffer.writeln('  Map<$indexType, $type> get values => {');
    for (final entry in values.entries) {
      final key = entry.key;
      final fieldName = _getFieldName(key);
      final indexValue = _getIndexValue(key, indexType);
      buffer.writeln('    $indexValue: $fieldName,');
    }
    buffer.writeln('  };');
  } else {
    buffer.writeln('  /// Get all values as a map');
    buffer.writeln('  Map<String, $type> get values => {');
    for (final entry in values.entries) {
      final key = entry.key;
      final fieldName = _getFieldName(key);
      final mapKey = key.isEmpty ? "''" : "'${_getFieldName(key)}'";
      buffer.writeln('    $mapKey: $fieldName,');
    }
    if (customValues) {
      buffer.writeln('    ...$customFieldName,');
    }
    buffer.writeln('  };');
  }

  buffer.writeln();

  // Generate operator[] method
  if (indexedAccess) {
    buffer.writeln('  /// Access values by index');
    buffer.writeln('  $type? operator []($indexType index) => values[index];');
  } else {
    buffer.writeln('  /// Access values by key');
    if (customValues) {
      buffer.writeln(
        '  $type? operator [](String key) => values[key] ?? $customFieldName[key];',
      );
    } else {
      buffer.writeln('  $type? operator [](String key) => values[key];');
    }
  }

  buffer.writeln();

  // Generate custom methods
  for (final methodEntry in methods.entries) {
    final methodName = methodEntry.key;
    final methodConfig = methodEntry.value as Map<String, dynamic>;
    final returnType = methodConfig['returnType'] as String;
    final methodDescription = methodConfig['description'] as String? ?? '';

    if (methodDescription.isNotEmpty) {
      buffer.writeln('  /// $methodDescription');
    }

    if (methodName == 'getValue' && type == 'String') {
      buffer.writeln('  $returnType $methodName(String key) {');
      buffer.writeln('    final stringValue = values[key];');
      buffer.writeln('    if (stringValue == null) return null;');
      buffer.writeln('    return double.tryParse(stringValue);');
      buffer.writeln('  }');
    }

    buffer.writeln();
  }

  // Generate copyWith method
  buffer.writeln('  /// Create a copy with updated values');
  buffer.writeln('  $className copyWith({');

  for (final entry in values.entries) {
    final key = entry.key;
    final fieldName = _getFieldName(key);
    buffer.writeln('    $type? $fieldName,');
  }

  if (customValues) {
    final customType = indexedAccess
        ? 'Map<$indexType, $type>?'
        : 'Map<String, $type>?';
    buffer.writeln('    $customType $customFieldName,');
  }

  buffer.writeln('  }) {');
  buffer.writeln('    return $className(');

  for (final entry in values.entries) {
    final key = entry.key;
    final fieldName = _getFieldName(key);
    buffer.writeln('      $fieldName: $fieldName ?? this.$fieldName,');
  }

  if (customValues) {
    buffer.writeln(
      '      $customFieldName: $customFieldName ?? this.$customFieldName,',
    );
  }

  buffer.writeln('    );');
  buffer.writeln('  }');
  buffer.writeln();

  // Generate static default constant
  buffer.writeln('  /// Default $className instance');
  buffer.writeln(
    '  static const $className default${className.replaceAll('Fly', '')} = $className(',
  );

  for (final entry in values.entries) {
    final key = entry.key;
    final fieldName = _getFieldName(key);
    final value = entry.value;
    final formattedValue = _formatValue(value, type);
    buffer.writeln('    $fieldName: $formattedValue,');
  }

  buffer.writeln('  );');
  buffer.writeln('}');

  // Generate extension if requested
  if (extension) {
    buffer.writeln();
    buffer.writeln(
      '/// Extension on $className to easily override specific values',
    );
    buffer.writeln('extension ${className}Extension on $className {');
    buffer.writeln(
      '  /// Create a new $className instance with specific value overrides',
    );
    buffer.writeln('  $className copyWith({');

    for (final entry in values.entries) {
      final key = entry.key;
      final fieldName = _getFieldName(key);
      buffer.writeln('    $type? $fieldName,');
    }

    if (customValues) {
      final customType = indexedAccess
          ? 'Map<$indexType, $type>?'
          : 'Map<String, $type>?';
      buffer.writeln('    $customType $customFieldName,');
    }

    buffer.writeln('  }) {');
    buffer.writeln('    return $className(');

    for (final entry in values.entries) {
      final key = entry.key;
      final fieldName = _getFieldName(key);
      buffer.writeln('      $fieldName: $fieldName ?? this.$fieldName,');
    }

    if (customValues) {
      buffer.writeln(
        '      $customFieldName: $customFieldName ?? this.$customFieldName,',
      );
    }

    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln('}');
  }

  return buffer.toString();
}

/// Convert key to valid Dart field name
String _getFieldName(String key) {
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

/// Convert key to index value for indexed access
String _getIndexValue(String key, String indexType) {
  if (indexType == 'int') {
    return key;
  }
  return "'$key'";
}

/// Format value based on type
String _formatValue(dynamic value, String type) {
  // Since we're forcing all types to be String, always format as string
  // But for Color values, extract the hex value from Color(...) format
  if (value.toString().startsWith('Color(0x') && value.toString().endsWith(')')) {
    // Extract hex value from Color(0xFF5733) format
    final colorString = value.toString();
    final hexMatch = RegExp(r'Color\(0x([A-Fa-f0-9]+)\)').firstMatch(colorString);
    if (hexMatch != null) {
      final hexValue = hexMatch.group(1)!;
      return "'#$hexValue'";
    }
  }
  return "'$value'";
}

/// Generate tokens.dart export file
void _generateTokensExport(Directory outputDir, List<File> jsonFiles) {
  final buffer = StringBuffer();
  
  // Add warning header
  buffer.writeln('// GENERATED FILE - DO NOT EDIT MANUALLY');
  buffer.writeln('// This file was generated by FlyWind CLI');
  buffer.writeln(
    '// To modify this file, edit the JSON configuration in tokens/ directory and run: dart tailwind/generate_tokens.dart',
  );
  buffer.writeln('//');
  buffer.writeln();
  
  // Add exports for each token file
  for (final jsonFile in jsonFiles) {
    final fileName = _getOutputFileName(jsonFile);
    buffer.writeln("export '$fileName';");
  }
  
  // Write the export file
  final exportFile = File('${outputDir.path}/tokens.dart');
  exportFile.writeAsStringSync(buffer.toString());
  
  print('Generated: ${exportFile.path}');
}

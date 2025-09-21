#!/usr/bin/env dart

import 'dart:convert';
import 'dart:io';

/// FlyWind CLI - Design token management for Flutter projects
///
/// Usage:
///   fly init     - Initialize FlyWind in your project
///   fly generate - Generate Dart classes from JSON tokens
///   fly help     - Show help information
void main(List<String> args) async {
  if (args.isEmpty) {
    _showHelp();
    return;
  }

  final command = args[0].toLowerCase();

  switch (command) {
    case 'init':
      await _initCommand(args.skip(1).toList());
      break;
    case 'generate':
    case 'gen':
      await _generateCommand(args.skip(1).toList());
      break;
    case 'help':
    case '--help':
    case '-h':
      _showHelp();
      break;
    default:
      print('❌ Unknown command: $command');
      print('');
      _showHelp();
      exit(1);
  }
}

/// Initialize FlyWind in the current project
Future<void> _initCommand(List<String> args) async {
  print('🎨 Initializing FlyWind in your project...');

  // Check if we're in a Flutter project
  if (!File('pubspec.yaml').existsSync()) {
    print('❌ Error: Not in a Flutter project directory');
    print('   Please run this command from your Flutter project root');
    exit(1);
  }

  // Check if flywind is already initialized
  if (Directory('fly').existsSync()) {
    print('⚠️  FlyWind is already initialized in this project');
    print('   The fly/ directory already exists');

    stdout.write('   Do you want to overwrite existing files? (y/N): ');
    final input = stdin.readLineSync()?.toLowerCase();
    if (input != 'y' && input != 'yes') {
      print('   Initialization cancelled');
      return;
    }
  }

  // Create fly directory
  final flyDir = Directory('fly');
  if (!flyDir.existsSync()) {
    flyDir.createSync();
  }

  // Copy JSON template files
  final templateFiles = ['border_radius.json', 'spacing.json', 'colors.json'];

  int copiedFiles = 0;
  for (final fileName in templateFiles) {
    try {
      final templateContent = _getTemplateContent(fileName);
      final outputFile = File('fly/$fileName');
      outputFile.writeAsStringSync(templateContent);
      copiedFiles++;
      print('   ✅ Created fly/$fileName');
    } catch (e) {
      print('   ❌ Failed to create fly/$fileName: $e');
    }
  }

  // Create fly/generate.dart script
  final generateScript = _getGenerateScript();
  final generateFile = File('fly/generate.dart');
  generateFile.writeAsStringSync(generateScript);
  print('   ✅ Created fly/generate.dart');

  // Create fly/README.md
  final readmeContent = _getReadmeContent();
  final readmeFile = File('fly/README.md');
  readmeFile.writeAsStringSync(readmeContent);
  print('   ✅ Created fly/README.md');

  print('');
  print('🎉 FlyWind initialized successfully!');
  print('');
  print('Next steps:');
  print('  1. Customize the JSON files in fly/ directory');
  print('  2. Run: fly generate');
  print('  3. Import and use the generated classes in your Flutter app');
  print('');
  print('📖 See fly/README.md for more information');
}

/// Generate Dart classes from JSON tokens
Future<void> _generateCommand(List<String> args) async {
  print('🔧 Generating FlyWind design tokens...');

  // Check if fly directory exists
  if (!Directory('fly').existsSync()) {
    print('❌ Error: FlyWind not initialized in this project');
    print('   Run "fly init" first to set up FlyWind');
    exit(1);
  }

  // Check if we're in a Flutter project
  if (!File('pubspec.yaml').existsSync()) {
    print('❌ Error: Not in a Flutter project directory');
    print('   Please run this command from your Flutter project root');
    exit(1);
  }

  // Ensure lib/tokens directory exists
  final tokensDir = Directory('lib/tokens');
  if (!tokensDir.existsSync()) {
    tokensDir.createSync(recursive: true);
  }

  // Find JSON files in fly directory
  final flyDir = Directory('fly');
  final jsonFiles = flyDir
      .listSync()
      .whereType<File>()
      .where((file) => file.path.endsWith('.json'))
      .toList();

  if (jsonFiles.isEmpty) {
    print('❌ Error: No JSON configuration files found in fly/ directory');
    print('   Run "fly init" to create template files');
    exit(1);
  }

  print('   Found ${jsonFiles.length} token configuration files:');
  for (final file in jsonFiles) {
    print('     - ${file.path}');
  }

  // Generate classes for each token file
  int generatedFiles = 0;
  for (final jsonFile in jsonFiles) {
    try {
      final config = _loadConfig(jsonFile);
      final generatedCode = _generateClass(config);

      final outputFile = File('lib/tokens/${_getOutputFileName(jsonFile)}');
      outputFile.writeAsStringSync(generatedCode);
      generatedFiles++;
      print('   ✅ Generated lib/tokens/${_getOutputFileName(jsonFile)}');
    } catch (e) {
      print('   ❌ Error processing ${jsonFile.path}: $e');
    }
  }

  print('');
  if (generatedFiles > 0) {
    print('🎉 Successfully generated $generatedFiles token class(es)!');
    print('');
    print('Usage in your Flutter app:');
    print('  import \'package:your_app/tokens/colors.dart\';');
    print('  import \'package:your_app/tokens/spacing.dart\';');
    print('  import \'package:your_app/tokens/border_radius.dart\';');
  } else {
    print('❌ No files were generated');
    exit(1);
  }
}

/// Show help information
void _showHelp() {
  print('''
🎨 FlyWind CLI - Design token management for Flutter

USAGE:
    fly <command> [options]

COMMANDS:
    init        Initialize FlyWind in your project
    generate    Generate Dart classes from JSON tokens
    help        Show this help message

EXAMPLES:
    fly init                    # Initialize FlyWind
    fly generate                # Generate token classes
    fly gen                     # Short form of generate

For more information, visit: https://github.com/realflyui/flywind
''');
}

/// Load and parse JSON configuration
Map<String, dynamic> _loadConfig(File jsonFile) {
  final content = jsonFile.readAsStringSync();
  return jsonDecode(content) as Map<String, dynamic>;
}

/// Get output file name from input JSON file
String _getOutputFileName(File jsonFile) {
  final baseName = jsonFile.path.split('/').last.split('.').first;
  return '${baseName}.dart';
}

/// Get template content for a given file
String _getTemplateContent(String fileName) {
  switch (fileName) {
    case 'border_radius.json':
      return '''{
  "name": "FlyBorderRadius",
  "type": "String",
  "defaultValue": "4",
  "description": "Border radius scale class with type-safe access to radius values",
  "values": {
    "none": "0",
    "sm": "2",
    "md": "6",
    "lg": "8",
    "xl": "12",
    "2xl": "16",
    "3xl": "24",
    "full": "9999",
    "": "4"
  },
  "customValues": true,
  "customFieldName": "customBorderRadius",
  "methods": {
    "getValue": {
      "returnType": "double?",
      "description": "Get the actual double value for a given key"
    }
  }
}''';

    case 'spacing.json':
      return '''{
  "name": "FlySpacing",
  "type": "String",
  "description": "Spacing scale class with type-safe access to spacing values",
  "values": {
    "0": "0",
    "1": "4",
    "2": "8",
    "3": "12",
    "4": "16",
    "5": "20",
    "6": "24",
    "7": "28",
    "8": "32",
    "9": "36",
    "10": "40",
    "11": "44",
    "12": "48"
  },
  "customValues": true,
  "customFieldName": "customSpacing",
  "indexedAccess": true,
  "indexType": "int"
}''';

    case 'colors.json':
      return '''{
  "name": "FlyColors",
  "type": "Color",
  "description": "Color palette class with type-safe access to color values",
  "imports": ["package:flutter/material.dart"],
  "values": {
    "inherit": "Color(0x00000000)",
    "current": "Color(0x00000000)",
    "transparent": "Color(0x00000000)",
    "black": "Color(0xFF000000)",
    "white": "Color(0xFFFFFFFF)",
    "red50": "Color(0xFFFEF2F2)",
    "red100": "Color(0xFFFEE2E2)",
    "red200": "Color(0xFFFECACA)",
    "red300": "Color(0xFFFCA5A5)",
    "red400": "Color(0xFFF87171)",
    "red500": "Color(0xFFEF4444)",
    "red600": "Color(0xFFDC2626)",
    "red700": "Color(0xFFB91C1C)",
    "red800": "Color(0xFF991B1B)",
    "red900": "Color(0xFF7F1D1D)",
    "red950": "Color(0xFF450A0A)",
    "blue50": "Color(0xFFEFF6FF)",
    "blue100": "Color(0xFFDBEAFE)",
    "blue200": "Color(0xFFBFDBFE)",
    "blue300": "Color(0xFF93C5FD)",
    "blue400": "Color(0xFF60A5FA)",
    "blue500": "Color(0xFF3B82F6)",
    "blue600": "Color(0xFF2563EB)",
    "blue700": "Color(0xFF1D4ED8)",
    "blue800": "Color(0xFF1E40AF)",
    "blue900": "Color(0xFF1E3A8A)",
    "blue950": "Color(0xFF172554)"
  },
  "customValues": true,
  "customFieldName": "customColors",
  "extension": true
}''';

    default:
      throw Exception('Unknown template file: $fileName');
  }
}

/// Get the generate script content
String _getGenerateScript() {
  return '''#!/usr/bin/env dart

import 'dart:convert';
import 'dart:io';

/// Code generator for FlyWind design tokens
/// 
/// This script reads JSON configuration files and generates Dart classes
/// for design tokens like colors, spacing, and border radius.
void main(List<String> args) {
  final tokensDir = Directory('fly');
  final outputDir = Directory('lib/tokens');
  
  // Ensure output directory exists
  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }
  
  // Find all JSON files in fly directory
  final jsonFiles = tokensDir
      .listSync()
      .whereType<File>()
      .where((file) => file.path.endsWith('.json'))
      .toList();
  
  if (jsonFiles.isEmpty) {
    print('No JSON configuration files found in fly/ directory');
    return;
  }
  
  print('Found \${jsonFiles.length} token configuration files:');
  for (final file in jsonFiles) {
    print('  - \${file.path}');
  }
  
  // Generate classes for each token file
  for (final jsonFile in jsonFiles) {
    try {
      final config = _loadConfig(jsonFile);
      final generatedCode = _generateClass(config);
      
      final outputFile = File('\${outputDir.path}/\${_getOutputFileName(jsonFile)}');
      outputFile.writeAsStringSync(generatedCode);
      
      print('Generated: \${outputFile.path}');
    } catch (e) {
      print('Error processing \${jsonFile.path}: \$e');
    }
  }
  
  print('\\nToken generation complete!');
}

/// Load and parse JSON configuration
Map<String, dynamic> _loadConfig(File jsonFile) {
  final content = jsonFile.readAsStringSync();
  return jsonDecode(content) as Map<String, dynamic>;
}

/// Get output file name from input JSON file
String _getOutputFileName(File jsonFile) {
  final baseName = jsonFile.path.split('/').last.split('.').first;
  return '\${baseName}.dart';
}

/// Generate Dart class from configuration
String _generateClass(Map<String, dynamic> config) {
  final className = config['name'] as String;
  final type = config['type'] as String;
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
  buffer.writeln('// To modify this file, edit the JSON configuration in fly/ directory and run: fly generate');
  buffer.writeln('//');
  buffer.writeln('// Generated on: \${DateTime.now().toIso8601String()}');
  buffer.writeln();
  
  // Add imports
  for (final import in imports) {
    buffer.writeln("import '\$import';");
  }
  if (imports.isNotEmpty) {
    buffer.writeln();
  }
  
  // Add class documentation
  if (description.isNotEmpty) {
    buffer.writeln('/// \$description');
  }
  
  // Generate class
  buffer.writeln('class \$className {');
  buffer.writeln('  const \$className({');
  
  // Generate constructor parameters
  final fieldNames = <String>[];
  for (final entry in values.entries) {
    final key = entry.key;
    final fieldName = _getFieldName(key);
    fieldNames.add(fieldName);
    
    buffer.writeln('    required this.\$fieldName,');
  }
  
  if (customValues) {
    buffer.writeln('    this.\$customFieldName = const {},');
  }
  
  buffer.writeln('  });');
  buffer.writeln();
  
  // Generate field declarations
  for (int i = 0; i < values.length; i++) {
    final entry = values.entries.elementAt(i);
    final key = entry.key;
    final fieldName = _getFieldName(key);
    buffer.writeln('  final \$type \$fieldName;');
  }
  
  if (customValues) {
    final customType = indexedAccess
        ? 'Map<\$indexType, \$type>'
        : 'Map<String, \$type>';
    buffer.writeln('  final \$customType \$customFieldName;');
  }
  
  buffer.writeln();
  
  // Generate values getter
  if (indexedAccess) {
    buffer.writeln('  /// Get all values as a map');
    buffer.writeln('  Map<\$indexType, \$type> get values => {');
    for (final entry in values.entries) {
      final key = entry.key;
      final fieldName = _getFieldName(key);
      final indexValue = _getIndexValue(key, indexType);
      buffer.writeln('    \$indexValue: \$fieldName,');
    }
    buffer.writeln('  };');
  } else {
    buffer.writeln('  /// Get all values as a map');
    buffer.writeln('  Map<String, \$type> get values => {');
    for (final entry in values.entries) {
      final key = entry.key;
      final fieldName = _getFieldName(key);
      final mapKey = key.isEmpty ? "''" : "'\$key'";
      buffer.writeln('    \$mapKey: \$fieldName,');
    }
    if (customValues) {
      buffer.writeln('    ...\$customFieldName,');
    }
    buffer.writeln('  };');
  }
  
  buffer.writeln();
  
  // Generate operator[] method
  if (indexedAccess) {
    buffer.writeln('  /// Access values by index');
    buffer.writeln('  \$type? operator [](\$indexType index) => values[index];');
  } else {
    buffer.writeln('  /// Access values by key');
    if (customValues) {
      buffer.writeln(
        '  \$type? operator [](String key) => values[key] ?? \$customFieldName[key];',
      );
    } else {
      buffer.writeln('  \$type? operator [](String key) => values[key];');
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
      buffer.writeln('  /// \$methodDescription');
    }
    
    if (methodName == 'getValue' && type == 'String') {
      buffer.writeln('  \$returnType \$methodName(String key) {');
      buffer.writeln('    final stringValue = values[key];');
      buffer.writeln('    if (stringValue == null) return null;');
      buffer.writeln('    return double.tryParse(stringValue);');
      buffer.writeln('  }');
    }
    
    buffer.writeln();
  }
  
  // Generate copyWith method
  buffer.writeln('  /// Create a copy with updated values');
  buffer.writeln('  \$className copyWith({');
  
  for (final entry in values.entries) {
    final key = entry.key;
    final fieldName = _getFieldName(key);
    buffer.writeln('    \$type? \$fieldName,');
  }
  
  if (customValues) {
    final customType = indexedAccess
        ? 'Map<\$indexType, \$type>?'
        : 'Map<String, \$type>?';
    buffer.writeln('    \$customType \$customFieldName,');
  }
  
  buffer.writeln('  }) {');
  buffer.writeln('    return \$className(');
  
  for (final entry in values.entries) {
    final key = entry.key;
    final fieldName = _getFieldName(key);
    buffer.writeln('      \$fieldName: \$fieldName ?? this.\$fieldName,');
  }
  
  if (customValues) {
    buffer.writeln(
      '      \$customFieldName: \$customFieldName ?? this.\$customFieldName,',
    );
  }
  
  buffer.writeln('    );');
  buffer.writeln('  }');
  buffer.writeln();
  
  // Generate static default constant
  buffer.writeln('  /// Default \$className instance');
  buffer.writeln(
    '  static const \$className default\${className.replaceAll('Fly', '')} = \$className(',
  );
  
  for (final entry in values.entries) {
    final key = entry.key;
    final fieldName = _getFieldName(key);
    final value = entry.value;
    final formattedValue = _formatValue(value, type);
    buffer.writeln('    \$fieldName: \$formattedValue,');
  }
  
  buffer.writeln('  );');
  buffer.writeln('}');
  
  // Generate extension if requested
  if (extension) {
    buffer.writeln();
    buffer.writeln(
      '/// Extension on \$className to easily override specific values',
    );
    buffer.writeln('extension \${className}Extension on \$className {');
    buffer.writeln(
      '  /// Create a new \$className instance with specific value overrides',
    );
    buffer.writeln('  \$className copyWith({');
    
    for (final entry in values.entries) {
      final key = entry.key;
      final fieldName = _getFieldName(key);
      buffer.writeln('    \$type? \$fieldName,');
    }
    
    if (customValues) {
      final customType = indexedAccess
          ? 'Map<\$indexType, \$type>?'
          : 'Map<String, \$type>?';
      buffer.writeln('    \$customType \$customFieldName,');
    }
    
    buffer.writeln('  }) {');
    buffer.writeln('    return \$className(');
    
    for (final entry in values.entries) {
      final key = entry.key;
      final fieldName = _getFieldName(key);
      buffer.writeln('      \$fieldName: \$fieldName ?? this.\$fieldName,');
    }
    
    if (customValues) {
      buffer.writeln(
        '      \$customFieldName: \$customFieldName ?? this.\$customFieldName,',
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
  
  // Handle special cases
  if (key == '2xl') return 'xl2';
  if (key == '3xl') return 'xl3';
  
  // Handle numeric keys for spacing
  if (RegExp(r'^\\d+\$').hasMatch(key)) {
    return 's\$key';
  }
  
  // Convert to camelCase and handle numbers
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
  return "'\$key'";
}

/// Format value based on type
String _formatValue(dynamic value, String type) {
  if (type == 'String') {
    return "'\$value'";
  }
  return value.toString();
}
''';
}

/// Get README content for the fly directory
String _getReadmeContent() {
  return '''# FlyWind Design Tokens

This directory contains your project's design token configurations. Edit the JSON files to customize your design system, then run `fly generate` to create the Dart classes.

## Files

- `border_radius.json` - Border radius scale configuration
- `spacing.json` - Spacing scale configuration  
- `colors.json` - Color palette configuration
- `generate.dart` - Code generation script

## Usage

### 1. Customize Your Tokens

Edit the JSON files to match your design system:

```json
{
  "name": "FlyColors",
  "type": "Color",
  "values": {
    "primary": "Color(0xFF3B82F6)",
    "secondary": "Color(0xFF10B981)"
  }
}
```

### 2. Generate Classes

Run the generation command:

```bash
fly generate
```

This creates Dart classes in `lib/tokens/` that you can import and use in your Flutter app.

### 3. Use in Your App

```dart
import 'package:your_app/tokens/colors.dart';
import 'package:your_app/tokens/spacing.dart';

// Use the generated classes
final colors = FlyColors.defaultColors;
final primaryColor = colors['primary'];

final spacing = FlySpacing.defaultSpacing;
final padding = spacing[4]; // "16"
```

## JSON Configuration

Each JSON file supports these options:

- `name`: The generated class name
- `type`: The data type (String, Color, double, etc.)
- `description`: Class documentation
- `values`: Map of key-value pairs
- `customValues`: Enable custom values support
- `customFieldName`: Name of custom values field
- `indexedAccess`: Use indexed access (for spacing)
- `indexType`: Type of index (String or int)
- `imports`: Additional imports needed
- `methods`: Custom methods to generate
- `extension`: Generate copyWith extension

## Examples

### Border Radius
```dart
final borderRadius = FlyBorderRadius.defaultBorderRadius;
final value = borderRadius['md']; // "6"
final doubleValue = borderRadius.getValue('md'); // 6.0
```

### Spacing
```dart
final spacing = FlySpacing.defaultSpacing;
final value = spacing[4]; // "16"
```

### Colors
```dart
final colors = FlyColors.defaultColors;
final color = colors['blue500']; // Color(0xFF3B82F6)
```

## Need Help?

- Visit: https://github.com/realflyui/flywind
- Run: `fly help`
''';
}

/// Generate Dart class from configuration (simplified version for CLI)
String _generateClass(Map<String, dynamic> config) {
  final className = config['name'] as String;
  final type = config['type'] as String;
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
    '// To modify this file, edit the JSON configuration in fly/ directory and run: fly generate',
  );
  buffer.writeln('//');
  buffer.writeln('// Generated on: ${DateTime.now().toIso8601String()}');
  buffer.writeln();

  // Add imports
  for (final import in imports) {
    buffer.writeln("import '$import';");
  }
  if (imports.isNotEmpty) {
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
      final mapKey = key.isEmpty ? "''" : "'$key'";
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

  // Handle special cases
  if (key == '2xl') return 'xl2';
  if (key == '3xl') return 'xl3';

  // Handle numeric keys for spacing
  if (RegExp(r'^\d+$').hasMatch(key)) {
    return 's$key';
  }

  // Convert to camelCase and handle numbers
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
  if (type == 'String') {
    return "'$value'";
  }
  return value.toString();
}

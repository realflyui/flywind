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

  for (final fileName in templateFiles) {
    try {
      final templateContent = _getTemplateContent(fileName);
      final outputFile = File('fly/$fileName');
      outputFile.writeAsStringSync(templateContent);
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
  // Get the path to the templates directory relative to this script
  final scriptPath = Platform.script.toFilePath();
  final scriptDir = File(scriptPath).parent;
  
  // Try different possible locations for templates
  final possiblePaths = [
    '${scriptDir.path}/../templates/$fileName',  // When run from bin/
    '${scriptDir.path}/templates/$fileName',     // When run from project root
    'templates/$fileName',                       // Relative to current working directory
  ];
  
  for (final path in possiblePaths) {
    final templateFile = File(path);
    if (templateFile.existsSync()) {
      return templateFile.readAsStringSync();
    }
  }
  
  throw Exception('Template file not found: $fileName. Tried paths: $possiblePaths');
}

/// Get the generate script content
String _getGenerateScript() {
  return _getTemplateContent('generate.dart');
}

/// Get README content for the fly directory
String _getReadmeContent() {
  return _getTemplateContent('README.md');
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

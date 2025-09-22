#!/usr/bin/env dart

import 'dart:io';

/// FlyWind CLI - Design token management for Flutter projects
///
/// Usage:
///   flw init     - Initialize FlyWind in your project
///   flw generate - Generate Dart classes from flywind.yaml
///   flw help     - Show help information
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
  if (File('flywind.yaml').existsSync()) {
    print('⚠️  FlyWind is already initialized in this project');
    print('   The flywind.yaml file already exists');

    stdout.write('   Do you want to overwrite existing files? (y/N): ');
    final input = stdin.readLineSync()?.toLowerCase();
    if (input != 'y' && input != 'yes') {
      print('   Initialization cancelled');
      return;
    }
  }

  // Create flywind.yaml configuration file
  try {
    final configContent = _getFlywindYamlTemplate();
    final outputFile = File('flywind.yaml');
    outputFile.writeAsStringSync(configContent);
    print('   ✅ Created flywind.yaml');
  } catch (e) {
    print('   ❌ Failed to create flywind.yaml: $e');
    exit(1);
  }

  print('');
  print('🎉 FlyWind initialized successfully!');
  print('');
  print('Next steps:');
  print('  1. Customize the flywind.yaml configuration file');
  print(
    '  2. Run: flutter pub get (or flutter run) for automatic code generation',
  );
  print('  3. Or run: flw generate to generate manually');
  print('  4. Import and use the generated classes in your Flutter app');
  print('');
  print('📖 See flywind.yaml for configuration options');
}

/// Generate Dart classes from flywind.yaml
Future<void> _generateCommand(List<String> args) async {
  print('🔧 Generating FlyWind design tokens...');

  // Check if flywind.yaml exists
  if (!File('flywind.yaml').existsSync()) {
    print('❌ Error: FlyWind not initialized in this project');
    print('   Run "flw init" first to set up FlyWind');
    exit(1);
  }

  // Check if we're in a Flutter project
  if (!File('pubspec.yaml').existsSync()) {
    print('❌ Error: Not in a Flutter project directory');
    print('   Please run this command from your Flutter project root');
    exit(1);
  }

  try {
    // Run flutter packages pub run build_runner build
    print('   Running build_runner to generate code...');
    final result = await Process.run('flutter', [
      'packages',
      'pub',
      'run',
      'build_runner',
      'build',
      '--delete-conflicting-outputs',
    ], workingDirectory: Directory.current.path);

    if (result.exitCode == 0) {
      print('   ✅ Code generation completed successfully!');
      print('');
      print('🎉 FlyWind tokens have been generated!');
      print('');
      print('Usage in your Flutter app:');
      print('  import \'package:flywind/flywind.dart\';');
      print('  // Use FlywindTokens class for accessing your design tokens');
    } else {
      print('   ❌ Code generation failed:');
      print('   ${result.stderr}');
      exit(1);
    }
  } catch (e) {
    print('   ❌ Error running build_runner: $e');
    print('   Make sure you have build_runner installed:');
    print('   flutter pub add --dev build_runner');
    exit(1);
  }
}

/// Show help information
void _showHelp() {
  print('''
🎨 FlyWind CLI - Design token management for Flutter

USAGE:
    flw <command> [options]

COMMANDS:
    init        Initialize FlyWind in your project
    generate    Generate Dart classes from flywind.yaml
    help        Show this help message

EXAMPLES:
    flw init                    # Initialize FlyWind
    flw generate                # Generate token classes
    flw gen                     # Short form of generate

For more information, visit: https://github.com/realflyui/flywind
''');
}

/// Get flywind.yaml template content
String _getFlywindYamlTemplate() {
  return '''# FlyWind Configuration
# This file defines your design tokens for the FlyWind system

tokens:
  colors:
    name: FlyColors
    type: Color
    description: Color palette for the application
    values:
      primary: 0xFF3B82F6
      secondary: 0xFF10B981
      accent: 0xFFF59E0B
      neutral: 0xFF6B7280
      success: 0xFF10B981
      warning: 0xFFF59E0B
      error: 0xFFEF4444
      info: 0xFF3B82F6
      white: 0xFFFFFFFF
      black: 0xFF000000
    custom-values: true
    extension: true

  spacing:
    name: FlySpacing
    type: double
    description: Spacing values for margins and padding
    values:
      "0": 0.0
      "1": 4.0
      "2": 8.0
      "3": 12.0
      "4": 16.0
      "5": 20.0
      "6": 24.0
      "8": 32.0
      "10": 40.0
      "12": 48.0
      "16": 64.0
      "20": 80.0
      "24": 96.0
      "32": 128.0
    indexed-access: true
    index-type: String
    custom-values: true
    extension: true

  radius:
    name: FlyRadius
    type: BorderRadius
    description: Border radius values for rounded corners
    values:
      none: "BorderRadius.zero"
      sm: "BorderRadius.circular(2.0)"
      default: "BorderRadius.circular(4.0)"
      md: "BorderRadius.circular(6.0)"
      lg: "BorderRadius.circular(8.0)"
      xl: "BorderRadius.circular(12.0)"
      "2xl": "BorderRadius.circular(16.0)"
      "3xl": "BorderRadius.circular(24.0)"
      full: "BorderRadius.circular(9999.0)"
    custom-values: true
    extension: true

  text:
    name: FlyText
    type: TextStyle
    description: Text styles for typography
    values:
      xs: "TextStyle(fontSize: 12.0, height: 1.5)"
      sm: "TextStyle(fontSize: 14.0, height: 1.5)"
      base: "TextStyle(fontSize: 16.0, height: 1.5)"
      lg: "TextStyle(fontSize: 18.0, height: 1.5)"
      xl: "TextStyle(fontSize: 20.0, height: 1.5)"
      "2xl": "TextStyle(fontSize: 24.0, height: 1.5)"
      "3xl": "TextStyle(fontSize: 30.0, height: 1.5)"
      "4xl": "TextStyle(fontSize: 36.0, height: 1.5)"
    custom-values: true
    extension: true
''';
}

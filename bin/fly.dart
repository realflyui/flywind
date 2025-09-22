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

  // Check if lib/fly directory exists
  if (!Directory('lib/flywind').existsSync()) {
    // Create lib/fly directory
    Directory('lib/flywind').createSync(recursive: true);
    print('   ✅ Created lib/flywind directory');
  }

  // Check if flywind is already initialized
  if (File('lib/flywind/flywind.yaml').existsSync()) {
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
    final outputFile = File('lib/flywind/flywind.yaml');
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
  if (!File('lib/flywind/flywind.yaml').existsSync()) {
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
  final file = File('flywind.yaml');
  if (file.existsSync()) {
    return file.readAsStringSync();
  }

  // Fallback template if file doesn't exist
  return '''# FlyWind Configuration
#
# This file defines custom tokens that extend the default FlyWind tokens.
# Run 'dart generate/generate_custom.dart' to generate custom token classes.

extend:
  colors:
    test: "#FF0000"

  spacing:
    test: "99"

  radius:
    test: "99"

  breakpoint:
    test: "999"

  container:
    test: "999"

  text:
    test: "99"

  text_line_height:
    test: "99"

  font_weight:
    test: "999"

  tracking:
    test: "0.99"

  blur:
    test: "99"

  perspective:
    test: "999"

  leading:
    test: "9.9"
''';
}

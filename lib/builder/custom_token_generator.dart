import 'dart:async';

import 'package:build/build.dart';
import 'package:yaml/yaml.dart';
import 'converters/color_converter.dart';

/// Custom token builder that generates custom token classes and extensions from fly-config.yaml
class CustomTokenBuilder implements Builder {
  @override
  Map<String, List<String>> get buildExtensions => {
    'lib/flywind/flywind.yaml': [
      'lib/flywind/config/config.dart',
      'lib/flywind/config/colors.dart',
      'lib/flywind/config/spacing.dart',
      'lib/flywind/config/radius.dart',
      'lib/flywind/config/text_style.dart',
      'lib/flywind/config/font_weight.dart',
      'lib/flywind/config/leading.dart',
    ],
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    // Get the input asset (lib/flywind/flywind.yaml)
    final inputId = buildStep.inputId;
    log.info('Processing custom token config: ${inputId.path}');

    if (!inputId.path.endsWith('flywind.yaml')) {
      log.warning('Expected flywind.yaml input, got: ${inputId.path}');
      return;
    }

    final configContent = await buildStep.readAsString(inputId);
    log.info('Found flywind.yaml, generating custom tokens...');

    // Parse YAML configuration
    final config = loadYaml(configContent) as Map<dynamic, dynamic>;

    // Generate custom token classes
    if (config['extend']?['colors'] != null) {
      await _generateCustomColors(buildStep, config);
    }

    if (config['extend']?['spacing'] != null) {
      await _generateCustomSpacing(buildStep, config);
    }

    if (config['extend']?['radius'] != null) {
      await _generateCustomRadius(buildStep, config);
    }

    if (config['extend']?['text_style'] != null) {
      await _generateCustomTextStyle(buildStep, config);
    }

    if (config['extend']?['font_weight'] != null) {
      await _generateCustomFontWeight(buildStep, config);
    }

    if (config['extend']?['leading'] != null) {
      await _generateCustomLeading(buildStep, config);
    }

    // Generate the main custom tokens file
    await _generateCustomTokensFile(buildStep, config);

    log.info('Custom token generation completed!');
  }

  /// Generate custom colors class
  Future<void> _generateCustomColors(
    BuildStep buildStep,
    Map<dynamic, dynamic> config,
  ) async {
    final colors = Map<String, dynamic>.from(config['extend']['colors']);
    if (colors.isEmpty) return;

    log.info('Generating custom colors...');

    final buffer = StringBuffer();

    // Add header
    buffer.writeln('// GENERATED FILE - DO NOT EDIT MANUALLY');
    buffer.writeln('// To regenerate, run: dart run flywind:fly generate');
    buffer.writeln();

    buffer.writeln();

    // Add imports
    buffer.writeln("import 'package:flutter/material.dart';");
    buffer.writeln("import 'package:flywind/tokens/color.dart';");
    buffer.writeln();

    // Add class documentation
    buffer.writeln(
      '/// Custom colors that provide dot notation access to custom color values',
    );
    buffer.writeln('class CustomColors {');
    buffer.writeln('  const CustomColors._();');
    buffer.writeln();

    // Generate custom color properties
    for (final entry in colors.entries) {
      final key = entry.key;
      final value = entry.value.toString();
      final fieldName = _getFieldName(key);
      final flutterColor = _convertColorValue(value);

      buffer.writeln('  /// Custom color: $key');
      buffer.writeln('  static const Color $fieldName = $flutterColor;');
    }
    buffer.writeln();

    // Generate default method that creates a FlyColorToken with custom extras
    buffer.writeln('  /// Create default custom colors as FlyColorToken');
    buffer.writeln('  static FlyColorToken defaultColors() {');
    buffer.writeln('    return FlyColorToken.defaultColor().copyWith(');
    buffer.writeln('      extras: {');
    for (final entry in colors.entries) {
      final key = entry.key;
      final value = entry.value.toString();
      final flutterColor = _convertColorValue(value);
      buffer.writeln("        '$key': $flutterColor,");
    }
    buffer.writeln('      },');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln('}');
    buffer.writeln();

    // Add extension methods for dot notation
    buffer.writeln(
      '/// Extension methods for FlyColorToken to provide dot notation access',
    );
    buffer.writeln('extension FlyColorTokenExtensions on FlyColorToken {');

    for (final entry in colors.entries) {
      final key = entry.key;
      final value = entry.value.toString();
      final fieldName = _getFieldName(key);
      final flutterColor = _convertColorValue(value);

      buffer.writeln('  /// Custom color: $key');
      buffer.writeln(
        '  Color get $fieldName => extras[\'$key\'] ?? $flutterColor;',
      );
    }

    buffer.writeln('}');

    // Write the file using BuildStep
    final outputAsset = AssetId(
      buildStep.inputId.package,
      'lib/flywind/config/colors.dart',
    );
    await buildStep.writeAsString(outputAsset, buffer.toString());

    log.info('Generated: ${outputAsset.path}');
    log.info('Custom colors: ${colors.keys.join(', ')}');
  }

  /// Generate custom spacing class
  Future<void> _generateCustomSpacing(
    BuildStep buildStep,
    Map<dynamic, dynamic> config,
  ) async {
    final spacing = Map<String, dynamic>.from(config['extend']['spacing']);
    if (spacing.isEmpty) return;

    log.info('Generating custom spacing...');

    final buffer = StringBuffer();

    // Add header
    buffer.writeln('// GENERATED FILE - DO NOT EDIT MANUALLY');
    buffer.writeln('// To regenerate, run: dart run flywind:fly generate');
    buffer.writeln();

    buffer.writeln();

    // Add imports
    buffer.writeln("import 'package:flywind/tokens/spacing.dart';");
    buffer.writeln();

    // Add class documentation
    buffer.writeln(
      '/// Custom spacing that provide dot notation access to custom spacing values',
    );
    buffer.writeln('class CustomSpacing {');
    buffer.writeln('  const CustomSpacing._();');
    buffer.writeln();

    // Generate custom spacing properties
    for (final entry in spacing.entries) {
      final key = entry.key;
      final value = entry.value.toString();
      final fieldName = _getFieldName(key);
      final flutterValue = _convertSpacingValue(value);

      buffer.writeln('  /// Custom spacing: $key');
      buffer.writeln('  static const double $fieldName = $flutterValue;');
    }
    buffer.writeln();

    // Generate default method that creates a FlySpacingToken with custom extras
    buffer.writeln('  /// Create default custom spacing as FlySpacingToken');
    buffer.writeln('  static FlySpacingToken defaultSpacing() {');
    buffer.writeln('    return FlySpacingToken.defaultSpacing().copyWith(');
    buffer.writeln('      extras: {');
    for (final entry in spacing.entries) {
      final key = entry.key;
      final value = entry.value.toString();
      final flutterValue = _convertSpacingValue(value);
      buffer.writeln("        '$key': $flutterValue,");
    }
    buffer.writeln('      },');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln('}');
    buffer.writeln();

    // Add extension methods for dot notation
    buffer.writeln(
      '/// Extension methods for FlySpacingToken to provide dot notation access',
    );
    buffer.writeln('extension FlySpacingTokenExtensions on FlySpacingToken {');

    for (final entry in spacing.entries) {
      final key = entry.key;
      final value = entry.value.toString();
      final fieldName = _getFieldName(key);
      final flutterValue = _convertSpacingValue(value);

      buffer.writeln('  /// Custom spacing: $key');
      buffer.writeln(
        '  double get $fieldName => extras[\'$key\'] ?? $flutterValue;',
      );
    }

    buffer.writeln('}');

    // Write the file using BuildStep
    final outputAsset = AssetId(
      buildStep.inputId.package,
      'lib/flywind/config/spacing.dart',
    );
    await buildStep.writeAsString(outputAsset, buffer.toString());

    log.info('Generated: ${outputAsset.path}');
    log.info('Custom spacing: ${spacing.keys.join(', ')}');
  }

  /// Generate custom radius class
  Future<void> _generateCustomRadius(
    BuildStep buildStep,
    Map<dynamic, dynamic> config,
  ) async {
    final radius = Map<String, dynamic>.from(config['extend']['radius']);
    if (radius.isEmpty) return;

    log.info('Generating custom radius...');

    final buffer = StringBuffer();

    // Add header
    buffer.writeln('// GENERATED FILE - DO NOT EDIT MANUALLY');
    buffer.writeln('// To regenerate, run: dart run flywind:fly generate');
    buffer.writeln();

    buffer.writeln();

    // Add imports
    buffer.writeln("import 'package:flywind/tokens/radius.dart';");
    buffer.writeln();

    // Add class documentation
    buffer.writeln(
      '/// Custom radius that provide dot notation access to custom radius values',
    );
    buffer.writeln('class CustomRadius {');
    buffer.writeln('  const CustomRadius._();');
    buffer.writeln();

    // Generate custom radius properties
    for (final entry in radius.entries) {
      final key = entry.key;
      final value = entry.value.toString();
      final fieldName = _getFieldName(key);
      final flutterValue = _convertRadiusValue(value);

      buffer.writeln('  /// Custom radius: $key');
      buffer.writeln('  static const double $fieldName = $flutterValue;');
    }
    buffer.writeln();

    // Generate default method that creates a FlyRadiusToken with custom extras
    buffer.writeln('  /// Create default custom radius as FlyRadiusToken');
    buffer.writeln('  static FlyRadiusToken defaultRadius() {');
    buffer.writeln('    return FlyRadiusToken.defaultRadius().copyWith(');
    buffer.writeln('      extras: {');
    for (final entry in radius.entries) {
      final key = entry.key;
      final value = entry.value.toString();
      final flutterValue = _convertRadiusValue(value);
      buffer.writeln("        '$key': $flutterValue,");
    }
    buffer.writeln('      },');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln('}');
    buffer.writeln();

    // Add extension methods for dot notation
    buffer.writeln(
      '/// Extension methods for FlyRadiusToken to provide dot notation access',
    );
    buffer.writeln('extension FlyRadiusTokenExtensions on FlyRadiusToken {');

    for (final entry in radius.entries) {
      final key = entry.key;
      final value = entry.value.toString();
      final fieldName = _getFieldName(key);
      final flutterValue = _convertRadiusValue(value);

      buffer.writeln('  /// Custom radius: $key');
      buffer.writeln(
        '  double get $fieldName => extras[\'$key\'] ?? $flutterValue;',
      );
    }

    buffer.writeln('}');

    // Write the file using BuildStep
    final outputAsset = AssetId(
      buildStep.inputId.package,
      'lib/flywind/config/radius.dart',
    );
    await buildStep.writeAsString(outputAsset, buffer.toString());

    log.info('Generated: ${outputAsset.path}');
    log.info('Custom radius: ${radius.keys.join(', ')}');
  }

  /// Generate custom text style class
  Future<void> _generateCustomTextStyle(
    BuildStep buildStep,
    Map<dynamic, dynamic> config,
  ) async {
    final textStyle = Map<String, dynamic>.from(config['extend']['text_style']);
    if (textStyle.isEmpty) return;

    log.info('Generating custom text style...');

    final buffer = StringBuffer();

    // Add header
    buffer.writeln('// GENERATED FILE - DO NOT EDIT MANUALLY');
    buffer.writeln('// To regenerate, run: dart run flywind:fly generate');
    buffer.writeln();

    buffer.writeln();

    // Add imports
    buffer.writeln("import 'package:flutter/material.dart';");
    buffer.writeln("import 'package:flywind/tokens/text_style.dart';");
    buffer.writeln();

    // Add class documentation
    buffer.writeln(
      '/// Custom text style that provide dot notation access to custom text style values',
    );
    buffer.writeln('class CustomTextStyle {');
    buffer.writeln('  const CustomTextStyle._();');
    buffer.writeln();

    // Generate custom text style properties
    for (final entry in textStyle.entries) {
      final key = entry.key;
      final value = entry.value;
      final fieldName = _getFieldName(key);
      final flutterValue = _convertTextStyleValue(value);

      buffer.writeln('  /// Custom text style: $key');
      buffer.writeln('  static const TextStyle $fieldName = $flutterValue;');
    }
    buffer.writeln();

    // Generate default method that creates a FlyTextStyleToken with custom extras
    buffer.writeln(
      '  /// Create default custom text style as FlyTextStyleToken',
    );
    buffer.writeln('  static FlyTextStyleToken defaultTextStyle() {');
    buffer.writeln('    return FlyTextStyleToken.defaultTextStyle().copyWith(');
    buffer.writeln('      extras: {');
    for (final entry in textStyle.entries) {
      final key = entry.key;
      final value = entry.value;
      final flutterValue = _convertTextStyleValue(value);
      buffer.writeln("        '$key': $flutterValue,");
    }
    buffer.writeln('      },');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln('}');
    buffer.writeln();

    // Add extension methods for dot notation
    buffer.writeln(
      '/// Extension methods for FlyTextStyleToken to provide dot notation access',
    );
    buffer.writeln(
      'extension FlyTextStyleTokenExtensions on FlyTextStyleToken {',
    );

    for (final entry in textStyle.entries) {
      final key = entry.key;
      final value = entry.value;
      final fieldName = _getFieldName(key);
      final flutterValue = _convertTextStyleValue(value);

      buffer.writeln('  /// Custom text style: $key');
      buffer.writeln(
        '  TextStyle get $fieldName => extras[\'$key\'] ?? $flutterValue;',
      );
    }

    buffer.writeln('}');

    // Write the file using BuildStep
    final outputAsset = AssetId(
      buildStep.inputId.package,
      'lib/flywind/config/text_style.dart',
    );
    await buildStep.writeAsString(outputAsset, buffer.toString());

    log.info('Generated: ${outputAsset.path}');
    log.info('Custom text style: ${textStyle.keys.join(', ')}');
  }

  /// Generate custom font weight class
  Future<void> _generateCustomFontWeight(
    BuildStep buildStep,
    Map<dynamic, dynamic> config,
  ) async {
    final fontWeight = Map<String, dynamic>.from(
      config['extend']['font_weight'],
    );
    if (fontWeight.isEmpty) return;

    log.info('Generating custom font weight...');

    final buffer = StringBuffer();

    // Add header
    buffer.writeln('// GENERATED FILE - DO NOT EDIT MANUALLY');
    buffer.writeln('// To regenerate, run: dart run flywind:fly generate');
    buffer.writeln();

    buffer.writeln();

    // Add imports
    buffer.writeln("import 'package:flutter/material.dart';");
    buffer.writeln("import 'package:flywind/tokens/font_weight.dart';");
    buffer.writeln();

    // Add class documentation
    buffer.writeln(
      '/// Custom font weight that provide dot notation access to custom font weight values',
    );
    buffer.writeln('class CustomFontWeight {');
    buffer.writeln('  const CustomFontWeight._();');
    buffer.writeln();

    // Generate custom font weight properties
    for (final entry in fontWeight.entries) {
      final key = entry.key;
      final value = entry.value.toString();
      final fieldName = _getFieldName(key);
      final flutterValue = _convertFontWeightValue(value);

      buffer.writeln('  /// Custom font weight: $key');
      buffer.writeln('  static const FontWeight $fieldName = $flutterValue;');
    }
    buffer.writeln();

    // Generate default method that creates a FlyFontWeightToken with custom extras
    buffer.writeln(
      '  /// Create default custom font weight as FlyFontWeightToken',
    );
    buffer.writeln('  static FlyFontWeightToken defaultFontWeight() {');
    buffer.writeln(
      '    return FlyFontWeightToken.defaultFontWeight().copyWith(',
    );
    buffer.writeln('      extras: {');
    for (final entry in fontWeight.entries) {
      final key = entry.key;
      final value = entry.value.toString();
      final flutterValue = _convertFontWeightValue(value);
      buffer.writeln("        '$key': $flutterValue,");
    }
    buffer.writeln('      },');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln('}');
    buffer.writeln();

    // Add extension methods for dot notation
    buffer.writeln(
      '/// Extension methods for FlyFontWeightToken to provide dot notation access',
    );
    buffer.writeln(
      'extension FlyFontWeightTokenExtensions on FlyFontWeightToken {',
    );

    for (final entry in fontWeight.entries) {
      final key = entry.key;
      final value = entry.value.toString();
      final fieldName = _getFieldName(key);
      final flutterValue = _convertFontWeightValue(value);

      buffer.writeln('  /// Custom font weight: $key');
      buffer.writeln(
        '  FontWeight get $fieldName => extras[\'$key\'] ?? $flutterValue;',
      );
    }

    buffer.writeln('}');

    // Write the file using BuildStep
    final outputAsset = AssetId(
      buildStep.inputId.package,
      'lib/flywind/config/font_weight.dart',
    );
    await buildStep.writeAsString(outputAsset, buffer.toString());

    log.info('Generated: ${outputAsset.path}');
    log.info('Custom font weight: ${fontWeight.keys.join(', ')}');
  }

  /// Generate custom leading class
  Future<void> _generateCustomLeading(
    BuildStep buildStep,
    Map<dynamic, dynamic> config,
  ) async {
    final leading = Map<String, dynamic>.from(config['extend']['leading']);
    if (leading.isEmpty) return;

    log.info('Generating custom leading...');

    final buffer = StringBuffer();

    // Add header
    buffer.writeln('// GENERATED FILE - DO NOT EDIT MANUALLY');
    buffer.writeln('// To regenerate, run: dart run flywind:fly generate');
    buffer.writeln();

    buffer.writeln();

    // Add imports
    buffer.writeln("import 'package:flywind/tokens/leading.dart';");
    buffer.writeln();

    // Add class documentation
    buffer.writeln(
      '/// Custom leading that provide dot notation access to custom leading values',
    );
    buffer.writeln('class CustomLeading {');
    buffer.writeln('  const CustomLeading._();');
    buffer.writeln();

    // Generate custom leading properties
    for (final entry in leading.entries) {
      final key = entry.key;
      final value = entry.value.toString();
      final fieldName = _getFieldName(key);
      final flutterValue = _convertDoubleValue(value);

      buffer.writeln('  /// Custom leading: $key');
      buffer.writeln('  static const double $fieldName = $flutterValue;');
    }
    buffer.writeln();

    // Generate default method that creates a FlyLeadingToken with custom extras
    buffer.writeln('  /// Create default custom leading as FlyLeadingToken');
    buffer.writeln('  static FlyLeadingToken defaultLeading() {');
    buffer.writeln('    return FlyLeadingToken.defaultLeading().copyWith(');
    buffer.writeln('      extras: {');
    for (final entry in leading.entries) {
      final key = entry.key;
      final value = entry.value.toString();
      final flutterValue = _convertDoubleValue(value);
      buffer.writeln("        '$key': $flutterValue,");
    }
    buffer.writeln('      },');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln('}');
    buffer.writeln();

    // Add extension methods for dot notation
    buffer.writeln(
      '/// Extension methods for FlyLeadingToken to provide dot notation access',
    );
    buffer.writeln('extension FlyLeadingTokenExtensions on FlyLeadingToken {');

    for (final entry in leading.entries) {
      final key = entry.key;
      final value = entry.value.toString();
      final fieldName = _getFieldName(key);
      final flutterValue = _convertDoubleValue(value);

      buffer.writeln('  /// Custom leading: $key');
      buffer.writeln(
        '  double get $fieldName => extras[\'$key\'] ?? $flutterValue;',
      );
    }

    buffer.writeln('}');

    // Write the file using BuildStep
    final outputAsset = AssetId(
      buildStep.inputId.package,
      'lib/flywind/config/leading.dart',
    );
    await buildStep.writeAsString(outputAsset, buffer.toString());

    log.info('Generated: ${outputAsset.path}');
    log.info('Custom leading: ${leading.keys.join(', ')}');
  }

  /// Generate the main custom tokens file
  Future<void> _generateCustomTokensFile(
    BuildStep buildStep,
    Map<dynamic, dynamic> config,
  ) async {
    final buffer = StringBuffer();

    // Add header
    buffer.writeln('// GENERATED FILE - DO NOT EDIT MANUALLY');
    buffer.writeln('// To regenerate, run: dart run flywind:fly generate');
    buffer.writeln();

    buffer.writeln();

    // Add exports
    if (config['extend']?['colors'] != null) {
      buffer.writeln("export 'colors.dart';");
    }
    if (config['extend']?['spacing'] != null) {
      buffer.writeln("export 'spacing.dart';");
    }
    if (config['extend']?['radius'] != null) {
      buffer.writeln("export 'radius.dart';");
    }
    if (config['extend']?['text_style'] != null) {
      buffer.writeln("export 'text_style.dart';");
    }
    if (config['extend']?['font_weight'] != null) {
      buffer.writeln("export 'font_weight.dart';");
    }
    if (config['extend']?['leading'] != null) {
      buffer.writeln("export 'leading.dart';");
    }

    // Write the file using BuildStep
    final outputAsset = AssetId(
      buildStep.inputId.package,
      'lib/flywind/config/config.dart',
    );
    await buildStep.writeAsString(outputAsset, buffer.toString());

    log.info('Generated: ${outputAsset.path}');
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

  /// Convert color value to Flutter Color
  String _convertColorValue(String value) {
    if (value.startsWith('#')) {
      return ColorConverter.hexToFlutterColor(value);
    } else {
      return 'const Color(0xFF000000)'; // fallback
    }
  }

  /// Convert spacing value to Flutter double
  String _convertSpacingValue(String value) {
    final doubleValue = double.tryParse(value) ?? 0.0;
    return doubleValue.toString();
  }

  /// Convert radius value to Flutter double
  String _convertRadiusValue(String value) {
    final doubleValue = double.tryParse(value) ?? 0.0;
    return doubleValue.toString();
  }

  /// Convert double value to Flutter double
  String _convertDoubleValue(String value) {
    final doubleValue = double.tryParse(value) ?? 0.0;
    return doubleValue.toString();
  }

  /// Convert font weight value to Flutter FontWeight
  String _convertFontWeightValue(String value) {
    final intValue = int.tryParse(value) ?? 400;

    // Clamp to valid FontWeight values (100-900, in steps of 100)
    final clampedValue = (intValue / 100).round() * 100;
    final validValue = clampedValue.clamp(100, 900);

    return 'FontWeight.w$validValue';
  }

  /// Convert text style array value to Flutter TextStyle
  String _convertTextStyleValue(dynamic value) {
    if (value is List && value.length >= 2) {
      final fontSize = double.tryParse(value[0].toString()) ?? 16.0;
      final lineHeight = double.tryParse(value[1].toString()) ?? 1.5;
      return 'TextStyle(fontSize: $fontSize, height: $lineHeight)';
    } else if (value is String) {
      // Handle single value as fontSize only
      final fontSize = double.tryParse(value) ?? 16.0;
      return 'TextStyle(fontSize: $fontSize)';
    } else {
      // Fallback
      return 'TextStyle(fontSize: 16.0, height: 1.5)';
    }
  }
}

/// Builder factory function for the build system
Builder customTokenBuilder(BuilderOptions options) => CustomTokenBuilder();

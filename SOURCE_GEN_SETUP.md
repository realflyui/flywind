# FlyWind Source Gen Setup

This document explains how FlyWind has been set up to use `source_gen` for code generation, following the [source_gen documentation](https://pub.dev/packages/source_gen).

## Overview

FlyWind now uses `source_gen` to generate Dart code from your `flywind.yaml` configuration file. This provides better integration with the Dart build system and follows Flutter's recommended patterns for code generation.

## Setup

### 1. Dependencies

The following dependencies have been added to `pubspec.yaml`:

```yaml
dev_dependencies:
  source_gen: ^4.0.1
  build_runner: ^2.4.7
  build: ^4.0.0
```

### 2. Builder Configuration

The `build.yaml` file has been configured to use `source_gen`:

```yaml
targets:
  $default:
    builders:
      flywind:flywindBuilder:
        enabled: true
        build_extensions:
          ".dart": [".flywind.g.part"]
        build_to: cache
        applies_builders: ["source_gen:combining_builder"]
```

### 3. Generator Implementation

The code generation is handled by `FlywindGenerator` class in `lib/builder/flywind_generator.dart`, which:

- Extends `Generator` from `source_gen`
- Reads the `flywind.yaml` configuration file
- Generates Dart classes for design tokens
- Follows the same logic as the original builder

### 4. Builder Factory

The `lib/builder.dart` file exports a builder factory function:

```dart
Builder flywindBuilder(BuilderOptions options) {
  return SharedPartBuilder([FlywindGenerator()], 'flywind');
}
```

## Usage

### 1. Create a Dart file with part directive

Create a Dart file that will use the generated tokens:

```dart
// my_widget.dart
part 'my_widget.g.dart';

import 'package:flutter/material.dart';
import 'package:flywind/flywind.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(FlywindTokens.spacing.s4),
      decoration: BoxDecoration(
        color: FlywindTokens.colors.primary,
        borderRadius: BorderRadius.circular(FlywindTokens.borderRadius.lg),
      ),
      child: Text('Hello FlyWind!'),
    );
  }
}
```

### 2. Run code generation

Generate the tokens by running:

```bash
flutter packages pub run build_runner build
```

Or for continuous generation during development:

```bash
flutter packages pub run build_runner watch
```

### 3. Use generated tokens

The generated tokens will be available in the `.g.dart` file and can be used throughout your application:

```dart
// Access colors
FlywindTokens.colors.primary
FlywindTokens.colors.secondary

// Access spacing
FlywindTokens.spacing.s4
FlywindTokens.spacing.s8

// Access border radius
FlywindTokens.borderRadius.lg
FlywindTokens.borderRadius.xl
```

## Configuration

The `flywind.yaml` file works exactly the same as before. The source_gen setup reads from this file and generates the appropriate Dart classes.

Example `flywind.yaml`:

```yaml
tokens:
  colors:
    name: FlyColors
    type: Color
    description: Color palette for the application
    values:
      primary: Color(0xFF3B82F6)
      secondary: Color(0xFF10B981)
      accent: Color(0xFFF59E0B)
    custom-values: true
    extension: true

  spacing:
    name: FlySpacing
    type: String
    description: Spacing scale for consistent layout
    values:
      "0": "0"
      "1": "4"
      "2": "8"
      "4": "16"
      "8": "32"
    indexed-access: true
    index-type: int
    custom-values: true
    extension: true
```

## Benefits of Source Gen Setup

1. **Better Integration**: Follows Flutter's recommended patterns for code generation
2. **Part Files**: Uses `.g.dart` part files, which is the standard approach
3. **Combining Builder**: Multiple generators can work together seamlessly
4. **Build System Integration**: Better integration with `build_runner` and other build tools
5. **IDE Support**: Better IDE support for generated code

## Migration from Previous Setup

If you were using the previous builder setup:

1. Add the `part` directive to your Dart files
2. Run `flutter packages pub run build_runner build` instead of the previous generation method
3. The generated code will be in `.g.dart` files instead of standalone files

## Example

See `lib/examples/source_gen_example.dart` for a complete example of how to use the new source_gen setup.

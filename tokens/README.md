# Design Token Code Generation

This directory contains JSON configuration files that are used to generate Dart classes for design tokens.

## Overview

The design token system allows you to define design values (colors, spacing, border radius, etc.) in JSON format and automatically generate type-safe Dart classes from them.

## Files

- `border_radius.json` - Border radius scale configuration
- `spacing.json` - Spacing scale configuration  
- `colors.json` - Color palette configuration

## Usage

### Regenerating Classes

To regenerate the Dart classes from JSON configurations:

```bash
# Using the script (recommended)
./scripts/generate_tokens.sh

# Or directly with Dart
dart tool/generate_tokens.dart
```

### Modifying Tokens

1. Edit the JSON files in this directory
2. Run the generation script
3. The corresponding Dart classes will be updated automatically

## JSON Configuration Format

Each JSON file follows this structure:

```json
{
  "name": "ClassName",
  "type": "String|Color|double",
  "description": "Class description",
  "values": {
    "key1": "value1",
    "key2": "value2"
  },
  "customValues": true,
  "customFieldName": "customValues",
  "indexedAccess": false,
  "indexType": "String|int",
  "imports": ["package:flutter/material.dart"],
  "methods": {
    "methodName": {
      "returnType": "double?",
      "description": "Method description"
    }
  },
  "extension": true
}
```

### Configuration Options

- `name`: The generated class name
- `type`: The data type for values (String, Color, double, etc.)
- `description`: Documentation for the class
- `values`: Map of key-value pairs for the design tokens
- `customValues`: Whether to support custom values
- `customFieldName`: Name of the custom values field
- `indexedAccess`: Whether to use indexed access (for spacing)
- `indexType`: Type of index for indexed access
- `imports`: Additional imports needed
- `methods`: Custom methods to generate
- `extension`: Whether to generate a copyWith extension

## Generated Classes

The generator creates classes with:

- Constructor with required parameters
- Final fields for each token value
- `values` getter returning a Map
- `operator[]` for accessing values
- `copyWith` method for creating modified instances
- Static `default*` constant
- Optional custom values support
- Custom methods (if specified)
- Extension with copyWith (if enabled)

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

## Benefits

- **Type Safety**: Generated classes provide compile-time type checking
- **Maintainability**: Easy to update design tokens without touching Dart code
- **Consistency**: Ensures all token classes follow the same pattern
- **Scalability**: Easy to add new token types or modify existing ones
- **Design System Integration**: Can sync with design tools that export JSON

# FlyWind CLI Usage

The FlyWind CLI provides easy-to-use commands for managing design tokens in your Flutter projects.

## Installation

### From pub.dev (when published)
```bash
dart pub global activate flywind
```

### From source (development)
```bash
git clone https://github.com/realflyui/flywind.git
cd flywind
dart pub global activate --source path .
```

## Commands

### `fly init`
Initialize FlyWind in your Flutter project.

```bash
fly init
```

This command:
- Creates a `fly/` directory in your project
- Copies JSON template files for design tokens
- Creates a standalone code generator script
- Adds documentation

**Requirements:**
- Must be run from a Flutter project root (where `pubspec.yaml` exists)

### `fly generate`
Generate Dart classes from your JSON token configurations.

```bash
fly generate
# or short form
fly gen
```

This command:
- Reads JSON files from the `fly/` directory
- Generates type-safe Dart classes in `lib/tokens/`
- Provides usage examples

**Requirements:**
- Must be run from a Flutter project root
- Must have run `fly init` first

### `fly help`
Show help information and available commands.

```bash
fly help
```

## Workflow

### 1. Initialize FlyWind
```bash
cd your_flutter_project
fly init
```

### 2. Customize Your Tokens
Edit the JSON files in the `fly/` directory:

```json
// fly/colors.json
{
  "name": "FlyColors",
  "type": "Color",
  "values": {
    "primary": "Color(0xFF3B82F6)",
    "secondary": "Color(0xFF10B981)",
    "accent": "Color(0xFFF59E0B)"
  }
}
```

### 3. Generate Classes
```bash
fly generate
```

### 4. Use in Your App
```dart
import 'package:your_app/tokens/colors.dart';
import 'package:your_app/tokens/spacing.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = FlyColors.defaultColors;
    final spacing = FlySpacing.defaultSpacing;
    
    return Container(
      color: colors['primary'],
      padding: EdgeInsets.all(double.parse(spacing[4]!)),
      child: Text('Hello FlyWind!'),
    );
  }
}
```

## Project Structure

After running `fly init`, your project will have:

```
your_flutter_project/
├── fly/                          # Design token configurations
│   ├── border_radius.json       # Border radius scale
│   ├── spacing.json             # Spacing scale
│   ├── colors.json              # Color palette
│   ├── generate.dart            # Standalone generator
│   └── README.md                # Token documentation
├── lib/
│   └── tokens/                  # Generated classes (after fly generate)
│       ├── border_radius.dart
│       ├── spacing.dart
│       └── colors.dart
└── pubspec.yaml
```

## Standalone Generation

You can also run the generator directly without the CLI:

```bash
dart fly/generate.dart
```

This is useful for:
- CI/CD pipelines
- Custom build scripts
- When you don't have the CLI installed globally

## Customization

### Adding New Token Types

1. Create a new JSON file in `fly/` directory
2. Follow the JSON configuration format
3. Run `fly generate`

### Modifying Existing Tokens

1. Edit the JSON files in `fly/` directory
2. Run `fly generate`
3. The Dart classes will be updated automatically

### JSON Configuration Format

```json
{
  "name": "FlyYourToken",
  "type": "String|Color|double",
  "description": "Your token description",
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

## Troubleshooting

### "Not in a Flutter project directory"
- Make sure you're in the root of your Flutter project
- Verify that `pubspec.yaml` exists in the current directory

### "FlyWind not initialized in this project"
- Run `fly init` first to set up the project
- Make sure the `fly/` directory exists

### "No JSON configuration files found"
- Check that JSON files exist in the `fly/` directory
- Re-run `fly init` if files are missing

### Generation errors
- Check JSON syntax in your configuration files
- Ensure all required fields are present
- See the generated error messages for specific issues

## Examples

### Custom Color Palette
```json
{
  "name": "FlyBrandColors",
  "type": "Color",
  "description": "Brand-specific color palette",
  "values": {
    "brand": "Color(0xFF1E40AF)",
    "brandLight": "Color(0xFF3B82F6)",
    "brandDark": "Color(0xFF1E3A8A)"
  },
  "customValues": true,
  "extension": true
}
```

### Custom Spacing Scale
```json
{
  "name": "FlyCustomSpacing",
  "type": "String",
  "description": "Custom spacing scale",
  "values": {
    "0": "0",
    "1": "2",
    "2": "4",
    "3": "8",
    "4": "16",
    "5": "32"
  },
  "indexedAccess": true,
  "indexType": "int"
}
```

## Support

- GitHub: https://github.com/realflyui/flywind
- Issues: https://github.com/realflyui/flywind/issues
- Documentation: https://github.com/realflyui/flywind#readme

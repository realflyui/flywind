# FlyWind Flutter-Style Setup Example

This example shows how to set up FlyWind in a Flutter project using the new Flutter-style approach, similar to `flutter_localizations`.

## Step 1: Add FlyWind to your project

```bash
flutter pub add flywind
```

## Step 2: Create flywind.yaml configuration

Create a `flywind.yaml` file in your project root:

```yaml
# FlyWind Configuration
output-dir: lib/tokens

tokens:
  colors:
    name: FlyColors
    type: Color
    description: Color palette for the application
    values:
      primary: Color(0xFF3B82F6)
      secondary: Color(0xFF10B981)
      accent: Color(0xFFF59E0B)
      success: Color(0xFF10B981)
      warning: Color(0xFFF59E0B)
      error: Color(0xFFEF4444)
      info: Color(0xFF3B82F6)
      neutral: Color(0xFF6B7280)
      white: Color(0xFFFFFFFF)
      black: Color(0xFF000000)
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
      "3": "12"
      "4": "16"
      "5": "20"
      "6": "24"
      "8": "32"
      "10": "40"
      "12": "48"
      "16": "64"
      "20": "80"
      "24": "96"
      "32": "128"
    indexed-access: true
    index-type: int
    custom-values: true
    extension: true

  border-radius:
    name: FlyBorderRadius
    type: double
    description: Border radius scale for rounded corners
    values:
      none: 0
      sm: 2
      default: 4
      md: 6
      lg: 8
      xl: 12
      "2xl": 16
      "3xl": 24
      full: 9999
    custom-values: true
    extension: true

  breakpoints:
    name: FlyBreakpoints
    type: double
    description: Responsive breakpoints for different screen sizes
    values:
      sm: 640
      md: 768
      lg: 1024
      xl: 1280
      "2xl": 1536
    custom-values: true
    extension: true

  font-weights:
    name: FlyFontWeight
    type: FontWeight
    description: Font weight scale for typography
    values:
      thin: FontWeight.w100
      extralight: FontWeight.w200
      light: FontWeight.w300
      normal: FontWeight.w400
      medium: FontWeight.w500
      semibold: FontWeight.w600
      bold: FontWeight.w700
      extrabold: FontWeight.w800
      black: FontWeight.w900
    custom-values: true
    extension: true

  text-sizes:
    name: FlyTextSize
    type: double
    description: Text size scale for typography
    values:
      xs: 12
      sm: 14
      base: 16
      lg: 18
      xl: 20
      "2xl": 24
      "3xl": 30
      "4xl": 36
      "5xl": 48
      "6xl": 60
      "7xl": 72
      "8xl": 96
      "9xl": 128
    custom-values: true
    extension: true
```

## Step 3: Run flutter pub get

```bash
flutter pub get
```

This will automatically generate the token classes in `lib/tokens/flywind_tokens.dart`.

## Step 4: Use in your Flutter app

```dart
import 'package:flutter/material.dart';
import 'package:your_app/tokens/flywind_tokens.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlyWind Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = FlywindTokens.colors;
    final spacing = FlywindTokens.spacing;
    final borderRadius = FlywindTokens.borderRadius;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('FlyWind Example'),
        backgroundColor: colors['primary'],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(double.parse(spacing[4]!)),
          decoration: BoxDecoration(
            color: colors['secondary'],
            borderRadius: BorderRadius.circular(borderRadius['lg']!),
          ),
          child: Text(
            'Hello FlyWind!',
            style: TextStyle(
              color: colors['white'],
              fontSize: FlywindTokens.textSizes['xl'],
              fontWeight: FlywindTokens.fontWeights['bold'],
            ),
          ),
        ),
      ),
    );
  }
}
```

## Project Structure

After setup, your project will look like this:

```
your_flutter_project/
├── flywind.yaml                 # FlyWind configuration
├── lib/
│   ├── main.dart               # Your app
│   └── tokens/                 # Generated automatically
│       └── flywind_tokens.dart # All your tokens
└── pubspec.yaml                # With flywind dependency
```

## Manual Code Generation

If you need to manually trigger code generation:

```bash
flutter packages pub run build_runner build
```

For continuous generation during development:

```bash
flutter packages pub run build_runner watch
```

## Benefits of Flutter-Style Setup

1. **No global CLI installation required** - Everything runs locally in your project
2. **Automatic code generation** - Happens when you run `flutter pub get` or `flutter run`
3. **Familiar workflow** - Similar to `flutter_localizations` and other Flutter packages
4. **Version consistency** - Uses the same version of FlyWind as your project
5. **CI/CD friendly** - No need to install global tools in build pipelines

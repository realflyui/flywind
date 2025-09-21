# Flywind

A Tailwind-like utility-first Flutter component library that brings the power and flexibility of Tailwind CSS to Flutter development.

## 🚀 Features

- **String-Based Unit System**: Flexible CSS-like units supporting `px`, `rem`, `em`, `%`, and plain numbers
- **Utility-First Components**: `FlyText` and `FlyContainer` with Tailwind-like method chaining
- **Theme Integration**: Seamless integration with Flutter's `ThemeData` extensions via `FlyTheme`
- **Type-Safe Access**: Full autocomplete support with `context.flywind` extension
- **Custom Configuration**: Easy custom colors and spacing via `FlyConfig` class
- **Comprehensive Utilities**: Padding, margin, colors, and border radius with 80+ tests
- **Error Handling**: Helpful debug messages for invalid tokens with graceful fallbacks
- **Flexible API**: Both dot notation (`colors.blue600`) and bracket notation (`colors['blue600']`)
- **Design Token System**: Centralized `FlySpacing`, `FlyColors`, and `FlyBorderRadius` classes
- **Method Chaining**: Fluent API for clean, readable code composition

## 📦 Components

### FlyText
A text widget with Tailwind-like utilities for styling:

```dart
FlyText('Hello World')
  .p('16')        // padding: 16px
  .px('24')       // horizontal padding: 24px
  .m('8')         // margin: 8px
  .color('blue600') // text color
  .rounded('lg')   // border radius: 8px
```

### FlyContainer
A container widget with background color, padding, and margin utilities:

```dart
FlyContainer(
  child: FlyText('Content'),
)
  .bg('red600')   // background color
  .p('16')        // padding: 16px
  .m('8')         // margin: 8px
  .rounded('xl')  // border radius: 12px
```

## 🎨 Design System

### String-Based Unit System
Flywind uses a flexible string-based unit system that supports multiple CSS-like formats:

```dart
// Plain numbers (assumed pixels)
FlyText('Hello').p('16')        // 16px

// Explicit pixel values
FlyText('Hello').p('16px')      // 16px

// Rem values (16px base)
FlyText('Hello').p('1rem')      // 16px
FlyText('Hello').p('1.5rem')    // 24px

// Em values (16px base)
FlyText('Hello').p('1em')       // 16px
FlyText('Hello').p('0.5em')     // 8px

// Percentage values (returned as decimal)
FlyText('Hello').p('50%')       // 0.5 (50%)

// Mixed unit types
FlyText('Hello')
  .pl('1rem')    // 16px left
  .pr('10px')    // 10px right
  .pt('0.5em')   // 8px top
  .pb('10')      // 10px bottom
```

### Spacing Scale
Flexible string-based unit system supporting multiple formats:
- **Plain numbers**: `p('16')` / `m('8')` = 16px / 8px (assumed pixels)
- **Pixel values**: `p('16px')` / `m('8px')` = 16px / 8px
- **Rem values**: `p('1rem')` / `m('0.5rem')` = 16px / 8px (16px base)
- **Em values**: `p('1em')` / `m('0.5em')` = 16px / 8px (16px base)
- **Percentage values**: `p('50%')` / `m('25%')` = 50% / 25% (returned as decimal)

#### Examples:
```dart
FlyText('Hello')
  .p('20')        // 20px
  .px('1.5rem')   // 24px (1.5 * 16)
  .py('0.5em')    // 8px (0.5 * 16)
  .m('10%')       // 10% margin
```

### Color Palette
Comprehensive color system with semantic naming:
- **Grays**: `gray50`, `gray100`, `gray200`, ..., `gray800`
- **Primary Colors**: `blue600`, `red600`, `green600`, `yellow600`
- **Extended Colors**: `purple600`, `teal600`, `orange600`
- **Basic Colors**: `white`, `black`

### Border Radius Scale
Matching Tailwind CSS border radius system:
- `rounded('none')` = 0px
- `rounded('sm')` = 2px (0.125rem)
- `rounded('')` = 4px (0.25rem) - default
- `rounded('md')` = 6px (0.375rem)
- `rounded('lg')` = 8px (0.5rem)
- `rounded('xl')` = 12px (0.75rem)
- `rounded('2xl')` = 16px (1rem)
- `rounded('3xl')` = 24px (1.5rem)
- `rounded('full')` = 9999px (circular)

### Border Radius Directions
- **Uniform**: `rounded('lg')` - all corners
- **Directional**: `roundedT('xl')`, `roundedR('md')`, `roundedB('lg')`, `roundedL('sm')`
- **Individual**: `roundedTl('2xl')`, `roundedTr('lg')`, `roundedBl('md')`, `roundedBr('xl')`

## 🛠️ Usage

### 1. Setup your app with FlyTheme

#### Option A: Use Default Theme
```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        extensions: [
          FlyTheme.defaultTheme, // Uses default colors and spacing
        ],
      ),
      home: const HomePage(),
    );
  }
}
```

#### Option B: Use Custom Theme
```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        extensions: [
          FlyConfig.createTheme(), // Creates theme with custom colors/spacing
        ],
      ),
      home: const HomePage(),
    );
  }
}
```

### 2. Access theme values with context.flywind

```dart
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final flywind = context.flywind; // Access Flywind theme
    final spacing = flywind.spacing;
    final colors = flywind.colors;
    final borderRadius = flywind.borderRadius;
    
    return Scaffold(
      body: Column(
        children: [
          // Use utility components with method chaining
          FlyText('Welcome to Flywind')
            .p('16')
            .m('8')
            .color('blue600')
            .rounded('lg'),
          
          // Access theme values directly
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.leif, // Custom color with autocomplete
              padding: EdgeInsets.all(spacing.s4), // Type-safe spacing
            ),
            onPressed: () {},
            child: Text('Custom Button'),
          ),
          
          // Container with background, padding, margin, and border radius
          FlyContainer(
            child: FlyText('Card Content').color('white'),
          )
            .bg('gray800')
            .p('24')
            .px('32')
            .m('12')
            .mx('16')
            .rounded('xl'),
        ],
      ),
    );
  }
}
```

## 🧪 Testing

**All Tests Passing** - 80+ comprehensive tests covering all components and utilities.

### Test Coverage

- **FlyUnitParser**: Parses string-based units (px, rem, em, %, plain numbers) with comprehensive error handling
- **FlyPadding Utility**: Resolves uniform and directional padding, handles mixed combinations with string units
- **FlyMargin Utility**: Resolves uniform and directional margin, handles mixed combinations with string units
- **FlyColor Utility**: Resolves colors from theme, applies to TextStyle and Container
- **FlyRounded Utility**: Resolves uniform, directional, and individual corner border radius
- **FlyStyle Class**: copyWith, hasPadding/Margin/BorderRadius properties, apply method
- **FlyText Widget**: Renders, applies padding/color, handles method chaining with string units
- **FlyContainer Widget**: Renders, applies background/padding, handles method chaining with string units

### Running Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```


## 🎯 Key Concepts

### Custom Configuration
Define your custom colors and spacing in `FlyConfig`:

```dart
class FlyConfig {
  static const Map<String, Color> customColors = {
    'leif': Color(0xFF8B5CF6),     // Purple
    'brand': Color(0xFF10B981),    // Green
    'accent': Color(0xFFF59E0B),   // Orange
  };

  static const Map<String, double> customSpacing = {
    'leif': 64.0,
    'brand': 80.0,
    'large': 96.0,
  };

  static FlyTheme createTheme() {
    return FlyTheme.withCustom(
      customColors: customColors,
      customSpacing: customSpacing,
    );
  }
}
```

### Type-Safe Access
Access theme values with full autocomplete support:

```dart
final flywind = context.flywind;
final spacing = flywind.spacing;
final colors = flywind.colors;

// Type-safe dot notation
spacing.s4        // 16.0
colors.blue600    // Color(0xFF2563EB)
colors.leif       // Custom color with autocomplete

// Bracket notation still works
spacing[4]        // 16.0
colors['blue600'] // Color(0xFF2563EB)
```

### Fluent API
Method chaining allows for clean, readable code:

```dart
FlyText('Hello')
  .p('12')        // Returns FlyText
  .px('16')       // Returns FlyText
  .m('8')         // Returns FlyText
  .color('blue')  // Returns FlyText
  .rounded('lg')  // Returns FlyText
```

### Padding vs Margin
Understanding the difference between padding and margin:

- **Padding**: Space inside the element (background color extends into padding area)
- **Margin**: Space outside the element (background color does not extend into margin area)

```dart
FlyContainer(
  child: FlyText('Content'),
)
  .bg('blue600')  // Background color
  .p('16')        // Padding: background extends here
  .m('8')         // Margin: background does NOT extend here
  .rounded('lg')  // Border radius: applied to background
```

### Utility-First Approach
Instead of creating custom styles, use utility classes:

```dart
// Instead of custom styling
Container(
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.all(8),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8),
  ),
  child: Text('Hello'),
)

// Use utilities
FlyContainer(
  child: FlyText('Hello'),
)
  .p('16')        // padding: 16px
  .m('8')         // margin: 8px
  .bg('blue600')  // background color
  .rounded('lg')  // border radius: 8px
```

### Theme Integration
Flywind integrates seamlessly with Flutter's theme system:

```dart
// Access theme values in any widget
Widget build(BuildContext context) {
  final flywind = context.flywind;
  
  return Container(
    padding: EdgeInsets.all(flywind.spacing.s4),
    decoration: BoxDecoration(
      color: flywind.colors.leif,
      borderRadius: BorderRadius.circular(flywind.borderRadius.lg),
    ),
    child: Text('Styled with theme'),
  );
}
```

## 🚀 Getting Started

### Quick Setup
```bash
# 1. Add to your Flutter project
flutter pub add flywind

# 2. Activate CLI globally (one-time setup)
dart pub global activate flywind

# 3. Initialize FlyWind in your project
fly init

# 4. Generate design tokens
fly generate
```

### Development Setup
1. **Clone the repository**
2. **Run the example app**:
   ```bash
   flutter run
   ```
3. **Explore the code** in `lib/main.dart`
4. **Run the tests**:
   ```bash
   flutter test
   ```

## 🔧 Troubleshooting

### Build Issues and Stale Files

If you encounter warnings about "stale files located outside of the allowed root paths" or other build-related issues, try these cleanup steps:

```bash
# Clean all build artifacts and cache
flutter clean

# Reinstall dependencies
flutter pub get

# Verify your Flutter environment
flutter doctor
```

This will remove all build artifacts, clear the cache, and reinstall dependencies, resolving most build-related issues.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

---

**Flywind** - Bringing Tailwind's utility-first approach to Flutter development. 🎨✨
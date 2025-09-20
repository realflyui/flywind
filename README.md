# Flywind

A Tailwind-like utility-first Flutter component library that brings the power and flexibility of Tailwind CSS to Flutter development.

## 🚀 Features

- **Utility-First Approach**: Build UIs using utility classes instead of custom CSS
- **Fluent API**: Method chaining for clean, readable code
- **Design Tokens**: Centralized spacing, color, and border radius management
- **Type-Safe**: Full TypeScript-like safety with Dart
- **Comprehensive Testing**: 65+ tests ensuring reliability
- **Tailwind CSS Compatible**: Matches Tailwind's API and naming conventions
- **Border Radius System**: Complete rounded corner utilities matching Tailwind's `rounded-*` classes

## 📦 Components

### TwText
A text widget with Tailwind-like utilities for styling:

```dart
TwText('Hello World')
  .p(3)           // padding: 12px
  .px(4)          // horizontal padding: 16px
  .py(2)          // vertical padding: 8px
  .pl(1)          // left padding: 4px
  .pr(2)          // right padding: 8px
  .pt(3)          // top padding: 12px
  .pb(4)          // bottom padding: 16px
  .m(2)           // margin: 8px
  .mx(3)          // horizontal margin: 12px
  .my(1)          // vertical margin: 4px
  .ml(2)          // left margin: 8px
  .mr(3)          // right margin: 12px
  .mt(1)          // top margin: 4px
  .mb(2)          // bottom margin: 8px
  .color('blue600') // text color
  .rounded('lg')   // border radius: 8px all corners
  .roundedT('xl')  // border radius: 12px top corners
  .roundedTl('sm') // border radius: 2px top-left corner
```

### TwContainer
A container widget with background color, padding, and margin utilities:

```dart
TwContainer(
  child: TwText('Content'),
)
  .bg('red600')   // background color
  .p(4)           // padding: 16px
  .px(6)          // horizontal padding: 24px
  .m(2)           // margin: 8px
  .mx(3)          // horizontal margin: 12px
  .my(1)          // vertical margin: 4px
  .rounded('xl')  // border radius: 12px all corners
  .roundedT('2xl') // border radius: 16px top corners
```

## 🎨 Design System

### Spacing Scale
Based on a 4px grid system:
- `p(1)` / `m(1)` = 4px
- `p(2)` / `m(2)` = 8px
- `p(3)` / `m(3)` = 12px
- `p(4)` / `m(4)` = 16px
- `p(5)` / `m(5)` = 20px
- etc.

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

### 1. Wrap your app with TwConfig

```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TwConfig(
        spacing: defaultSpacing,
        colors: defaultColors,
        borderRadius: defaultBorderRadius,
        child: const HomePage(),
      ),
    );
  }
}
```

### 2. Use utility components

```dart
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Text with padding, margin, color, and border radius
          TwText('Welcome to Flywind')
            .p(4)
            .m(2)
            .color('blue600')
            .rounded('lg'),
          
          // Container with background, padding, margin, and border radius
          TwContainer(
            child: TwText('Card Content').color('white'),
          )
            .bg('gray800')
            .p(6)
            .px(8)
            .m(3)
            .mx(4)
            .rounded('xl'),
          
          // Complex combinations with all utilities
          TwText('Complex Styling')
            .p(2)
            .px(4)
            .pl(6)
            .m(1)
            .my(2)
            .color('green600')
            .roundedT('2xl')
            .roundedBl('md'),
        ],
      ),
    );
  }
}
```

## 🧪 Testing

This project includes a comprehensive test suite covering all functionality:

- **Unit Tests**: Testing utility classes and logic (`TwPadding`, `TwMargin`, `TwColor`, `TwStyle`)
- **Widget Tests**: Testing component rendering and behavior (`TwText`, `TwContainer`)
- **Integration Tests**: Testing complex combinations of padding, margin, and colors

### Test Coverage

- **Padding Tests**: 8 comprehensive tests covering all padding scenarios
- **Margin Tests**: 9 comprehensive tests covering all margin scenarios  
- **Color Tests**: 8 tests covering color resolution and application
- **Rounded Tests**: 8 tests covering border radius resolution and application
- **Style Tests**: 8 tests covering style combinations and application
- **Widget Tests**: 24 tests covering component behavior and method chaining

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test files
flutter test test/tw_padding_test.dart
flutter test test/tw_margin_test.dart
flutter test test/tw_color_test.dart
flutter test test/tw_rounded_test.dart
flutter test test/tw_style_test.dart
flutter test test/tw_text_test.dart
flutter test test/tw_container_test.dart
```

For detailed testing information, see [test/README.md](test/README.md).


## 🎯 Key Concepts

### Design Tokens
Centralized values for spacing, colors, and border radius that can be easily customized:

```dart
const Map<int, double> defaultSpacing = {
  1: 4.0,
  2: 8.0,
  3: 12.0,
  // ...
};

const Map<String, Color> defaultColors = {
  'blue600': Color(0xFF2563EB),
  'red600': Color(0xFFDC2626),
  // ...
};

const Map<String, double> defaultBorderRadius = {
  'none': 0.0,
  'sm': 2.0,
  '': 4.0,        // default
  'md': 6.0,
  'lg': 8.0,
  'xl': 12.0,
  '2xl': 16.0,
  '3xl': 24.0,
  'full': 9999.0,
};
```

### Fluent API
Method chaining allows for clean, readable code:

```dart
TwText('Hello')
  .p(3)           // Returns TwText
  .px(4)          // Returns TwText
  .m(2)           // Returns TwText
  .color('blue')  // Returns TwText
  .rounded('lg')  // Returns TwText
```

### Padding vs Margin
Understanding the difference between padding and margin:

- **Padding**: Space inside the element (background color extends into padding area)
- **Margin**: Space outside the element (background color does not extend into margin area)

```dart
TwContainer(
  child: TwText('Content'),
)
  .bg('blue600')  // Background color
  .p(4)           // Padding: background extends here
  .m(2)           // Margin: background does NOT extend here
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
TwContainer(
  child: TwText('Hello'),
)
  .p(4)           // padding: 16px
  .m(2)           // margin: 8px
  .bg('blue600')  // background color
  .rounded('lg')  // border radius: 8px
```

## 🚀 Getting Started

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
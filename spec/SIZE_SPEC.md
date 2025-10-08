# Flywind Sizing Specification

## Overview

This specification defines the comprehensive sizing system for Flywind, providing Tailwind-like sizing utilities that map to Flutter's layout widgets including `SizedBox`, `ConstrainedBox`, `IntrinsicWidth`, `IntrinsicHeight`, and `FractionallySizedBox`.

## 🧩 Tailwind → Flutter sizing concept map

| Tailwind class  | CSS meaning                             | Flutter equivalent                                                                 | Notes                                                          |
| --------------- | --------------------------------------- | ---------------------------------------------------------------------------------- | -------------------------------------------------------------- |
| **`.w-min`**    | `width: min-content;`                   | `IntrinsicWidth(child: ...)` or `Row(mainAxisSize: MainAxisSize.min)`              | Shrinks to the smallest size that fits content                 |
| **`.w-max`**    | `width: max-content;`                   | `IntrinsicWidth(child: ...)` with `maxIntrinsicWidth` logic                        | Expands to fit the widest unbroken content                     |
| **`.h-min`**    | `height: min-content;`                  | `IntrinsicHeight(child: ...)` or `Column(mainAxisSize: MainAxisSize.min)`          | Shrinks vertically to fit content                              |
| **`.h-max`**    | `height: max-content;`                  | `IntrinsicHeight(child: ...)` with max logic                                       | Expands vertically to show full content                        |
| **`.w-full`**   | `width: 100%;` (fills parent)           | `SizedBox.expand(width: double.infinity)` or `Container(width: double.infinity)`   | Expands to parent's max width constraint                       |
| **`.h-full`**   | `height: 100%;`                         | `SizedBox.expand(height: double.infinity)` or `Container(height: double.infinity)` | Fills parent's max height                                      |
| **`.w-screen`** | `width: 100vw;` (fills entire viewport) | `MediaQuery.of(context).size.width`                                                | Matches physical screen width regardless of parent constraints |
| **`.h-screen`** | `height: 100vh;`                        | `MediaQuery.of(context).size.height`                                               | Matches full screen height                                     |

## 🔍 Conceptual difference

* **`full` = relative to parent constraints** (container-based)
* **`screen` = relative to device viewport** (global size)
* **`min/max` = relative to intrinsic content** (content-driven)
* **`50%` = percentage of parent** (fractional sizing)

## 🧱 Flutter examples

### `.w-full` (fill parent)

```dart
FlyBox(
  child: FlyText('Full width'),
).w('full').bg('blue500');
```

### `.w-screen` (fill viewport)

```dart
FlyBox(
  child: FlyText('Screen width'),
).w('screen').bg('blue500');
```

### `.w-min` (fit to content)

```dart
FlyBox(
  child: FlyText('Shrink to content'),
).w('min').bg('red500');
```

### `.w-max` (expand to content's max size)

```dart
FlyBox(
  child: FlyText('Expand to max content'),
).w('max').bg('green500');
```

### `.w-50%` (percentage sizing)

```dart
FlyBox(
  child: FlyText('Half width'),
).w('50%').bg('purple500');
```

## Supported Sizing Values

### Numeric Values
- **Fixed pixels**: `w(200)`, `h(150)`, `w(16.5)`
- **Integer values**: `w(64)`, `h(48)`

### Theme Tokens
- **Spacing tokens**: `w('s64')`, `h('s96')`, `w('s32')`
- **Custom tokens**: Any token defined in your theme's spacing configuration

### CSS-like Units
- **Pixels**: `w('200px')`, `h('150px')`
- **Em units**: `w('2em')`, `h('1.5em')` (1em = 16px)
- **Rem units**: `w('2rem')`, `h('1.5rem')` (1rem = 16px)

### Percentage Values
- **Percentage of parent**: `w('50%')`, `h('100%')`, `w('25%')`
- **Uses FractionallySizedBox** for proper CSS-like behavior
- **Range**: 0% to 100%

### Special Keywords

#### `'full'` - Fill Parent
- **Width**: `w('full')` - Fills parent's width constraint
- **Height**: `h('full')` - Fills parent's height constraint
- **Equivalent to**: CSS `width: 100%` / `height: 100%`
- **Implementation**: `SizedBox(width: double.infinity)`

#### `'screen'` - Fill Viewport
- **Width**: `w('screen')` - Fills entire screen width
- **Height**: `h('screen')` - Fills entire screen height
- **Equivalent to**: CSS `width: 100vw` / `height: 100vh`
- **Implementation**: `MediaQuery.of(context).size.width/height`

#### `'min'` - Shrink to Content
- **Width**: `w('min')` - Shrinks to fit content width
- **Height**: `h('min')` - Shrinks to fit content height
- **Equivalent to**: CSS `width: min-content` / `height: min-content`
- **Implementation**: `IntrinsicWidth` / `IntrinsicHeight`

#### `'max'` - Expand to Content
- **Width**: `w('max')` - Expands to fit content width
- **Height**: `h('max')` - Expands to fit content height
- **Equivalent to**: CSS `width: max-content` / `height: max-content`
- **Implementation**: `IntrinsicWidth` / `IntrinsicHeight` (same as min in Flutter)

## Code Examples

### Basic Sizing

```dart
// Fixed size
FlyBox(child: FlyText('Fixed')).w(200).h(100)

// Theme token
FlyBox(child: FlyText('Token')).w('s64').h('s48')

// CSS unit
FlyBox(child: FlyText('CSS Unit')).w('200px').h('150px')

// Percentage
FlyBox(child: FlyText('Half width')).w('50%').h('100%')

// Special keywords
FlyBox(child: FlyText('Full width')).w('full')
FlyBox(child: FlyText('Screen height')).h('screen')
FlyBox(child: FlyText('Minimal')).w('min').h('min')
```

### Complex Layouts

```dart
// Responsive layout
FlyBox(
  children: [
    FlyBox(child: FlyText('Sidebar')).w('25%').h('full'),
    FlyBox(child: FlyText('Content')).w('75%').h('full'),
  ],
).row().h('screen')

// Intrinsic sizing
FlyBox(
  child: FlyText('This text determines the width'),
).w('min').bg('blue100')

// Mixed sizing
FlyBox(
  children: [
    FlyBox(child: FlyText('Fixed')).w(100).h('full'),
    FlyBox(child: FlyText('Flexible')).w('full'),
    FlyBox(child: FlyText('Minimal')).w('min'),
  ],
).row().h(200)
```

### Image Sizing

```dart
// Fill parent with cover
FlyImage(
  imageUrl: 'https://example.com/image.jpg',
).w('full').h('full').object('cover')

// Half parent size with contain
FlyImage(
  imageUrl: 'https://example.com/image.jpg',
).w('50%').h('50%').object('contain')

// Screen width with contain
FlyImage(
  imageUrl: 'https://example.com/image.jpg',
).w('screen').object('contain')

// Intrinsic size
FlyImage(
  imageUrl: 'https://example.com/image.jpg',
).w('min').h('min')
```

## Performance Considerations

### IntrinsicWidth/IntrinsicHeight
- **Use sparingly**: These widgets can be expensive as they require measuring all children
- **Avoid deep nesting**: Performance degrades with complex widget trees
- **Consider alternatives**: Use `MainAxisSize.min` in Row/Column when possible

### FractionallySizedBox
- **Efficient**: Good performance for percentage-based sizing
- **Parent constraints**: Requires parent to have bounded constraints
- **Use cases**: Great for responsive layouts and CSS-like behavior

### MediaQuery
- **Screen sizing**: `w('screen')` / `h('screen')` uses MediaQuery
- **Performance**: Minimal overhead, cached by Flutter
- **Responsive**: Automatically updates on orientation changes

## Edge Cases and Limitations

### Percentage Sizing
- **Parent constraints**: Requires parent to have bounded width/height
- **Nested percentages**: Work correctly with proper parent constraints
- **0% and 100%**: `w('0%')` creates zero-width, `w('100%')` fills parent

### Intrinsic Sizing
- **Flutter limitation**: `'min'` and `'max'` behave identically (both use Intrinsic widgets)
- **CSS difference**: In CSS, `min-content` and `max-content` have different behaviors
- **Performance**: Can be slow with complex layouts

### Screen Sizing
- **Viewport only**: `w('screen')` / `h('screen')` always uses full viewport
- **Not responsive to parent**: Ignores parent constraints
- **Orientation changes**: Automatically updates on device rotation

## Migration from CSS

### Common Patterns

| CSS | Flywind | Notes |
|-----|---------|-------|
| `width: 100%` | `w('full')` | Fill parent |
| `width: 100vw` | `w('screen')` | Fill viewport |
| `width: 50%` | `w('50%')` | Half parent |
| `width: min-content` | `w('min')` | Shrink to content |
| `width: max-content` | `w('max')` | Expand to content |
| `width: 200px` | `w('200px')` or `w(200)` | Fixed size |

### Best Practices

1. **Use `'full'` for responsive layouts** instead of `'100%'` when you want to fill parent
2. **Use `'screen'` for viewport-based layouts** like full-screen modals
3. **Use `'min'` for content-driven sizing** like buttons or badges
4. **Use percentages for proportional layouts** like sidebars and main content
5. **Combine with flex layouts** for complex responsive designs

## API Reference

### FlySize Mixin Methods

```dart
// Width methods
T w(dynamic value)           // Set width
T maxW(dynamic value)        // Set max width
T minW(dynamic value)        // Set min width

// Height methods  
T h(dynamic value)           // Set height
T maxH(dynamic value)        // Set max height
T minH(dynamic value)        // Set min height

// Resolution methods
double? resolveWidth(BuildContext context)
double? resolveHeight(BuildContext context)
double? resolveMaxWidth(BuildContext context)
double? resolveMaxHeight(BuildContext context)
double? resolveMinWidth(BuildContext context)
double? resolveMinHeight(BuildContext context)

// Application method
Widget applySize(BuildContext context, Widget child)
```

### Supported Value Types

- `int` - Integer pixel values
- `double` - Decimal pixel values  
- `String` - Tokens, units, percentages, or keywords
- `Color` - For color-related properties (not sizing)

### Error Handling

- **Invalid percentage**: Throws `ArgumentError` for values outside 0-100%
- **Invalid keyword**: Throws `ArgumentError` for unknown keywords
- **Invalid token**: Throws `ArgumentError` for undefined theme tokens
- **Invalid unit**: Throws `ArgumentError` for malformed CSS units

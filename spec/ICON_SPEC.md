# Icon Specification

## Overview

This specification defines the requirements for implementing Flywind's icon system. The system provides Tailwind-like icon utilities that map to Flutter's `Icon` widget and its associated properties for controlling icon appearance, sizing, and behavior.

## Icon Properties

Icon properties control appearance, sizing, and behavior of icon widgets. All icon properties accept design tokens, numeric values, or custom values through the unified FlyValue system.

### Code Example
```dart
FlyIcon(Icons.star)
  .w('s8')             // Icon size
  .color('yellow500')   // Icon color
  .p('s2')             // Padding
  .m('s1')             // Margin
  .flex('1')           // Flex grow
```

## Supported Properties

| Flywind Helper | Tailwind Class | Flutter Widget | Description |
|---|---|---|---|
| `.color(<flyValue>)` | `.text-*` | `Icon(color:)` | Icon color |
| `.w(<flyValue>)` | `.w-*` | `Icon(size:)` | Icon width (maps to Icon size) |
| `.h(<flyValue>)` | `.h-*` | `Icon(size:)` | Icon height (maps to Icon size) |
| `.p(<flyValue>)` | `.p-*` | `FlyPadding` | Padding |
| `.m(<flyValue>)` | `.m-*` | `FlyMargin` | Margin |
| `.top(<flyValue>)` | `.top-*` | `FlyPosition` | Position |
| `.right(<flyValue>)` | `.right-*` | `FlyPosition` | Position |
| `.bottom(<flyValue>)` | `.bottom-*` | `FlyPosition` | Position |
| `.left(<flyValue>)` | `.left-*` | `FlyPosition` | Position |
| `.flex(<flyValue>)` | `.flex-*` | `FlyFlex` | Flex |
| `.grow(<flyValue>)` | `.flex-grow-*` | `FlyFlex` | Flex grow |
| `.shrink(<flyValue>)` | `.flex-shrink-*` | `FlyFlex` | Flex shrink |
| `.basis(<flyValue>)` | `.flex-basis-*` | `FlyFlex` | Flex basis |

### Icon Sizing Behavior

**Key Difference from Containers**: Icons use `Icon(size:)` instead of layout constraints.

- **`.w()` and `.h()`** → Both map to `Icon(size:)` property
- **No wrappers** → Direct `Icon.size` control (no ConstrainedBox/SizedBox)
- **Square by nature** → Uses width if available, otherwise height

```dart
// Icon sizing (uses Icon.size)
FlyIcon(Icons.star).w('s8')          // → Icon(Icons.star, size: 32.0)
FlyIcon(Icons.star).h('s6')          // → Icon(Icons.star, size: 24.0)  
FlyIcon(Icons.star).w('s8').h('s6')  // → Icon(Icons.star, size: 32.0) // width takes precedence

// Container sizing (uses SizedBox)  
FlyContainer(child: Text('Hello')).w('s8').h('s6')  // → SizedBox(32×24, child: Container(...))
```

## Not Implemented

### Missing Icon Properties

| Icon Property | Tailwind Class | Flutter Widget | Description |
|---|---|---|---|
| `textDirection` | `.rtl`, `.ltr` | `Icon(textDirection:)` | Text direction (LTR/RTL) |
| `iconTheme` | N/A | `Icon(iconTheme:)` | Icon theme data |
| `grade` | N/A | `Icon(grade:)` | Icon grade (filled/outlined) |
| `opticalSize` | N/A | `Icon(opticalSize:)` | Icon optical size |
| `weight` | N/A | `Icon(weight:)` | Icon weight |
| `fill` | N/A | `Icon(fill:)` | Icon fill |
| `gradeFill` | N/A | `Icon(gradeFill:)` | Icon grade fill |
| `opticalSizeFill` | N/A | `Icon(opticalSizeFill:)` | Icon optical size fill |
| `weightFill` | N/A | `Icon(weightFill:)` | Icon weight fill |

**Note:** These properties are available through direct constructor access but not as utility methods.

## Icon API

### Direct Flutter API Access

Access the underlying Flutter `Icon` widget with direct property configuration in the constructor:

```dart
// Direct Icon properties in constructor
FlyIcon(
  Icons.star,
  iconSize: 24.0,
  color: Colors.yellow,
  semanticLabel: 'Star rating',
  textDirection: TextDirection.ltr,
  iconTheme: IconThemeData(
    size: 24.0,
    color: Colors.yellow,
    opacity: 1.0,
  ),
);

// Mixed with utility methods
FlyIcon(
  Icons.home,
  iconSize: 32.0,
  semanticLabel: 'Home navigation',
)
  .color('blue600')
  .p('s2')
  .m('s1');
```

## Default Values

The `FlyIcon` widget applies sensible defaults when no explicit values are provided:

- **Icon Size**: `s6` (24px - standard icon size)
- **Icon Color**: `gray900` (dark gray for good contrast)
- **Semantic Label**: `null` (no accessibility label)
- **Text Direction**: `null` (inherits from parent)
- **Icon Theme**: `null` (inherits from parent)

These defaults ensure consistent icon appearance across the application while maintaining Tailwind-like conventions.

## Accessibility

Icons support semantic labels for accessibility:

```dart
// With semantic label
FlyIcon(Icons.star, semanticLabel: 'Star rating')
  .color('yellow500')
  .w('s8');
```
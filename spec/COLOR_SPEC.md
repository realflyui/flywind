# Color Specification

## Overview

This specification defines the requirements for implementing Flywind's color system. The system provides Tailwind-like color utilities that map to Flutter's `TextStyle` color property and `Container` background color for controlling text and background colors of widgets.

## Color Properties

Color properties control the text color and background color of widgets. All color properties accept color tokens, Color objects, or custom values.

### Code Examples

**Text Color Example:**
```dart
FlyText('Hello World')
  .color('red500')
```

**Container Background Example:**
```dart
FlyContainer(
  child: FlyText('Content'),
).bg('blue100')
```

### Supported Properties

| Flywind Helper | Tailwind Class | Flutter Widget | Description |
|---|---|---|---|
| `.color(<flyValue>)` | `.text-*` | `TextStyle(color: <color>)` | Unified value resolution |
| `.bg(<flyValue>)` | `.bg-*` | `Container(decoration: BoxDecoration(color: <color>))` | Unified value resolution |

### Not Implemented

| Flywind Helper | Tailwind Class | Flutter Widget | Description |
|---|---|---|---|
| `.color('inherit')` | `.text-inherit` | `TextStyle(color: inherit)` | Inherit text color |
| `.color('current')` | `.text-current` | `TextStyle(color: currentColor)` | Current text color |
| `.color('transparent')` | `.text-transparent` | `TextStyle(color: transparent)` | Transparent text color |
| `.bg('inherit')` | `.bg-inherit` | `Container(decoration: BoxDecoration(color: inherit))` | Inherit background color |
| `.bg('current')` | `.bg-current` | `Container(decoration: BoxDecoration(color: currentColor))` | Current background color |
| `.bg('transparent')` | `.bg-transparent` | `Container(decoration: BoxDecoration(color: transparent))` | Transparent background color |

**Note:** Special color values (`inherit`, `current`, `transparent`) are not yet implemented.

## FlyValue Examples

The `<flyValue>` notation accepts direct Color objects, string tokens, and hex color strings:

```dart
final flyTheme = FlyTheme.of(context);
final colors = flyTheme.colors;

.color(Colors.red)           // Direct Flutter Color object
.color('#ff0000')            // String with hex color
.color('#ff0000ff')          // String with hex color (with alpha)
.color(colors.blue500)       // Theme color dot access
.color(colors['blue500'])    // Theme color index access

.bg(Colors.blue)              // Direct Flutter Color object
.bg('#0000ff')                // String with hex color
.bg('#0000ff80')              // String with hex color (with alpha)
.bg(colors.green500)          // Theme color dot access
.color(colors['green500'])    // Theme color index access
```


For complete details on supported value types, input patterns, and resolution order, see [VALUE_SPEC.md](VALUE_SPEC.md).

---

## Color API

Access the underlying Flutter color properties with direct `Color` object configuration:

```dart
FlyContainer(
  child: FlyText('Content'),
)
  .color(Colors.red)      // Direct Color for text
  .bg(Colors.blue);       // Direct Color for background
```


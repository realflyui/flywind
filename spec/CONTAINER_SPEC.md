# Container Specification

## Overview

This specification defines the requirements for implementing Flywind's container system. The system provides Tailwind-like container utilities that map to Flutter's `Container` widget and its associated properties for controlling layout, styling, and positioning of widgets.

## Container Properties

Container properties control the layout, styling, and positioning of widgets. All container properties accept spacing tokens, numeric values, or custom values through the unified FlyValue system.

### Code Example
```dart
FlyContainer(
  child: FlyText('Content'),
)
  .bg('primary')         // Background color
  .p('s4')              // Padding
  .m('s2')              // Margin
  .rounded('lg')        // Border radius
  .border('1')          // Border width
  .borderColor('gray')  // Border color
  .w('s64')             // Width
  .h('s32')             // Height
  .flex('1')            // Flex properties
  .top('s4')            // Position
  .left('s2');          // Position
```

## Supported Properties

| Flywind Helper | Tailwind Class | Flutter Widget | Description |
|---|---|---|---|
| `.bg(<flyValue>)` | `.bg-*` | `Container(decoration: BoxDecoration(color:))` | Background color |
| `.color(<flyValue>)` | `.text-*` | `TextStyle(color:)` | Text color (inherited by child) |
| `.p(*)` | `.p-*` | `FlyPadding` | Padding |
| `.m(*)` | `.m-*` | `FlyMargin` | Margin |
| `.rounded(*)` | `.rounded-*` | `FlyRounded` | Border radius |
| `.border(*)` | `.border-*` | `FlyBorder` | Border |
| `.w(*)` | `.w-*` | `FlySize` | Width |
| `.h(*)` | `.h-*` | `FlySize` | Height |
| `.flex(*)` | `.flex-*` | `FlyFlex` | Flex |
| `.top(*)` | `.top-*` | `FlyPosition` | Position |

## Not Implemented

### Missing Container Properties

| Container Property | Tailwind Class | Flutter Widget | Description |
|---|---|---|---|
| `alignment` | `.items-*` | Direct constructor | Child alignment within container |
| `decoration` | `.decoration-*` | Direct constructor | Background decorations (BoxDecoration) |
| `foregroundDecoration` | `.decoration-*` | Direct constructor | Front-layer decorations |
| `constraints` | `.constraints-*` | Direct constructor | Size constraints (BoxConstraints) |
| `transform` | `.transform` | Direct constructor | Matrix transformations |
| `transformAlignment` | `.origin-*` | Direct constructor | Transform alignment origin |
| `clipBehavior` | `.overflow-*` | Direct constructor | Overflow clipping behavior |

**Note:** These properties are available through direct constructor access but not as utility methods.

## Container API

### Direct Flutter API Access

Access the underlying Flutter `Container` widget with direct property configuration in the constructor:

```dart
// Direct Container properties in constructor
FlyContainer(
  child: FlyText('Content'),
  alignment: Alignment.center,
  padding: EdgeInsets.all(16.0),
  margin: EdgeInsets.symmetric(horizontal: 8.0),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Colors.red, width: 2),
  ),
  foregroundDecoration: BoxDecoration(
    gradient: LinearGradient(colors: [Colors.red, Colors.blue]),
  ),
  width: 200,
  height: 100,
  constraints: BoxConstraints(maxWidth: 300),
  transform: Matrix4.rotationZ(0.1),
  transformAlignment: Alignment.center,
  clipBehavior: Clip.hardEdge,
);

// Mixed with utility methods
FlyContainer(
  child: FlyText('Content'),
  alignment: Alignment.center,
  transform: Matrix4.rotationZ(0.1),
)
  .bg('primary')
  .p('s4')
  .rounded('lg');
```

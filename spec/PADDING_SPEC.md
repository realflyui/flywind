# Padding Specification

## Overview

This specification defines the requirements for implementing Flywind's padding system. The system provides Tailwind-like padding utilities that map to Flutter's `Padding` widget and `EdgeInsets` for controlling internal spacing within widgets.

## Padding Properties

Padding properties control the internal spacing of widgets, creating space between the widget's border and its content. All padding properties accept spacing tokens, numeric values, or custom values.

### Code Example
```dart
FlyContainer(
  child: FlyText('Content'),
)
  .p('s4')           // Uniform padding
  .px('s2')          // Horizontal padding
  .py('s3')          // Vertical padding
  .pt('s1')          // Top padding
  .pr('s2')          // Right padding
  .pb('s1')          // Bottom padding
  .pl('s2');         // Left padding
```

### Supported Properties

| Flywind Helper | Tailwind Class | Flutter Widget | Description |
|---|---|---|---|
| `.p(<flyValue>)` | `.p-*` | `Padding(padding: EdgeInsets.all())` | Unified value resolution |
| `.px(<flyValue>)` | `.px-*` | `Padding(padding: EdgeInsets.symmetric(horizontal:))` | Horizontal padding (left + right) |
| `.py(<flyValue>)` | `.py-*` | `Padding(padding: EdgeInsets.symmetric(vertical:))` | Vertical padding (top + bottom) |
| `.pt(<flyValue>)` | `.pt-*` | `Padding(padding: EdgeInsets.only(top:))` | Top padding only |
| `.pr(<flyValue>)` | `.pr-*` | `Padding(padding: EdgeInsets.only(right:))` | Right padding only |
| `.pb(<flyValue>)` | `.pb-*` | `Padding(padding: EdgeInsets.only(bottom:))` | Bottom padding only |
| `.pl(<flyValue>)` | `.pl-*` | `Padding(padding: EdgeInsets.only(left:))` | Left padding only |

### Not Implemented

| Flywind Helper | Tailwind Class | Flutter Widget | Description |
|---|---|---|---|
| `.ps(<flyValue>)` | `.ps-*` | `Padding(padding: EdgeInsets.only(start:))` | Logical start padding (LTR: left, RTL: right) |
| `.pe(<flyValue>)` | `.pe-*` | `Padding(padding: EdgeInsets.only(end:))` | Logical end padding (LTR: right, RTL: left) |

**Note:** Logical padding properties (`.ps()` and `.pe()`) are not yet implemented. These would require additional Flutter `EdgeInsetsDirectional` support for proper RTL/LTR handling.

## FlyValue Examples

The `<flyValue>` notation accepts direct numeric values, string values with CSS units, and string tokens:

```dart
final flyTheme = FlyTheme.of(context);
final spacing = flyTheme.spacing;

.p(16)                           // Direct numeric value
.p('16px')                       // String with px unit
.p('1.5em')                      // String with em unit
.p('2rem')                       // String with rem unit
.p('50%')                        // String with percentage
.p('s4')                         // String token lookup
.p(spacing.s4)                   // Theme spacing dot access
.p(spacing['s4'] ?? 0)           // Theme spacing index access
```

For complete details on supported value types, input patterns, and resolution order, see [VALUE_SPEC.md](VALUE_SPEC.md).

---

## EdgeInsets API

**Note:** Direct `EdgeInsets` objects are not yet supported in the value resolution system.

Access the underlying Flutter `Padding` widget with direct `EdgeInsets` constructor configuration:

```dart
FlyContainer(
  child: FlyText('Content'),
)
  .p(EdgeInsets.all(16.0));  // Direct EdgeInsets
```

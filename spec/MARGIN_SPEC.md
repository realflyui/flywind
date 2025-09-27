# Margin Specification

## Overview

This specification defines the requirements for implementing Flywind's margin system. The system provides Tailwind-like margin utilities that map to Flutter's `Container` widget with `margin` property and `EdgeInsets` for controlling external spacing around widgets.

## Margin Properties

Margin properties control the external spacing of widgets, creating space between the widget and its surrounding elements. All margin properties accept spacing tokens, numeric values, or custom values.

### Code Example
```dart
FlyContainer(
  child: FlyText('Content'),
)
  .m('s4')           // Uniform margin
  .mx('s2')          // Horizontal margin
  .my('s3')          // Vertical margin
  .mt('s1')          // Top margin
  .mr('s2')          // Right margin
  .mb('s1')          // Bottom margin
  .ml('s2');         // Left margin
```

### Supported Properties

| Flywind Helper | Tailwind Class | Flutter Widget | Description |
|---|---|---|---|
| `.m(<flyValue>)` | `.m-*` | `Container(margin: EdgeInsets.all())` | Unified value resolution |
| `.mx(<flyValue>)` | `.mx-*` | `Container(margin: EdgeInsets.symmetric(horizontal:))` | Horizontal margin (left + right) |
| `.my(<flyValue>)` | `.my-*` | `Container(margin: EdgeInsets.symmetric(vertical:))` | Vertical margin (top + bottom) |
| `.mt(<flyValue>)` | `.mt-*` | `Container(margin: EdgeInsets.only(top:))` | Top margin only |
| `.mr(<flyValue>)` | `.mr-*` | `Container(margin: EdgeInsets.only(right:))` | Right margin only |
| `.mb(<flyValue>)` | `.mb-*` | `Container(margin: EdgeInsets.only(bottom:))` | Bottom margin only |
| `.ml(<flyValue>)` | `.ml-*` | `Container(margin: EdgeInsets.only(left:))` | Left margin only |

### Not Implemented

| Flywind Helper | Tailwind Class | Flutter Widget | Description |
|---|---|---|---|
| `.m(-<flyValue>)` | `.-m-*` | `Container(margin: EdgeInsets.all(-))` | Negative uniform margin |
| `.mx(-<flyValue>)` | `.-mx-*` | `Container(margin: EdgeInsets.symmetric(horizontal: -))` | Negative horizontal margin |
| `.my(-<flyValue>)` | `.-my-*` | `Container(margin: EdgeInsets.symmetric(vertical: -))` | Negative vertical margin |
| `.mt(-<flyValue>)` | `.-mt-*` | `Container(margin: EdgeInsets.only(top: -))` | Negative top margin |
| `.mr(-<flyValue>)` | `.-mr-*` | `Container(margin: EdgeInsets.only(right: -))` | Negative right margin |
| `.mb(-<flyValue>)` | `.-mb-*` | `Container(margin: EdgeInsets.only(bottom: -))` | Negative bottom margin |
| `.ml(-<flyValue>)` | `.-ml-*` | `Container(margin: EdgeInsets.only(left: -))` | Negative left margin |
| `.ms(<flyValue>)` | `.ms-*` | `Container(margin: EdgeInsets.only(start:))` | Logical start margin (LTR: left, RTL: right) |
| `.me(<flyValue>)` | `.me-*` | `Container(margin: EdgeInsets.only(end:))` | Logical end margin (LTR: right, RTL: left) |
| `spaceX(<flyValue>)` | `.space-x-*` | `Row/Column with spacing` | Horizontal spacing between children |
| `spaceY(<flyValue>)` | `.space-y-*` | `Column with spacing` | Vertical spacing between children |
| `spaceXReverse()` | `.space-x-reverse` | `Row with reversed spacing` | Reverse horizontal spacing direction |
| `spaceYReverse()` | `.space-y-reverse` | `Column with reversed spacing` | Reverse vertical spacing direction |

**Note:** Negative margin properties, logical margin properties (`.ms()` and `.me()`), space utilities (`spaceX()`, `spaceY()`), and space reverse utilities (`spaceXReverse()`, `spaceYReverse()`) are not yet implemented. Negative margins would require updating the value resolver to allow negative values for margin properties. Logical margins would require additional Flutter `EdgeInsetsDirectional` support for proper RTL/LTR handling. Space utilities would require specialized spacing widgets with reverse direction support.

## FlyValue Examples

The `<flyValue>` notation accepts direct numeric values, string values with CSS units, and string tokens:

```dart
final flyTheme = FlyTheme.of(context);
final spacing = flyTheme.spacing;

.m(16)                           // Direct numeric value
.m('16px')                       // String with px unit
.m('1.5em')                      // String with em unit
.m('2rem')                       // String with rem unit
.m('50%')                        // String with percentage
.m('s4')                         // String token lookup
```

**Note:** Complex Flutter objects like `EdgeInsets` and token object access are not yet implemented.

For complete details on supported value types, input patterns, and resolution order, see [VALUE_SPEC.md](VALUE_SPEC.md).

---

## EdgeInsets API

**Note:** Direct `EdgeInsets` objects are not yet supported in the value resolution system.

Access the underlying Flutter `Container` widget with direct `EdgeInsets` constructor configuration:

```dart
FlyContainer(
  child: FlyText('Content'),
)
  .m(EdgeInsets.all(16.0));  // Direct EdgeInsets
```

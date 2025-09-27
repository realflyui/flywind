# Value Specification

## Overview

This specification defines the requirements for implementing Flywind's value resolution system. The system provides a unified way to convert various input types into Flutter-compatible values for all utility methods.

## Value Properties

Value properties control how different input types are resolved into Flutter-compatible values. All value properties accept `<flyValue>` which represents Flywind's unified value resolution system.

### Code Example
```dart
final flyTheme = FlyTheme.of(context);
final text = flyTheme.textStyle;

FlyText('Hello World')
  .color('blue500')        // String token
  .text(text.sm)           // Token enum
  .p(16)                   // Direct numeric value
  .bg(Colors.white)        // Flutter object
  .underline();            // Parameterless method
```

### Supported Properties

| Flywind Helper | Input Type | Flutter Widget | Description |
|---|---|---|---|
| `.method(<direct>)` | `int`, `double`, `Color`, `TextStyle`, `EdgeInsets`, etc. | Direct conversion | Direct Flutter object or primitive |
| `.method('<token>')` | `'blue500'`, `'s4'`, `'bold'` | Token lookup | String token resolution |
| `.method('<unit>')` | `'16px'`, `'1.5em'`, `'50%'` | CSS unit parsing | String with CSS units |
| `.method('<hex>')` | `'#FF0000'`, `'#FF0000FF'` | Hex color parsing | String with hex color |
| `.method(tokens.property)` | `colors.blue500`, `spacing.s4` | Token object access | Direct token property access |
| `.method(tokens['property'])` | `colors['blue500']`, `spacing['s4']` | Token bracket access | Token property with bracket notation |
| `.method()` | No parameters | Method call | Parameterless method (underline, uppercase, etc.) |

### Not Implemented

| Flywind Helper | Input Type | Flutter Widget | Description |
|---|---|---|---|
| `.method('calc(100%-2rem)')` | `'calc(...)'` | CSS calc() parsing | CSS calc() expressions |

**Note:** CSS calc() expressions are not yet implemented. These would require additional CSS parsing capabilities.

## FlyValue Types

The `<flyValue>` notation accepts different input types depending on the context. Everywhere else `<flyValue>` means:

### Get tokens
```dart
final flyTheme = FlyTheme.of(context);
final colors = flyTheme.colors;
final spacing = flyTheme.spacing;
final radius = flyTheme.radius;
const fontWeight = flyTheme.fontWeight;
// ...
```

### Direct Values
```dart
.p(16)                           // Direct numeric value
.color(Colors.blue)              // Direct Flutter object
```

### String Tokens
```dart
.color('blue500')                // String token lookup
.p('s4')                         // String token lookup
.weight('bold')                  // String token lookup
.rounded('md')                   // String token lookup
```

### CSS Units
```dart
.p('16px')                       // String with px unit
.p('1.5em')                      // String with em unit
.p('2rem')                       // String with rem unit
.p('50%')                        // String with percentage
.tracking('-1.5em')              // Negative units (letter spacing only)
```

### Hex Colors
```dart
.color('#FF0000')                // String with hex color
.color('#FF0000FF')              // String with hex color (with alpha)
.bg('#0000ff')                   // String with hex color
```

#### Token Object Access
```dart
.color(colors.blue500)           // Theme color access
.p(spacing.s4)                   // Theme spacing access
.weight(fontWeight.bold)         // Theme font weight access
.rounded(radius.md)              // Theme radius access
```

#### Bracket Notation
```dart
.color(colors['blue500'])        // Theme color with bracket access
.p(spacing['s4'])                // Theme spacing with bracket access
.weight(fontWeight['bold'])      // Theme font weight with bracket access
```

#### Complex Flutter Objects
```dart
.text(TextStyle(fontSize: 20))   // Direct TextStyle object
.p(EdgeInsets.all(16))           // Direct EdgeInsets object
```

#### Fallback Patterns
```dart
.color(colors['blue200'] ?? Colors.black)  // Token with fallback
.p(spacing['s4'] ?? 0)                     // Token with fallback
.color(colors['blue200'] ?? 'red500')      // Token with token fallback
```

For complete details on supported value types, input patterns, and resolution order, see the implementation in `lib/helpers/value.dart`.
---

## CSS Unit Support

The system supports standard CSS units with specific conversion ratios:

| Unit | Conversion | Example | Result |
|---|---|---|---|
| `px` | 1:1 ratio | `'16px'` | `16.0` |
| `em` | 16px base | `'1.5em'` | `24.0` |
| `rem` | 16px base | `'2rem'` | `32.0` |
| `%` | 0-100% range | `'50%'` | `0.5` |

**Note:** Negative units are supported for letter spacing methods only (e.g., `'-16px'`, `'-1.5em'`).

---

## Error Handling

The system provides clear error messages for invalid inputs:

```dart
// Invalid token names
.method('invalid')  // Error: Invalid unit "invalid": expected format like "10px", "1.5em", "50%", or "16"

// Invalid CSS units
.method('16pt')  // Error: Invalid unit "16pt": expected format like "10px", "1.5em", "50%", or "16"

// Invalid hex colors
.method('#GG0000')  // Error: Invalid hex color "#GG0000": contains non-hex characters
.method('#12345')   // Error: Invalid hex color "#12345": must be 6 (#RRGGBB) or 8 (#AARRGGBB) characters

// Range violations
.method('150%')  // Error: Invalid percentage "150%": must be between 0% and 100%

// Type validation errors
.method(true)  // Error: expected int, double, or String (token name/unit)
```

---

## Value API

Access the underlying value resolution with direct object configuration:

```dart
FlyText('Content')
  .color(Colors.red)      // Direct Color object
  .p(16);                 // Direct numeric value
```
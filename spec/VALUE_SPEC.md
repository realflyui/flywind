# Value Specification

## Overview

This specification defines the requirements for implementing Flywind's value resolution system. The system provides a unified way to convert various input types into Flutter-compatible values.

## Input Type Support

**REQUIRED**: All helper methods MUST support these input patterns:

### Direct Values
```dart
.method(16)              // int → target type
.method(16.0)            // double → target type
.method(Colors.blue)     // Flutter object → target type
.method(TextStyle())     // Flutter object → target type
```

### String Inputs
```dart
// Token lookup
.method('blue200')       // string → token lookup → target type
.method('s4')            // string → token lookup → target type

// CSS units
.method('16px')          // string → parse unit → target type
.method('1.5em')         // string → parse unit → target type
.method('2rem')          // string → parse unit → target type
.method('50%')           // string → parse unit → target type

// Special parsing
.method('#FF0000')       // string → parse hex → Color
.method('solid')         // string → parse enum → target type
```

### Token Object Access
```dart
// Dot notation
.method(colors.blue200)  // token property → target type
.method(spacing.s4)      // token property → target type

// Bracket notation
.method(colors['blue200']) // token bracket → target type
.method(spacing['s4'])     // token bracket → target type
```

### Fallback Patterns
```dart
// With fallback
.method(colors['blue200'] ?? Colors.black)  // token with fallback → target type
.method(spacing['s4'] ?? 0)                 // token with fallback → target type

// Token fallback
.method(colors['blue200'] ?? 'red500')      // token with token fallback → target type
.method(spacing['s4'] ?? 's1')              // token with token fallback → target type
```

### Method Calls
```dart
// Parameterless methods
.underline()             // () → TextDecoration.underline
.uppercase()             // () → 'uppercase'
.noDecoration()          // () → TextDecoration.none
```

## CSS Unit Support

### Supported Units

**REQUIRED**: All implementations MUST support these CSS units:

```dart
'16px'   // Pixels (1:1 ratio)
'1em'    // Em units (16px base)
'1.5em'  // Em units (24.0)
'2rem'   // Rem units (32.0)
'50%'    // Percentage (0.5)
'100%'   // Percentage (1.0)
```

### Negative Units (Letter Spacing Only)

**REQUIRED**: Letter spacing methods MUST support negative units:

```dart
'-16px'  // Negative pixels (-16.0)
'-1.5em' // Negative em units (-24.0)
'-2rem'  // Negative rem units (-32.0)
```

## Error Handling

### Invalid Token Names

```dart
.method('invalid')  // Error: Invalid unit "invalid": expected format like "10px", "1.5em", "50%", or "16"
```

### Invalid CSS Units

```dart
.method('16pt')  // Error: Invalid unit "16pt": expected format like "10px", "1.5em", "50%", or "16"
```

### Invalid Hex Colors

```dart
.method('#GG0000')  // Error: Invalid hex color "#GG0000": contains non-hex characters. Use format #RRGGBB or #AARRGGBB
.method('#12345')   // Error: Invalid hex color "#12345": must be 6 (#RRGGBB) or 8 (#AARRGGBB) characters
```

### Range Violations

```dart
.method('150%')  // Error: Invalid percentage "150%": must be between 0% and 100%
```

### Type Validation Errors

```dart
// Invalid types for numeric methods
.method(true)  // Error: expected int, double, or String (token name/unit)

// Invalid types for color methods  
.method(123)  // Error: expected Color object, hex string, or token name

// Invalid types for FontWeight
.method(123)  // Error: must be a String or FontWeight

// Invalid types for TextAlign
.method(123)  // Error: must be a String or TextAlign
```

## Method Chaining

### Chaining Pattern

**REQUIRED**: All helper methods MUST support method chaining:

```dart
FlyText('Hello')
  .p('s4')           // padding
  .color('blue600')  // color
  .text('lg')        // text style
  .weight('bold')    // font weight
  .align('center');  // text alignment
```

### Mixed Value Types

**REQUIRED**: Methods MUST support mixed value types in chaining:

```dart
FlyContainer(
  child: FlyText('Content'),
)
  .p(16)              // direct numeric
  .px('s4')           // token lookup
  .py('1.5em')        // CSS unit
  .bg(Colors.white)   // direct Flutter object
  .rounded('s2')      // token lookup
  .border('1px')      // CSS unit
  .borderColor('gray300'); // token lookup
```

## Behavioral Requirements

### Case Insensitive String Parsing

**REQUIRED**: All string-based resolution MUST be case insensitive:

```dart
// FontWeight resolution
.weight('BOLD')    // same as 'bold'
.weight('Light')   // same as 'light'

// TextAlign resolution  
.align('CENTER')   // same as 'center'
.align('Left')     // same as 'left'

// Color hex parsing
.color('#ff5733')  // same as '#FF5733'
```

### Null Handling

**REQUIRED**: All utility methods MUST handle null inputs gracefully:

```dart
// Core resolution methods throw errors for null inputs
.method(null)          // → throws ArgumentError
```

### Token Lookup Priority

**REQUIRED**: String inputs MUST be resolved in this order:

1. **Token lookup** - Check if string matches a token name
2. **CSS unit parsing** - Parse as unit if not a token
3. **Error** - Throw error if neither token nor valid unit

```dart
.method('s4')     // 1. Token lookup → spacing.s4
.method('16px')   // 2. CSS unit parsing → 16.0
.method('invalid') // 3. Error → throws ArgumentError
```

## Implementation Guidelines

### Value Resolution Order

1. **Direct Flutter objects** (Color, TextStyle, etc.) - return as-is
2. **Primitive types** (int, double) - convert to target type
3. **Token lookup** - resolve string through token map
4. **CSS unit parsing** - parse string with units
5. **Fallback** - use default value on failure

### Error Handling Strategy

- **Graceful degradation**: Always provide sensible fallbacks
- **Clear error messages**: Include available options in error text
- **Debug logging**: Log resolution attempts in debug mode
- **Type safety**: Validate input types before processing

### Performance Requirements

- **Token lookup**: O(1) map access for valid tokens
- **CSS parsing**: Minimal overhead for common units
- **Caching**: Cache resolved values per context
- **Memory efficiency**: Avoid unnecessary object creation

This specification defines the complete requirements for implementing Flywind's value resolution system. All implementations MUST conform to these patterns and behaviors.
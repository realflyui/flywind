# Flywind Helper API Specification

## Overview

This specification defines the requirements for implementing Flywind's value resolution system. The system provides a unified way to convert various input types into Flutter-compatible values.

## Input Type Support Requirements

### Numeric Value Methods

**REQUIRED**: All spacing, size, and radius methods MUST support these input patterns:

#### Direct Numeric Values
```dart
.p(16)           // int → double
.p(16.0)         // double → double
```

#### Token Lookup
```dart
.p('s4')         // string → token lookup → double
.p('s1')         // string → token lookup → double
```

#### CSS Units
```dart
.p('16px')       // string → parse unit → double
.p('1.5em')      // string → parse unit → double (24.0)
.p('2rem')       // string → parse unit → double (32.0)
.p('50%')        // string → parse unit → double (0.5)
```

#### Token Object Access
```dart
.p(spacing.s4)   // token property → double
.p(spacing['s4']) // token bracket → double
```

#### Fallback Patterns
```dart
.p(spacing['s4'] ?? 0)     // token with fallback → double
.p(spacing['s4'] ?? 's1')  // token with token fallback → double
```

### Letter Spacing Methods (Allows Negatives)

**REQUIRED**: All letter spacing methods MUST support these input patterns:

#### Direct Numeric Values (Including Negatives)
```dart
.tracking(16)    // int → double
.tracking(-16)   // int → double (negative allowed)
```

#### Token Lookup
```dart
.tracking('tight')    // string → token lookup → double
.tracking('wide')     // string → token lookup → double
```

#### CSS Units with Negatives
```dart
.tracking('-16px')    // string → parse unit → double (-16.0)
.tracking('-1.5em')   // string → parse unit → double (-24.0)
```

#### Token Object Access
```dart
.tracking(tracking.tight)     // token property → double
.tracking(tracking['tight'])  // token bracket → double
```

#### Fallback Patterns
```dart
.tracking(tracking['tight'] ?? 0)        // token with fallback → double
.tracking(tracking['tight'] ?? 'normal') // token with token fallback → double
```

### Color Value Methods

**REQUIRED**: All color methods MUST support these input patterns:

#### Direct Flutter Objects
```dart
.color(Colors.blue)        // Color → Color
.bg(Colors.red)            // Color → Color
```

#### Token Lookup
```dart
.color('blue600')          // string → token lookup → Color
.bg('red500')              // string → token lookup → Color
```

#### Hex Colors
```dart
.color('#FF0000')          // string → parse hex → Color
.bg('#AARRGGBB')           // string → parse hex → Color
```

#### Token Object Access
```dart
.color(colors.blue600)     // token property → Color
.bg(colors['blue600'])     // token bracket → Color
```

#### Fallback Patterns
```dart
.color(colors['blue600'] ?? Colors.black)  // token with fallback → Color
.bg(colors['blue600'] ?? 'red500')         // token with token fallback → Color
```

### Text Style Methods

**REQUIRED**: All text style methods MUST support these input patterns:

#### Direct Flutter Objects
```dart
.text(TextStyle(fontSize: 16))  // TextStyle → TextStyle
.align(TextAlign.center)        // TextAlign → TextAlign
.weight(FontWeight.bold)        // FontWeight → FontWeight
```

#### Token Lookup
```dart
.text('lg')                     // string → token lookup → TextStyle
.align('center')                // string → parse alignment → TextAlign
.weight('bold')                 // string → token lookup → FontWeight
```

#### Token Object Access
```dart
.text(textStyles.lg)            // token property → TextStyle
.align(textStyles['lg'])        // token bracket → TextStyle
```

#### Fallback Patterns
```dart
.text(textStyles['lg'] ?? TextStyle())  // token with fallback → TextStyle
.align(textStyles['lg'] ?? 'left')      // token with token fallback → TextAlign
```

### Font Methods

**REQUIRED**: All font methods MUST support these input patterns:

#### Direct Flutter Objects
```dart
.font(GoogleFonts.inter())      // TextStyle → extract font families
.font(['Inter', 'system-ui'])   // List<String> → font stack
```

#### Token Lookup
```dart
.font('sans')                   // string → token lookup → font stack
.font('Inter')                  // string → raw font name
```

#### Token Object Access
```dart
.font(fonts.sans)               // token property → font stack
.font(fonts['sans'])            // token bracket → font stack
```

#### Fallback Patterns
```dart
.font(fonts['sans'] ?? 'Inter')           // token with fallback → font stack
.font(fonts['sans'] ?? ['Arial'])         // token with fallback → font stack
```

### Border Methods

**REQUIRED**: All border methods MUST support these input patterns:

#### Border Width Methods
```dart
.border(2)              // int → double
.border(2.0)            // double → double
.border('s1')           // string → token lookup → double
.border('2px')          // string → parse unit → double
.border(spacing.s1)     // token property → double
.border(spacing['s1'])  // token bracket → double
.border(spacing['s1'] ?? 0)     // token with fallback → double
.border(spacing['s1'] ?? 's2')  // token with token fallback → double
```

#### Border Style Methods
```dart
.borderStyle('solid')   // string → BorderStyle
.borderStyle('dashed')  // string → BorderStyle
.borderStyle('dotted')  // string → BorderStyle
.borderStyle('none')    // string → BorderStyle
```

### Text Decoration Methods

**REQUIRED**: All text decoration methods MUST support these patterns:

#### Method Calls
```dart
.underline()            // () → TextDecoration.underline
.lineThrough()          // () → TextDecoration.lineThrough
.overline()             // () → TextDecoration.overline
.noDecoration()         // () → TextDecoration.none
```

#### String Values
```dart
.decoration('underline')    // string → parse decoration → TextDecoration
.decoration('line-through') // string → parse decoration → TextDecoration
```

### Text Transform Methods

**REQUIRED**: All text transform methods MUST support these patterns:

#### Method Calls
```dart
.uppercase()            // () → 'uppercase'
.lowercase()            // () → 'lowercase'
.capitalize()           // () → 'capitalize'
```

#### String Values
```dart
.transform('uppercase') // string → 'uppercase'
.transform('lowercase') // string → 'lowercase'
.transform('capitalize') // string → 'capitalize'
```

## CSS Unit Support Requirements

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

## Error Handling Requirements

### Invalid Token Names

**REQUIRED**: Invalid token names MUST produce this error:

```dart
.p('invalid')  // Error: Invalid unit "invalid": expected format like "10px", "1.5em", "50%", or "16"
```

### Invalid CSS Units

**REQUIRED**: Invalid CSS units MUST produce this error:

```dart
.p('16pt')  // Error: Invalid unit "16pt": expected format like "10px", "1.5em", "50%", or "16"
```

### Invalid Hex Colors

**REQUIRED**: Invalid hex colors MUST produce this error:

```dart
.color('#GG0000')  // Error: Invalid hex color "#GG0000": contains non-hex characters. Use format #RRGGBB or #AARRGGBB
.color('#12345')   // Error: Invalid hex color "#12345": must be 6 (#RRGGBB) or 8 (#AARRGGBB) characters
```

### Range Violations

**REQUIRED**: Invalid percentage ranges MUST produce this error:

```dart
.p('150%')  // Error: Invalid percentage "150%": must be between 0% and 100%
```

### Type Validation Errors

**REQUIRED**: Invalid input types MUST produce these errors:

```dart
// Invalid types for numeric methods
.p(true)  // Error: expected int, double, or String (token name/unit)

// Invalid types for color methods  
.color(123)  // Error: expected Color object, hex string, or token name

// Invalid types for FontWeight
.weight(123)  // Error: must be a String or FontWeight

// Invalid types for TextAlign
.align(123)  // Error: must be a String or TextAlign
```

## Method Chaining Requirements

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
.p(null)          // → throws ArgumentError
.color(null)      // → throws ArgumentError
```

### Token Lookup Priority

**REQUIRED**: String inputs MUST be resolved in this order:

1. **Token lookup** - Check if string matches a token name
2. **CSS unit parsing** - Parse as unit if not a token
3. **Error** - Throw error if neither token nor valid unit

```dart
.p('s4')     // 1. Token lookup → spacing.s4
.p('16px')   // 2. CSS unit parsing → 16.0
.p('invalid') // 3. Error → throws ArgumentError
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
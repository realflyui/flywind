# Mode Specification

## Overview

Flywind provides two approaches for mode-based design: string syntax for simple cases and builder pattern for complex logic. Modes allow styling to change based on the current theme mode (light/dark).

## Modes

Flywind uses the following mode system (defined in `FlyTheme`):

```dart
light  // Light mode (default)
dark   // Dark mode
```

## Approach 1: String Syntax

Mode values as space-separated strings with mode prefixes:

```dart
'baseValue dark:darkValue'
```

```dart
// Basic usage
widget
  .p('s2 dark:s4')              // Mode-based padding
  .color('gray200 dark:gray600') // Mode-based color
  .bg('white dark:gray800');     // Mode-based background

// String syntax rules
'gray200'                    // gray200 for all modes
'gray200 dark:gray600'       // gray200 for light, gray600 for dark
'blue500 dark:blue300'       // blue500 for light, blue300 for dark
'white dark:gray900'         // white for light, gray900 for dark
```

## Approach 2: Builder Pattern

Complex mode logic with mode methods:

```dart
// Basic usage
widget
  .mode('light', (w) => w.p('s2').color('gray200'))
  .mode('dark', (w) => w.p('s4').color('gray600'));

// Complex conditional styling
widget
  .mode('light', (w) => 
    w.p('s4').bg('white').color('gray900').border('1').borderColor('gray200')
  )
  .mode('dark', (w) => 
    w.p('s6').bg('gray800').color('gray100').border('1').borderColor('gray600')
  );
```

## Mixed Approach

Combine both approaches:

```dart
widget
  .p('s2 dark:s4')                    // String syntax for simple values
  .color('gray200 dark:gray600')      // String syntax for color
  .mode('dark', (w) =>                // Builder pattern for complex logic
    w.weight('bold').border('2')
  );
```

## Implementation Requirements

### String Parsing
1. Parse mode strings into mode maps
2. Resolve values based on current theme mode
3. Handle fallbacks when mode values are missing
4. Validate syntax and provide clear error messages

### Builder Pattern
1. Theme mode detection using `FlyTheme.of(context)`
2. Mode resolution using current brightness
3. Type-safe builders with proper IDE support
4. Efficient rebuilding to minimize performance impact

### Value Resolution
1. Extend existing value resolvers to handle mode values
2. Maintain compatibility with existing helper methods
3. Support all input types (tokens, CSS units, direct values)
4. Handle edge cases gracefully

## Error Handling

### String Syntax Errors
```dart
.color('gray200 invalid:gray600')  // Error: Invalid mode "invalid". Expected: light, dark
.color('gray200 dark:')            // Error: Invalid mode value "gray200 dark:": missing value after mode
```

### Builder Pattern Errors
```dart
.mode('invalid', (w) => w.color('gray200'))  // Error: Invalid mode "invalid"
.mode('dark', null)                          // Error: Mode function cannot be null
```

## Performance Considerations

1. **Efficient parsing**: Cache parsed mode strings
2. **Minimal rebuilds**: Only rebuild when theme mode changes
3. **Value caching**: Cache resolved values per mode
4. **Memory efficiency**: Avoid unnecessary object creation

This specification provides a comprehensive foundation for implementing mode-based design capabilities in Flywind while maintaining consistency with the existing API patterns.

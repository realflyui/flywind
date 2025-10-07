# Responsive Specification

## Overview

Flywind provides two approaches for responsive design: string syntax for simple cases and builder pattern for complex logic.

## Breakpoints

Flywind uses the following breakpoint system (defined in `FlyBreakpointToken`):

```dart
sm: 640px   // Small screens and up
md: 768px   // Medium screens and up  
lg: 1024px  // Large screens and up
xl: 1280px  // Extra large screens and up
xl2: 1536px // 2X large screens and up
```

## Approach 1: String Syntax

Responsive values as space-separated strings with breakpoint prefixes:

```dart
'baseValue sm:smallValue md:mediumValue lg:largeValue'
```

```dart
// Basic usage
widget
  .p('s2 sm:s4 md:s6')           // Responsive padding
  .color('blue500 sm:blue600')   // Responsive color
  .text('sm md:lg lg:xl');       // Responsive text size

// String syntax rules
's1'                    // s1 for all screen sizes
's1 sm:s2'              // s1 for mobile, s2 for sm and up
's1 sm:s2 md:s4'        // s1 for mobile, s2 for sm, s4 for md and up
's1 sm:s2 md:s4 lg:s6'  // Progressive scaling across breakpoints
```

## Approach 2: Builder Pattern

Complex responsive logic with breakpoint methods:

```dart
// Basic usage
widget
  .breakpoint('sm', (w) => w.p('s2').color('blue500'))
  .breakpoint('md', (w) => w.p('s4').color('blue600'))
  .breakpoint('lg', (w) => w.p('s6').color('blue700'));

// Complex conditional styling
widget
  .breakpoint('sm', (w) => 
    w.p('s4').bg('gray100').rounded('s2').w('100%')
  )
  .breakpoint('md', (w) => 
    w.p('s6').bg('gray200').rounded('s4').w('50%').border('2')
  )
  .breakpoint('lg', (w) => 
    w.p('s8').bg('gray300').rounded('s6').w('33%').border('4')
  );
```

## Mixed Approach

Combine both approaches:

```dart
widget
  .p('s2 sm:s4 md:s6')                 // String syntax for simple values
  .color('blue500 sm:blue600')         // String syntax for color
  .breakpoint('lg', (w) =>              // Builder pattern for complex logic
    w.weight('bold').align('center')
  );
```

## Implementation Requirements

### String Parsing
1. Parse responsive strings into breakpoint maps
2. Resolve values based on current screen size
3. Handle fallbacks when breakpoint values are missing
4. Validate syntax and provide clear error messages

### Builder Pattern
1. LayoutBuilder integration for screen size detection
2. Breakpoint resolution using `FlyBreakpointToken`
3. Type-safe builders with proper IDE support
4. Efficient rebuilding to minimize performance impact

### Value Resolution
1. Extend existing value resolvers to handle responsive values
2. Maintain compatibility with existing helper methods
3. Support all input types (tokens, CSS units, direct values)
4. Handle edge cases gracefully

## Error Handling

### String Syntax Errors
```dart
.p('s1 invalid:s2')  // Error: Invalid breakpoint "invalid". Expected: sm, md, lg, xl, xl2
.p('s1 sm:')         // Error: Invalid responsive value "s1 sm:": missing value after breakpoint
.p('s1 md:s2 sm:s3') // Error: Breakpoints must be in ascending order: sm, md, lg, xl, xl2
```

### Builder Pattern Errors
```dart
.breakpoint('invalid', (w) => w.p('s2'))  // Error: Invalid breakpoint "invalid"
.breakpoint('sm', null)                   // Error: Breakpoint function cannot be null
```

## Performance Considerations

1. **Efficient parsing**: Cache parsed responsive strings
2. **Minimal rebuilds**: Only rebuild when screen size changes
3. **Value caching**: Cache resolved values per breakpoint
4. **Memory efficiency**: Avoid unnecessary object creation

This specification provides a comprehensive foundation for implementing responsive design capabilities in Flywind while maintaining consistency with the existing API patterns.
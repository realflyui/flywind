# Text Specification

## Overview

This specification defines the requirements for implementing Flywind's text system. The system provides Tailwind-like text utilities that map to Flutter's `Text` widget and its associated properties for controlling typography, styling, and text behavior.

## Text Properties

Text properties control typography, styling, and behavior of text widgets. All text properties accept design tokens, numeric values, or custom values through the unified FlyValue system.

### Code Example
```dart
FlyText('Hello World')
  .text('lg')           // Text style (fontSize + height)
  .color('primary')     // Text color
  .weight('bold')       // Font weight
  .font('sans')         // Font family
  .leading('tight')     // Line height
  .tracking('wide')     // Letter spacing
  .align('center')      // Text alignment
  .uppercase()          // Text transformation
  .underline()          // Text decoration
  .p('s4')             // Padding
  .m('s2');            // Margin
```

## Supported Properties

| Flywind Helper | Tailwind Class | Flutter Widget | Description |
|---|---|---|---|
| `.text(<flyValue>)` | `.text-*` | `TextStyle` | Text style (fontSize + height) |
| `.color(<flyValue>)` | `.text-*` | `TextStyle(color:)` | Text color |
| `.weight(<flyValue>)` | `.font-*` | `TextStyle(fontWeight:)` | Font weight |
| `.font(<flyValue>)` | `.font-*` | `TextStyle(fontFamily:)` | Font family |
| `.leading(<flyValue>)` | `.leading-*` | `TextStyle(height:)` | Line height |
| `.tracking(<flyValue>)` | `.tracking-*` | `TextStyle(letterSpacing:)` | Letter spacing |
| `.align(<flyValue>)` | `.text-*` | `Text(textAlign:)` | Text alignment |
| `.uppercase()` | `.uppercase` | Text transformation | Transform to uppercase |
| `.lowercase()` | `.lowercase` | Text transformation | Transform to lowercase |
| `.capitalize()` | `.capitalize` | Text transformation | Capitalize words |
| `.underline()` | `.underline` | `TextStyle(decoration:)` | Underline decoration |
| `.lineThrough()` | `.line-through` | `TextStyle(decoration:)` | Line-through decoration |
| `.overline()` | `.overline` | `TextStyle(decoration:)` | Overline decoration |
| `.noDecoration()` | `.no-underline` | `TextStyle(decoration:)` | Remove decoration |
| `.p(<flyValue>)` | `.p-*` | `FlyPadding` | Padding |
| `.m(<flyValue>)` | `.m-*` | `FlyMargin` | Margin |
| `.flex(<flyValue>)` | `.flex-*` | `FlyFlex` | Flex |
| `.top(<flyValue>)` | `.top-*` | `FlyPosition` | Position |

## Not Implemented

### Missing Text Properties

| Text Property | Tailwind Class | Flutter Widget | Description |
|---|---|---|---|
| `textDirection` | `.rtl`, `.ltr` | `Text(textDirection:)` | Text direction (LTR/RTL) |
| `locale` | `.locale-*` | `Text(locale:)` | Text locale |
| `softWrap` | `.whitespace-*` | `Text(softWrap:)` | Soft wrap behavior |
| `overflow` | `.truncate`, `.overflow-*` | `Text(overflow:)` | Text overflow behavior |
| `textScaler` | `.text-scale-*` | `Text(textScaler:)` | Text scaling |
| `maxLines` | `.line-clamp-*` | `Text(maxLines:)` | Maximum number of lines |
| `semanticsLabel` | `.sr-only` | `Text(semanticsLabel:)` | Semantic label |
| `textWidthBasis` | `.text-width-*` | `Text(textWidthBasis:)` | Text width basis |
| `textHeightBehavior` | `.text-height-*` | `Text(textHeightBehavior:)` | Text height behavior |

**Note:** These properties are available through direct constructor access but not as utility methods.

## Text API

### Direct Flutter API Access

Access the underlying Flutter `Text` widget with direct property configuration in the constructor:

```dart
// Direct Text properties in constructor
FlyText(
  'Hello World',
  textStyle: TextStyle( // TODO: should be style but conflicts with FlyStyle
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
    fontFamily: 'Inter',
    height: 1.5,
    letterSpacing: 0.5,
    decoration: TextDecoration.underline,
  ),
  textAlign: TextAlign.center,
  textDirection: TextDirection.ltr,
  locale: Locale('en', 'US'),
  softWrap: true,
  overflow: TextOverflow.ellipsis,
  textScaler: TextScaler.linear(1.2),
  maxLines: 2,
  semanticsLabel: 'Greeting text',
  textWidthBasis: TextWidthBasis.longestLine,
  textHeightBehavior: TextHeightBehavior(
    applyHeightToFirstAscent: true,
    applyHeightToLastDescent: true,
  ),
);

// Mixed with utility methods
FlyText(
  'Hello World',
  textAlign: TextAlign.center,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)
  .text('lg')
  .weight('bold')
  .color('primary')
  .font('sans')
  .leading('tight')
  .tracking('wide')
  .underline();
```

## Default Values

The `FlyText` widget applies sensible defaults when no explicit values are provided:

- **Text Style**: `base` (16px font size, 1.5 line height)
- **Text Color**: `gray900` (dark gray for good contrast)
- **Font Weight**: `normal` (FontWeight.w400)
- **Font Family**: `sans` (Roboto, Helvetica, sans-serif stack)
- **Line Height**: `normal` (1.5)
- **Letter Spacing**: `normal` (0.0)
- **Text Alignment**: `left`
- **Text Transform**: `none`
- **Text Decoration**: `none`

These defaults ensure consistent typography across the application while maintaining Tailwind-like conventions.

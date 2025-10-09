# Image Specification

## Overview

This specification defines the requirements for implementing Flywind's image system. The system provides Tailwind-like image utilities that map to Flutter's `Image` widget and its associated properties for controlling image display, sizing, positioning, and styling.

## Image Properties

Image properties control the display, sizing, positioning, and styling of images. All image properties accept spacing tokens, numeric values, or custom values through the unified FlyValue system.

### Code Example
```dart
FlyImage(
  imageUrl: 'https://example.com/image.jpg',
  child: FlyText('Loading...'),
)
  .w('s64')              // Width
  .h('s48')              // Height
  .object('cover')       // Object fit
  .rounded('lg')         // Border radius
  .p('s2')               // Padding
  .m('s4')               // Margin
  .top('s2')             // Position
  .left('s4');           // Position
```

## Supported Properties

| Flywind Helper | Tailwind Class | Flutter Widget | Description |
|---|---|---|---|
| `.w(*)` | `.w-*` | `Image(width:)` | Width |
| `.h(*)` | `.h-*` | `Image(height:)` | Height |
| `.object(*)` | `.object-*` | `Image(fit:)` | Object fit (BoxFit) |
| `.rounded(*)` | `.rounded-*` | `ClipRRect(borderRadius:)` | Border radius |
| `.p(*)` | `.p-*` | `FlyPadding` | Padding |
| `.m(*)` | `.m-*` | `FlyMargin` | Margin |
| `.top(*)` | `.top-*` | `FlyPosition` | Position |
| `.right(*)` | `.right-*` | `FlyPosition` | Position |
| `.bottom(*)` | `.bottom-*` | `FlyPosition` | Position |
| `.left(*)` | `.left-*` | `FlyPosition` | Position |
| `.inset(*)` | `.inset-*` | `FlyPosition` | Position (all sides) |

## Object Fit Values

| Flywind Value | Tailwind Class | Flutter BoxFit | Description |
|---|---|---|---|
| `'cover'` | `.object-cover` | `BoxFit.cover` | Scale to cover entire area, may crop |
| `'contain'` | `.object-contain` | `BoxFit.contain` | Scale to fit within area, no cropping |
| `'fill'` | `.object-fill` | `BoxFit.fill` | Stretch to fill area, may distort |
| `'scaleDown'` | `.object-scale-down` | `BoxFit.scaleDown` | Scale down only if larger than area |
| `'none'` | `.object-none` | `BoxFit.none` | No scaling, use original size |
| `'fitWidth'` | `.object-scale-down` | `BoxFit.fitWidth` | Scale to fit width |
| `'fitHeight'` | `.object-scale-down` | `BoxFit.fitHeight` | Scale to fit height |

## Image Sources

### Network Images
```dart
FlyImage(
  imageUrl: 'https://example.com/image.jpg',
).w('s64').h('s48');
```

### Asset Images
```dart
FlyImage(
  assetPath: 'assets/images/logo.png',
).w('s32').h('s32');
```

### Custom ImageProvider
```dart
FlyImage(
  imageProvider: MemoryImage(bytes),
).w('s48').h('s48');
```

## Loading and Error States

### Custom Loading Widget
```dart
FlyImage(
  imageUrl: 'https://example.com/image.jpg',
  loadingWidget: FlyBox(
    child: FlyText('Loading...').color('gray500'),
  ).w('s64').h('s48').bg('gray100').rounded('md').justify('center').items('center'),
).w('s64').h('s48');
```

### Custom Error Widget
```dart
FlyImage(
  imageUrl: 'https://invalid-url.com/image.jpg',
  errorWidget: FlyBox(
    child: FlyText('Failed to load').color('red500').text('sm'),
  ).w('s64').h('s48').bg('red50').rounded('md').justify('center').items('center'),
).w('s64').h('s48');
```

### Loading State Callback
```dart
FlyImage(
  imageUrl: 'https://example.com/image.jpg',
  onLoadingStateChange: (isLoading) {
    print('Image loading: $isLoading');
  },
).w('s64').h('s48');
```

## Not Implemented

### Missing Image Properties

| Image Property | Tailwind Class | Flutter Widget | Description |
|---|---|---|---|
| `color` | `.text-*` | `ColorFilter` | Color overlay/tinting |
| `colorBlendMode` | `.blend-*` | `ColorFilter` | Color blending mode |
| `filterQuality` | `.filter-*` | `Image(filterQuality:)` | Image filtering quality |
| `isAntiAlias` | `.antialias` | `Image(isAntiAlias:)` | Anti-aliasing |
| `repeat` | `.bg-repeat-*` | `Image(repeat:)` | Image repetition |
| `centerSlice` | `.slice-*` | `Image(centerSlice:)` | Nine-patch slice |
| `matchTextDirection` | `.rtl` | `Image(matchTextDirection:)` | RTL text direction matching |
| `gaplessPlayback` | `.gapless` | `Image(gaplessPlayback:)` | Smooth animation transitions |
| `frameBuilder` | `.frame-*` | `Image(frameBuilder:)` | Custom frame building |
| `semanticLabel` | `.sr-only` | `Image(semanticLabel:)` | Accessibility label |

**Note:** These properties are available through direct constructor access but not as utility methods.

## Image API

### Direct Flutter API Access

Access the underlying Flutter `Image` widget with direct property configuration in the constructor:

```dart
// Direct Image properties in constructor
FlyImage(
  imageUrl: 'https://example.com/image.jpg',
  width: 200,
  height: 150,
  fit: BoxFit.cover,
  alignment: Alignment.center,
  repeat: ImageRepeat.noRepeat,
  centerSlice: Rect.fromLTRB(10, 10, 20, 20),
  matchTextDirection: false,
  gaplessPlayback: true,
  filterQuality: FilterQuality.high,
  isAntiAlias: true,
  color: Colors.blue,
  colorBlendMode: BlendMode.multiply,
  semanticLabel: 'Profile picture',
  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
    if (wasSynchronouslyLoaded) return child;
    return AnimatedOpacity(
      opacity: frame == null ? 0 : 1,
      duration: const Duration(milliseconds: 300),
      child: child,
    );
  },
);

// Mixed with utility methods
FlyImage(
  imageUrl: 'https://example.com/image.jpg',
  alignment: Alignment.center,
  filterQuality: FilterQuality.high,
)
  .w('s64')
  .h('s48')
  .object('cover')
  .rounded('lg');
```

## Layout Considerations

### Flex Layout
Images with flex properties should be wrapped in a flex container:

```dart
// ❌ This will break - flex without container
FlyImage(imageUrl: '...').flex(1)

// ✅ This works - wrapped in flex container
FlyBox(
  children: [
    FlyBox(child: FlyImage('...')).flex(1),
    FlyBox(child: FlyImage('...')).flex(2),
  ],
).row()
```

### Styling with FlyBox
For visual styling (colors, borders), wrap images in `FlyBox`:

```dart
// ❌ This won't work - FlyImage doesn't support colors
FlyImage(imageUrl: '...').bg('blue100').border(2)

// ✅ This works - wrapped in FlyBox
FlyBox(
  child: FlyImage(imageUrl: '...'),
).bg('blue100').border(2).borderColor('blue500').rounded('lg')
```

## Performance Considerations

### Image Caching
Network images are automatically cached by Flutter's image system. For custom caching strategies, use a custom `ImageProvider`:

```dart
FlyImage(
  imageProvider: CachedNetworkImageProvider('https://example.com/image.jpg'),
).w('s64').h('s48');
```

### Memory Management
Large images should be sized appropriately to avoid memory issues:

```dart
// Good - explicit sizing
FlyImage(imageUrl: '...').w('s64').h('s48')

// Avoid - no size constraints on large images
FlyImage(imageUrl: '...')  // May load full resolution
```

## Accessibility

### Semantic Labels
Use the `semanticLabel` parameter for screen readers:

```dart
FlyImage(
  imageUrl: 'https://example.com/logo.png',
  semanticLabel: 'Company logo',
).w('s32').h('s32');
```

### Error Handling
Always provide meaningful error widgets for better user experience:

```dart
FlyImage(
  imageUrl: 'https://example.com/image.jpg',
  errorWidget: FlyBox(
    child: Column(
      children: [
        FlyIcon(Icons.broken_image).color('gray400').w('s8').h('s8'),
        FlyText('Image unavailable').color('gray500').text('xs'),
      ],
    ),
  ).w('s64').h('s48').justify('center').items('center'),
).w('s64').h('s48');
```

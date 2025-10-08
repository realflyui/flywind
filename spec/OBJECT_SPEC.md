# Object Specification

## Overview

This specification defines the requirements for implementing Flywind's object fitting system. The system provides Tailwind-like object utilities that map to Flutter's `BoxFit` enum for controlling how content (images, videos, etc.) should be resized and positioned within their containers.

## Object Properties

Object properties control how replaced elements (images, videos) are resized and positioned within their containers. All object properties accept `BoxFit` enum values or string tokens that map to specific fitting behaviors.

### Code Example
```dart
FlyImage(
  imageUrl: 'https://example.com/image.jpg',
)
  .w('s48')           // Set width
  .h('s32')           // Set height
  .object('cover')    // Object fit: cover
  .rounded('md');     // Border radius

// Or with BoxFit enum
FlyImage(
  imageUrl: 'https://example.com/image.jpg',
)
  .w('s48')
  .h('s32')
  .object(BoxFit.cover)
  .rounded('md');
```

### Supported Properties

| Flywind Helper | Tailwind Class | Flutter Widget | Description |
|---|---|---|---|
| `.object('cover')` | `.object-cover` | `Image(fit: BoxFit.cover)` | Scales to fill container, may crop |
| `.object('contain')` | `.object-contain` | `Image(fit: BoxFit.contain)` | Scales to fit entirely within container |
| `.object('fill')` | `.object-fill` | `Image(fit: BoxFit.fill)` | Stretches to fill container exactly |
| `.object('scaleDown')` | `.object-scale-down` | `Image(fit: BoxFit.scaleDown)` | Scales down only if larger than container |
| `.object('none')` | `.object-none` | `Image(fit: BoxFit.none)` | No scaling, positioned at top-left |

### Not Implemented

| Flywind Helper | Tailwind Class | Flutter Widget | Description |
|---|---|---|---|
| `.object('fitWidth')` | *No Tailwind equivalent* | `Image(fit: BoxFit.fitWidth)` | Scales to fit container width |
| `.object('fitHeight')` | *No Tailwind equivalent* | `Image(fit: BoxFit.fitHeight)` | Scales to fit container height |

**Note:** Flutter-specific object fit properties (`.object('fitWidth')` and `.object('fitHeight')`) are not yet implemented. These provide more granular control than standard CSS object-fit properties and would require additional Flutter-specific handling.

### BoxFit Behavior Details

| BoxFit Value | Behavior | Use Cases |
|---|---|---|
| `cover` | Scales to maintain aspect ratio while filling the entire container. The image may be clipped. | Hero images, backgrounds, thumbnails |
| `contain` | Scales to maintain aspect ratio while fitting entirely within the container. The entire image is visible. | Logos, icons, full image display |
| `fill` | Stretches the image to fill the container exactly. May distort aspect ratio. | When exact dimensions are required |
| `scaleDown` | Scales down only if the image is larger than the container, otherwise maintains original size. | Responsive images that don't grow |
| `none` | No scaling applied. Image is positioned at the top-left corner of the container. | Pixel-perfect images, sprites |
| `fitWidth` | Scales to fit the width of the container while maintaining aspect ratio. | Horizontal banners, wide content |
| `fitHeight` | Scales to fit the height of the container while maintaining aspect ratio. | Vertical banners, tall content |

## Value Resolution

The `.object()` method accepts both `BoxFit` enum values and string tokens:

```dart
// BoxFit enum values
.object(BoxFit.cover)
.object(BoxFit.contain)
.object(BoxFit.fill)
.object(BoxFit.scaleDown)
.object(BoxFit.none)

// String tokens (case-insensitive)
.object('cover')
.object('contain')
.object('fill')
.object('scaledown')      // or 'scale-down'
.object('none')
```

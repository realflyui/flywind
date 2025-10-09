// Flywind Object Mixin
//
// This mixin provides object fitting utilities for images and other objects,
// similar to Tailwind CSS object utilities.
//
// ## Available Methods
//
// - [objectCover] - object-cover (BoxFit.cover)
// - [objectContain] - object-contain (BoxFit.contain)
// - [objectFill] - object-fill (BoxFit.fill)
// - [objectScaleDown] - object-scale-down (BoxFit.scaleDown)
// - [objectNone] - object-none (BoxFit.none)
// - [objectFitWidth] - object-scale-down (BoxFit.fitWidth)
// - [objectFitHeight] - object-scale-down (BoxFit.fitHeight)
//
// ## Usage
//
// ```dart
// import 'package:flywind/helpers.dart';
//
// class MyImageWidget extends StatelessWidget with FlyObject {
//   @override
//   Widget build(BuildContext context) {
//     return Image.network('url')
//       .objectCover()
//       .w('s64')
//       .h('s48');
//   }
// }
// ```

import 'package:flutter/material.dart';

import '../core/style.dart';

/// Utility class for handling object fitting logic
class FlyObjectUtils {
  /// Parse BoxFit from string
  static BoxFit parseBoxFitFromString(String fitString) {
    switch (fitString.toLowerCase()) {
      case 'cover':
        return BoxFit.cover;
      case 'contain':
        return BoxFit.contain;
      case 'fill':
        return BoxFit.fill;
      case 'scaledown':
      case 'scale-down':
        return BoxFit.scaleDown;
      case 'none':
        return BoxFit.none;
      default:
        throw ArgumentError(
          'Invalid object fit value: $fitString. Valid values are: cover, contain, fill, scaleDown, none',
        );
    }
  }
}

/// Mixin that provides object fitting utilities for images and other objects
mixin FlyObject<T> {
  FlyStyle get flyStyle;

  T Function(FlyStyle newStyle) get copyWith;

  /// Set object fit - accepts BoxFit or String ('cover', 'contain', 'fill', 'scaleDown', 'none')
  ///
  /// Examples:
  /// - object('cover') - scales to fill, may crop (equivalent to object-cover in Tailwind)
  /// - object('contain') - scales to fit entirely (equivalent to object-contain in Tailwind)
  /// - object('fill') - stretches to fill exactly (equivalent to object-fill in Tailwind)
  /// - object('scaleDown') - scales down only if needed (equivalent to object-scale-down in Tailwind)
  /// - object('none') - no scaling (equivalent to object-none in Tailwind)
  T object(dynamic value) {
    if (value is BoxFit) {
      return copyWith(flyStyle.copyWith(object: value));
    } else if (value is String) {
      return copyWith(
        flyStyle.copyWith(object: FlyObjectUtils.parseBoxFitFromString(value)),
      );
    } else {
      throw ArgumentError(
        'Object fit value must be BoxFit or String, got: $value',
      );
    }
  }
}

import 'package:flutter/material.dart';

import '../../../helpers/style.dart';

/// Handles alignment resolution for FlyBox widgets
class BoxAlignment {
  /// Resolve alignment from layout utilities (justify and items)
  static AlignmentGeometry? resolveFromLayoutUtilities(FlyStyle flyStyle) {
    // Only resolve if both justify and items are set to 'center'
    if (flyStyle.justify == 'center' && flyStyle.items == 'center') {
      return Alignment.center;
    }

    // Handle other combinations
    if (flyStyle.justify == 'center' && flyStyle.items == 'start') {
      return Alignment.centerLeft;
    }

    if (flyStyle.justify == 'center' && flyStyle.items == 'end') {
      return Alignment.centerRight;
    }

    if (flyStyle.justify == 'start' && flyStyle.items == 'center') {
      return Alignment.topCenter;
    }

    if (flyStyle.justify == 'end' && flyStyle.items == 'center') {
      return Alignment.bottomCenter;
    }

    if (flyStyle.justify == 'start' && flyStyle.items == 'start') {
      return Alignment.topLeft;
    }

    if (flyStyle.justify == 'start' && flyStyle.items == 'end') {
      return Alignment.topRight;
    }

    if (flyStyle.justify == 'end' && flyStyle.items == 'start') {
      return Alignment.bottomLeft;
    }

    if (flyStyle.justify == 'end' && flyStyle.items == 'end') {
      return Alignment.bottomRight;
    }

    // Default to no alignment if utilities don't map to a single alignment
    return null;
  }
}

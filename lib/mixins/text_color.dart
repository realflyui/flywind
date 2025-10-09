import '../core/style.dart';

/// Mixin that provides text color methods for text widgets
mixin FlyTextColor<T> {
  FlyStyle get flyStyle;

  T Function(FlyStyle newStyle) get copyWith;

  /// Set text color - accepts Color object or String (token name/hex)
  T color(dynamic value) {
    return copyWith(flyStyle.copyWith(color: value));
  }
}

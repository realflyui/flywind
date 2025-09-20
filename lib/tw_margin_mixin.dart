import 'tw_style.dart';

/// Mixin that provides Tailwind-like margin methods for any widget
mixin TwMarginMixin<T> {
  TwStyle get style;
  
  T Function(TwStyle newStyle) get copyWith;

  /// Set uniform margin using token scale
  T m(int step) {
    return copyWith(style.copyWith(m: step));
  }

  /// Set horizontal margin (left + right) using token scale
  T mx(int step) {
    return copyWith(style.copyWith(mx: step));
  }

  /// Set vertical margin (top + bottom) using token scale
  T my(int step) {
    return copyWith(style.copyWith(my: step));
  }

  /// Set top margin using token scale
  T mt(int step) {
    return copyWith(style.copyWith(mt: step));
  }

  /// Set right margin using token scale
  T mr(int step) {
    return copyWith(style.copyWith(mr: step));
  }

  /// Set bottom margin using token scale
  T mb(int step) {
    return copyWith(style.copyWith(mb: step));
  }

  /// Set left margin using token scale
  T ml(int step) {
    return copyWith(style.copyWith(ml: step));
  }
}

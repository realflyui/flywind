import 'tw_style.dart';

/// Mixin that provides Tailwind-like padding methods for any widget
mixin TwPaddingMixin<T> {
  TwStyle get style;
  
  T Function(TwStyle newStyle) get copyWith;

  /// Set uniform padding using token scale
  T p(int step) {
    return copyWith(style.copyWith(p: step));
  }

  /// Set horizontal padding (left + right) using token scale
  T px(int step) {
    return copyWith(style.copyWith(px: step));
  }

  /// Set vertical padding (top + bottom) using token scale
  T py(int step) {
    return copyWith(style.copyWith(py: step));
  }

  /// Set top padding using token scale
  T pt(int step) {
    return copyWith(style.copyWith(pt: step));
  }

  /// Set right padding using token scale
  T pr(int step) {
    return copyWith(style.copyWith(pr: step));
  }

  /// Set bottom padding using token scale
  T pb(int step) {
    return copyWith(style.copyWith(pb: step));
  }

  /// Set left padding using token scale
  T pl(int step) {
    return copyWith(style.copyWith(pl: step));
  }
}

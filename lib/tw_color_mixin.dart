import 'tw_style.dart';

/// Mixin that provides Tailwind-like color methods for any widget
mixin TwColorMixin<T> {
  TwStyle get style;
  
  T Function(TwStyle newStyle) get copyWith;

  /// Set text color using named token
  T color(String key) {
    return copyWith(style.copyWith(color: key));
  }
}

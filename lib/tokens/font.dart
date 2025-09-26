// GENERATED FILE - DO NOT EDIT MANUALLY
// To regenerate, run: dart cli/generate_defaults.dart

import '../core/token.dart';

/// Font family stacks (sans, serif, mono)
class FlyFontToken implements FlyToken<List<String>> {
  const FlyFontToken({
    required this.sans,
    required this.serif,
    required this.mono,
    this.extras = const {},
  });

  /// sans Font family stacks (sans, serif, mono)
  final List<String> sans;
  /// serif Font family stacks (sans, serif, mono)
  final List<String> serif;
  /// mono Font family stacks (sans, serif, mono)
  final List<String> mono;

  /// Additional custom values
  final Map<String, List<String>> extras;

  /// All values in a single map for easier iteration
  Map<String, List<String>> get _allValues => {
    'sans': sans,
    'serif': serif,
    'mono': mono,
    ...extras,
  };

  /// Access value by key (canonical or extra)
  @override
  List<String>? operator[](String key) => _allValues[key];

  /// Get all available keys (canonical + extras)
  @override
  Iterable<String> get keys => _allValues.keys;

  /// Put a new value for the given key
  @override
  FlyFontToken put(String key, List<String> value) {
    switch (key) {
      case 'sans':
        return copyWith(sans: value);
      case 'serif':
        return copyWith(serif: value);
      case 'mono':
        return copyWith(mono: value);
      default:
        final newExtras = Map<String, List<String>>.from(extras);
        newExtras[key] = value;
        return copyWith(extras: newExtras);
    }
  }

  /// Merge another token into this one (right side wins)
  @override
  FlyFontToken merge(FlyToken<List<String>> other) {
    if (other is! FlyFontToken) return this;
    
    return copyWith(
      sans: other.sans,
      serif: other.serif,
      mono: other.mono,
      extras: {...extras, ...other.extras},
    );
  }

  /// Create a copy with updated values
  FlyFontToken copyWith({
    List<String>? sans,
    List<String>? serif,
    List<String>? mono,
    Map<String, List<String>>? extras,
  }) {
    return FlyFontToken(
      sans: sans ?? this.sans,
      serif: serif ?? this.serif,
      mono: mono ?? this.mono,
      extras: extras ?? this.extras,
    );
  }

  /// Create default values
  static FlyFontToken defaultFont() {
    return const FlyFontToken(
      sans: ["Roboto", "Helvetica", "sans-serif"],
      serif: ["Noto Serif", "Georgia", "Cambria", "Times New Roman", "Times", "serif"],
      mono: ["Roboto Mono", "SFMono-Regular", "Menlo", "Monaco", "Consolas", "Liberation Mono", "Courier New", "monospace"],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FlyFontToken && _allValues.toString() == other._allValues.toString();
  }

  @override
  int get hashCode => _allValues.hashCode;
}

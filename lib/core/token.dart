/// Base interface for all Fly tokens
///
/// Provides a consistent API for accessing, modifying, and merging design tokens.
/// All token types (spacing, colors, etc.) must implement this interface.
///
/// Example usage:
/// ```dart
/// final spacing = FlySpacingBase.defaultSpacing();
/// final value = spacing['medium']; // Access token
/// final updated = spacing.put('large', 32.0); // Create new instance with update
/// final merged = spacing.merge(otherSpacing); // Merge with another token
/// ```
abstract class FlyToken<T> {
  /// Access token value by key using bracket notation
  ///
  /// Returns the token value for the given key, or null if not found.
  /// Supports both canonical keys (defined in the token class) and custom keys.
  T? operator [](String key);

  /// Get all available keys
  ///
  /// Returns an iterable of all keys available in this token,
  /// including both canonical and custom keys.
  Iterable<String> get keys;

  /// Put a new value for the given key
  ///
  /// Creates a new token instance with the updated value.
  /// The original token remains unchanged (immutable pattern).
  FlyToken<T> put(String key, T value);

  /// Merge another token into this one (right side wins)
  ///
  /// Creates a new token instance by merging this token with another.
  /// Values from the other token take precedence over this token's values.
  FlyToken<T> merge(FlyToken<T> other);
}

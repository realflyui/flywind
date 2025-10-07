// GENERATED FILE - DO NOT EDIT MANUALLY
// To regenerate, run: dart cli/generate_defaults.dart

import '../core/token.dart';

/// Spacing values for margins and padding
class FlySpacingToken implements FlyToken<double> {
  const FlySpacingToken({
    required this.base,
    required this.px,
    required this.s0,
    required this.s05,
    required this.s1,
    required this.s15,
    required this.s2,
    required this.s25,
    required this.s3,
    required this.s35,
    required this.s4,
    required this.s5,
    required this.s6,
    required this.s7,
    required this.s8,
    required this.s9,
    required this.s10,
    required this.s11,
    required this.s12,
    required this.s14,
    required this.s16,
    required this.s20,
    required this.s24,
    required this.s28,
    required this.s32,
    required this.s36,
    required this.s40,
    required this.s44,
    required this.s48,
    required this.s52,
    required this.s56,
    required this.s60,
    required this.s64,
    required this.s72,
    required this.s80,
    required this.s96,
    this.extras = const {},
  });

  /// base Spacing values for margins and padding
  final double base;

  /// px Spacing values for margins and padding
  final double px;

  /// s0 Spacing values for margins and padding
  final double s0;

  /// s0_5 Spacing values for margins and padding
  final double s05;

  /// s1 Spacing values for margins and padding
  final double s1;

  /// s1_5 Spacing values for margins and padding
  final double s15;

  /// s2 Spacing values for margins and padding
  final double s2;

  /// s2_5 Spacing values for margins and padding
  final double s25;

  /// s3 Spacing values for margins and padding
  final double s3;

  /// s3_5 Spacing values for margins and padding
  final double s35;

  /// s4 Spacing values for margins and padding
  final double s4;

  /// s5 Spacing values for margins and padding
  final double s5;

  /// s6 Spacing values for margins and padding
  final double s6;

  /// s7 Spacing values for margins and padding
  final double s7;

  /// s8 Spacing values for margins and padding
  final double s8;

  /// s9 Spacing values for margins and padding
  final double s9;

  /// s10 Spacing values for margins and padding
  final double s10;

  /// s11 Spacing values for margins and padding
  final double s11;

  /// s12 Spacing values for margins and padding
  final double s12;

  /// s14 Spacing values for margins and padding
  final double s14;

  /// s16 Spacing values for margins and padding
  final double s16;

  /// s20 Spacing values for margins and padding
  final double s20;

  /// s24 Spacing values for margins and padding
  final double s24;

  /// s28 Spacing values for margins and padding
  final double s28;

  /// s32 Spacing values for margins and padding
  final double s32;

  /// s36 Spacing values for margins and padding
  final double s36;

  /// s40 Spacing values for margins and padding
  final double s40;

  /// s44 Spacing values for margins and padding
  final double s44;

  /// s48 Spacing values for margins and padding
  final double s48;

  /// s52 Spacing values for margins and padding
  final double s52;

  /// s56 Spacing values for margins and padding
  final double s56;

  /// s60 Spacing values for margins and padding
  final double s60;

  /// s64 Spacing values for margins and padding
  final double s64;

  /// s72 Spacing values for margins and padding
  final double s72;

  /// s80 Spacing values for margins and padding
  final double s80;

  /// s96 Spacing values for margins and padding
  final double s96;

  /// Additional custom values
  final Map<String, double> extras;

  /// All values in a single map for easier iteration
  Map<String, double> get _allValues => {
    'base': base,
    'px': px,
    's0': s0,
    's05': s05,
    's1': s1,
    's15': s15,
    's2': s2,
    's25': s25,
    's3': s3,
    's35': s35,
    's4': s4,
    's5': s5,
    's6': s6,
    's7': s7,
    's8': s8,
    's9': s9,
    's10': s10,
    's11': s11,
    's12': s12,
    's14': s14,
    's16': s16,
    's20': s20,
    's24': s24,
    's28': s28,
    's32': s32,
    's36': s36,
    's40': s40,
    's44': s44,
    's48': s48,
    's52': s52,
    's56': s56,
    's60': s60,
    's64': s64,
    's72': s72,
    's80': s80,
    's96': s96,
    ...extras,
  };

  /// Access value by key (canonical or extra)
  @override
  double? operator [](String key) => _allValues[key];

  /// Get all available keys (canonical + extras)
  @override
  Iterable<String> get keys => _allValues.keys;

  /// Put a new value for the given key
  @override
  FlySpacingToken put(String key, double value) {
    switch (key) {
      case 'base':
        return copyWith(base: value);
      case 'px':
        return copyWith(px: value);
      case 's0':
        return copyWith(s0: value);
      case 's05':
        return copyWith(s05: value);
      case 's1':
        return copyWith(s1: value);
      case 's15':
        return copyWith(s15: value);
      case 's2':
        return copyWith(s2: value);
      case 's25':
        return copyWith(s25: value);
      case 's3':
        return copyWith(s3: value);
      case 's35':
        return copyWith(s35: value);
      case 's4':
        return copyWith(s4: value);
      case 's5':
        return copyWith(s5: value);
      case 's6':
        return copyWith(s6: value);
      case 's7':
        return copyWith(s7: value);
      case 's8':
        return copyWith(s8: value);
      case 's9':
        return copyWith(s9: value);
      case 's10':
        return copyWith(s10: value);
      case 's11':
        return copyWith(s11: value);
      case 's12':
        return copyWith(s12: value);
      case 's14':
        return copyWith(s14: value);
      case 's16':
        return copyWith(s16: value);
      case 's20':
        return copyWith(s20: value);
      case 's24':
        return copyWith(s24: value);
      case 's28':
        return copyWith(s28: value);
      case 's32':
        return copyWith(s32: value);
      case 's36':
        return copyWith(s36: value);
      case 's40':
        return copyWith(s40: value);
      case 's44':
        return copyWith(s44: value);
      case 's48':
        return copyWith(s48: value);
      case 's52':
        return copyWith(s52: value);
      case 's56':
        return copyWith(s56: value);
      case 's60':
        return copyWith(s60: value);
      case 's64':
        return copyWith(s64: value);
      case 's72':
        return copyWith(s72: value);
      case 's80':
        return copyWith(s80: value);
      case 's96':
        return copyWith(s96: value);
      default:
        final newExtras = Map<String, double>.from(extras);
        newExtras[key] = value;
        return copyWith(extras: newExtras);
    }
  }

  /// Merge another token into this one (right side wins)
  @override
  FlySpacingToken merge(FlyToken<double> other) {
    if (other is! FlySpacingToken) return this;

    return copyWith(
      base: other.base,
      px: other.px,
      s0: other.s0,
      s05: other.s05,
      s1: other.s1,
      s15: other.s15,
      s2: other.s2,
      s25: other.s25,
      s3: other.s3,
      s35: other.s35,
      s4: other.s4,
      s5: other.s5,
      s6: other.s6,
      s7: other.s7,
      s8: other.s8,
      s9: other.s9,
      s10: other.s10,
      s11: other.s11,
      s12: other.s12,
      s14: other.s14,
      s16: other.s16,
      s20: other.s20,
      s24: other.s24,
      s28: other.s28,
      s32: other.s32,
      s36: other.s36,
      s40: other.s40,
      s44: other.s44,
      s48: other.s48,
      s52: other.s52,
      s56: other.s56,
      s60: other.s60,
      s64: other.s64,
      s72: other.s72,
      s80: other.s80,
      s96: other.s96,
      extras: {...extras, ...other.extras},
    );
  }

  /// Create a copy with updated values
  FlySpacingToken copyWith({
    double? base,
    double? px,
    double? s0,
    double? s05,
    double? s1,
    double? s15,
    double? s2,
    double? s25,
    double? s3,
    double? s35,
    double? s4,
    double? s5,
    double? s6,
    double? s7,
    double? s8,
    double? s9,
    double? s10,
    double? s11,
    double? s12,
    double? s14,
    double? s16,
    double? s20,
    double? s24,
    double? s28,
    double? s32,
    double? s36,
    double? s40,
    double? s44,
    double? s48,
    double? s52,
    double? s56,
    double? s60,
    double? s64,
    double? s72,
    double? s80,
    double? s96,
    Map<String, double>? extras,
  }) {
    return FlySpacingToken(
      base: base ?? this.base,
      px: px ?? this.px,
      s0: s0 ?? this.s0,
      s05: s05 ?? this.s05,
      s1: s1 ?? this.s1,
      s15: s15 ?? this.s15,
      s2: s2 ?? this.s2,
      s25: s25 ?? this.s25,
      s3: s3 ?? this.s3,
      s35: s35 ?? this.s35,
      s4: s4 ?? this.s4,
      s5: s5 ?? this.s5,
      s6: s6 ?? this.s6,
      s7: s7 ?? this.s7,
      s8: s8 ?? this.s8,
      s9: s9 ?? this.s9,
      s10: s10 ?? this.s10,
      s11: s11 ?? this.s11,
      s12: s12 ?? this.s12,
      s14: s14 ?? this.s14,
      s16: s16 ?? this.s16,
      s20: s20 ?? this.s20,
      s24: s24 ?? this.s24,
      s28: s28 ?? this.s28,
      s32: s32 ?? this.s32,
      s36: s36 ?? this.s36,
      s40: s40 ?? this.s40,
      s44: s44 ?? this.s44,
      s48: s48 ?? this.s48,
      s52: s52 ?? this.s52,
      s56: s56 ?? this.s56,
      s60: s60 ?? this.s60,
      s64: s64 ?? this.s64,
      s72: s72 ?? this.s72,
      s80: s80 ?? this.s80,
      s96: s96 ?? this.s96,
      extras: extras ?? this.extras,
    );
  }

  /// Linear interpolation between two tokens
  FlySpacingToken lerp(FlySpacingToken other, double t) {
    final result = <String, double>{};
    final allKeys = {..._allValues.keys, ...other._allValues.keys};

    for (final key in allKeys) {
      final valueA = _allValues[key];
      final valueB = other._allValues[key];
      final numA = valueA ?? 0.0;
      final numB = valueB ?? 0.0;
      result[key] = numA + (numB - numA) * t;
    }

    return FlySpacingToken(
      base: result['base']!,
      px: result['px']!,
      s0: result['s0']!,
      s05: result['s05']!,
      s1: result['s1']!,
      s15: result['s15']!,
      s2: result['s2']!,
      s25: result['s25']!,
      s3: result['s3']!,
      s35: result['s35']!,
      s4: result['s4']!,
      s5: result['s5']!,
      s6: result['s6']!,
      s7: result['s7']!,
      s8: result['s8']!,
      s9: result['s9']!,
      s10: result['s10']!,
      s11: result['s11']!,
      s12: result['s12']!,
      s14: result['s14']!,
      s16: result['s16']!,
      s20: result['s20']!,
      s24: result['s24']!,
      s28: result['s28']!,
      s32: result['s32']!,
      s36: result['s36']!,
      s40: result['s40']!,
      s44: result['s44']!,
      s48: result['s48']!,
      s52: result['s52']!,
      s56: result['s56']!,
      s60: result['s60']!,
      s64: result['s64']!,
      s72: result['s72']!,
      s80: result['s80']!,
      s96: result['s96']!,
      extras: Map.fromEntries(
        result.entries.where(
          (e) => ![
            'base',
            'px',
            's0',
            's05',
            's1',
            's15',
            's2',
            's25',
            's3',
            's35',
            's4',
            's5',
            's6',
            's7',
            's8',
            's9',
            's10',
            's11',
            's12',
            's14',
            's16',
            's20',
            's24',
            's28',
            's32',
            's36',
            's40',
            's44',
            's48',
            's52',
            's56',
            's60',
            's64',
            's72',
            's80',
            's96',
          ].contains(e.key),
        ),
      ),
    );
  }

  /// Create default values
  static FlySpacingToken defaultSpacing() {
    return const FlySpacingToken(
      base: 4.0,
      px: 1.0,
      s0: 0.0,
      s05: 2.0,
      s1: 4.0,
      s15: 6.0,
      s2: 8.0,
      s25: 10.0,
      s3: 12.0,
      s35: 14.0,
      s4: 16.0,
      s5: 20.0,
      s6: 24.0,
      s7: 28.0,
      s8: 32.0,
      s9: 36.0,
      s10: 40.0,
      s11: 44.0,
      s12: 48.0,
      s14: 56.0,
      s16: 64.0,
      s20: 80.0,
      s24: 96.0,
      s28: 112.0,
      s32: 128.0,
      s36: 144.0,
      s40: 160.0,
      s44: 176.0,
      s48: 192.0,
      s52: 208.0,
      s56: 224.0,
      s60: 240.0,
      s64: 256.0,
      s72: 288.0,
      s80: 320.0,
      s96: 384.0,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FlySpacingToken &&
        _allValues.toString() == other._allValues.toString();
  }

  @override
  int get hashCode => _allValues.hashCode;
}

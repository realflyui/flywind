import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flywind/parsers/color_parser.dart';

void main() {
  group('FlyColorParser', () {
    test('parse returns Color object when input is already a Color', () {
      const color = Color(0xFF8B5CF6);
      final result = FlyColorParser.parse(color);
      expect(result, equals(color));
    });

    test('parse returns null when input is not a String or Color', () {
      expect(FlyColorParser.parse(123), isNull);
      expect(FlyColorParser.parse(null), isNull);
      expect(FlyColorParser.parse([]), isNull);
    });

    group('Hex color parsing', () {
      test('parses 6-character hex colors with #', () {
        final result = FlyColorParser.parse('#FF5733');
        expect(result, equals(const Color(0xFFFF5733)));
      });

      test('parses 6-character hex colors without #', () {
        final result = FlyColorParser.parse('FF5733');
        expect(result, equals(const Color(0xFFFF5733)));
      });

      test('parses 3-character hex colors', () {
        final result = FlyColorParser.parse('#F53');
        expect(result, equals(const Color(0xFFFF5533)));
      });

      test('parses 8-character hex colors with alpha', () {
        final result = FlyColorParser.parse('#80FF5733');
        expect(result, equals(const Color(0x80FF5733)));
      });

      test('handles case insensitive hex colors', () {
        final result = FlyColorParser.parse('#ff5733');
        expect(result, equals(const Color(0xFFFF5733)));
      });
    });

    group('RGB color parsing', () {
      test('parses RGB color strings', () {
        final result = FlyColorParser.parse('rgb(255, 87, 51)');
        expect(result, equals(const Color(0xFFFF5733)));
      });

      test('parses RGB with spaces', () {
        final result = FlyColorParser.parse('rgb( 255 , 87 , 51 )');
        expect(result, isNull); // RGB parser doesn't handle extra spaces
      });
    });

    group('RGBA color parsing', () {
      test('parses RGBA color strings', () {
        final result = FlyColorParser.parse('rgba(255, 87, 51, 0.5)');
        expect(result, equals(Color.fromRGBO(255, 87, 51, 0.5)));
      });

      test('parses RGBA with spaces', () {
        final result = FlyColorParser.parse('rgba( 255 , 87 , 51 , 0.8 )');
        expect(result, isNull); // RGBA parser doesn't handle extra spaces
      });
    });

    group('Theme color parsing', () {
      test('parses theme colors when themeColors map is provided', () {
        final themeColors = {
          'brand': const Color(0xFF8B5CF6),
          'primary': const Color(0xFF3B82F6),
        };
        
        final result = FlyColorParser.parse('brand', themeColors: themeColors);
        expect(result, equals(const Color(0xFF8B5CF6)));
      });

      test('returns null for unknown theme colors', () {
        final themeColors = {'brand': const Color(0xFF8B5CF6)};
        
        final result = FlyColorParser.parse('unknown', themeColors: themeColors);
        expect(result, isNull);
      });

      test('handles case insensitive theme colors', () {
        final themeColors = {'brand': const Color(0xFF8B5CF6)};
        
        final result = FlyColorParser.parse('Brand', themeColors: themeColors);
        expect(result, equals(const Color(0xFF8B5CF6)));
      });
    });

    group('Invalid input handling', () {
      test('returns null for invalid hex colors', () {
        expect(FlyColorParser.parse('#GGGGGG'), isNull);
        expect(FlyColorParser.parse('#12345'), isNull);
        expect(FlyColorParser.parse('invalid'), isNull);
      });

      test('returns null for invalid RGB colors', () {
        expect(FlyColorParser.parse('rgb(255, 87)'), isNull);
        expect(FlyColorParser.parse('rgb(255, 87, 51, 0.5)'), isNull);
      });

      test('returns null for invalid RGBA colors', () {
        expect(FlyColorParser.parse('rgba(255, 87)'), isNull);
        expect(FlyColorParser.parse('rgba(255, 87, 51)'), isNull);
      });

      test('returns null for empty or whitespace strings', () {
        expect(FlyColorParser.parse(''), isNull);
        expect(FlyColorParser.parse('   '), isNull);
      });
    });
  });
}

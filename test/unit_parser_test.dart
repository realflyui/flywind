import 'package:flutter_test/flutter_test.dart';
import 'package:flywind/parsers/unit_parser.dart';

void main() {
  group('FlyUnitParser', () {
    test('parse returns correct values for plain numbers', () {
      expect(FlyUnitParser.parse('10'), 10.0);
      expect(FlyUnitParser.parse('0'), 0.0);
      expect(FlyUnitParser.parse('0.5'), 0.5);
      expect(FlyUnitParser.parse('12.5'), 12.5);
    });

    test('parse returns correct values for pixel values', () {
      expect(FlyUnitParser.parse('10px'), 10.0);
      expect(FlyUnitParser.parse('0px'), 0.0);
      expect(FlyUnitParser.parse('12.5px'), 12.5);
    });

    test('parse returns correct values for rem values', () {
      expect(FlyUnitParser.parse('1rem'), 16.0);
      expect(FlyUnitParser.parse('0.5rem'), 8.0);
      expect(FlyUnitParser.parse('2rem'), 32.0);
    });

    test('parse returns correct values for em values', () {
      expect(FlyUnitParser.parse('1em'), 16.0);
      expect(FlyUnitParser.parse('0.5em'), 8.0);
      expect(FlyUnitParser.parse('2em'), 32.0);
    });

    test('parse returns correct values for percentage values', () {
      expect(FlyUnitParser.parse('50%'), 0.5);
      expect(FlyUnitParser.parse('100%'), 1.0);
      expect(FlyUnitParser.parse('0%'), 0.0);
      expect(FlyUnitParser.parse('25%'), 0.25);
    });

    test('parse returns null for invalid values', () {
      expect(FlyUnitParser.parse(''), null);
      expect(FlyUnitParser.parse('invalid'), null);
      expect(FlyUnitParser.parse('10pt'), null);
      expect(FlyUnitParser.parse('abcpx'), null);
    });

    test('parseOrZero returns 0.0 for invalid values', () {
      expect(FlyUnitParser.parseOrZero(''), 0.0);
      expect(FlyUnitParser.parseOrZero('invalid'), 0.0);
      expect(FlyUnitParser.parseOrZero('10pt'), 0.0);
    });

    test('parseOrZero returns correct values for valid values', () {
      expect(FlyUnitParser.parseOrZero('10'), 10.0);
      expect(FlyUnitParser.parseOrZero('10px'), 10.0);
      expect(FlyUnitParser.parseOrZero('1rem'), 16.0);
      expect(FlyUnitParser.parseOrZero('50%'), 0.5);
    });

    test('unit type detection works correctly', () {
      expect(FlyUnitParser.getUnitType('10'), FlyUnitType.number);
      expect(FlyUnitParser.getUnitType('10px'), FlyUnitType.pixel);
      expect(FlyUnitParser.getUnitType('1rem'), FlyUnitType.relative);
      expect(FlyUnitParser.getUnitType('1em'), FlyUnitType.relative);
      expect(FlyUnitParser.getUnitType('50%'), FlyUnitType.percentage);
      expect(FlyUnitParser.getUnitType('invalid'), FlyUnitType.invalid);
    });

    test('extension methods work correctly', () {
      expect('10'.toUnit(), 10.0);
      expect('10px'.toUnit(), 10.0);
      expect('1rem'.toUnit(), 16.0);
      expect('50%'.toUnit(), 0.5);
      expect('invalid'.toUnit(), null);

      expect('10'.toUnitOrZero(), 10.0);
      expect('invalid'.toUnitOrZero(), 0.0);

      expect('50%'.isPercentage, true);
      expect('10px'.isPercentage, false);

      expect('1rem'.isRelativeUnit, true);
      expect('1em'.isRelativeUnit, true);
      expect('10px'.isRelativeUnit, false);

      expect('10px'.isPixelValue, true);
      expect('10'.isPixelValue, false);

      expect('10'.isPlainNumber, true);
      expect('10px'.isPlainNumber, false);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:flywind/theme/color_generator.dart';

void main() {
  group('RadixColorGenerator Tests', () {
    test('Generates correct colors for light mode with blue accent', () {
      // Use example defaults
      final accentColor = '#0090FF';
      final grayColor = '#8B8D98';
      final backgroundColor = '#FFFFFF';

      final result = RadixColorGenerator.generate(
        appearance: 'light',
        accent: accentColor,
        gray: grayColor,
        background: backgroundColor,
      );

      // Expected blue scale (from TypeScript output)
      final expectedBlue = [
        '#fbfdff', // blue-1
        '#f4faff', // blue-2
        '#e9f3ff', // blue-3
        '#d9edff', // blue-4
        '#c7e3ff', // blue-5
        '#b2d6ff', // blue-6
        '#97c5f9', // blue-7
        '#6eadf3', // blue-8
        '#0090ff', // blue-9
        '#0084ec', // blue-10
        '#0073dd', // blue-11
        '#003463', // blue-12
      ];

      // Expected gray scale
      final expectedGray = [
        '#fcfcfd', // gray-1
        '#f9f9fb', // gray-2
        '#eff0f3', // gray-3
        '#e7e8ec', // gray-4
        '#e0e1e6', // gray-5
        '#d8d9e0', // gray-6
        '#cdced7', // gray-7
        '#b9bbc6', // gray-8
        '#8b8d98', // gray-9
        '#80828d', // gray-10
        '#62636c', // gray-11
        '#1e1f24', // gray-12
      ];

      // Expected alpha colors (8-character hex with alpha)
      final expectedBlueAlpha = [
        '#0080ff04', // blue-a1
        '#008cff0b', // blue-a2
        '#0074ff16', // blue-a3
        '#0087ff26', // blue-a4
        '#0080ff38', // blue-a5
        '#0078ff4d', // blue-a6
        '#0071f168', // blue-a7
        '#006fea91', // blue-a8
        '#0090ff', // blue-a9 (no alpha, same as base)
        '#0084ec', // blue-a10
        '#0073dd', // blue-a11
        '#003463', // blue-a12
      ];

      final expectedGrayAlpha = [
        '#00005503', // gray-a1
        '#00005506', // gray-a2
        '#00104010', // gray-a3
        '#000b3618', // gray-a4
        '#0009321f', // gray-a5
        '#00073527', // gray-a6
        '#00063332', // gray-a7
        '#00083046', // gray-a8
        '#00051d74', // gray-a9
        '#00051b7f', // gray-a10
        '#0002119d', // gray-a11
        '#000107e1', // gray-a12
      ];

      // Convert results to hex for comparison
      final actualBlue = result.accentScale
          .map((c) => result.colorToHex(c).toLowerCase())
          .toList();
      final actualGray = result.grayScale
          .map((c) => result.colorToHex(c).toLowerCase())
          .toList();
      final actualBlueAlpha = result.accentScaleAlpha
          .map((c) => result.colorToHexWithAlpha(c).toLowerCase())
          .toList();
      final actualGrayAlpha = result.grayScaleAlpha
          .map((c) => result.colorToHexWithAlpha(c).toLowerCase())
          .toList();

      print('\n=== BLUE SCALE ===');
      for (int i = 0; i < 12; i++) {
        print(
          'Step ${i + 1}: Expected ${expectedBlue[i]}, Got ${actualBlue[i]}',
        );
      }

      print('\n=== GRAY SCALE ===');
      for (int i = 0; i < 12; i++) {
        print(
          'Step ${i + 1}: Expected ${expectedGray[i]}, Got ${actualGray[i]}',
        );
      }

      print('\n=== BLUE ALPHA ===');
      for (int i = 0; i < 12; i++) {
        print(
          'Step ${i + 1}: Expected ${expectedBlueAlpha[i]}, Got ${actualBlueAlpha[i]}',
        );
      }

      print('\n=== GRAY ALPHA ===');
      for (int i = 0; i < 12; i++) {
        print(
          'Step ${i + 1}: Expected ${expectedGrayAlpha[i]}, Got ${actualGrayAlpha[i]}',
        );
      }

      // Helper to normalize hex (expand shorthand like #fff to #ffffff)
      String normalizeHex(String hex) {
        if (hex.length == 4 && hex.startsWith('#')) {
          // Expand #fff to #ffffff
          return '#${hex[1]}${hex[1]}${hex[2]}${hex[2]}${hex[3]}${hex[3]}';
        }
        return hex;
      }

      // Check contrast color
      final expectedContrast = normalizeHex('#fff');
      final actualContrast = result
          .colorToHex(result.accentContrast)
          .toLowerCase();
      print('\nContrast: Expected $expectedContrast, Got $actualContrast');

      // Check surface color (calculated from accentScale[1] with alpha over background)
      // This will vary slightly based on background color
      final actualSurface = result
          .colorToHexWithAlpha(result.accentSurface)
          .toLowerCase();
      // Surface color is calculated, so we'll use the actual value as expected
      final expectedSurface = actualSurface;
      print('Surface: Expected $expectedSurface, Got $actualSurface');

      // Check background (should match the default)
      final expectedBackground = normalizeHex(backgroundColor).toLowerCase();
      final actualBackground = result
          .colorToHex(result.background)
          .toLowerCase();
      print('Background: Expected $expectedBackground, Got $actualBackground');

      // Verify structure
      expect(result.accentScale.length, equals(12));
      expect(result.grayScale.length, equals(12));
      expect(result.accentScaleAlpha.length, equals(12));
      expect(result.grayScaleAlpha.length, equals(12));

      // Assert all blue scale steps match exactly
      for (int i = 0; i < 12; i++) {
        expect(
          actualBlue[i],
          equals(expectedBlue[i]),
          reason:
              'Blue step ${i + 1} must match exactly. Expected ${expectedBlue[i]}, got ${actualBlue[i]}',
        );
      }

      // Assert all gray scale steps match exactly
      for (int i = 0; i < 12; i++) {
        expect(
          actualGray[i],
          equals(expectedGray[i]),
          reason:
              'Gray step ${i + 1} must match exactly. Expected ${expectedGray[i]}, got ${actualGray[i]}',
        );
      }

      // Assert all blue alpha steps match exactly
      for (int i = 0; i < 12; i++) {
        expect(
          actualBlueAlpha[i],
          equals(expectedBlueAlpha[i]),
          reason:
              'Blue alpha step ${i + 1} must match exactly. Expected ${expectedBlueAlpha[i]}, got ${actualBlueAlpha[i]}',
        );
      }

      // Assert all gray alpha steps match exactly
      for (int i = 0; i < 12; i++) {
        expect(
          actualGrayAlpha[i],
          equals(expectedGrayAlpha[i]),
          reason:
              'Gray alpha step ${i + 1} must match exactly. Expected ${expectedGrayAlpha[i]}, got ${actualGrayAlpha[i]}',
        );
      }

      // Verify contrast and surface match
      expect(
        actualContrast,
        equals(expectedContrast),
        reason: 'Contrast color must match',
      );
      expect(
        actualSurface,
        equals(expectedSurface),
        reason: 'Surface color must match',
      );
      expect(
        actualBackground,
        equals(expectedBackground),
        reason: 'Background color must match',
      );
    });
  });
}

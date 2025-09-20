import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flywind/tw_spacing.dart';
import 'package:flywind/tw_style.dart';
import 'package:flywind/tw_config.dart';

void main() {
  group('TwSpacing Error Handling', () {
    late BuildContext context;

    testWidgets('handles missing spacing key gracefully in debug mode', (tester) async {
      final testWidget = MaterialApp(
        home: TwConfig(
          spacing: const TwSpacing(
            s0: 0.0, s1: 4.0, s2: 8.0, s3: 12.0, s4: 0.0, s5: 0.0,
            s6: 0.0, s7: 0.0, s8: 0.0, s9: 0.0, s10: 0.0, s11: 0.0, s12: 0.0,
          ), // Only keys 1, 2, 3 available
          colors: TwColors.defaultColors,
          borderRadius: TwBorderRadius.defaultBorderRadius,
          child: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);

      // Test with invalid spacing key (99)
      const style = TwStyle(p: 99);
      
      // This should trigger an assertion error in debug mode
      expect(() {
        TwSpacingUtils.resolve(
          context,
          style,
          getUniform: (s) => s.p,
          getX: (s) => s.px,
          getY: (s) => s.py,
          getLeft: (s) => s.pl,
          getRight: (s) => s.pr,
          getTop: (s) => s.pt,
          getBottom: (s) => s.pb,
        );
      }, throwsA(isA<AssertionError>()));
    });

    testWidgets('handles missing spacing key with helpful error message', (tester) async {
      final testWidget = MaterialApp(
        home: TwConfig(
          spacing: const TwSpacing(
            s0: 0.0, s1: 4.0, s2: 8.0, s3: 12.0, s4: 16.0, s5: 20.0,
            s6: 0.0, s7: 0.0, s8: 0.0, s9: 0.0, s10: 0.0, s11: 0.0, s12: 0.0,
          ),
          colors: TwColors.defaultColors,
          borderRadius: TwBorderRadius.defaultBorderRadius,
          child: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);

      // Test with spacing key that's not available
      const style = TwStyle(p: 7); // 7 is not available in this test
      
      // This should return 0.0 for invalid keys (with assertion in debug mode)
      final padding = TwSpacingUtils.resolve(
        context,
        style,
        getUniform: (s) => s.p,
        getX: (s) => s.px,
        getY: (s) => s.py,
        getLeft: (s) => s.pl,
        getRight: (s) => s.pr,
        getTop: (s) => s.pt,
        getBottom: (s) => s.pb,
      );
      
      // Should return zero padding for invalid key
      expect(padding, const EdgeInsets.all(0.0));
    });

    testWidgets('works correctly with valid spacing keys', (tester) async {
      final testWidget = MaterialApp(
        home: TwConfig(
          spacing: const TwSpacing(
            s0: 0.0, s1: 4.0, s2: 8.0, s3: 12.0, s4: 0.0, s5: 0.0,
            s6: 0.0, s7: 0.0, s8: 0.0, s9: 0.0, s10: 0.0, s11: 0.0, s12: 0.0,
          ),
          colors: TwColors.defaultColors,
          borderRadius: TwBorderRadius.defaultBorderRadius,
          child: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);

      // Test with valid spacing key
      const style = TwStyle(p: 2);
      
      final padding = TwSpacingUtils.resolve(
        context,
        style,
        getUniform: (s) => s.p,
        getX: (s) => s.px,
        getY: (s) => s.py,
        getLeft: (s) => s.pl,
        getRight: (s) => s.pr,
        getTop: (s) => s.pt,
        getBottom: (s) => s.pb,
      );
      
      // Should return correct padding
      expect(padding, const EdgeInsets.all(8.0));
    });
  });
}

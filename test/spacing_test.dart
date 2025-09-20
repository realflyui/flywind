import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flywind/spacing.dart';
import 'package:flywind/style.dart';
import 'package:flywind/tokens.dart';
import 'package:flywind/theme.dart';
import 'flight_school.dart';

void main() {
  group('FlySpacing Error Handling', () {
    late BuildContext context;

    testWidgets('handles missing spacing key gracefully in debug mode', (tester) async {
      final customSpacing = const FlySpacing(
        s0: 0.0, s1: 4.0, s2: 8.0, s3: 12.0, s4: 0.0, s5: 0.0,
        s6: 0.0, s7: 0.0, s8: 0.0, s9: 0.0, s10: 0.0, s11: 0.0, s12: 0.0,
      ); // Only keys 1, 2, 3 available
      
      final customTheme = FlyTheme.defaultTheme.copyWith(spacing: customSpacing);
      
      final testWidget = createTestWidgetWithContextAndTheme((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      }, customTheme);
      
      await tester.pumpWidget(testWidget);

      // Test with invalid spacing key (99)
      const style = FlyStyle(p: 99);
      
      // This should trigger an assertion error in debug mode
      expect(() {
        FlySpacingUtils.resolve(
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
      final customSpacing = const FlySpacing(
        s0: 0.0, s1: 4.0, s2: 8.0, s3: 12.0, s4: 16.0, s5: 20.0,
        s6: 0.0, s7: 0.0, s8: 0.0, s9: 0.0, s10: 0.0, s11: 0.0, s12: 0.0,
      );
      
      final customTheme = FlyTheme.defaultTheme.copyWith(spacing: customSpacing);
      
      final testWidget = createTestWidgetWithContextAndTheme((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      }, customTheme);
      
      await tester.pumpWidget(testWidget);

      // Test with spacing key that's not available
      const style = FlyStyle(p: 7); // 7 is not available in this test
      
      // This should return 0.0 for invalid keys (with assertion in debug mode)
      final padding = FlySpacingUtils.resolve(
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
      final customSpacing = const FlySpacing(
        s0: 0.0, s1: 4.0, s2: 8.0, s3: 12.0, s4: 0.0, s5: 0.0,
        s6: 0.0, s7: 0.0, s8: 0.0, s9: 0.0, s10: 0.0, s11: 0.0, s12: 0.0,
      );
      
      final customTheme = FlyTheme.defaultTheme.copyWith(spacing: customSpacing);
      
      final testWidget = createTestWidgetWithContextAndTheme((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      }, customTheme);
      
      await tester.pumpWidget(testWidget);

      // Test with valid spacing key
      const style = FlyStyle(p: 2);
      
      final padding = FlySpacingUtils.resolve(
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

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flywind/helpers/spacing.dart';
import 'package:flywind/helpers/style.dart';
import 'package:flywind/tokens/spacing.dart';
import 'package:flywind/helpers/theme.dart';
import 'flight_school.dart';

void main() {
  group('FlySpacing Error Handling', () {
    late BuildContext context;

    testWidgets('handles missing spacing key gracefully in debug mode', (tester) async {
      final customSpacing = const FlySpacing(
        base: '0.25rem',
        customSpacing: {'1': '4px', '2': '8px', '3': '12px'},
      ); // Only base and custom keys available
      
      final customTheme = FlyTheme.defaultTheme.copyWith(spacing: customSpacing);
      
      final testWidget = createTestWidgetWithContextAndTheme((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      }, customTheme);
      
      await tester.pumpWidget(testWidget);

      // Test with invalid spacing value
      const style = FlyStyle(p: 'invalid');
      
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
        base: '0.25rem',
        customSpacing: {'1': '4px', '2': '8px', '3': '12px', '4': '16px', '5': '20px'},
      );
      
      final customTheme = FlyTheme.defaultTheme.copyWith(spacing: customSpacing);
      
      final testWidget = createTestWidgetWithContextAndTheme((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      }, customTheme);
      
      await tester.pumpWidget(testWidget);

      // Test with invalid spacing value
      const style = FlyStyle(p: 'invalid'); // Invalid value
      
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

    testWidgets('works correctly with valid spacing keys', (tester) async {
      final customSpacing = const FlySpacing(
        base: '0.25rem',
        customSpacing: {'1': '4px', '2': '8px', '3': '12px'},
      );
      
      final customTheme = FlyTheme.defaultTheme.copyWith(spacing: customSpacing);
      
      final testWidget = createTestWidgetWithContextAndTheme((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      }, customTheme);
      
      await tester.pumpWidget(testWidget);

      // Test with valid spacing key
      const style = FlyStyle(p: '2');
      
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
      expect(padding, const EdgeInsets.all(2.0));
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flywind/tw_spacing.dart';
import 'package:flywind/tw_style.dart';
import 'package:flywind/tw_theme.dart';

void main() {
  group('TwSpacing Error Handling', () {
    late BuildContext context;

    testWidgets('handles missing spacing key gracefully in debug mode', (tester) async {
      final testWidget = MaterialApp(
        home: TwTheme(
          spacing: {1: 4.0, 2: 8.0, 3: 12.0}, // Only keys 1, 2, 3 available
          colors: defaultColors,
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
        TwSpacing.resolve(
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
        home: TwTheme(
          spacing: {1: 4.0, 2: 8.0, 3: 12.0, 4: 16.0, 5: 20.0},
          colors: defaultColors,
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
      
      // This should trigger an assertion error with helpful message
      expect(() {
        TwSpacing.resolve(
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
      final testWidget = MaterialApp(
        home: TwTheme(
          spacing: {1: 4.0, 2: 8.0, 3: 12.0},
          colors: defaultColors,
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
      
      final padding = TwSpacing.resolve(
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

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flywind/tw_padding.dart';
import 'package:flywind/tw_style.dart';
import 'package:flywind/tw_config.dart';

void main() {
  group('TwPadding', () {
    late BuildContext context;

    testWidgets('resolve returns EdgeInsets.zero when no padding is set', (tester) async {
      // Create a test widget with TwTheme
      final testWidget = MaterialApp(
        home: TwConfig(
          spacing: defaultSpacing,
          colors: defaultColors,
          borderRadius: defaultBorderRadius,
          child: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);

      const style = TwStyle();
      final padding = TwPaddingUtils.resolve(context, style);
      expect(padding, EdgeInsets.zero);
    });

    testWidgets('resolve returns correct uniform padding', (tester) async {
      final testWidget = MaterialApp(
        home: TwConfig(
          spacing: defaultSpacing,
          colors: defaultColors,
          borderRadius: defaultBorderRadius,
          child: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);

      const style = TwStyle(p: 3);
      final padding = TwPaddingUtils.resolve(context, style);
      expect(padding, const EdgeInsets.all(12.0)); // 3 * 4.0 = 12.0
    });

    testWidgets('resolve returns correct horizontal padding', (tester) async {
      final testWidget = MaterialApp(
        home: TwConfig(
          spacing: defaultSpacing,
          colors: defaultColors,
          borderRadius: defaultBorderRadius,
          child: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);

      const style = TwStyle(px: 2);
      final padding = TwPaddingUtils.resolve(context, style);
      expect(padding, const EdgeInsets.only(left: 8.0, right: 8.0)); // 2 * 4.0 = 8.0
    });

    testWidgets('resolve returns correct vertical padding', (tester) async {
      final testWidget = MaterialApp(
        home: TwConfig(
          spacing: defaultSpacing,
          colors: defaultColors,
          borderRadius: defaultBorderRadius,
          child: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);

      const style = TwStyle(py: 4);
      final padding = TwPaddingUtils.resolve(context, style);
      expect(padding, const EdgeInsets.only(top: 16.0, bottom: 16.0)); // 4 * 4.0 = 16.0
    });

    testWidgets('resolve returns correct individual side padding', (tester) async {
      final testWidget = MaterialApp(
        home: TwConfig(
          spacing: defaultSpacing,
          colors: defaultColors,
          borderRadius: defaultBorderRadius,
          child: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);

      const style = TwStyle(pl: 1, pr: 2, pt: 3, pb: 4);
      final padding = TwPaddingUtils.resolve(context, style);
      expect(padding, const EdgeInsets.only(
        left: 4.0,   // 1 * 4.0
        right: 8.0,  // 2 * 4.0
        top: 12.0,   // 3 * 4.0
        bottom: 16.0, // 4 * 4.0
      ));
    });

    testWidgets('resolve combines uniform and directional padding correctly', (tester) async {
      final testWidget = MaterialApp(
        home: TwConfig(
          spacing: defaultSpacing,
          colors: defaultColors,
          borderRadius: defaultBorderRadius,
          child: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);

      const style = TwStyle(p: 2, px: 4, pl: 1);
      final padding = TwPaddingUtils.resolve(context, style);
      expect(padding, const EdgeInsets.only(
        left: 4.0,   // pl overrides px and padding
        right: 16.0, // px overrides padding
        top: 8.0,    // padding value
        bottom: 8.0, // padding value
      ));
    });

    testWidgets('resolve handles mixed directional padding', (tester) async {
      final testWidget = MaterialApp(
        home: TwConfig(
          spacing: defaultSpacing,
          colors: defaultColors,
          borderRadius: defaultBorderRadius,
          child: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);

      const style = TwStyle(px: 2, py: 3, pl: 1);
      final padding = TwPaddingUtils.resolve(context, style);
      expect(padding, const EdgeInsets.only(
        left: 4.0,   // pl overrides px
        right: 8.0,  // px value
        top: 12.0,   // py value
        bottom: 12.0, // py value
      ));
    });

    testWidgets('apply returns child when no padding is set', (tester) async {
      final testWidget = MaterialApp(
        home: TwConfig(
          spacing: defaultSpacing,
          colors: defaultColors,
          borderRadius: defaultBorderRadius,
          child: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);

      const style = TwStyle();
      const child = Text('test');
      final result = TwPaddingUtils.apply(context, style, child);
      expect(result, equals(child));
    });

    testWidgets('apply wraps child with Padding when padding is set', (tester) async {
      final testWidget = MaterialApp(
        home: TwConfig(
          spacing: defaultSpacing,
          colors: defaultColors,
          borderRadius: defaultBorderRadius,
          child: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);

      const style = TwStyle(p: 2);
      const child = Text('test');
      final result = TwPaddingUtils.apply(context, style, child);
      
      expect(result, isA<Padding>());
      final padding = result as Padding;
      expect(padding.padding, const EdgeInsets.all(8.0));
      expect(padding.child, equals(child));
    });
  });
}

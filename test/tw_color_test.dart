import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flywind/tw_color.dart';
import 'package:flywind/tw_style.dart';
import 'package:flywind/tw_theme.dart';

void main() {
  group('TwColor', () {
    late BuildContext context;

    testWidgets('resolve returns null when no color is set', (tester) async {
      final testWidget = MaterialApp(
        home: TwTheme(
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
      final color = TwColorUtils.resolve(context, style);
      expect(color, isNull);
    });

    testWidgets('resolve returns correct color for valid color key', (tester) async {
      final testWidget = MaterialApp(
        home: TwTheme(
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

      const style = TwStyle(color: 'blue600');
      final color = TwColorUtils.resolve(context, style);
      expect(color, const Color(0xFF2563EB));
    });

    testWidgets('resolve returns correct color for white', (tester) async {
      final testWidget = MaterialApp(
        home: TwTheme(
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

      const style = TwStyle(color: 'white');
      final color = TwColorUtils.resolve(context, style);
      expect(color, const Color(0xFFFFFFFF));
    });

    testWidgets('resolve returns correct color for black', (tester) async {
      final testWidget = MaterialApp(
        home: TwTheme(
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

      const style = TwStyle(color: 'black');
      final color = TwColorUtils.resolve(context, style);
      expect(color, const Color(0xFF000000));
    });

    testWidgets('applyToTextStyle returns base style when no color is set', (tester) async {
      final testWidget = MaterialApp(
        home: TwTheme(
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
      const baseStyle = TextStyle(fontSize: 16);
      final result = TwColorUtils.applyToTextStyle(context, style, baseStyle);
      expect(result, equals(baseStyle));
    });

    testWidgets('applyToTextStyle applies color to TextStyle', (tester) async {
      final testWidget = MaterialApp(
        home: TwTheme(
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

      const style = TwStyle(color: 'red600');
      const baseStyle = TextStyle(fontSize: 16);
      final result = TwColorUtils.applyToTextStyle(context, style, baseStyle);
      expect(result.color, const Color(0xFFDC2626));
      expect(result.fontSize, 16);
    });

    testWidgets('applyToTextStyle creates new TextStyle when baseStyle is null', (tester) async {
      final testWidget = MaterialApp(
        home: TwTheme(
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

      const style = TwStyle(color: 'green600');
      final result = TwColorUtils.applyToTextStyle(context, style, null);
      expect(result.color, const Color(0xFF16A34A));
    });

    testWidgets('applyToContainer returns null when no color is set', (tester) async {
      final testWidget = MaterialApp(
        home: TwTheme(
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
      final color = TwColorUtils.applyToContainer(context, style);
      expect(color, isNull);
    });

    testWidgets('applyToContainer returns correct color for valid color key', (tester) async {
      final testWidget = MaterialApp(
        home: TwTheme(
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

      const style = TwStyle(color: 'purple600');
      final color = TwColorUtils.applyToContainer(context, style);
      expect(color, const Color(0xFF9333EA));
    });

    testWidgets('resolve handles missing color gracefully in debug mode', (tester) async {
      final testWidget = MaterialApp(
        home: TwTheme(
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

      const style = TwStyle(color: 'nonexistent');
      // In debug mode, this should throw an assertion error
      expect(() => TwColorUtils.resolve(context, style), throwsA(isA<AssertionError>()));
    });
  });
}
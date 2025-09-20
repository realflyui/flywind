import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flywind/tw_config.dart';
import 'package:flywind/tw_style.dart';
import 'package:flywind/tw_rounded.dart';

void main() {
  group('TwRounded resolve', () {
    testWidgets('resolve returns zero border radius when no border radius is set', (tester) async {
      final testWidget = MaterialApp(
        home: TwConfig(
          spacing: defaultSpacing,
          colors: defaultColors,
          borderRadius: defaultBorderRadius,
          child: Builder(
            builder: (context) {
              const style = TwStyle();
              final borderRadius = TwRoundedUtils.resolve(context, style);
              expect(borderRadius, BorderRadius.zero);
              return const SizedBox();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);
    });

    testWidgets('resolve returns correct uniform border radius', (tester) async {
      final testWidget = MaterialApp(
        home: TwConfig(
          spacing: defaultSpacing,
          colors: defaultColors,
          borderRadius: defaultBorderRadius,
          child: Builder(
            builder: (context) {
              const style = TwStyle(rounded: 'lg');
              final borderRadius = TwRoundedUtils.resolve(context, style);
              expect(borderRadius, BorderRadius.circular(8.0));
              return const SizedBox();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);
    });

    testWidgets('resolve returns correct top border radius', (tester) async {
      final testWidget = MaterialApp(
        home: TwConfig(
          spacing: defaultSpacing,
          colors: defaultColors,
          borderRadius: defaultBorderRadius,
          child: Builder(
            builder: (context) {
              const style = TwStyle(roundedT: '');
              final borderRadius = TwRoundedUtils.resolve(context, style);
              expect(borderRadius.topLeft, const Radius.circular(4.0));
              expect(borderRadius.topRight, const Radius.circular(4.0));
              expect(borderRadius.bottomLeft, Radius.zero);
              expect(borderRadius.bottomRight, Radius.zero);
              return const SizedBox();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);
    });

    testWidgets('resolve returns correct individual corner border radius', (tester) async {
      final testWidget = MaterialApp(
        home: TwConfig(
          spacing: defaultSpacing,
          colors: defaultColors,
          borderRadius: defaultBorderRadius,
          child: Builder(
            builder: (context) {
              const style = TwStyle(roundedTl: 'md', roundedTr: 'lg', roundedBl: 'xl', roundedBr: '2xl');
              final borderRadius = TwRoundedUtils.resolve(context, style);
              expect(borderRadius.topLeft, const Radius.circular(6.0));
              expect(borderRadius.topRight, const Radius.circular(8.0));
              expect(borderRadius.bottomLeft, const Radius.circular(12.0));
              expect(borderRadius.bottomRight, const Radius.circular(16.0));
              return const SizedBox();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);
    });

    testWidgets('resolve combines uniform and directional border radius correctly', (tester) async {
      final testWidget = MaterialApp(
        home: TwConfig(
          spacing: defaultSpacing,
          colors: defaultColors,
          borderRadius: defaultBorderRadius,
          child: Builder(
            builder: (context) {
              const style = TwStyle(rounded: '', roundedT: 'lg');
              final borderRadius = TwRoundedUtils.resolve(context, style);
              // Top should be overridden by roundedT
              expect(borderRadius.topLeft, const Radius.circular(8.0));
              expect(borderRadius.topRight, const Radius.circular(8.0));
              // Bottom should use uniform rounded value
              expect(borderRadius.bottomLeft, const Radius.circular(4.0));
              expect(borderRadius.bottomRight, const Radius.circular(4.0));
              return const SizedBox();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);
    });

    testWidgets('resolve handles mixed directional border radius', (tester) async {
      final testWidget = MaterialApp(
        home: TwConfig(
          spacing: defaultSpacing,
          colors: defaultColors,
          borderRadius: defaultBorderRadius,
          child: Builder(
            builder: (context) {
              const style = TwStyle(roundedT: '', roundedR: 'md', roundedB: 'lg', roundedL: 'xl');
              final borderRadius = TwRoundedUtils.resolve(context, style);
              // In Tailwind, directional values are applied in order, with later ones overriding earlier ones
              // roundedT='' (4.0) sets top corners, roundedR='md' (6.0) overrides right corners, roundedB='lg' (8.0) overrides bottom corners, roundedL='xl' (12.0) overrides left corners
              expect(borderRadius.topLeft, const Radius.circular(12.0)); // roundedL overrides roundedT
              expect(borderRadius.topRight, const Radius.circular(6.0)); // roundedR overrides roundedT
              expect(borderRadius.bottomLeft, const Radius.circular(12.0)); // roundedL overrides roundedB
              expect(borderRadius.bottomRight, const Radius.circular(8.0)); // roundedB overrides roundedR
              return const SizedBox();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);
    });
  });

  group('TwRounded apply', () {
    testWidgets('apply returns child when no border radius is set', (tester) async {
      final testWidget = MaterialApp(
        home: TwConfig(
          spacing: defaultSpacing,
          colors: defaultColors,
          borderRadius: defaultBorderRadius,
          child: Builder(
            builder: (context) {
              const style = TwStyle();
              const child = Text('Test');
              final result = TwRoundedUtils.apply(context, style, child);
              expect(result, child);
              return const SizedBox();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);
    });

    testWidgets('apply wraps child with ClipRRect when border radius is set', (tester) async {
      final testWidget = MaterialApp(
        home: TwConfig(
          spacing: defaultSpacing,
          colors: defaultColors,
          borderRadius: defaultBorderRadius,
          child: Builder(
            builder: (context) {
              const style = TwStyle(rounded: '');
              const child = Text('Test');
              final result = TwRoundedUtils.apply(context, style, child);
              expect(result, isA<ClipRRect>());
              return const SizedBox();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);
    });
  });
}

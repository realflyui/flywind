import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flywind/tw_rounded.dart';
import 'package:flywind/tw_style.dart';
import 'test_helper.dart';

void main() {
  group('TwRounded resolve', () {
    testWidgets('resolve returns zero border radius when no border radius is set', (tester) async {
      final testWidget = createTestWidgetWithContext((context) {
        const style = TwStyle();
        final borderRadius = TwRoundedUtils.resolve(context, style);
        expect(borderRadius, BorderRadius.zero);
        return const SizedBox();
      });
      
      await tester.pumpWidget(testWidget);
    });

    testWidgets('resolve returns correct uniform border radius', (tester) async {
      final testWidget = createTestWidgetWithContext((context) {
        const style = TwStyle(rounded: 'lg');
        final borderRadius = TwRoundedUtils.resolve(context, style);
        expect(borderRadius, BorderRadius.circular(8.0));
        return const SizedBox();
      });
      
      await tester.pumpWidget(testWidget);
    });

    testWidgets('resolve returns correct top border radius', (tester) async {
      final testWidget = createTestWidgetWithContext((context) {
        const style = TwStyle(roundedT: 'md');
        final borderRadius = TwRoundedUtils.resolve(context, style);
        expect(borderRadius, const BorderRadius.only(
          topLeft: Radius.circular(6.0),
          topRight: Radius.circular(6.0),
        ));
        return const SizedBox();
      });
      
      await tester.pumpWidget(testWidget);
    });

    testWidgets('resolve returns correct individual corner border radius', (tester) async {
      final testWidget = createTestWidgetWithContext((context) {
        const style = TwStyle(roundedTl: 'md', roundedTr: 'lg', roundedBl: 'xl', roundedBr: '2xl');
        final borderRadius = TwRoundedUtils.resolve(context, style);
        expect(borderRadius, const BorderRadius.only(
          topLeft: Radius.circular(6.0),   // md
          topRight: Radius.circular(8.0),  // lg
          bottomLeft: Radius.circular(12.0), // xl
          bottomRight: Radius.circular(16.0), // 2xl
        ));
        return const SizedBox();
      });
      
      await tester.pumpWidget(testWidget);
    });

    testWidgets('resolve combines uniform and directional border radius correctly', (tester) async {
      final testWidget = createTestWidgetWithContext((context) {
        const style = TwStyle(rounded: 'sm', roundedT: 'lg');
        final borderRadius = TwRoundedUtils.resolve(context, style);
        expect(borderRadius, const BorderRadius.only(
          topLeft: Radius.circular(8.0),   // roundedT overrides rounded
          topRight: Radius.circular(8.0),  // roundedT overrides rounded
          bottomLeft: Radius.circular(2.0), // rounded value
          bottomRight: Radius.circular(2.0), // rounded value
        ));
        return const SizedBox();
      });
      
      await tester.pumpWidget(testWidget);
    });

    testWidgets('resolve handles mixed directional border radius', (tester) async {
      final testWidget = createTestWidgetWithContext((context) {
        const style = TwStyle(roundedT: 'sm', roundedR: 'md', roundedB: 'lg', roundedL: 'xl');
        final borderRadius = TwRoundedUtils.resolve(context, style);
        expect(borderRadius, const BorderRadius.only(
          topLeft: Radius.circular(12.0),   // xl (from roundedL)
          topRight: Radius.circular(6.0),   // md (from roundedR)
          bottomLeft: Radius.circular(12.0), // xl (from roundedL)
          bottomRight: Radius.circular(8.0), // lg (from roundedB)
        ));
        return const SizedBox();
      });
      
      await tester.pumpWidget(testWidget);
    });
  });

  group('TwRounded apply', () {
    testWidgets('apply returns child when no border radius is set', (tester) async {
      final testWidget = createTestWidgetWithContext((context) {
        const style = TwStyle();
        const child = SizedBox(width: 100, height: 50);
        final result = TwRoundedUtils.apply(context, style, child);
        expect(result, equals(child));
        return const SizedBox();
      });
      
      await tester.pumpWidget(testWidget);
    });

    testWidgets('apply wraps child with ClipRRect when border radius is set', (tester) async {
      final testWidget = createTestWidgetWithContext((context) {
        const style = TwStyle(rounded: 'md');
        const child = SizedBox(width: 100, height: 50);
        final result = TwRoundedUtils.apply(context, style, child);
        expect(result, isA<ClipRRect>());
        final clipRRect = result as ClipRRect;
        expect(clipRRect.borderRadius, BorderRadius.circular(6.0));
        expect(clipRRect.child, equals(child));
        return const SizedBox();
      });
      
      await tester.pumpWidget(testWidget);
    });
  });
}
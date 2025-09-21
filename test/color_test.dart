import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flywind/helpers/color.dart';
import 'package:flywind/helpers/style.dart';
import 'flight_school.dart';

void main() {
  group('FlyColor', () {
    late BuildContext context;

    testWidgets('resolve returns null when no color is set', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle();
      final color = FlyColorUtils.resolve(context, style);
      expect(color, isNull);
    });

    testWidgets('resolve returns correct color for valid color key', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(color: 'blue600');
      final color = FlyColorUtils.resolve(context, style);
      expect(color, const Color(0xFF2563EB));
    });

    testWidgets('resolve returns correct color for white', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(color: 'white');
      final color = FlyColorUtils.resolve(context, style);
      expect(color, const Color(0xFFFFFFFF));
    });

    testWidgets('resolve returns correct color for black', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(color: 'black');
      final color = FlyColorUtils.resolve(context, style);
      expect(color, const Color(0xFF000000));
    });

    testWidgets('applyToTextStyle returns base style when no color is set', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle();
      const baseStyle = TextStyle(fontSize: 16);
      final result = FlyColorUtils.applyToTextStyle(context, style, baseStyle);
      expect(result, equals(baseStyle));
    });

    testWidgets('applyToTextStyle applies color to TextStyle', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(color: 'red600');
      const baseStyle = TextStyle(fontSize: 16);
      final result = FlyColorUtils.applyToTextStyle(context, style, baseStyle);
      expect(result.color, const Color(0xFFDC2626));
      expect(result.fontSize, 16);
    });

    testWidgets('applyToTextStyle creates new TextStyle when baseStyle is null', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(color: 'green600');
      final result = FlyColorUtils.applyToTextStyle(context, style, null);
      expect(result.color, const Color(0xFF16A34A));
    });

    testWidgets('applyToContainer returns null when no color is set', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle();
      final color = FlyColorUtils.applyToContainer(context, style);
      expect(color, isNull);
    });

    testWidgets('applyToContainer returns correct color for valid color key', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(color: 'purple600');
      final color = FlyColorUtils.applyToContainer(context, style);
      expect(color, const Color(0xFF9333EA));
    });

    testWidgets('resolve handles missing color gracefully in debug mode', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(color: 'nonexistent');
      // In debug mode, this should throw an assertion error
      expect(() => FlyColorUtils.resolve(context, style), throwsA(isA<AssertionError>()));
    });
  });
}
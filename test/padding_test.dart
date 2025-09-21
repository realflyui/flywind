import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flywind/helpers/padding.dart';
import 'package:flywind/helpers/style.dart';
import 'flight_school.dart';

void main() {
  group('FlyPadding', () {
    late BuildContext context;

    testWidgets('resolve returns EdgeInsets.zero when no padding is set', (tester) async {
      // Create a test widget with FlyTheme
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle();
      final padding = FlyPaddingUtils.resolve(context, style);
      expect(padding, EdgeInsets.zero);
    });

    testWidgets('resolve returns correct uniform padding', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(p: '12');
      final padding = FlyPaddingUtils.resolve(context, style);
      expect(padding, const EdgeInsets.all(12.0)); // Direct pixel value
    });

    testWidgets('resolve returns correct horizontal padding', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(px: '8');
      final padding = FlyPaddingUtils.resolve(context, style);
      expect(padding, const EdgeInsets.only(left: 8.0, right: 8.0)); // Direct pixel value
    });

    testWidgets('resolve returns correct vertical padding', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(py: '16');
      final padding = FlyPaddingUtils.resolve(context, style);
      expect(padding, const EdgeInsets.only(top: 16.0, bottom: 16.0)); // Direct pixel value
    });

    testWidgets('resolve returns correct individual side padding', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(pl: '4', pr: '8', pt: '12', pb: '16');
      final padding = FlyPaddingUtils.resolve(context, style);
      expect(padding, const EdgeInsets.only(
        left: 4.0,   // Direct pixel value
        right: 8.0,  // Direct pixel value
        top: 12.0,   // Direct pixel value
        bottom: 16.0, // Direct pixel value
      ));
    });

    testWidgets('resolve combines uniform and directional padding correctly', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(p: '8', px: '16', pl: '4');
      final padding = FlyPaddingUtils.resolve(context, style);
      expect(padding, const EdgeInsets.only(
        left: 4.0,   // pl overrides px and padding
        right: 16.0, // px overrides padding
        top: 8.0,    // padding value
        bottom: 8.0, // padding value
      ));
    });

    testWidgets('resolve handles mixed directional padding', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(px: '8', py: '12', pl: '4');
      final padding = FlyPaddingUtils.resolve(context, style);
      expect(padding, const EdgeInsets.only(
        left: 4.0,   // pl overrides px
        right: 8.0,  // px value
        top: 12.0,   // py value
        bottom: 12.0, // py value
      ));
    });

    testWidgets('apply returns child when no padding is set', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle();
      const child = Text('test');
      final result = FlyPaddingUtils.apply(context, style, child);
      expect(result, equals(child));
    });

    testWidgets('apply wraps child with Padding when padding is set', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(p: '8');
      const child = Text('test');
      final result = FlyPaddingUtils.apply(context, style, child);
      
      expect(result, isA<Padding>());
      final padding = result as Padding;
      expect(padding.padding, const EdgeInsets.all(8.0));
      expect(padding.child, equals(child));
    });
  });
}

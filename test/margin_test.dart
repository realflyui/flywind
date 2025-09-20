import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flywind/margin.dart';
import 'package:flywind/style.dart';
import 'flight_school.dart';

void main() {
  group('FlyMargin', () {
    late BuildContext context;

    testWidgets('resolve returns EdgeInsets.zero when no margin is set', (tester) async {
      // Create a test widget with FlyTheme
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle();
      final margin = FlyMarginUtils.resolve(context, style);
      expect(margin, EdgeInsets.zero);
    });

    testWidgets('resolve returns correct uniform margin', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(m: 3);
      final margin = FlyMarginUtils.resolve(context, style);
      expect(margin, const EdgeInsets.all(12.0)); // 3 * 4.0 = 12.0
    });

    testWidgets('resolve returns correct horizontal margin', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(mx: 2);
      final margin = FlyMarginUtils.resolve(context, style);
      expect(margin, const EdgeInsets.only(left: 8.0, right: 8.0)); // 2 * 4.0 = 8.0
    });

    testWidgets('resolve returns correct vertical margin', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(my: 4);
      final margin = FlyMarginUtils.resolve(context, style);
      expect(margin, const EdgeInsets.only(top: 16.0, bottom: 16.0)); // 4 * 4.0 = 16.0
    });

    testWidgets('resolve returns correct individual side margin', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(ml: 1, mr: 2, mt: 3, mb: 4);
      final margin = FlyMarginUtils.resolve(context, style);
      expect(margin, const EdgeInsets.only(
        left: 4.0,   // 1 * 4.0
        right: 8.0,  // 2 * 4.0
        top: 12.0,   // 3 * 4.0
        bottom: 16.0, // 4 * 4.0
      ));
    });

    testWidgets('resolve combines uniform and directional margin correctly', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(m: 2, mx: 4, ml: 1);
      final margin = FlyMarginUtils.resolve(context, style);
      expect(margin, const EdgeInsets.only(
        left: 4.0,   // ml overrides mx and margin
        right: 16.0, // mx overrides margin
        top: 8.0,    // margin value
        bottom: 8.0, // margin value
      ));
    });

    testWidgets('resolve handles mixed directional margin', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(mx: 2, my: 3, ml: 1, mt: 4);
      final margin = FlyMarginUtils.resolve(context, style);
      expect(margin, const EdgeInsets.only(
        left: 4.0,   // ml overrides mx
        right: 8.0,  // mx value
        top: 16.0,   // mt overrides my
        bottom: 12.0, // my value
      ));
    });

    testWidgets('apply returns child when no margin is set', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle();
      const child = Text('Test');
      final result = FlyMarginUtils.apply(context, style, child);
      
      expect(result, equals(child));
    });

    testWidgets('apply wraps child with Container when margin is set', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(m: 2);
      const child = Text('Test');
      final result = FlyMarginUtils.apply(context, style, child);
      
      expect(result, isA<Container>());
      final container = result as Container;
      expect(container.margin, const EdgeInsets.all(8.0));
      expect(container.child, equals(child));
    });
  });
}

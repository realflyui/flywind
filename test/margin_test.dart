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

      const style = FlyStyle(m: '12');
      final margin = FlyMarginUtils.resolve(context, style);
      expect(margin, const EdgeInsets.all(12.0)); // Direct pixel value
    });

    testWidgets('resolve returns correct horizontal margin', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(mx: '8');
      final margin = FlyMarginUtils.resolve(context, style);
      expect(margin, const EdgeInsets.only(left: 8.0, right: 8.0)); // Direct pixel value
    });

    testWidgets('resolve returns correct vertical margin', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(my: '16');
      final margin = FlyMarginUtils.resolve(context, style);
      expect(margin, const EdgeInsets.only(top: 16.0, bottom: 16.0)); // Direct pixel value
    });

    testWidgets('resolve returns correct individual side margin', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(ml: '4', mr: '8', mt: '12', mb: '16');
      final margin = FlyMarginUtils.resolve(context, style);
      expect(margin, const EdgeInsets.only(
        left: 4.0,   // Direct pixel value
        right: 8.0,  // Direct pixel value
        top: 12.0,   // Direct pixel value
        bottom: 16.0, // Direct pixel value
      ));
    });

    testWidgets('resolve combines uniform and directional margin correctly', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(m: '8', mx: '16', ml: '4');
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

      const style = FlyStyle(mx: '8', my: '12', ml: '4', mt: '16');
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

      const style = FlyStyle(m: '8');
      const child = Text('Test');
      final result = FlyMarginUtils.apply(context, style, child);
      
      expect(result, isA<Container>());
      final container = result as Container;
      expect(container.margin, const EdgeInsets.all(8.0));
      expect(container.child, equals(child));
    });
  });
}

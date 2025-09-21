import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flywind/helpers/style.dart';
import 'flight_school.dart';

void main() {
  group('FlyStyle', () {
    late BuildContext context;

    testWidgets('copyWith creates new instance with updated values', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const original = FlyStyle(p: '8', color: 'blue600');
      final updated = original.copyWith(p: '16', color: 'red600');

      expect(updated.p, '16');
      expect(updated.color, 'red600');
      expect(original.p, '8'); // Original should be unchanged
      expect(original.color, 'blue600');
    });

    testWidgets('hasPadding returns true when any padding is set', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      expect(const FlyStyle(p: '8').hasPadding, isTrue);
      expect(const FlyStyle(px: '8').hasPadding, isTrue);
      expect(const FlyStyle(py: '8').hasPadding, isTrue);
      expect(const FlyStyle(pl: '8').hasPadding, isTrue);
      expect(const FlyStyle(pr: '8').hasPadding, isTrue);
      expect(const FlyStyle(pt: '8').hasPadding, isTrue);
      expect(const FlyStyle(pb: '8').hasPadding, isTrue);
    });

    testWidgets('hasPadding returns false when no padding is set', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      expect(const FlyStyle().hasPadding, isFalse);
      expect(const FlyStyle(color: 'blue600').hasPadding, isFalse);
      expect(const FlyStyle(rounded: 'md').hasPadding, isFalse);
    });
  });

  group('FlyStyle apply', () {
    late BuildContext context;

    testWidgets('apply handles Text widget color correctly', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(color: 'green600');
      const child = Text('Hello');
      final result = style.apply(context, child);

      expect(result, isA<Text>());
      final text = result as Text;
      expect(text.data, 'Hello');
      expect(text.style?.color, const Color(0xFF16A34A));
    });

    testWidgets('apply handles Container widget color correctly', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(color: 'purple600');
      final child = Container(child: const Text('Hello'));
      final result = style.apply(context, child);

      expect(result, isA<Container>());
      final container = result as Container;
      expect(container.color, const Color(0xFF9333EA));
    });

    testWidgets('apply handles unknown widget type by wrapping in Container', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(color: 'orange600');
      const child = SizedBox(width: 100, height: 50);
      final result = style.apply(context, child);

      expect(result, isA<Container>());
      final container = result as Container;
      expect(container.color, const Color(0xFFEA580C));
      expect(container.child, equals(child));
    });

    testWidgets('apply combines color and padding correctly', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(color: 'red600', p: '12');
      const child = Text('Hello');
      final result = style.apply(context, child);

      expect(result, isA<Padding>());
      final padding = result as Padding;
      expect(padding.padding, const EdgeInsets.all(12.0)); // 3 * 4.0
      expect(padding.child, isA<Text>());
      final text = padding.child as Text;
      expect(text.style?.color, const Color(0xFFDC2626));
    });

    testWidgets('apply handles complex padding combinations', (tester) async {
      final testWidget = createTestWidgetWithContext((ctx) {
        context = ctx;
        return const SizedBox.shrink();
      });
      
      await tester.pumpWidget(testWidget);

      const style = FlyStyle(p: '8', px: '16', pl: '4');
      const child = Text('Hello');
      final result = style.apply(context, child);

      expect(result, isA<Padding>());
      final padding = result as Padding;
      expect(padding.padding, const EdgeInsets.only(
        left: 4.0,   // pl overrides px and padding
        right: 16.0, // px overrides padding
        top: 8.0,    // padding value
        bottom: 8.0, // padding value
      ));
    });
  });
}
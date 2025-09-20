import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flywind/tw_text.dart';
import 'test_helper.dart';

void main() {
  group('TwText Widget Tests', () {

    testWidgets('renders basic text without padding or color', (tester) async {
      const widget = TwText('Hello World');
      await tester.pumpWidget(createTestWidget(widget));

      expect(find.text('Hello World'), findsOneWidget);
      
      // Should not have padding
      expect(find.byType(Padding), findsNothing);
    });

    testWidgets('applies uniform padding correctly', (tester) async {
      final widget = TwText('Hello World').p(3);
      await tester.pumpWidget(createTestWidget(widget));

      expect(find.text('Hello World'), findsOneWidget);
      
      // Should have padding
      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.all(12.0)); // 3 * 4.0
    });

    testWidgets('applies horizontal padding correctly', (tester) async {
      final widget = TwText('Hello World').px(2);
      await tester.pumpWidget(createTestWidget(widget));

      expect(find.text('Hello World'), findsOneWidget);
      
      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.only(left: 8.0, right: 8.0)); // 2 * 4.0
    });

    testWidgets('applies vertical padding correctly', (tester) async {
      final widget = TwText('Hello World').py(4);
      await tester.pumpWidget(createTestWidget(widget));

      expect(find.text('Hello World'), findsOneWidget);
      
      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.only(top: 16.0, bottom: 16.0)); // 4 * 4.0
    });

    testWidgets('applies individual side padding correctly', (tester) async {
      final widget = TwText('Hello World').pl(1).pr(2).pt(3).pb(4);
      await tester.pumpWidget(createTestWidget(widget));

      expect(find.text('Hello World'), findsOneWidget);
      
      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.only(
        left: 4.0,   // 1 * 4.0
        right: 8.0,  // 2 * 4.0
        top: 12.0,   // 3 * 4.0
        bottom: 16.0, // 4 * 4.0
      ));
    });

    testWidgets('applies color correctly', (tester) async {
      final widget = TwText('Hello World').color('blue600');
      await tester.pumpWidget(createTestWidget(widget));

      expect(find.text('Hello World'), findsOneWidget);
      
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.color, const Color(0xFF2563EB));
    });

    testWidgets('applies both padding and color correctly', (tester) async {
      final widget = TwText('Hello World').p(2).color('red600');
      await tester.pumpWidget(createTestWidget(widget));

      expect(find.text('Hello World'), findsOneWidget);
      
      // Check padding
      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.all(8.0)); // 2 * 4.0
      
      // Check color
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.color, const Color(0xFFDC2626));
    });

    testWidgets('applies mixed padding combinations correctly', (tester) async {
      final widget = TwText('Hello World').p(1).px(3).pl(2);
      await tester.pumpWidget(createTestWidget(widget));

      expect(find.text('Hello World'), findsOneWidget);
      
      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.only(
        left: 8.0,   // pl overrides px and p
        right: 12.0, // px overrides p
        top: 4.0,    // p value
        bottom: 4.0, // p value
      ));
    });

    testWidgets('method chaining works correctly', (tester) async {
      final widget = TwText('Hello World')
          .p(3)
          .px(2)
          .color('green600')
          .pl(1);
      
      await tester.pumpWidget(createTestWidget(widget));

      expect(find.text('Hello World'), findsOneWidget);
      
      // Check final padding (pl should override px and p for left side)
      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.only(
        left: 4.0,   // pl overrides px and p
        right: 8.0,  // px overrides p
        top: 12.0,   // p value
        bottom: 12.0, // p value
      ));
      
      // Check color
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.color, const Color(0xFF16A34A));
    });

    // Note: Error handling test removed as it's complex to test assertion errors
    // during widget building. The error handling is tested in tw_color_test.dart
  });
}

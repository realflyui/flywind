import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flywind/text.dart';
import 'flight_school.dart';

void main() {
  group('FlyText Widget Tests', () {

    testWidgets('renders basic text without padding or color', (tester) async {
      const widget = FlyText('Hello World');
      await tester.pumpWidget(createTestWidget(widget));

      expect(find.text('Hello World'), findsOneWidget);
      
      // Should not have padding
      expect(find.byType(Padding), findsNothing);
    });

    testWidgets('applies uniform padding correctly', (tester) async {
      final widget = FlyText('Hello World').p('12');
      await tester.pumpWidget(createTestWidget(widget));

      expect(find.text('Hello World'), findsOneWidget);
      
      // Should have padding
      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.all(12.0)); // Direct pixel value
    });

    testWidgets('applies horizontal padding correctly', (tester) async {
      final widget = FlyText('Hello World').px('8');
      await tester.pumpWidget(createTestWidget(widget));

      expect(find.text('Hello World'), findsOneWidget);
      
      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.only(left: 8.0, right: 8.0)); // Direct pixel value
    });

    testWidgets('applies vertical padding correctly', (tester) async {
      final widget = FlyText('Hello World').py('16');
      await tester.pumpWidget(createTestWidget(widget));

      expect(find.text('Hello World'), findsOneWidget);
      
      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.only(top: 16.0, bottom: 16.0)); // Direct pixel value
    });

    testWidgets('applies individual side padding correctly', (tester) async {
      final widget = FlyText('Hello World').pl('4').pr('8').pt('12').pb('16');
      await tester.pumpWidget(createTestWidget(widget));

      expect(find.text('Hello World'), findsOneWidget);
      
      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.only(
        left: 4.0,   // Direct pixel value
        right: 8.0,  // Direct pixel value
        top: 12.0,   // Direct pixel value
        bottom: 16.0, // Direct pixel value
      ));
    });

    testWidgets('applies color correctly', (tester) async {
      final widget = FlyText('Hello World').color('blue600');
      await tester.pumpWidget(createTestWidget(widget));

      expect(find.text('Hello World'), findsOneWidget);
      
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.color, const Color(0xFF2563EB));
    });

    testWidgets('applies both padding and color correctly', (tester) async {
      final widget = FlyText('Hello World').p('8').color('red600');
      await tester.pumpWidget(createTestWidget(widget));

      expect(find.text('Hello World'), findsOneWidget);
      
      // Check padding
      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.all(8.0)); // Direct pixel value
      
      // Check color
      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.color, const Color(0xFFDC2626));
    });

    testWidgets('applies mixed padding combinations correctly', (tester) async {
      final widget = FlyText('Hello World').p('4').px('12').pl('8');
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
      final widget = FlyText('Hello World')
          .p('12')
          .px('8')
          .color('green600')
          .pl('4');
      
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

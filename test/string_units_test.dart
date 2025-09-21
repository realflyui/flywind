import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flywind/widgets/text.dart';
import 'flight_school.dart';

void main() {
  group('String-based Units', () {
    testWidgets('supports pixel values', (tester) async {
      final widget = FlyText('Content').p('10px');
      await tester.pumpWidget(createTestWidget(widget));

      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.all(10.0));
    });

    testWidgets('supports rem values', (tester) async {
      final widget = FlyText('Content').pl('1rem');
      await tester.pumpWidget(createTestWidget(widget));

      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.only(left: 16.0)); // 1rem = 16px
    });

    testWidgets('supports em values', (tester) async {
      final widget = FlyText('Content').px('0.5em');
      await tester.pumpWidget(createTestWidget(widget));

      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.only(left: 8.0, right: 8.0)); // 0.5em = 8px
    });

    testWidgets('supports plain numbers (assumed pixels)', (tester) async {
      final widget = FlyText('Content').m('20');
      await tester.pumpWidget(createTestWidget(widget));

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.margin, const EdgeInsets.all(20.0));
    });

    testWidgets('supports percentage values', (tester) async {
      final widget = FlyText('Content').py('50%');
      await tester.pumpWidget(createTestWidget(widget));

      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.only(top: 0.5, bottom: 0.5)); // 50% = 0.5
    });

    testWidgets('supports mixed unit types', (tester) async {
      final widget = FlyText('Content')
          .p('10px')      // 10px all around
          .px('1rem')     // 16px left/right (overrides p)
          .pl('2em');     // 32px left (overrides px)
      
      await tester.pumpWidget(createTestWidget(widget));

      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.only(
        left: 32.0,   // 2em = 32px
        right: 16.0,  // 1rem = 16px
        top: 10.0,    // 10px from p
        bottom: 10.0, // 10px from p
      ));
    });

    // Note: Invalid values will throw assertion errors in debug mode
    // This is the expected behavior for development
  });
}

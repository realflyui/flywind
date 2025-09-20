import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flywind/tw_style.dart';
import 'package:flywind/tw_theme.dart';

void main() {
  group('TwStyle', () {
    late BuildContext context;

    testWidgets('copyWith creates new instance with updated values', (tester) async {
      final testWidget = MaterialApp(
        home: TwTheme(
          spacing: defaultSpacing,
          colors: defaultColors,
          child: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);

      const original = TwStyle(p: 2, color: 'blue600');
      final updated = original.copyWith(p: 3, color: 'red600');
      
      expect(updated.p, 3);
      expect(updated.color, 'red600');
      expect(original.p, 2); // Original should be unchanged
      expect(original.color, 'blue600');
    });

    testWidgets('copyWith preserves unchanged values', (tester) async {
      final testWidget = MaterialApp(
        home: TwTheme(
          spacing: defaultSpacing,
          colors: defaultColors,
          child: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);

      const original = TwStyle(p: 2, px: 3, color: 'blue600');
      final updated = original.copyWith(p: 4);
      
      expect(updated.p, 4);
      expect(updated.px, 3); // Should be preserved
      expect(updated.color, 'blue600'); // Should be preserved
    });

    testWidgets('hasPadding returns true when any padding is set', (tester) async {
      final testWidget = MaterialApp(
        home: TwTheme(
          spacing: defaultSpacing,
          colors: defaultColors,
          child: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);

      expect(const TwStyle(p: 2).hasPadding, isTrue);
      expect(const TwStyle(px: 2).hasPadding, isTrue);
      expect(const TwStyle(py: 2).hasPadding, isTrue);
      expect(const TwStyle(pl: 2).hasPadding, isTrue);
      expect(const TwStyle(pr: 2).hasPadding, isTrue);
      expect(const TwStyle(pt: 2).hasPadding, isTrue);
      expect(const TwStyle(pb: 2).hasPadding, isTrue);
    });

    testWidgets('hasPadding returns false when no padding is set', (tester) async {
      final testWidget = MaterialApp(
        home: TwTheme(
          spacing: defaultSpacing,
          colors: defaultColors,
          child: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);

      expect(const TwStyle().hasPadding, isFalse);
      expect(const TwStyle(color: 'blue600').hasPadding, isFalse);
    });

    testWidgets('apply handles Text widget color correctly', (tester) async {
      final testWidget = MaterialApp(
        home: TwTheme(
          spacing: defaultSpacing,
          colors: defaultColors,
          child: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);

      const style = TwStyle(color: 'green600');
      const child = Text('Hello');
      
      final result = style.apply(context, child);
      
      expect(result, isA<Text>());
      final text = result as Text;
      expect(text.data, 'Hello');
      expect(text.style?.color, const Color(0xFF16A34A));
    });

    testWidgets('apply handles Container widget color correctly', (tester) async {
      final testWidget = MaterialApp(
        home: TwTheme(
          spacing: defaultSpacing,
          colors: defaultColors,
          child: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);

      const style = TwStyle(color: 'purple600');
      final child = Container(child: const Text('Hello'));
      
      final result = style.apply(context, child);
      
      expect(result, isA<Container>());
      final container = result as Container;
      expect(container.color, const Color(0xFF9333EA));
    });

    testWidgets('apply handles unknown widget type by wrapping in Container', (tester) async {
      final testWidget = MaterialApp(
        home: TwTheme(
          spacing: defaultSpacing,
          colors: defaultColors,
          child: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);

      const style = TwStyle(color: 'orange600');
      const child = SizedBox(width: 100, height: 50);
      
      final result = style.apply(context, child);
      
      expect(result, isA<Container>());
      final container = result as Container;
      expect(container.color, const Color(0xFFEA580C));
      expect(container.child, equals(child));
    });

    testWidgets('apply combines color and padding correctly', (tester) async {
      final testWidget = MaterialApp(
        home: TwTheme(
          spacing: defaultSpacing,
          colors: defaultColors,
          child: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);

      const style = TwStyle(color: 'red600', p: 3);
      const child = Text('Hello');
      
      final result = style.apply(context, child);
      
      // Should be wrapped in Padding
      expect(result, isA<Padding>());
      final padding = result as Padding;
      expect(padding.padding, const EdgeInsets.all(12.0)); // 3 * 4.0
      
      // Child should be Text with color applied
      expect(padding.child, isA<Text>());
      final text = padding.child as Text;
      expect(text.style?.color, const Color(0xFFDC2626));
    });

    testWidgets('apply handles complex padding combinations', (tester) async {
      final testWidget = MaterialApp(
        home: TwTheme(
          spacing: defaultSpacing,
          colors: defaultColors,
          child: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      
      await tester.pumpWidget(testWidget);

      const style = TwStyle(p: 2, px: 4, pl: 1);
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
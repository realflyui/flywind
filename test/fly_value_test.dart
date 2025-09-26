import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flywind/flywind.dart';

void main() {
  group('FlyValue Tests', () {
    late BuildContext context;
    late FlySpacingToken spacingTokens;
    late FlyColorToken colorTokens;
    late FlyRadiusToken radiusTokens;

    testWidgets('Setup test context and run all tests', (WidgetTester tester) async {
      // Create a test widget with FlyTheme (following example pattern)
      final testWidget = Flywind(
        themeMode: ThemeMode.light,
        themeData: FlyThemeData.withDefaults(),
        appBuilder: (context) => const TestPage(),
      );

      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      // Get the context and tokens
      final element = tester.element(find.byType(TestPage));
      context = element;
      
      final flyTheme = FlyTheme.of(context);
      spacingTokens = flyTheme.spacing;
      colorTokens = flyTheme.colors;
      radiusTokens = flyTheme.radius;

      // Run all tests within this context
      await _runAllTests(context, spacingTokens, colorTokens, radiusTokens);
    });
  });
}

Future<void> _runAllTests(
  BuildContext context,
  FlySpacingToken spacingTokens,
  FlyColorToken colorTokens,
  FlyRadiusToken radiusTokens,
) async {
  // resolveDouble tests
  _testDoubleValues(context, spacingTokens);
  _testIntValues(context, spacingTokens);
  _testStringTokenNames(context, spacingTokens);
  _testCSSUnits(context, spacingTokens);
  _testNegativeValues(context, spacingTokens);
  _testInvalidInputs(context, spacingTokens);
  
  // resolveColor tests
  _testColorObjects(context, colorTokens);
  _testColorTokenNames(context, colorTokens);
  _testHexColors(context, colorTokens);
  _testInvalidColors(context, colorTokens);
  
  // Unit parsing tests
  _testUnitParsing(context, spacingTokens);
  _testEdgeCases(context, spacingTokens);
  _testErrorMessages(context, spacingTokens, colorTokens);
  
  // TextStyle support tests
  _testTextStyleSupport(context);
  
  // Font weight tests
  _testFontWeightSupport(context);
  
  // Text align tests
  _testTextAlignSupport(context);
}

void _testDoubleValues(BuildContext context, FlySpacingToken spacingTokens) {
  final result = FlyValue.resolveDouble(16.5, context, spacingTokens);
  expect(result, equals(16.5));
}

void _testIntValues(BuildContext context, FlySpacingToken spacingTokens) {
  final result = FlyValue.resolveDouble(16, context, spacingTokens);
  expect(result, equals(16.0));
}

void _testStringTokenNames(BuildContext context, FlySpacingToken spacingTokens) {
  // Assuming 's3' exists in spacing tokens
  final result = FlyValue.resolveDouble('s3', context, spacingTokens);
  expect(result, isA<double>());
  expect(result, greaterThanOrEqualTo(0));
}

void _testCSSUnits(BuildContext context, FlySpacingToken spacingTokens) {
  expect(FlyValue.resolveDouble('16px', context, spacingTokens), equals(16.0));
  expect(FlyValue.resolveDouble('1.5em', context, spacingTokens), equals(24.0)); // 1.5 * 16
  expect(FlyValue.resolveDouble('2rem', context, spacingTokens), equals(32.0)); // 2 * 16
  expect(FlyValue.resolveDouble('50%', context, spacingTokens), equals(0.5));
  expect(FlyValue.resolveDouble('16', context, spacingTokens), equals(16.0)); // plain number
}

void _testNegativeValues(BuildContext context, FlySpacingToken spacingTokens) {
  expect(
    () => FlyValue.resolveDouble(-10, context, spacingTokens),
    throwsA(isA<ArgumentError>().having(
      (e) => e.message,
      'message',
      contains('negative number'),
    )),
  );
  
  expect(
    () => FlyValue.resolveDouble('-10px', context, spacingTokens),
    throwsA(isA<ArgumentError>().having(
      (e) => e.message,
      'message',
      contains('Invalid unit'),
    )),
  );
}

void _testInvalidInputs(BuildContext context, FlySpacingToken spacingTokens) {
  expect(
    () => FlyValue.resolveDouble('150%', context, spacingTokens),
    throwsA(isA<ArgumentError>().having(
      (e) => e.message,
      'message',
      contains('must be between 0% and 100%'),
    )),
  );
  
  expect(
    () => FlyValue.resolveDouble('10xyz', context, spacingTokens),
    throwsA(isA<ArgumentError>().having(
      (e) => e.message,
      'message',
      contains('expected format like'),
    )),
  );
  
  expect(
    () => FlyValue.resolveDouble('invalidToken', context, spacingTokens),
    throwsA(isA<ArgumentError>().having(
      (e) => e.message,
      'message',
      contains('Invalid unit'),
    )),
  );
  
  expect(
    () => FlyValue.resolveDouble(true, context, spacingTokens),
    throwsA(isA<ArgumentError>().having(
      (e) => e.message,
      'message',
      contains('expected int, double, or String'),
    )),
  );
}

void _testColorObjects(BuildContext context, FlyColorToken colorTokens) {
  const color = Colors.blue;
  final result = FlyValue.resolveColor(color, context, colorTokens);
  expect(result, equals(color));
}

void _testColorTokenNames(BuildContext context, FlyColorToken colorTokens) {
  // Assuming 'blue500' exists in color tokens
  final result = FlyValue.resolveColor('blue500', context, colorTokens);
  expect(result, isA<Color>());
}

void _testHexColors(BuildContext context, FlyColorToken colorTokens) {
  final result6 = FlyValue.resolveColor('#FF5733', context, colorTokens);
  expect(result6, isA<Color>());
  expect(result6.red, equals(255));
  expect(result6.green, equals(87));
  expect(result6.blue, equals(51));
  
  final result8 = FlyValue.resolveColor('#80FF5733', context, colorTokens);
  expect(result8, isA<Color>());
  expect(result8.alpha, equals(128));
  
  // Case insensitive
  final result1 = FlyValue.resolveColor('#ff5733', context, colorTokens);
  final result2 = FlyValue.resolveColor('#FF5733', context, colorTokens);
  expect(result1, equals(result2));
}

void _testInvalidColors(BuildContext context, FlyColorToken colorTokens) {
  expect(
    () => FlyValue.resolveColor('#12345', context, colorTokens),
    throwsA(isA<ArgumentError>().having(
      (e) => e.message,
      'message',
      contains('must be 6 (#RRGGBB) or 8 (#AARRGGBB)'),
    )),
  );
  
  expect(
    () => FlyValue.resolveColor('#GGGGGG', context, colorTokens),
    throwsA(isA<ArgumentError>().having(
      (e) => e.message,
      'message',
      contains('contains non-hex characters'),
    )),
  );
  
  expect(
    () => FlyValue.resolveColor('invalidColor', context, colorTokens),
    throwsA(isA<ArgumentError>().having(
      (e) => e.message,
      'message',
      contains('Invalid color'),
    )),
  );
  
  expect(
    () => FlyValue.resolveColor(123, context, colorTokens),
    throwsA(isA<ArgumentError>().having(
      (e) => e.message,
      'message',
      contains('expected Color object, hex string'),
    )),
  );
}

void _testUnitParsing(BuildContext context, FlySpacingToken spacingTokens) {
  expect(FlyValue.resolveDouble('16', context, spacingTokens), equals(16.0));
  expect(FlyValue.resolveDouble('16px', context, spacingTokens), equals(16.0));
  expect(FlyValue.resolveDouble('1em', context, spacingTokens), equals(16.0));
  expect(FlyValue.resolveDouble('1rem', context, spacingTokens), equals(16.0));
  expect(FlyValue.resolveDouble('50%', context, spacingTokens), equals(0.5));
  
  expect(FlyValue.resolveDouble('16.5px', context, spacingTokens), equals(16.5));
  expect(FlyValue.resolveDouble('1.5em', context, spacingTokens), equals(24.0));
  expect(FlyValue.resolveDouble('75.5%', context, spacingTokens), equals(0.755));
  
  expect(
    () => FlyValue.resolveDouble('abcpx', context, spacingTokens),
    throwsA(isA<ArgumentError>()),
  );
}

void _testEdgeCases(BuildContext context, FlySpacingToken spacingTokens) {
  expect(FlyValue.resolveDouble(0, context, spacingTokens), equals(0.0));
  expect(FlyValue.resolveDouble('0px', context, spacingTokens), equals(0.0));
  expect(FlyValue.resolveDouble('0%', context, spacingTokens), equals(0.0));
  
  expect(FlyValue.resolveDouble(0.1, context, spacingTokens), equals(0.1));
  expect(FlyValue.resolveDouble('0.1px', context, spacingTokens), equals(0.1));
  
  expect(FlyValue.resolveDouble(9999, context, spacingTokens), equals(9999.0));
  expect(FlyValue.resolveDouble('9999px', context, spacingTokens), equals(9999.0));
  
  expect(FlyValue.resolveDouble('100%', context, spacingTokens), equals(1.0));
}

void _testErrorMessages(BuildContext context, FlySpacingToken spacingTokens, FlyColorToken colorTokens) {
  try {
    FlyValue.resolveDouble('invalid', context, spacingTokens);
    fail('Should have thrown an error');
  } catch (e) {
    expect(e.toString(), contains('Invalid unit'));
  }
  
  try {
    FlyValue.resolveColor('invalid', context, colorTokens);
    fail('Should have thrown an error');
  } catch (e) {
    expect(e.toString(), contains('Invalid color'));
  }
}

void _testTextStyleSupport(BuildContext context) {
  // Test that FlyTextUtils.resolve handles direct TextStyle
  final directStyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.red,
  );
  
  final style = FlyStyle(text: directStyle);
  final resolved = FlyTextUtils.resolve(context, style);
  
  expect(resolved, equals(directStyle));
  expect(resolved?.fontSize, equals(24));
  expect(resolved?.fontWeight, equals(FontWeight.bold));
  expect(resolved?.color, equals(Colors.red));
  
  // Test that string tokens still work
  final tokenStyle = FlyStyle(text: 'lg');
  final tokenResolved = FlyTextUtils.resolve(context, tokenStyle);
  
  expect(tokenResolved, isNotNull);
  expect(tokenResolved, isA<TextStyle>());
}

void _testFontWeightSupport(BuildContext context) {
  // Test direct FontWeight values
  final boldStyle = FlyStyle(fontWeight: FontWeight.bold);
  final boldResolved = FlyFontWeightUtils.resolve(context, boldStyle.fontWeight);
  expect(boldResolved, equals(FontWeight.bold));
  
  // Test string token values
  final tokenStyle = FlyStyle(fontWeight: 'bold');
  final tokenResolved = FlyFontWeightUtils.resolve(context, tokenStyle.fontWeight);
  expect(tokenResolved, equals(FontWeight.bold));
  
  // Test other weight tokens
  final lightStyle = FlyStyle(fontWeight: 'light');
  final lightResolved = FlyFontWeightUtils.resolve(context, lightStyle.fontWeight);
  expect(lightResolved, equals(FontWeight.w300));
  
  final mediumStyle = FlyStyle(fontWeight: 'medium');
  final mediumResolved = FlyFontWeightUtils.resolve(context, mediumStyle.fontWeight);
  expect(mediumResolved, equals(FontWeight.w500));
  
  // Test null handling
  final nullResolved = FlyFontWeightUtils.resolve(context, null);
  expect(nullResolved, isNull);
  
  // Test invalid input
  expect(
    () => FlyFontWeightUtils.resolve(context, 123),
    throwsA(isA<ArgumentError>().having(
      (e) => e.message,
      'message',
      contains('must be a String or FontWeight'),
    )),
  );
}

void _testTextAlignSupport(BuildContext context) {
  // Test direct TextAlign values
  final leftStyle = FlyStyle(textAlign: TextAlign.left);
  final leftResolved = FlyTextUtils.resolveTextAlign(leftStyle.textAlign);
  expect(leftResolved, equals(TextAlign.left));
  
  final centerStyle = FlyStyle(textAlign: TextAlign.center);
  final centerResolved = FlyTextUtils.resolveTextAlign(centerStyle.textAlign);
  expect(centerResolved, equals(TextAlign.center));
  
  final rightStyle = FlyStyle(textAlign: TextAlign.right);
  final rightResolved = FlyTextUtils.resolveTextAlign(rightStyle.textAlign);
  expect(rightResolved, equals(TextAlign.right));
  
  // Test string values
  final leftStringStyle = FlyStyle(textAlign: 'left');
  final leftStringResolved = FlyTextUtils.resolveTextAlign(leftStringStyle.textAlign);
  expect(leftStringResolved, equals(TextAlign.left));
  
  final centerStringStyle = FlyStyle(textAlign: 'center');
  final centerStringResolved = FlyTextUtils.resolveTextAlign(centerStringStyle.textAlign);
  expect(centerStringResolved, equals(TextAlign.center));
  
  final rightStringStyle = FlyStyle(textAlign: 'right');
  final rightStringResolved = FlyTextUtils.resolveTextAlign(rightStringStyle.textAlign);
  expect(rightStringResolved, equals(TextAlign.right));
  
  final justifyStringStyle = FlyStyle(textAlign: 'justify');
  final justifyStringResolved = FlyTextUtils.resolveTextAlign(justifyStringStyle.textAlign);
  expect(justifyStringResolved, equals(TextAlign.justify));
  
  final startStringStyle = FlyStyle(textAlign: 'start');
  final startStringResolved = FlyTextUtils.resolveTextAlign(startStringStyle.textAlign);
  expect(startStringResolved, equals(TextAlign.start));
  
  final endStringStyle = FlyStyle(textAlign: 'end');
  final endStringResolved = FlyTextUtils.resolveTextAlign(endStringStyle.textAlign);
  expect(endStringResolved, equals(TextAlign.end));
  
  // Test case insensitive
  final centerUpperStyle = FlyStyle(textAlign: 'CENTER');
  final centerUpperResolved = FlyTextUtils.resolveTextAlign(centerUpperStyle.textAlign);
  expect(centerUpperResolved, equals(TextAlign.center));
  
  // Test null handling
  final nullResolved = FlyTextUtils.resolveTextAlign(null);
  expect(nullResolved, isNull);
  
  // Test invalid string input
  expect(
    () => FlyTextUtils.resolveTextAlign('invalid'),
    throwsA(isA<ArgumentError>().having(
      (e) => e.message,
      'message',
      contains('Invalid text alignment'),
    )),
  );
  
  // Test invalid type input
  expect(
    () => FlyTextUtils.resolveTextAlign(123),
    throwsA(isA<ArgumentError>().having(
      (e) => e.message,
      'message',
      contains('must be a String or TextAlign'),
    )),
  );
}

/// Simple test page to provide context
class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: const Scaffold(
        body: Center(
          child: Text('Test Page'),
        ),
      ),
    );
  }
}

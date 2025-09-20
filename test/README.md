# Flywind Tests

This directory contains comprehensive tests for the Flywind Tailwind-like Flutter components.

## ✅ Test Status

**All Tests Passing** - 65+ comprehensive tests covering all components and utilities including the new border radius system.

## Running Tests

### Run All Tests
```bash
flutter test
```

### Run Tests with Coverage
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## Test Coverage

The tests cover:

### FlyPadding Utility
- ✅ Resolves uniform padding correctly
- ✅ Resolves directional padding (px, py, pl, pr, pt, pb)
- ✅ Handles mixed padding combinations
- ✅ Applies padding to widgets correctly
- ✅ Returns child when no padding is set

### FlyMargin Utility
- ✅ Resolves uniform margin correctly
- ✅ Resolves directional margin (mx, my, ml, mr, mt, mb)
- ✅ Handles mixed margin combinations
- ✅ Applies margin to widgets correctly
- ✅ Returns child when no margin is set

### FlyColor Utility
- ✅ Resolves colors from theme correctly
- ✅ Applies colors to TextStyle correctly
- ✅ Applies colors to Container correctly
- ✅ Handles missing colors with helpful error messages
- ✅ Returns null when no color is set

### FlyRounded Utility
- ✅ Resolves uniform border radius correctly
- ✅ Resolves directional border radius (roundedT, roundedR, roundedB, roundedL)
- ✅ Resolves individual corner border radius (roundedTl, roundedTr, roundedBl, roundedBr)
- ✅ Handles mixed border radius combinations
- ✅ Applies border radius to widgets correctly
- ✅ Returns child when no border radius is set

### FlyStyle Class
- ✅ copyWith creates new instances correctly
- ✅ hasPadding property works correctly
- ✅ hasMargin property works correctly
- ✅ hasBorderRadius property works correctly
- ✅ apply method handles Text widgets
- ✅ apply method handles Container widgets
- ✅ apply method combines color, padding, margin, and border radius
- ✅ apply method handles complex combinations

### FlyText Widget
- ✅ Renders basic text without styling
- ✅ Applies uniform padding correctly
- ✅ Applies directional padding correctly
- ✅ Applies individual side padding correctly
- ✅ Applies color correctly
- ✅ Combines padding and color correctly
- ✅ Handles method chaining correctly
- ✅ Handles missing colors gracefully

### FlyContainer Widget
- ✅ Renders basic container without styling
- ✅ Applies background color correctly
- ✅ Applies uniform padding correctly
- ✅ Applies horizontal padding correctly
- ✅ Combines background color and padding
- ✅ Handles mixed padding combinations
- ✅ Handles method chaining correctly
- ✅ Handles complex nested content
- ✅ Handles missing colors gracefully

## Test Examples

### Padding Tests
```dart
test('resolve returns correct uniform padding', () {
  const style = FlyStyle(padding: 3);
  final padding = FlyPadding.resolve(context, style);
  expect(padding, const EdgeInsets.all(12.0)); // 3 * 4.0 = 12.0
});
```

### Color Tests
```dart
test('resolve returns correct color for valid color key', () {
  const style = FlyStyle(color: 'blue600');
  final color = FlyColor.resolve(context, style);
  expect(color, const Color(0xFF2563EB));
});
```

### Rounded Tests
```dart
test('resolve returns correct uniform border radius', () {
  const style = FlyStyle(rounded: 'lg');
  final borderRadius = FlyRoundedUtils.resolve(context, style);
  expect(borderRadius, BorderRadius.circular(8.0));
});

test('resolve handles mixed directional border radius', () {
  const style = FlyStyle(roundedT: '', roundedR: 'md', roundedB: 'lg', roundedL: 'xl');
  final borderRadius = FlyRoundedUtils.resolve(context, style);
  expect(borderRadius.topLeft, const Radius.circular(12.0)); // roundedL overrides roundedT
  expect(borderRadius.topRight, const Radius.circular(6.0)); // roundedR overrides roundedT
});
```

### Widget Tests
```dart
testWidgets('applies both padding and color correctly', (tester) async {
  final widget = FlyText('Hello World').p(2).color('red600');
  await tester.pumpWidget(createTestWidget(widget));

  // Check padding
  final padding = tester.widget<Padding>(find.byType(Padding));
  expect(padding.padding, const EdgeInsets.all(8.0)); // 2 * 4.0
  
  // Check color
  final text = tester.widget<Text>(find.byType(Text));
  expect(text.style?.color, const Color(0xFFDC2626));
});

testWidgets('applies border radius correctly', (tester) async {
  final widget = FlyContainer(
    child: FlyText('Content'),
  ).rounded('lg');
  await tester.pumpWidget(createTestWidget(widget));

  // Check border radius
  final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect));
  expect(clipRRect.borderRadius, BorderRadius.circular(8.0));
});
```

## Error Handling Tests

The tests also verify that error handling works correctly:

```dart
test('resolve handles missing color gracefully in debug mode', () {
  const style = FlyStyle(color: 'nonexistent');
  
  // In debug mode, this should trigger an assertion
  expect(() => FlyColor.resolve(context, style), throwsA(isA<AssertionError>()));
});

test('resolve handles missing border radius gracefully in debug mode', () {
  const style = FlyStyle(rounded: 'nonexistent');
  
  // In debug mode, this should trigger an assertion
  expect(() => FlyRoundedUtils.resolve(context, style), throwsA(isA<AssertionError>()));
});
```

This ensures that developers get helpful error messages when using invalid color names or border radius values.

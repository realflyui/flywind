# Flywind Layout Specification

## Overview

This specification defines the requirements for implementing Flywind's layout system. The system provides Tailwind-like layout utilities that map to Flutter's core layout widgets including Column, Row, Wrap, GridView, and Stack.

## `.col()` Component

Based on the `Column()` flutter component.

### Code Example
```dart
FlyLayout([
  FlyText('Header'),
  FlyText('Content'),
  FlyText('Footer'),
])
  .col()
  .items('stretch')
  .justify('between');
```

### Supported Properties

| FlyLayout Helper | Tailwind Class | Flutter Widget |
|---|---|---|
| `.col()` | `.flex-col` | `Column()` |
| `.items('stretch')` | `.items-stretch` | `CrossAxisAlignment.stretch` |
| `.items('start')` | `.items-start` | `CrossAxisAlignment.start` |
| `.items('center')` | `.items-center` | `CrossAxisAlignment.center` |
| `.items('end')` | `.items-end` | `CrossAxisAlignment.end` |
| `.items('baseline')` | `.items-baseline` | `CrossAxisAlignment.baseline` |
| `.justify('start')` | `.justify-start` | `MainAxisAlignment.start` |
| `.justify('end')` | `.justify-end` | `MainAxisAlignment.end` |
| `.justify('center')` | `.justify-center` | `MainAxisAlignment.center` |
| `.justify('between')` | `.justify-between` | `MainAxisAlignment.spaceBetween` |
| `.justify('around')` | `.justify-around` | `MainAxisAlignment.spaceAround` |
| `.justify('evenly')` | `.justify-evenly` | `MainAxisAlignment.spaceEvenly` |
| `.reverse()` | `.flex-col-reverse` | `Column()` with `verticalDirection: VerticalDirection.up` |
| `.gap('s0')` to `.gap('s96')` | `.gap-0` to `.gap-96` | Custom spacing between children |
| `.gap('px')` | `.gap-px` | Custom spacing (1px) |
| `.gapX('s0')` to `.gapX('s96')` | `.gap-x-0` to `.gap-x-96` | `mainAxisSpacing` in GridView |
| `.gapY('s0')` to `.gapY('s96')` | `.gap-y-0` to `.gap-y-96` | `crossAxisSpacing` in GridView |

### Not Implemented

| FlyLayout Helper | Tailwind Class | Flutter Widget |
|---|---|---|
| `.mainAxisSize('min')` | N/A | `MainAxisSize.min` |
| `.mainAxisSize('max')` | N/A | `MainAxisSize.max` |
| `.textBaseline('alphabetic')` | N/A | `TextBaseline.alphabetic` |
| `.textBaseline('ideographic')` | N/A | `TextBaseline.ideographic` |
| `.textDirection('ltr')` | N/A | `TextDirection.ltr` |
| `.textDirection('rtl')` | N/A | `TextDirection.rtl` |
| `.verticalDirection('down')` | N/A | `VerticalDirection.down` |
| `.verticalDirection('up')` | N/A | `VerticalDirection.up` |
| `.content('start')` | `.content-start` | `WrapAlignment.start` |
| `.content('center')` | `.content-center` | `WrapAlignment.center` |
| `.content('end')` | `.content-end` | `WrapAlignment.end` |
| `.content('between')` | `.content-between` | `WrapAlignment.spaceBetween` |
| `.content('around')` | `.content-around` | `WrapAlignment.spaceAround` |
| `.content('evenly')` | `.content-evenly` | `WrapAlignment.spaceEvenly` |
| `.placeContent('center')` | `.place-content-center` | `WrapAlignment.center` |
| `.placeContent('start')` | `.place-content-start` | `WrapAlignment.start` |
| `.placeContent('end')` | `.place-content-end` | `WrapAlignment.end` |
| `.placeContent('between')` | `.place-content-between` | `WrapAlignment.spaceBetween` |
| `.placeContent('around')` | `.place-content-around` | `WrapAlignment.spaceAround` |
| `.placeContent('evenly')` | `.place-content-evenly` | `WrapAlignment.spaceEvenly` |
| `.placeContent('stretch')` | `.place-content-stretch` | `WrapAlignment.spaceEvenly` |

### Flutter API Access

Access the underlying Flutter `Column` widget with direct constructor parameter configuration:

```dart
FlyLayout([...children])
  .col({
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    textBaseline: TextBaseline.alphabetic,
    textDirection: TextDirection.ltr,
    verticalDirection: VerticalDirection.down,
  });
```

---

## `.row()` Component

Based on the `Row()` flutter component.

### Code Example
```dart
FlyLayout([
  FlyText('Left'),
  FlyText('Center'),
  FlyText('Right'),
])
  .row()
  .justify('between')
  .items('center')
  .gap('s4');
```

### Supported Properties

| FlyLayout Helper | Tailwind Class | Flutter Widget |
|---|---|---|
| `.row()` | `.flex` | `Row()` |
| `.inline()` | `.inline-flex` | `Row()` with `mainAxisSize: MainAxisSize.min` |
| `.reverse()` | `.flex-row-reverse` | `Row()` with `textDirection: TextDirection.rtl` |
| `.items('stretch')` | `.items-stretch` | `CrossAxisAlignment.stretch` |
| `.items('start')` | `.items-start` | `CrossAxisAlignment.start` |
| `.items('center')` | `.items-center` | `CrossAxisAlignment.center` |
| `.items('end')` | `.items-end` | `CrossAxisAlignment.end` |
| `.items('baseline')` | `.items-baseline` | `CrossAxisAlignment.baseline` |
| `.justify('start')` | `.justify-start` | `MainAxisAlignment.start` |
| `.justify('end')` | `.justify-end` | `MainAxisAlignment.end` |
| `.justify('center')` | `.justify-center` | `MainAxisAlignment.center` |
| `.justify('between')` | `.justify-between` | `MainAxisAlignment.spaceBetween` |
| `.justify('around')` | `.justify-around` | `MainAxisAlignment.spaceAround` |
| `.justify('evenly')` | `.justify-evenly` | `MainAxisAlignment.spaceEvenly` |
| `.gap('s0')` to `.gap('s96')` | `.gap-0` to `.gap-96` | Custom spacing between children |
| `.gap('px')` | `.gap-px` | Custom spacing (1px) |
| `.gapX('s0')` to `.gapX('s96')` | `.gap-x-0` to `.gap-x-96` | `mainAxisSpacing` in GridView |
| `.gapY('s0')` to `.gapY('s96')` | `.gap-y-0` to `.gap-y-96` | `crossAxisSpacing` in GridView |

### Not Implemented

| FlyLayout Helper | Tailwind Class | Flutter Widget |
|---|---|---|
| `.mainAxisSize('min')` | N/A | `MainAxisSize.min` |
| `.mainAxisSize('max')` | N/A | `MainAxisSize.max` |
| `.textBaseline('alphabetic')` | N/A | `TextBaseline.alphabetic` |
| `.textBaseline('ideographic')` | N/A | `TextBaseline.ideographic` |
| `.textDirection('ltr')` | N/A | `TextDirection.ltr` |
| `.textDirection('rtl')` | N/A | `TextDirection.rtl` |
| `.verticalDirection('down')` | N/A | `VerticalDirection.down` |
| `.verticalDirection('up')` | N/A | `VerticalDirection.up` |
| `.content('start')` | `.content-start` | `WrapAlignment.start` |
| `.content('center')` | `.content-center` | `WrapAlignment.center` |
| `.content('end')` | `.content-end` | `WrapAlignment.end` |
| `.content('between')` | `.content-between` | `WrapAlignment.spaceBetween` |
| `.content('around')` | `.content-around` | `WrapAlignment.spaceAround` |
| `.content('evenly')` | `.content-evenly` | `WrapAlignment.spaceEvenly` |
| `.placeContent('center')` | `.place-content-center` | `WrapAlignment.center` |
| `.placeContent('start')` | `.place-content-start` | `WrapAlignment.start` |
| `.placeContent('end')` | `.place-content-end` | `WrapAlignment.end` |
| `.placeContent('between')` | `.place-content-between` | `WrapAlignment.spaceBetween` |
| `.placeContent('around')` | `.place-content-around` | `WrapAlignment.spaceAround` |
| `.placeContent('evenly')` | `.place-content-evenly` | `WrapAlignment.spaceEvenly` |
| `.placeContent('stretch')` | `.place-content-stretch` | `WrapAlignment.spaceEvenly` |

### Flutter API Access

Access the underlying Flutter `Row` widget with direct constructor parameter configuration:

```dart
FlyLayout([...children])
  .row({
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    textBaseline: TextBaseline.alphabetic,
    textDirection: TextDirection.ltr,
    verticalDirection: VerticalDirection.down,
  });
```

---

## Flex Item Properties

Individual flex properties for children within flex containers. Maps to Tailwind's flex utilities for controlling how flex items grow, shrink, and behave.

### Code Example
```dart
FlyLayout([
  FlyText('Fixed Width').w('s32'),           // Fixed size
  FlyText('Flexible').flex(1),               // Flexible growth
  FlyText('Expanded').grow(2),               // Expanded growth
  FlyText('Shrink').shrink(0),               // No shrinking
  FlyText('Basis').basis('s40'),             // Flex basis
])
  .row()
  .gap('s4')
  .items('stretch');
```

### Supported Properties

| FlyLayout Helper | Tailwind Class | Flutter Widget |
|---|---|---|
| `.flex(1)` | `.flex-1` | `Flexible(flex: 1)` |
| `.flex(2)` | `.flex-2` | `Flexible(flex: 2)` |
| `.flex(3)` | `.flex-3` | `Flexible(flex: 3)` |
| `.flex(4)` | `.flex-4` | `Flexible(flex: 4)` |
| `.flex(5)` | `.flex-5` | `Flexible(flex: 5)` |
| `.flex(6)` | `.flex-6` | `Flexible(flex: 6)` |
| `.flex(12)` | `.flex-12` | `Flexible(flex: 12)` |
| `.flex('auto')` | `.flex-auto` | `Flexible(flex: 1, fit: FlexFit.loose)` |
| `.flex('initial')` | `.flex-initial` | `Flexible(flex: 0, fit: FlexFit.loose)` |
| `.flex('none')` | `.flex-none` | `SizedBox()` with fixed dimensions |
| `.grow(1)` | `.flex-grow` | `Expanded(flex: 1)` |
| `.grow(2)` | `.flex-grow-2` | `Expanded(flex: 2)` |
| `.grow(0)` | `.flex-grow-0` | `Flexible(flex: 0, fit: FlexFit.loose)` |
| `.shrink(1)` | `.flex-shrink` | `Flexible(flex: 1, fit: FlexFit.loose)` |
| `.shrink(0)` | `.flex-shrink-0` | `Flexible(flex: 0, fit: FlexFit.loose)` |
| `.basis('s32')` | `.flex-basis-32` | `Flexible(flexBasis: 32)` |
| `.basis('s40')` | `.flex-basis-40` | `Flexible(flexBasis: 40)` |
| `.basis('s48')` | `.flex-basis-48` | `Flexible(flexBasis: 48)` |

### Not Implemented

| FlyLayout Helper | Tailwind Class | Flutter Widget |
|---|---|---|
| `.fit('loose')` | N/A | `Flexible(fit: FlexFit.loose)` |
| `.fit('tight')` | N/A | `Flexible(fit: FlexFit.tight)` |
| `.order(-9999)` | `.order-first` | `Flexible(flex: -9999)` |
| `.order(9999)` | `.order-last` | `Flexible(flex: 9999)` |
| `.order(0)` | `.order-none` | `Flexible(flex: 0)` |
| `.order(1)` | `.order-1` | `Flexible(flex: 1)` |
| `.order(2)` | `.order-2` | `Flexible(flex: 2)` |
| `.order(3)` | `.order-3` | `Flexible(flex: 3)` |
| `.order(4)` | `.order-4` | `Flexible(flex: 4)` |
| `.order(5)` | `.order-5` | `Flexible(flex: 5)` |
| `.order(6)` | `.order-6` | `Flexible(flex: 6)` |
| `.order(7)` | `.order-7` | `Flexible(flex: 7)` |
| `.order(8)` | `.order-8` | `Flexible(flex: 8)` |
| `.order(9)` | `.order-9` | `Flexible(flex: 9)` |
| `.self('auto')` | `.self-auto` | `Flexible(fit: FlexFit.loose)` |
| `.self('start')` | `.self-start` | Custom alignment |
| `.self('end')` | `.self-end` | Custom alignment |
| `.self('center')` | `.self-center` | Custom alignment |
| `.self('stretch')` | `.self-stretch` | Custom alignment |
| `.self('baseline')` | `.self-baseline` | Custom alignment |

---

## `.wrap()` Component

Based on the `Wrap()` flutter component.

### Code Example
```dart
FlyLayout([
  FlyText('Tag 1'),
  FlyText('Tag 2'),
  FlyText('Tag 3'),
])
  .wrap()
  .gap('s2')
  .runGap('s1')
  .align('start')
  .direction('horizontal');
```

### Supported Properties

| FlyLayout Helper | Tailwind Class | Flutter Widget |
|---|---|---|
| `.wrap()` | `.flex-wrap` | `Wrap()` |
| `.reverse()` | `.flex-wrap-reverse` | `Wrap()` with `verticalDirection: VerticalDirection.up` |
| `.gap('s2')` | `.gap-2` | `spacing` property |

### Not Implemented

| FlyLayout Helper | Tailwind Class | Flutter Widget |
|---|---|---|
| `.direction('horizontal')` | N/A | `Axis.horizontal` |
| `.direction('vertical')` | N/A | `Axis.vertical` |
| `.align('start')` | N/A | `WrapAlignment.start` |
| `.align('center')` | N/A | `WrapAlignment.center` |
| `.align('end')` | N/A | `WrapAlignment.end` |
| `.align('between')` | N/A | `WrapAlignment.spaceBetween` |
| `.align('around')` | N/A | `WrapAlignment.spaceAround` |
| `.align('evenly')` | N/A | `WrapAlignment.spaceEvenly` |
| `.runAlign('start')` | N/A | `WrapCrossAlignment.start` |
| `.runAlign('center')` | N/A | `WrapCrossAlignment.center` |
| `.runAlign('end')` | N/A | `WrapCrossAlignment.end` |
| `.runAlign('stretch')` | N/A | `WrapCrossAlignment.stretch` |
| `.runGap('s1')` | N/A | `runSpacing` property |
| `.textDirection('ltr')` | N/A | `TextDirection.ltr` |
| `.textDirection('rtl')` | N/A | `TextDirection.rtl` |
| `.verticalDirection('down')` | N/A | `VerticalDirection.down` |
| `.verticalDirection('up')` | N/A | `VerticalDirection.up` |
| `.clipBehavior('hardEdge')` | N/A | `Clip.hardEdge` |
| `.clipBehavior('antiAlias')` | N/A | `Clip.antiAlias` |
| `.clipBehavior('antiAliasWithSaveLayer')` | N/A | `Clip.antiAliasWithSaveLayer` |
| `.clipBehavior('none')` | N/A | `Clip.none` |
| `.crossAxisAlignment('start')` | N/A | `WrapCrossAlignment.start` |
| `.crossAxisAlignment('end')` | N/A | `WrapCrossAlignment.end` |
| `.crossAxisAlignment('center')` | N/A | `WrapCrossAlignment.center` |
| `.crossAxisAlignment('stretch')` | N/A | `WrapCrossAlignment.stretch` |

### Flutter API Access

Access the underlying Flutter `Wrap` widget with direct constructor parameter configuration:

```dart
FlyLayout([...children])
  .wrap({
    direction: Axis.horizontal,
    alignment: WrapAlignment.start,
    spacing: 0.0,
    runAlignment: WrapAlignment.start,
    runSpacing: 0.0,
    crossAxisAlignment: WrapCrossAlignment.start,
    textDirection: TextDirection.ltr,
    verticalDirection: VerticalDirection.down,
    clipBehavior: Clip.none,
  });
```

---

## `.grid()` Component

Based on the `GridView()` flutter component. Maps to Tailwind's CSS Grid system.

### Code Example
```dart
FlyLayout([
  FlyText('Item 1'),
  FlyText('Item 2'),
  FlyText('Item 3'),
  FlyText('Item 4'),
])
  .grid()
  .cols('2')
  .gap('s4')
  .justifyItems('center')
  .items('center');
```

### Supported Properties

| FlyLayout Helper | Tailwind Class | Flutter Widget |
|---|---|---|
| `.grid()` | `.grid` | `GridView()` |
| `.cols('1')` | `.grid-cols-1` | `GridView.count(crossAxisCount: 1)` |
| `.cols('2')` | `.grid-cols-2` | `GridView.count(crossAxisCount: 2)` |
| `.cols('3')` | `.grid-cols-3` | `GridView.count(crossAxisCount: 3)` |
| `.cols('4')` | `.grid-cols-4` | `GridView.count(crossAxisCount: 4)` |
| `.cols('5')` | `.grid-cols-5` | `GridView.count(crossAxisCount: 5)` |
| `.cols('6')` | `.grid-cols-6` | `GridView.count(crossAxisCount: 6)` |
| `.cols('12')` | `.grid-cols-12` | `GridView.count(crossAxisCount: 12)` |
| `.rows('1')` | `.grid-rows-1` | Custom `GridDelegate` |
| `.rows('2')` | `.grid-rows-2` | Custom `GridDelegate` |
| `.rows('3')` | `.grid-rows-3` | Custom `GridDelegate` |
| `.rows('6')` | `.grid-rows-6` | Custom `GridDelegate` |
| `.gap('s0')` | `.gap-0` | Custom spacing between children |
| `.gap('s4')` | `.gap-4` | Custom spacing between children |
| `.gap('s8')` | `.gap-8` | Custom spacing between children |
| `.gapX('s2')` | `.gap-x-2` | `mainAxisSpacing` in GridView |
| `.gapY('s2')` | `.gap-y-2` | `crossAxisSpacing` in GridView |
| `.justifyItems('start')` | `.justify-items-start` | Custom `GridDelegate` |
| `.justifyItems('end')` | `.justify-items-end` | Custom `GridDelegate` |
| `.justifyItems('center')` | `.justify-items-center` | Custom `GridDelegate` |
| `.justifyItems('stretch')` | `.justify-items-stretch` | Custom `GridDelegate` |
| `.items('start')` | `.items-start` | Custom `GridDelegate` |
| `.items('end')` | `.items-end` | Custom `GridDelegate` |
| `.items('center')` | `.items-center` | Custom `GridDelegate` |
| `.items('stretch')` | `.items-stretch` | Custom `GridDelegate` |
| `.flow('row')` | `.grid-flow-row` | `GridView()` with `scrollDirection: Axis.vertical` |
| `.flow('col')` | `.grid-flow-col` | `GridView()` with `scrollDirection: Axis.horizontal` |
| `.autoCols('auto')` | `.auto-cols-auto` | Custom `GridDelegate` |
| `.autoCols('min')` | `.auto-cols-min` | Custom `GridDelegate` |
| `.autoCols('max')` | `.auto-cols-max` | Custom `GridDelegate` |
| `.autoCols('fr')` | `.auto-cols-fr` | Custom `GridDelegate` |
| `.autoRows('auto')` | `.auto-rows-auto` | Custom `GridDelegate` |
| `.autoRows('min')` | `.auto-rows-min` | Custom `GridDelegate` |
| `.autoRows('max')` | `.auto-rows-max` | Custom `GridDelegate` |
| `.autoRows('fr')` | `.auto-rows-fr` | Custom `GridDelegate` |

### Not Implemented

| FlyLayout Helper | Tailwind Class | Flutter Widget |
|---|---|---|
| `.cols('none')` | `.grid-cols-none` | `GridView()` with custom delegate |
| `.rows('none')` | `.grid-rows-none` | `GridView()` with custom delegate |
| `.flow('row-dense')` | `.grid-flow-row-dense` | Custom `GridDelegate` |
| `.flow('col-dense')` | `.grid-flow-col-dense` | Custom `GridDelegate` |
| `.justifySelf('auto')` | `.justify-self-auto` | Custom `GridDelegate` |
| `.justifySelf('start')` | `.justify-self-start` | Custom `GridDelegate` |
| `.justifySelf('end')` | `.justify-self-end` | Custom `GridDelegate` |
| `.justifySelf('center')` | `.justify-self-center` | Custom `GridDelegate` |
| `.justifySelf('stretch')` | `.justify-self-stretch` | Custom `GridDelegate` |
| `.self('auto')` | `.self-auto` | Custom `GridDelegate` |
| `.self('start')` | `.self-start` | Custom `GridDelegate` |
| `.self('end')` | `.self-end` | Custom `GridDelegate` |
| `.self('center')` | `.self-center` | Custom `GridDelegate` |
| `.self('stretch')` | `.self-stretch` | Custom `GridDelegate` |
| `.self('baseline')` | `.self-baseline` | Custom `GridDelegate` |
| `.placeItems('start')` | `.place-items-start` | Custom `GridDelegate` |
| `.placeItems('end')` | `.place-items-end` | Custom `GridDelegate` |
| `.placeItems('center')` | `.place-items-center` | Custom `GridDelegate` |
| `.placeItems('stretch')` | `.place-items-stretch` | Custom `GridDelegate` |
| `.placeContent('center')` | `.place-content-center` | Custom `GridDelegate` |
| `.placeContent('start')` | `.place-content-start` | Custom `GridDelegate` |
| `.placeContent('end')` | `.place-content-end` | Custom `GridDelegate` |
| `.placeContent('between')` | `.place-content-between` | Custom `GridDelegate` |
| `.placeContent('around')` | `.place-content-around` | Custom `GridDelegate` |
| `.placeContent('evenly')` | `.place-content-evenly` | Custom `GridDelegate` |
| `.placeContent('stretch')` | `.place-content-stretch` | Custom `GridDelegate` |
| `.placeSelf('auto')` | `.place-self-auto` | Custom `GridDelegate` |
| `.placeSelf('start')` | `.place-self-start` | Custom `GridDelegate` |
| `.placeSelf('end')` | `.place-self-end` | Custom `GridDelegate` |
| `.placeSelf('center')` | `.place-self-center` | Custom `GridDelegate` |
| `.placeSelf('stretch')` | `.place-self-stretch` | Custom `GridDelegate` |

### Flutter API Access

Access the underlying Flutter `GridView` widget with direct constructor parameter configuration:

```dart
FlyLayout([...children])
  .grid({
    scrollDirection: Axis.vertical,
    reverse: false,
    controller: ScrollController(),
    primary: false,
    physics: ScrollPhysics(),
    shrinkWrap: false,
    padding: EdgeInsets.zero,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 0.0,
      crossAxisSpacing: 0.0,
      childAspectRatio: 1.0,
    ),
    addAutomaticKeepAlives: true,
    addRepaintBoundaries: true,
    addSemanticIndexes: true,
    cacheExtent: 0.0,
    clipBehavior: Clip.none,
  });
```

---

### Grid Item Properties

Grid item positioning methods for individual children. Maps to Tailwind's grid positioning utilities.

### Code Example
```dart
FlyLayout([
  FlyText('Item 1').colSpan('2').rowSpan('1'),
  FlyText('Item 2').colStart('3').colEnd('5'),
  FlyText('Item 3').rowStart('2').rowEnd('4'),
])
  .grid()
  .cols('4')
  .rows('3');
```

### Supported Properties

| FlyLayout Helper | Tailwind Class | Flutter Widget |
|---|---|---|
| `.colSpan('1')` | `.col-span-1` | Custom `GridDelegate` |
| `.colSpan('2')` | `.col-span-2` | Custom `GridDelegate` |
| `.colSpan('3')` | `.col-span-3` | Custom `GridDelegate` |
| `.colSpan('12')` | `.col-span-12` | Custom `GridDelegate` |
| `.colSpan('full')` | `.col-span-full` | Custom `GridDelegate` |
| `.colStart('1')` | `.col-start-1` | Custom `GridDelegate` |
| `.colStart('2')` | `.col-start-2` | Custom `GridDelegate` |
| `.colStart('13')` | `.col-start-13` | Custom `GridDelegate` |
| `.colEnd('1')` | `.col-end-1` | Custom `GridDelegate` |
| `.colEnd('2')` | `.col-end-2` | Custom `GridDelegate` |
| `.colEnd('13')` | `.col-end-13` | Custom `GridDelegate` |
| `.rowSpan('1')` | `.row-span-1` | Custom `GridDelegate` |
| `.rowSpan('2')` | `.row-span-2` | Custom `GridDelegate` |
| `.rowSpan('6')` | `.row-span-6` | Custom `GridDelegate` |
| `.rowSpan('full')` | `.row-span-full` | Custom `GridDelegate` |
| `.rowStart('1')` | `.row-start-1` | Custom `GridDelegate` |
| `.rowStart('2')` | `.row-start-2` | Custom `GridDelegate` |
| `.rowStart('7')` | `.row-start-7` | Custom `GridDelegate` |
| `.rowEnd('1')` | `.row-end-1` | Custom `GridDelegate` |
| `.rowEnd('2')` | `.row-end-2` | Custom `GridDelegate` |
| `.rowEnd('7')` | `.row-end-7` | Custom `GridDelegate` |

### Not Implemented

| FlyLayout Helper | Tailwind Class | Flutter Widget |
|---|---|---|
| `.colSpan('auto')` | `.col-auto` | Custom `GridDelegate` |
| `.colStart('auto')` | `.col-start-auto` | Custom `GridDelegate` |
| `.colEnd('auto')` | `.col-end-auto` | Custom `GridDelegate` |
| `.rowSpan('auto')` | `.row-auto` | Custom `GridDelegate` |
| `.rowStart('auto')` | `.row-start-auto` | Custom `GridDelegate` |
| `.rowEnd('auto')` | `.row-end-auto` | Custom `GridDelegate` |

---

## `.stack()` Component

Based on the `Stack()` flutter component. Maps to Tailwind's positioning system with `position: absolute` and positioning utilities.

### Code Example
```dart
FlyLayout([
  FlyContainer().bg('blue500').w('s64').h('s32'),
  FlyText('Overlay')
    .top('s2')
    .right('s2')
    .bg('red500')
    .px('s2')
    .py('s1'),
])
  .stack()
  .align('center')
  .fit('loose')
  .clipBehavior('hardEdge');
```

### Supported Properties

| FlyLayout Helper | Tailwind Class | Flutter Widget |
|---|---|---|
| `.stack()` | `.relative` | `Stack()` |

### Not Implemented

| FlyLayout Helper | Tailwind Class | Flutter Widget |
|---|---|---|
| `.align('center')` | N/A | `Stack alignment` |
| `.align('start')` | N/A | `Stack alignment` |
| `.align('end')` | N/A | `Stack alignment` |
| `.align('stretch')` | N/A | `Stack alignment` |
| `.fit('loose')` | N/A | `StackFit.loose` |
| `.fit('expand')` | N/A | `StackFit.expand` |
| `.fit('passthrough')` | N/A | `StackFit.passthrough` |
| `.clipBehavior('hardEdge')` | N/A | `Clip.hardEdge` |
| `.clipBehavior('antiAlias')` | N/A | `Clip.antiAlias` |
| `.clipBehavior('antiAliasWithSaveLayer')` | N/A | `Clip.antiAliasWithSaveLayer` |
| `.clipBehavior('none')` | N/A | `Clip.none` |
| `.textDirection('ltr')` | N/A | `TextDirection.ltr` |
| `.textDirection('rtl')` | N/A | `TextDirection.rtl` |
| `.verticalDirection('down')` | N/A | `VerticalDirection.down` |
| `.verticalDirection('up')` | N/A | `VerticalDirection.up` |
| `.textBaseline('alphabetic')` | N/A | `TextBaseline.alphabetic` |
| `.textBaseline('ideographic')` | N/A | `TextBaseline.ideographic` |

### Flutter API Access

Access the underlying Flutter `Stack` widget with direct constructor parameter configuration:

```dart
FlyLayout([...children])
  .stack({
    alignment: AlignmentDirectional.topStart,
    textDirection: TextDirection.ltr,
    fit: StackFit.loose,
    clipBehavior: Clip.hardEdge,
  });
```

---

## Position System

Positioning methods for `FlyText` and `FlyContainer` widgets. Maps to Tailwind's positioning utilities.

### Code Example
```dart
FlyLayout([
  FlyContainer(),
  FlyText('Overlay')
    .top('s2')
    .right('s2'),
])
  .stack();
```

### Supported Properties

| FlyLayout Helper | Tailwind Class | Flutter Widget |
|---|---|---|
| `.top('s2')` | `.top-2` | `Positioned(top: 2)` |
| `.right('s2')` | `.right-2` | `Positioned(right: 2)` |
| `.bottom('s2')` | `.bottom-2` | `Positioned(bottom: 2)` |
| `.left('s2')` | `.left-2` | `Positioned(left: 2)` |
| `.inset('s2')` | `.inset-2` | `Positioned(top: 2, right: 2, bottom: 2, left: 2)` |
| `.insetX('s2')` | `.inset-x-2` | `Positioned(left: 2, right: 2)` |
| `.insetY('s2')` | `.inset-y-2` | `Positioned(top: 2, bottom: 2)` |
| `.center()` | `.inset-0` | `Positioned.fill()` |

### Not Implemented

| FlyLayout Helper | Tailwind Class | Flutter Widget |
|---|---|---|---|
| `.position('static')` | `.static` | Default widget positioning |
| `.position('relative')` | `.relative` | `Transform.translate()` or `Positioned.fill()` |
| `.position('absolute')` | `.absolute` | `Positioned()` (requires Stack parent) |
| `.position('fixed')` | `.fixed` | `Positioned()` with `Overlay` |
| `.position('sticky')` | `.sticky` | `SliverAppBar()` or custom implementation |
| `.zIndex(1)` | `.z-10` | `Container()` with `z-index` |
| `.zIndex(10)` | `.z-10` | `Container()` with `z-index` |
| `.zIndex(20)` | `.z-20` | `Container()` with `z-index` |
| `.zIndex(30)` | `.z-30` | `Container()` with `z-index` |
| `.zIndex(40)` | `.z-40` | `Container()` with `z-index` |
| `.zIndex(50)` | `.z-50` | `Container()` with `z-index` |
| `.zIndex('auto')` | `.z-auto` | `Container()` with `z-index: auto` |

## Not Considered

#### 1. **Positioned Widget Constructor Parameters**
Flutter's `Positioned` widget has the following constructor parameters that were not fully considered:

```dart
Positioned({
  Key? key,
  double? left,
  double? top,
  double? right,
  double? bottom,
  double? width,
  double? height,
  Widget? child,
})
```

**Missing Properties:**
- `width` - Explicit width constraint for positioned child
- `height` - Explicit height constraint for positioned child
- `left` + `right` - Horizontal positioning with both sides
- `top` + `bottom` - Vertical positioning with both sides

#### 2. **StackFit Enumeration Values**
The `StackFit` enum has three values that affect how non-positioned children are sized:

- `StackFit.loose` - Children can be any size up to the Stack's size (default)
- `StackFit.expand` - Children are forced to fill the Stack
- `StackFit.passthrough` - Children can be any size they want

#### 3. **Clip Enumeration Values**
The `Clip` enum has four values for controlling overflow behavior:

- `Clip.none` - No clipping, allow overflow
- `Clip.hardEdge` - Clip to the Stack's bounds with hard edges (default)
- `Clip.antiAlias` - Clip with anti-aliased edges
- `Clip.antiAliasWithSaveLayer` - Clip with anti-aliased edges and save layer

#### 4. **AlignmentGeometry vs Alignment**
Flutter uses `AlignmentGeometry` (not just `Alignment`) for Stack alignment, which includes:
- `Alignment` - For absolute positioning
- `AlignmentDirectional` - For text-direction-aware positioning (default)

Note: Consider using `RepaintBoundary` for complex stacks

#### 5. **Animation Integration**
- `AnimatedPositioned` for animated positioning
- `AnimatedContainer` within Stack for size animations
- `Transform` widget for rotation, scale, and translation effects

---

## Missing Flutter Layout Components

The following Flutter layout widgets are not yet implemented in Flywind:

### Scrollable Layouts
- **SingleChildScrollView** - `.scrollable()` - `SingleChildScrollView()`
- **ListView** - `.list()` - `ListView()`
- **CustomScrollView** - `.customScroll()` - `CustomScrollView()`
- **SliverList** - `.sliverList()` - `SliverList()`
- **SliverGrid** - `.sliverGrid()` - `SliverGrid()`
- **SliverAppBar** - `.sliverAppBar()` - `SliverAppBar()`
- **SliverFillRemaining** - `.sliverFillRemaining()` - `SliverFillRemaining()`
- **SliverToBoxAdapter** - `.sliverToBoxAdapter()` - `SliverToBoxAdapter()`

### Table Layouts
- **Table** - `.table()` - `Table()`
- **DataTable** - `.dataTable()` - `DataTable()`
- **TableRow** - `.tableRow()` - `TableRow()`
- **TableCell** - `.tableCell()` - `TableCell()`

### Constraint Layouts
- **SizedBox** - `.sizedBox()` - `SizedBox()`
- **ConstrainedBox** - `.constrainedBox()` - `ConstrainedBox()`
- **UnconstrainedBox** - `.unconstrainedBox()` - `UnconstrainedBox()`
- **LimitedBox** - `.limitedBox()` - `LimitedBox()`
- **IntrinsicHeight** - `.intrinsicHeight()` - `IntrinsicHeight()`
- **IntrinsicWidth** - `.intrinsicWidth()` - `IntrinsicWidth()`
- **FractionallySizedBox** - `.fractionallySized()` - `FractionallySizedBox()`
- **SizedOverflowBox** - `.sizedOverflow()` - `SizedOverflowBox()`
- **OverflowBox** - `.overflowBox()` - `OverflowBox()`

### Aspect and Fitting
- **AspectRatio** - `.aspectRatio()` - `AspectRatio()`
- **FittedBox** - `.fittedBox()` - `FittedBox()`
- **Baseline** - `.baseline()` - `Baseline()`

### Transformations
- **Transform** - `.transform()` - `Transform()`
- **RotatedBox** - `.rotatedBox()` - `RotatedBox()`

### Clipping
- **ClipRect** - `.clipRect()` - `ClipRect()`
- **ClipRRect** - `.clipRRect()` - `ClipRRect()`
- **ClipOval** - `.clipOval()` - `ClipOval()`
- **ClipPath** - `.clipPath()` - `ClipPath()`

### Custom Layouts
- **Flow** - `.flow()` - `Flow()`
- **CustomSingleChildLayout** - `.customSingleChild()` - `CustomSingleChildLayout()`
- **CustomMultiChildLayout** - `.customMultiChild()` - `CustomMultiChildLayout()`

### Performance and Semantics
- **RepaintBoundary** - `.repaintBoundary()` - `RepaintBoundary()`
- **Semantics** - `.semantics()` - `Semantics()`

---

## Implementation Details

### Direct Flutter API Access

The layout system supports both utility methods and direct Flutter API access, allowing developers to choose the most appropriate approach for their needs.

#### Architecture

The implementation uses a hybrid approach that stores both utility method values and direct Flutter parameters in the `FlyStyle` class:

```dart
class FlyStyle {
  // Utility method properties (String values)
  final dynamic justify; // 'start', 'end', 'center', 'between', 'around', 'evenly'
  final dynamic items;   // 'start', 'end', 'center', 'stretch', 'baseline'
  
  // Direct Flutter API properties (Flutter objects)
  final dynamic col; // ColParams object
  final dynamic row; // RowParams object
}

class ColParams {
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final TextBaseline? textBaseline;
  final TextDirection? textDirection;
  final VerticalDirection? verticalDirection;
}
```

#### Method Overloading

Layout methods support both utility and direct API approaches through optional parameters:

```dart
// Utility method (no parameters)
T col() => copyWith(style.copyWith(layoutType: 'col'));

// Direct Flutter API (with parameters)
T col({
  MainAxisAlignment? mainAxisAlignment,
  CrossAxisAlignment? crossAxisAlignment,
  MainAxisSize? mainAxisSize,
  TextBaseline? textBaseline,
  TextDirection? textDirection,
  VerticalDirection? verticalDirection,
}) {
  // Store direct Flutter parameters in ColParams object
}
```

#### Priority Resolution

The build logic uses a priority system to resolve parameter conflicts:

1. **Direct Flutter API parameters** - Highest priority
2. **Utility method values** - Fallback when direct API not provided
3. **Default Flutter values** - Used when neither is specified

```dart
// In buildColumn/buildRow methods:
if (colParams != null) {
  // Use direct Flutter API parameters with utility method fallbacks
  mainAxisAlignment = colParams.mainAxisAlignment ?? resolveMainAxisAlignment(style.justify);
  crossAxisAlignment = colParams.crossAxisAlignment ?? resolveCrossAxisAlignment(style.items);
} else {
  // Use utility method parameters only
  mainAxisAlignment = resolveMainAxisAlignment(style.justify);
  crossAxisAlignment = resolveCrossAxisAlignment(style.items);
}
```

#### Mix and Match Support

Developers can combine both approaches in a single layout:

```dart
FlyLayout([...children])
  .col({
    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Direct API
    mainAxisSize: MainAxisSize.min,                   // Direct API
  })
  .items('center')  // Utility method
  .gap('s4');       // Utility method
```

This flexibility allows for gradual migration from utility methods to direct API access while maintaining backward compatibility with existing code.

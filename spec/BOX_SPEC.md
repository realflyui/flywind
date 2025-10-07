Here are both examples side-by-side:

## Container Mode (child)

```dart
// Flywind API
FlyBox(
  child: FlyText('Hello World').color('white').p('s3'),
)
  .bg('blue500')
  .rounded('md')
  .p('s4')
  .mb('s2');
```

```dart
// Equivalent Flutter Widget Tree
Container(
  margin: EdgeInsets.all(8.0),
  decoration: BoxDecoration(
    color: Color(0xFF3B82F6),
    borderRadius: BorderRadius.circular(6.0),
  ),
  padding: EdgeInsets.all(16.0),
  child: Padding(
    padding: EdgeInsets.all(12.0),
    child: Text(
      'Hello World',
      style: TextStyle(color: Colors.white),
    ),
  ),
)
```

## Layout Mode (children)

```dart
// Flywind API
FlyBox(
  children: [
    FlyText('Item 1').color('blue200').p('s2'),
    FlyText('Item 2').color('blue200').p('s2'),
  ],
)
  .col()
  .gap('s2')
  .bg('blue800')
  .rounded('md')
  .p('s4')
  .mb('s4');
```

```dart
// Equivalent Flutter Widget Tree
Container(
  margin: EdgeInsets.all(16.0),
  decoration: BoxDecoration(
    color: Color(0xFF1E40AF),
    borderRadius: BorderRadius.circular(6.0),
  ),
  padding: EdgeInsets.all(16.0),
  child: Column(
    children: [
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Item 1',
          style: TextStyle(color: Color(0xFFBFDBFE)),
        ),
      ),
      SizedBox(height: 8.0, width: 8.0),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Item 2',
          style: TextStyle(color: Color(0xFFBFDBFE)),
        ),
      ),
    ],
  ),
)
```

Great question! Let me check if `FlyBox` supports direct Flutter API access like the original `FlyContainer` did.


[2 tools called]

Yes! `FlyBox` does support direct Flutter API access, just like `FlyContainer` did. Looking at the constructor parameters, `FlyBox` includes all the same direct Flutter API parameters:

## ✅ Direct Flutter API Support in FlyBox

### Container Properties (Direct Flutter API)
```dart
FlyBox({
  super.key,
  this.child,
  this.children,
  this.alignment,           // ← Direct Flutter API
  this.padding,             // ← Direct Flutter API  
  this.margin,              // ← Direct Flutter API
  this.decoration,          // ← Direct Flutter API
  this.foregroundDecoration, // ← Direct Flutter API
  this.width,               // ← Direct Flutter API
  this.height,              // ← Direct Flutter API
  this.constraints,         // ← Direct Flutter API
  this.transform,           // ← Direct Flutter API
  this.transformAlignment,  // ← Direct Flutter API
  this.clipBehavior,        // ← Direct Flutter API
  FlyStyle flyStyle = const FlyStyle(),
})
```

### Layout Properties (Direct Flutter API)
For layout mode, `FlyBox` also supports direct Flutter API through the layout utilities. Let me check the layout utilities:


[1 tool called]

Perfect! Yes, `FlyBox` has comprehensive direct Flutter API support, just like `FlyContainer` did. Here's the complete breakdown:

## ✅ FlyBox Direct Flutter API Support

### 1. **Container Properties (Direct Flutter API)**
```dart
FlyBox(
  // Direct Flutter API parameters
  alignment: Alignment.center,
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.symmetric(vertical: 8),
  decoration: BoxDecoration(color: Colors.blue),
  foregroundDecoration: BoxDecoration(),
  width: 200,
  height: 100,
  constraints: BoxConstraints.tightFor(width: 200),
  transform: Matrix4.identity(),
  transformAlignment: Alignment.center,
  clipBehavior: Clip.antiAlias,
  
  // Flywind utilities
  child: FlyText('Hello'),
).bg('blue500').rounded('md').p('s4');
```

### 2. **Layout Properties (Direct Flutter API)**
```dart
// Column with direct Flutter API
FlyBox(
  children: [
    FlyText('Item 1'),
    FlyText('Item 2'),
  ],
).col(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  crossAxisAlignment: CrossAxisAlignment.stretch,
  mainAxisSize: MainAxisSize.max,
  textBaseline: TextBaseline.alphabetic,
  textDirection: TextDirection.ltr,
  verticalDirection: VerticalDirection.down,
);

// Row with direct Flutter API
FlyBox(
  children: [
    FlyText('Left'),
    FlyText('Right'),
  ],
).row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisSize: MainAxisSize.max,
  textBaseline: TextBaseline.alphabetic,
  textDirection: TextDirection.ltr,
  verticalDirection: VerticalDirection.down,
);
```

### 3. **Stack Properties (Direct Flutter API)**
```dart
FlyBox(
  children: [
    FlyText('Background'),
    FlyText('Foreground'),
  ],
).stack(
  alignment: Alignment.center,
  textDirection: TextDirection.ltr,
  fit: StackFit.loose,
  clipBehavior: Clip.hardEdge,
);
```

### 4. **Wrap Properties (Direct Flutter API)**
```dart
FlyBox(
  children: [
    FlyText('Tag 1'),
    FlyText('Tag 2'),
  ],
).wrap(
  direction: Axis.horizontal,
  alignment: WrapAlignment.start,
  crossAxisAlignment: WrapCrossAlignment.start,
  textDirection: TextDirection.ltr,
  verticalDirection: VerticalDirection.down,
  runAlignment: WrapAlignment.start,
  runSpacing: 8.0,
  spacing: 8.0,
);
```

## 🎯 Key Benefits

1. **Full Flutter API Access**: All Flutter Container, Column, Row, Stack, and Wrap properties are available
2. **Hybrid Approach**: Mix direct Flutter API with Flywind utilities
3. **Type Safety**: Full IntelliSense support for all Flutter parameters
4. **Backward Compatible**: Existing utility methods still work
5. **Flexible**: Choose the right approach for each use case

## 📝 Example Usage

```dart
// Mix direct Flutter API with utilities
FlyBox(
  children: [
    FlyText('Header'),
    FlyText('Content'),
    FlyText('Footer'),
  ],
).col(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.stretch,
).bg('blue500').rounded('lg').p('s4').h('s48');
```

So yes, `FlyBox` has the same comprehensive direct Flutter API support as `FlyContainer` did, plus additional layout APIs! 🚀

## Style Inheritance System

`FlyBox` implements a CSS-like inheritance system where text properties can be inherited by child widgets (`FlyText` and `FlyIcon`) without explicit prop drilling.

### How It Works

1. **Context Creation**: `FlyBox` creates a `FlyStyleContext` only when it has text properties (color, font, weight, etc.)
2. **Text Lookup**: `FlyText` and `FlyIcon` widgets walk up the widget tree to find the nearest `FlyStyleContext`
3. **Property Inheritance**: Child widgets inherit text properties with priority: explicit style → inherited context → widget defaults

### Inheritance Rules

| Widget Type | Inherits | Doesn't Inherit |
|-------------|----------|-----------------|
| `FlyText` | color, font, fontWeight, text, leading, tracking, textAlign, textTransform, textDecoration | layout properties (padding, margin, background, etc.) |
| `FlyIcon` | color only | all other properties |

### Examples

#### Basic Inheritance
```dart
FlyBox(
  children: [
    FlyText('Inherited Text'), // Gets blue400 and serif font
    FlyText('Override Color').color('red200'), // Gets serif font, overrides color
    FlyIcon(Icons.star), // Gets blue400 color
  ],
)
  .color('blue400') // Sets context color
  .font('serif') // Sets context font
  .weight('bold') // Sets context font weight
  .mb('s4');
```

#### Nested Inheritance
```dart
FlyBox(
  children: [
    FlyText('Outer text'), // Inherits red500, serif, bold
    FlyBox(
      children: [
        FlyText('Inner text'), // Inherits red500, serif, bold (from outer)
        FlyIcon(Icons.star), // Inherits red500 (from outer)
      ],
    )
      .bg('blue500') // Layout property - no context created
      .p('s4')
      .mb('s2'),
    FlyText('Back to outer'), // Inherits red500, serif, bold
  ],
)
  .color('red500') // Text property - creates context
  .font('serif') // Text property - creates context
  .weight('bold') // Text property - creates context
  .mb('s4');
```

#### Mixed Properties
```dart
FlyBox(
  children: [
    FlyText('Mixed box text'), // Inherits green500, mono
  ],
)
  .color('green500') // Text property - creates context
  .font('mono') // Text property - creates context
  .bg('yellow500') // Layout property - doesn't interfere
  .p('s4')
  .mb('s4');
```

### Context Creation Rules

| Box Properties | Creates Context? | Reason |
|----------------|------------------|---------|
| `.color('red')` | ✅ Yes | Text property |
| `.font('serif')` | ✅ Yes | Text property |
| `.weight('bold')` | ✅ Yes | Text property |
| `.bg('blue')` | ❌ No | Layout property |
| `.p('s4')` | ❌ No | Layout property |
| `.color('red').bg('blue')` | ✅ Yes | Has text properties |
| `.bg('blue').p('s4')` | ❌ No | Only layout properties |

### Performance Benefits

- **Conditional Context**: Only boxes with text properties create context
- **Lazy Evaluation**: Text widgets only do inheritance work when needed
- **Clean Separation**: Layout properties don't interfere with text inheritance
- **Efficient Lookup**: `InheritedWidget.of()` is O(1) and highly optimized by Flutter

### Design Philosophy

This inheritance system follows CSS principles:
- **Cascading**: Styles cascade down the widget tree
- **Inheritance**: Text properties are inherited by default
- **Specificity**: Explicit styles override inherited styles
- **Separation**: Layout and text concerns are separated
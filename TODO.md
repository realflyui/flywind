
* consider .color for text and icon in box recursively
* check that margin doesn't nest another container result = Container(margin: margin, child: result);

Notes:

Preserving User Values

The beauty of this pattern is that it preserves user-provided values:
FlyText('Hello World', flyStyle: FlyStyle(color: 'red500'))

* consider .color for text and icon in box recursively
* look at basic inheritance for text and icon
* think about how a custom component would implement this and have text overriden like card
* check that margin doesn't nest another container result = Container(margin: margin, child: result);
* think about style_applier again. 
* maybe helpers should be renamed to mixins
* Make FlywindColors
* Add IntinsicWidth as some sort of "container" 

* Maybe: 

lib/
├── utils/           # Pure utility classes (static methods)
│   ├── color.dart   # FlyColorUtils only
│   ├── flex.dart    # FlyFlexUtils only
│   ├── layout.dart  # FlyLayoutUtils only
│   └── ...
└── mixins/          # Mixins only
    ├── color.dart   # FlyColor<T> only
    ├── flex.dart    # FlyFlex<T> only
    ├── layout.dart  # FlyLayoutUtilities<T> only
    └── ...

Notes:

Preserving User Values

The beauty of this pattern is that it preserves user-provided values:
FlyText('Hello World', flyStyle: FlyStyle(color: 'red500'))


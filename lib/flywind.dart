// Flywind - A Tailwind-like utility-first Flutter component library
//
// This library provides utility-first widgets and helpers that bring the power
// and flexibility of Tailwind CSS to Flutter development.
//
// ## Getting Started
//
// ```dart
// import 'package:flywind/flywind.dart';
//
// // Use FlyText widget with utility classes
// FlyText('Hello World')
//   .color('blue600')
//   .px('16')
//   .py('8')
//   .rounded('lg');
//
// // Use FlyContainer widget
// FlyContainer(
//   child: FlyText('Content'),
// ).bg('gray100').p('16').rounded('md');
// ```
//
// ## Configuration
//
// Set up your custom theme with FlyConfig:
//
// ```dart
// MaterialApp(
//   theme: ThemeData(
//     extensions: [FlyConfig.createTheme()],
//   ),
//   // ...
// )
// ```

// Core configuration
export 'config.dart';

// Widgets
export 'widgets/container.dart';
export 'widgets/text.dart';

// Helpers and utilities
export 'helpers/color.dart';
export 'helpers/margin.dart';
export 'helpers/padding.dart';
export 'helpers/rounded.dart';
export 'helpers/spacing.dart';
export 'helpers/style.dart';
export 'helpers/theme.dart';

// Parsers
export 'parsers/color_parser.dart';
export 'parsers/unit_parser.dart';

// Tokens
export 'tokens/border_radius.dart';
export 'tokens/colors.dart';
export 'tokens/spacing.dart';

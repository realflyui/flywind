// Flywind Widgets
//
// This library exports all Flywind widget components that provide
// Tailwind-like utility-first styling capabilities.
//
// ## Available Widgets
//
// - [FlyText] - Text widget with utility styling
// - [FlyContainer] - Container widget with utility styling
//
// ## Usage
//
// ```dart
// import 'package:flywind/widgets.dart';
//
// // Text with utilities
// FlyText('Hello World')
//   .color('blue600')
//   .px('16')
//   .py('8');
//
// // Container with utilities
// FlyContainer(
//   child: FlyText('Content'),
// ).bg('gray100').p('16');
// ```

export 'container.dart';
export 'text.dart';

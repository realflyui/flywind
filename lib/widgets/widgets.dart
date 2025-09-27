// Flywind Widgets
//
// This library exports all Flywind widget components that provide
// Tailwind-like utility-first styling capabilities.
//
// ## Available Widgets
//
// - [FlyText] - Text widget with utility styling
// - [FlyContainer] - Container widget with utility styling
// - [FlyLayout] - Layout widget with col/row utilities
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
//
// // Layout with utilities
// FlyLayout([
//   FlyText('Header'),
//   FlyText('Content'),
//   FlyText('Footer'),
// ])
//   .col()
//   .items('center')
//   .justify('between')
//   .gap('s4');
//
// // Row layout
// FlyLayout([
//   FlyText('Left'),
//   FlyText('Center'),
//   FlyText('Right'),
// ])
//   .row()
//   .justify('between')
//   .items('center')
//   .gap('s2');
// ```

export 'container.dart';
export 'layout.dart';
export 'text.dart';

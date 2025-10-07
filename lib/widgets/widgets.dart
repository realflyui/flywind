// Flywind Widgets
//
// This library exports all Flywind widget components that provide
// Tailwind-like utility-first styling capabilities.
//
// ## Available Widgets
//
// - [FlyText] - Text widget with utility styling
// - [FlyBox] - Unified container and layout widget (recommended)
// - [FlyContainer] - Container widget with utility styling (legacy)
// - [FlyLayout] - Layout widget with col/row utilities (legacy)
// - [FlyIcon] - Icon widget with utility styling
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
// // Container mode
// FlyBox(
//   child: FlyText('Content'),
// ).bg('gray100').p('16');
//
// // Layout mode - Column
// FlyBox(
//   children: [
//     FlyText('Header'),
//     FlyText('Content'),
//     FlyText('Footer'),
//   ],
// )
//   .col()
//   .items('center')
//   .justify('between')
//   .gap('s4');
//
// // Layout mode - Row
// FlyBox(
//   children: [
//     FlyText('Left'),
//     FlyText('Center'),
//     FlyText('Right'),
//   ],
// )
//   .row()
//   .justify('between')
//   .items('center')
//   .gap('s2');
//
// // Icon with utilities
// FlyIcon(Icons.star)
//   .color('yellow500')
//   .w('s6')
//   .h('s6')
//   .p('s2')
//   .m('s1');
// ```

export 'box/box.dart';
export 'icon.dart';
export 'text.dart';

// Flywind Configuration
//
// This library exports the main configuration class and extensions
// for setting up custom themes and accessing custom values.
//
// ## Usage
//
// ```dart
// import 'package:flywind/config.dart';
//
// // Set up theme in MaterialApp
// MaterialApp(
//   theme: ThemeData(
//     extensions: [FlyConfig.createTheme()],
//   ),
//   // ...
// )
//
// // Access custom values
// final customColor = FlyConfig.getCustomColor('brand');
// final customSpacing = FlyConfig.getCustomSpacing('large');
// ```

export '../config.dart';

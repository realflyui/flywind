import 'package:flutter/material.dart';

import 'example.cupertino.dart' as cupertino;
import 'example.flywind.dart' as flywind;
import 'example.material.dart' as material;
import 'example.radix_colors.dart' as radix;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String _selectedExample = 'radix';

  @override
  Widget build(BuildContext context) {
    switch (_selectedExample) {
      case 'flywind':
        return const flywind.FlywindExample();
      case 'cupertino':
        return const cupertino.FlywindExample();
      case 'material':
        return const material.FlywindExample();
      case 'radix':
        return MaterialApp(
          title: 'Radix Colors',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: const radix.RadixColorsExample(),
        );
      default:
        return const flywind.FlywindExample();
    }
  }
}

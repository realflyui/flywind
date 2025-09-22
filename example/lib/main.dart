import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'example.cupertino.dart' as cupertino;
import 'example.flywind.dart' as flywind;
import 'example.material.dart' as material;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _selectedExample = 'material';

  @override
  Widget build(BuildContext context) {
    switch (_selectedExample) {
      case 'flywind':
        return const flywind.FlywindExample();
      case 'cupertino':
        return const cupertino.FlywindExample();
      case 'material':
        return const material.FlywindExample();
      default:
        return const flywind.FlywindExample();
    }
  }
}

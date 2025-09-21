import 'package:flutter/material.dart';
import 'package:flywind/flywind.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flywind Example',
      theme: ThemeData(extensions: [FlyConfig.createTheme()]),
      home: const ExampleHome(),
    );
  }
}

class ExampleHome extends StatelessWidget {
  const ExampleHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Example using FlyText with utilities
            FlyText(
              'Welcome to Flywind!',
            ).color('blue600').px('16').py('8').mb('16'),

            // Example using FlyContainer with utilities
            FlyContainer(
              child: FlyText(
                'This is a container with utilities',
              ).color('white').px('16').py('8'),
            ).bg('gray800').p('16').rounded('lg').mb('16'),

            // Example with custom colors from config
            FlyContainer(
              child: FlyText(
                'Custom brand color',
              ).color('white').px('16').py('8'),
            ).bg('brand').p('16').rounded('card').mb('16'),

            // Example with spacing utilities
            FlyText(
              'Spacing utilities example',
            ).color('green600').px('24').py('12').mb('8'),

            FlyText(
              'Another text with different spacing',
            ).color('purple600').px('32').py('16').mb('16'),
          ],
        ),
      ),
    );
  }
}

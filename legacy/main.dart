import 'package:flutter/material.dart';
import 'helpers/theme.dart';
// import 'widgets/text.dart';
// import 'widgets/container.dart';
import 'parsers/color_parser.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flywind Demo',
      theme: ThemeData(
        // Standard Material theme
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        extensions: [
          // FlyTheme.defaultTheme,
          FlyTheme(
            spacing: CustomSpacing,
            colors: CustomColors,
          ),
        ],
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access Flywind theme via the new simplified system
    final flywind = FlyTheme.of(context);
    final spacing = flywind.spacing;
    final colors = flywind.colors;
    final radius = flywind.radius;

    return Scaffold(
      body: SizedBox.expand(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // // Test the custom "blue200" color
              // FlyText('Custom "blue200" Color Test:').color('blue200').mb('12'),
              // // Mixed spacing examples
              // FlyText(
              //   'Mixed spacing example',
              // ).px(spacing.lg).py(spacing.xs).color('teal600').mb('8'),

              // // Test 100px horizontal padding
              // FlyText(
              //   'Testing 100px horizontal padding',
              // ).px('100px').color('red600').mb('8'),

              // // Background color examples using string-based spacing
              // FlyContainer(
              //   child: FlyText('Container with blue200 background').color('white'),
              // ).bg(colors.amber400).p(spacing.md).mb(spacing.md),

              // // Custom border radius example using extension
              // FlyContainer(
              //       child: FlyText('Custom pill border radius').color('white'),
              //     )
              //     .bg('brandPrimary')
              //     .p(spacing.xl)
              //     .rounded(radius.md)
              //     .mb(spacing.xl),

              // Material button using Flywind theme
              Padding(
                padding: EdgeInsets.only(bottom: double.parse(spacing.base)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: FlyColorParser.parse(colors.blue400),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.all(double.parse(spacing.base)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        double.parse(radius.lg),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Text('Material Button'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

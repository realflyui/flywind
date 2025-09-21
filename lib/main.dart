import 'package:flutter/material.dart';
import 'theme.dart';
import 'text.dart';
import 'container.dart';
import 'config.dart';
import 'color_parser.dart';

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
          FlyConfig.createTheme(),
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
    final flywind = context.flywind;
    final spacing = flywind.spacing;
    final colors = flywind.colors;
    final borderRadius = flywind.borderRadius;

    // Example usage - you can now use these values with type safety!
    print('Spacing 2 value: ${spacing.s2}'); // This will print "8" (default)
    print('Spacing 2 value (bracket): ${spacing[2]}'); // This will also print "8"
    
    // Standard colors using dot notation (type-safe!)
    print('Leif: ${colors.leif}'); // This will print the blue color
    print('Gray800: ${colors.gray800}'); // This will print the gray color

    // Bracket notation still works
    print('Blue 600 color (bracket): ${colors['blue600']}'); // This will also print the blue color
    
    return Scaffold(
      body: SizedBox.expand(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Test the custom "leif" color
            FlyText('Custom "leif" Color Test:').color('leif').mb('12'),
            // Mixed spacing examples
            FlyText('Mixed spacing example').px(spacing.s3).py(spacing.s2).color('teal600').mb('8'),
            
            // Background color examples using string-based spacing
            FlyContainer(
              child: FlyText('Container with leif background').color('white'),
            ).bg(colors.leif).p(spacing.s3).mb(spacing.s3),

            // Custom border radius example using extension
            FlyContainer(
              child: FlyText('Custom pill border radius').color('white'),
            ).bg('brand').p(spacing.s2).rounded('pill').mb(spacing.s2),

            // Material button using Flywind theme
            Padding(
              padding: EdgeInsets.only(bottom: double.parse(spacing.s2)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: FlyColorParser.parse(colors.leif),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.all(double.parse(spacing.s4)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius.lg),
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


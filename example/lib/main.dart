import 'package:flutter/material.dart';
import 'package:flywind/flywind.dart';
import 'flw/tokens/tokens.dart';

void main() {
  runApp(const FlywindExampleApp());
}

class FlywindExampleApp extends StatelessWidget {
  const FlywindExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flywind Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        extensions: [
        ]
      ),
      home: const FlywindExampleHomePage(),
    );
  }
}

class FlywindExampleHomePage extends StatelessWidget {
  const FlywindExampleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flywind Example'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flywind Examples',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'This example app demonstrates various Flywind components and utilities.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            // Add your Flywind examples here
            ExampleSection(),
          ],
        ),
      ),
    );
  }
}

class ExampleSection extends StatelessWidget {
  const ExampleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Container Examples',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        // Example containers with FlyWind design tokens
        FlyContainer(
              child: FlyText(
                'Container using FlyWind tokens',
              ).p(FlywindTokens.spacing.s2).color(FlywindTokens.colors.black),
            )
            .p(FlywindTokens.spacing.s4)
            .m(FlywindTokens.spacing.s2)
            .bg(FlywindTokens.colors.primary),
        FlyContainer(
              child: FlyText(
                'Container with FlyWind spacing and colors',
              ).color(FlywindTokens.colors.success),
            )
            .p(FlywindTokens.spacing.s4)
            .mb(FlywindTokens.spacing.s2)
            .bg(FlywindTokens.colors.success.withValues(alpha: 0.1))
            .rounded(12.0),
        const SizedBox(height: 24),
        const Text(
          'Text Examples',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        FlyText(
          'Large Heading Text',
        ).color(FlywindTokens.colors.primary).mb(FlywindTokens.spacing.s2),
        FlyText(
          'Medium body text with normal weight',
        ).color(FlywindTokens.colors.neutral).mb(FlywindTokens.spacing.s2),
        FlyText('Small caption text')
            .color(FlywindTokens.colors.neutral.withValues(alpha: 0.7))
            .mb(FlywindTokens.spacing.s4),
        FlyText('FlyWind utility example').color(FlywindTokens.colors.accent),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'tokens/tokens.dart';

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
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(FlywindTokens.spacing.s4),
          margin: EdgeInsets.only(bottom: FlywindTokens.spacing.s2),
          decoration: BoxDecoration(
            color: FlywindTokens.colors.primary.withValues(alpha: 0.1),
            borderRadius: FlywindTokens.radius.lg,
            border: Border.all(
              color: FlywindTokens.colors.primary.withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            'Container using FlyWind tokens',
            style: FlywindTokens.text.base.copyWith(
              color: FlywindTokens.colors.primary,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(FlywindTokens.spacing.s4),
          margin: EdgeInsets.only(bottom: FlywindTokens.spacing.s2),
          decoration: BoxDecoration(
            color: FlywindTokens.colors.success.withValues(alpha: 0.1),
            borderRadius: FlywindTokens.radius.xl,
            boxShadow: [
              BoxShadow(
                color: FlywindTokens.colors.success.withValues(alpha: 0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            'Container with FlyWind spacing and colors',
            style: FlywindTokens.text.lg.copyWith(
              color: FlywindTokens.colors.success,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Text Examples',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Text(
          'Large Heading Text',
          style: FlywindTokens.text.xl2.copyWith(
            fontWeight: FontWeight.bold,
            color: FlywindTokens.colors.primary,
          ),
        ),
        SizedBox(height: FlywindTokens.spacing.s2),
        Text(
          'Medium body text with normal weight',
          style: FlywindTokens.text.base.copyWith(
            color: FlywindTokens.colors.neutral,
          ),
        ),
        SizedBox(height: FlywindTokens.spacing.s2),
        Text(
          'Small caption text',
          style: FlywindTokens.text.sm.copyWith(
            color: FlywindTokens.colors.neutral.withValues(alpha: 0.7),
          ),
        ),
        SizedBox(height: FlywindTokens.spacing.s4),
        Text(
          'FlyWind utility example',
          style: FlywindTokens.text.lg.copyWith(
            color: FlywindTokens.colors.accent,
          ),
        ),
      ],
    );
  }
}

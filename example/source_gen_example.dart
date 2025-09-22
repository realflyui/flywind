// This file demonstrates how to use FlyWind with source_gen
// To regenerate tokens, run: flutter packages pub run build_runner build

import 'package:flutter/material.dart';
// import 'package:flywind/flywind.dart';

// part 'source_gen_example.g.dart';

/// Example widget demonstrating FlyWind token usage
///
/// This example shows how to set up a file to use FlyWind tokens generated
/// with source_gen. After running the build runner, you can uncomment the
/// code below to see the tokens in action.
class SourceGenExample extends StatelessWidget {
  const SourceGenExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlyWind Source Gen Example'),
        backgroundColor: Colors.blue, // FlywindTokens.colors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // FlywindTokens.spacing.s4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0), // FlywindTokens.spacing.s4,
              decoration: BoxDecoration(
                color: Colors.green, // FlywindTokens.colors.secondary,
                borderRadius: BorderRadius.circular(
                  8.0,
                ), // FlywindTokens.borderRadius.lg,
              ),
              child: const Text(
                'This example shows how to use FlyWind tokens generated with source_gen',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 24.0), // FlywindTokens.spacing.s6,
            Text(
              'Available Tokens:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16.0), // FlywindTokens.spacing.s4,
            _buildTokenExample(
              'Colors',
              'Primary: Color(0xFF3B82F6)', // FlywindTokens.colors.primary,
              Colors.blue,
            ),
            const SizedBox(height: 8.0), // FlywindTokens.spacing.s2,
            _buildTokenExample(
              'Spacing',
              'Large spacing: 32', // FlywindTokens.spacing.s8,
              null,
            ),
            const SizedBox(height: 8.0), // FlywindTokens.spacing.s2,
            _buildTokenExample(
              'Border Radius',
              'Large radius: 8.0', // FlywindTokens.borderRadius.lg,
              null,
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Instructions:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8.0),
            const Text(
              '1. Create a flywind.yaml file in your project root\n'
              '2. Add this file as a part of your main file\n'
              '3. Run: flutter packages pub run build_runner build\n'
              '4. Uncomment the FlywindTokens references above\n'
              '5. Use the generated tokens in your widgets!',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTokenExample(String title, String description, Color? color) {
    return Container(
      padding: const EdgeInsets.all(12.0), // FlywindTokens.spacing.s3,
      decoration: BoxDecoration(
        color: color ?? Colors.grey[100],
        borderRadius: BorderRadius.circular(
          6.0,
        ), // FlywindTokens.borderRadius.md,
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4.0), // FlywindTokens.spacing.s1,
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: color != null ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

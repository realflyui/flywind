import 'package:flutter/material.dart';
import '../fly.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return FlyApp(
      themeMode: _themeMode,
      themeData: FlyThemeData(
        spacing: const CustomSpacing(),
        colors: const BrandAColors(),
      ),
      darkThemeData: FlyThemeData(
        spacing: const CustomSpacing(),
        colors: const BrandAColors().copyWith(
          primary: const Color(0xFF10B981), // Green for dark mode
          surface: const Color(0xFF1F2937), // Dark surface
        ),
      ),
      appBuilder: (context) {
        final flyTheme = FlyTheme.of(context);
        
        return MaterialApp(
          title: 'Fly App',
          themeMode: _themeMode,
          theme: ThemeData(
            extensions: [flyTheme],
            colorScheme: ColorScheme.fromSeed(
              seedColor: flyTheme.colors.primary,
              brightness: Brightness.light,
            ),
          ),
          darkTheme: ThemeData(
            extensions: [flyTheme],
            colorScheme: ColorScheme.fromSeed(
              seedColor: flyTheme.colors.primary,
              brightness: Brightness.dark,
            ),
          ),
          home: MyHomePage(
            onThemeModeChanged: (mode) {
              setState(() {
                _themeMode = mode;
              });
            },
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.onThemeModeChanged,
  });

  final void Function(ThemeMode) onThemeModeChanged;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isGreen = false;

  @override
  Widget build(BuildContext context) {
    final flyTheme = FlyTheme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fly App'),
        backgroundColor: flyTheme.colors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(flyTheme.spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Fly!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: flyTheme.colors['text'] ?? Colors.black,
              ),
            ),
            SizedBox(height: flyTheme.spacing.md),
            Text(
              'Your Fly theming library is ready to use.',
              style: TextStyle(
                color: flyTheme.colors['textSecondary'] ?? Colors.grey,
              ),
            ),
            SizedBox(height: flyTheme.spacing.lg),
            
            // Theme mode toggle
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => widget.onThemeModeChanged(ThemeMode.light),
                  child: const Text('Light'),
                ),
                SizedBox(width: flyTheme.spacing.sm),
                ElevatedButton(
                  onPressed: () => widget.onThemeModeChanged(ThemeMode.dark),
                  child: const Text('Dark'),
                ),
                SizedBox(width: flyTheme.spacing.sm),
                ElevatedButton(
                  onPressed: () => widget.onThemeModeChanged(ThemeMode.system),
                  child: const Text('System'),
                ),
              ],
            ),
            
            SizedBox(height: flyTheme.spacing.lg),
            
            // Toggle primary color button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isGreen = !_isGreen;
                });
                
                final newColor = _isGreen ? Colors.green : const Color(0xFF6366F1);
                FlyTheme.putColor(context, 'primary', newColor);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _isGreen ? Colors.green : const Color(0xFF6366F1),
                foregroundColor: Colors.white,
              ),
              child: Text(_isGreen ? 'Change to Indigo' : 'Change to Green'),
            ),
            
            SizedBox(height: flyTheme.spacing.lg),
            
            // Current spacing values display
            Container(
              padding: EdgeInsets.all(flyTheme.spacing.sm),
              decoration: BoxDecoration(
                color: flyTheme.colors.surface,
                border: Border.all(color: flyTheme.colors['border'] ?? Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Spacing Values:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: flyTheme.colors['text'] ?? Colors.black,
                    ),
                  ),
                  SizedBox(height: flyTheme.spacing.sm),
                  Text('sm spacing: ${flyTheme.spacing.sm}'),
                  Text('md spacing: ${flyTheme.spacing.md}'),
                  Text('lg spacing: ${flyTheme.spacing.lg}'),
                ],
              ),
            ),
            
            SizedBox(height: flyTheme.spacing.md),
            
            // Update spacing button
            ElevatedButton(
              onPressed: () {
                final currentSm = flyTheme.spacing.sm;
                FlyTheme.putSpacing(context, 'sm', currentSm + 1);
              },
              child: const Text('Increment sm by 1'),
            ),
          ],
        ),
      ),
    );
  }
}
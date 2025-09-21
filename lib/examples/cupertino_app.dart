import 'package:flutter/cupertino.dart';
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

  Brightness _getCurrentBrightness() {
    switch (_themeMode) {
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.system:
        return WidgetsBinding.instance.platformDispatcher.platformBrightness;
    }
  }

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
        
        return CupertinoApp(
          title: 'Fly App',
          theme: CupertinoThemeData(
            primaryColor: flyTheme.colors.primary,
            brightness: _getCurrentBrightness(),
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
    
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Fly App'),
        backgroundColor: flyTheme.colors.primary,
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(flyTheme.spacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Fly!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: flyTheme.colors['text'] ?? CupertinoColors.black,
                ),
              ),
              SizedBox(height: flyTheme.spacing.md),
              Text(
                'Your Fly theming library is ready to use.',
                style: TextStyle(
                  color: flyTheme.colors['textSecondary'] ?? CupertinoColors.systemGrey,
                ),
              ),
              SizedBox(height: flyTheme.spacing.lg),
              
              // Theme mode toggle
              Row(
                children: [
                  CupertinoButton.filled(
                    onPressed: () => widget.onThemeModeChanged(ThemeMode.light),
                    child: const Text('Light'),
                  ),
                  SizedBox(width: flyTheme.spacing.sm),
                  CupertinoButton.filled(
                    onPressed: () => widget.onThemeModeChanged(ThemeMode.dark),
                    child: const Text('Dark'),
                  ),
                  SizedBox(width: flyTheme.spacing.sm),
                  CupertinoButton.filled(
                    onPressed: () => widget.onThemeModeChanged(ThemeMode.system),
                    child: const Text('System'),
                  ),
                ],
              ),
              
              SizedBox(height: flyTheme.spacing.lg),
              
              // Toggle primary color button
              Container(
                decoration: BoxDecoration(
                  color: _isGreen ? CupertinoColors.systemGreen : const Color(0xFF6366F1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CupertinoButton(
                  onPressed: () {
                    setState(() {
                      _isGreen = !_isGreen;
                    });
                    
                    final newColor = _isGreen ? CupertinoColors.systemGreen : const Color(0xFF6366F1);
                    FlyTheme.putColor(context, 'primary', newColor);
                  },
                  child: Text(
                    _isGreen ? 'Change to Indigo' : 'Change to Green',
                    style: const TextStyle(color: CupertinoColors.white),
                  ),
                ),
              ),
              
              SizedBox(height: flyTheme.spacing.lg),
              
              // Current spacing values display
              Container(
                padding: EdgeInsets.all(flyTheme.spacing.sm),
                decoration: BoxDecoration(
                  color: flyTheme.colors.surface,
                  border: Border.all(color: flyTheme.colors['border'] ?? CupertinoColors.systemGrey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Spacing Values:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: flyTheme.colors['text'] ?? CupertinoColors.black,
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
              CupertinoButton.filled(
                onPressed: () {
                  final currentSm = flyTheme.spacing.sm;
                  FlyTheme.putSpacing(context, 'sm', currentSm + 1);
                },
                child: const Text('Increment sm by 1'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
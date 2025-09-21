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
          background: const Color(0xFF111827), // Dark background
        ),
      ),
      appBuilder: (context) {
        return SimpleApp(
          onThemeModeChanged: (mode) {
            setState(() {
              _themeMode = mode;
            });
          },
        );
      },
    );
  }
}

/// Simple app without Material or Cupertino - just basic Flutter widgets
class SimpleApp extends StatefulWidget {
  const SimpleApp({
    super.key,
    required this.onThemeModeChanged,
  });

  final void Function(ThemeMode) onThemeModeChanged;

  @override
  State<SimpleApp> createState() => _SimpleAppState();
}

class _SimpleAppState extends State<SimpleApp> {
  bool _isGreen = false;

  @override
  Widget build(BuildContext context) {
    final flyTheme = FlyTheme.of(context);
    
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: flyTheme.colors.background,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(flyTheme.spacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(flyTheme.spacing.md),
                  decoration: BoxDecoration(
                    color: flyTheme.colors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Fly Theming Library',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                
                SizedBox(height: flyTheme.spacing.lg),
                
                // Description
                Text(
                  'Framework-agnostic theming with runtime updates',
                  style: TextStyle(
                    fontSize: 16,
                    color: flyTheme.colors['textSecondary'] ?? Colors.grey[600],
                  ),
                ),
                
                SizedBox(height: flyTheme.spacing.lg),
                
                // Theme mode toggle buttons
                Text(
                  'Theme Mode:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: flyTheme.colors['text'] ?? Colors.black,
                  ),
                ),
                SizedBox(height: flyTheme.spacing.sm),
                Row(
                  children: [
                    _buildThemeModeButton('Light', ThemeMode.light, flyTheme),
                    SizedBox(width: flyTheme.spacing.sm),
                    _buildThemeModeButton('Dark', ThemeMode.dark, flyTheme),
                    SizedBox(width: flyTheme.spacing.sm),
                    _buildThemeModeButton('System', ThemeMode.system, flyTheme),
                  ],
                ),
                
                SizedBox(height: (flyTheme.spacing['xl'] ?? flyTheme.spacing.lg).toDouble()),
                
                // Color toggle button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isGreen = !_isGreen;
                    });
                    
                    final newColor = _isGreen ? Colors.green : const Color(0xFF6366F1);
                    FlyTheme.putColor(context, 'primary', newColor);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: flyTheme.spacing.lg,
                      vertical: flyTheme.spacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: _isGreen ? Colors.green : const Color(0xFF6366F1),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      _isGreen ? 'Change to Indigo' : 'Change to Green',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: flyTheme.spacing.lg),
                
                // Spacing increment button
                GestureDetector(
                  onTap: () {
                    final currentSm = flyTheme.spacing.sm;
                    FlyTheme.putSpacing(context, 'sm', currentSm + 1);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: flyTheme.spacing.lg,
                      vertical: flyTheme.spacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: flyTheme.colors.secondary,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      'Increment sm spacing by 1',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: (flyTheme.spacing['xl'] ?? flyTheme.spacing.lg).toDouble()),
                
                // Current values display
                Container(
                  padding: EdgeInsets.all(flyTheme.spacing.md),
                  decoration: BoxDecoration(
                    color: flyTheme.colors.surface,
                    border: Border.all(
                      color: flyTheme.colors['border'] ?? Colors.grey[300]!,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Theme Values:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: flyTheme.colors['text'] ?? Colors.black,
                        ),
                      ),
                      SizedBox(height: flyTheme.spacing.sm),
                      Text(
                        'Primary Color: ${flyTheme.colors.primary}',
                        style: TextStyle(
                          color: flyTheme.colors['text'] ?? Colors.black,
                        ),
                      ),
                      Text(
                        'sm spacing: ${flyTheme.spacing.sm}',
                        style: TextStyle(
                          color: flyTheme.colors['text'] ?? Colors.black,
                        ),
                      ),
                      Text(
                        'md spacing: ${flyTheme.spacing.md}',
                        style: TextStyle(
                          color: flyTheme.colors['text'] ?? Colors.black,
                        ),
                      ),
                      Text(
                        'lg spacing: ${flyTheme.spacing.lg}',
                        style: TextStyle(
                          color: flyTheme.colors['text'] ?? Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Spacer(),
                
                // Footer
                Center(
                  child: Text(
                    'No Material or Cupertino - Just Fly! 🚀',
                    style: TextStyle(
                      color: flyTheme.colors['textSecondary'] ?? Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeModeButton(String label, ThemeMode mode, FlyThemeData flyTheme) {
    return GestureDetector(
      onTap: () => widget.onThemeModeChanged(mode),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: flyTheme.spacing.md,
          vertical: flyTheme.spacing.sm,
        ),
        decoration: BoxDecoration(
          color: flyTheme.colors.secondary,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: flyTheme.colors['border'] ?? Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
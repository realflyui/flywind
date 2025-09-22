import 'package:flutter/material.dart';
import '../flywind.dart';
import '../custom_tokens/custom_tokens.dart';

class Flywind extends StatefulWidget {
  const Flywind({super.key});

  @override
  State<Flywind> createState() => _FlywindState();
}

class _FlywindState extends State<Flywind> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return FlyApp(
      themeMode: _themeMode,
      themeData: FlyThemeData(
        spacing: CustomSpacing.defaultSpacing(),
        colors: CustomColors.defaultColors(),
        radius: FlyRadiusToken.defaultRadius(),
        breakpoints: FlyBreakpointToken.defaultBreakpoint(),
      ),
      darkThemeData: FlyThemeData(
        spacing: CustomSpacing.defaultSpacing(),
        colors: CustomColors.defaultColors()
          .put('primary', const Color(0xFF10B981)) // Green for dark mode
          .put('surface', const Color(0xFF1F2937)) // Dark surface
          .put('background', const Color(0xFF111827)), // Dark background
        radius: FlyRadiusToken.defaultRadius(),
        breakpoints: FlyBreakpointToken.defaultBreakpoint(),
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
        color: flyTheme.colors['background'] ?? Colors.white,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(flyTheme.spacing['lg'] ?? 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(flyTheme.spacing['md'] ?? 8.0),
                  decoration: BoxDecoration(
                    color: flyTheme.colors['primary'] ?? Colors.blue,
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
                
                SizedBox(height: flyTheme.spacing['lg'] ?? 16.0),
                
                // Description
                Text(
                  'Framework-agnostic theming with runtime updates',
                  style: TextStyle(
                    fontSize: 16,
                    color: flyTheme.colors['textSecondary'] ?? Colors.grey[600],
                  ),
                ),
                
                SizedBox(height: flyTheme.spacing['lg'] ?? 16.0),
                
                // Theme mode toggle buttons
                Text(
                  'Theme Mode:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: flyTheme.colors['text'] ?? Colors.black,
                  ),
                ),
                SizedBox(height: flyTheme.spacing['sm'] ?? 4.0),
                Row(
                  children: [
                    _buildThemeModeButton('Light', ThemeMode.light, flyTheme),
                    SizedBox(width: flyTheme.spacing['sm'] ?? 4.0),
                    _buildThemeModeButton('Dark', ThemeMode.dark, flyTheme),
                    SizedBox(width: flyTheme.spacing['sm'] ?? 4.0),
                    _buildThemeModeButton('System', ThemeMode.system, flyTheme),
                  ],
                ),
                
                SizedBox(height: (flyTheme.spacing['xl'] ?? flyTheme.spacing['lg'] ?? 16.0).toDouble()),
                
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
                      horizontal: flyTheme.spacing['lg'] ?? 16.0,
                      vertical: flyTheme.spacing['md'] ?? 8.0,
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
                
                SizedBox(height: flyTheme.spacing['lg'] ?? 16.0),
                
                // Spacing increment button
                GestureDetector(
                  onTap: () {
                    final currentSm = flyTheme.spacing['sm'] ?? 4.0;
                    FlyTheme.putSpacing(context, 'sm', currentSm + 1);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: flyTheme.spacing['lg'] ?? 16.0,
                      vertical: flyTheme.spacing['md'] ?? 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: flyTheme.colors['secondary'] ?? Colors.grey,
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
                
                SizedBox(height: (flyTheme.spacing['xl'] ?? flyTheme.spacing['lg'] ?? 16.0).toDouble()),
                
                // Current values display
                Container(
                  padding: EdgeInsets.all(flyTheme.spacing['md'] ?? 8.0),
                  decoration: BoxDecoration(
                    color: flyTheme.colors['surface'] ?? Colors.white,
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
                      SizedBox(height: flyTheme.spacing['sm'] ?? 4.0),
                      Text(
                        'Primary Color: ${flyTheme.colors['primary'] ?? Colors.blue}',
                        style: TextStyle(
                          color: flyTheme.colors['text'] ?? Colors.black,
                        ),
                      ),
                      Text(
                        'sm spacing: ${flyTheme.spacing['sm'] ?? 4.0}',
                        style: TextStyle(
                          color: flyTheme.colors['text'] ?? Colors.black,
                        ),
                      ),
                      Text(
                        'md spacing: ${flyTheme.spacing['md'] ?? 8.0}',
                        style: TextStyle(
                          color: flyTheme.colors['text'] ?? Colors.black,
                        ),
                      ),
                      Text(
                        'lg spacing: ${flyTheme.spacing['lg'] ?? 16.0}',
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
          horizontal: flyTheme.spacing['md'] ?? 8.0,
          vertical: flyTheme.spacing['sm'] ?? 4.0,
        ),
        decoration: BoxDecoration(
          color: flyTheme.colors['secondary'] ?? Colors.grey,
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
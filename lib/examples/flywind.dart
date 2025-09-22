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
      themeData: FlyThemeData.withDefaults(),
      darkThemeData: FlyThemeData.withDefaults(
        colors: CustomColors.defaultColors()
          .put('primary', const Color(0xFF10B981)) // Green for dark mode
          .put('surface', const Color(0xFF1F2937)) // Dark surface
          .put('background', const Color(0xFF111827)), // Dark background
      ),
      appBuilder: (context) {
        return FlywindApp(
          themeMode: _themeMode,
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
class FlywindApp extends StatefulWidget {
  const FlywindApp({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  final ThemeMode themeMode;
  final void Function(ThemeMode) onThemeModeChanged;

  @override
  State<FlywindApp> createState() => _FlywindAppState();
}

class _FlywindAppState extends State<FlywindApp> {
  bool _isGreen = false;

  String _getThemeModeText(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }

  @override
  Widget build(BuildContext context) {
    final flyTheme = FlyTheme.of(context);
    
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: flyTheme.colors.gray100,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(flyTheme.spacing['lg'] ?? 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description
                Text(
                  'Hello World',
                  style: TextStyle(
                    fontSize: 16,
                    color: flyTheme.colors['textSecondary'] ?? Colors.grey[600],
                  ),
                ),
                SizedBox(height: flyTheme.spacing['sm'] ?? 8.0),
                // Theme mode display
                Text(
                  'Theme Mode: ${_getThemeModeText(widget.themeMode)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: flyTheme.colors['textSecondary'] ?? Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
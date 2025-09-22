import 'package:flutter/material.dart';
import 'package:flywind/flywind.dart';
import 'flywind/config/config.dart';

class FlywindExample extends StatefulWidget {
  const FlywindExample({super.key});

  @override
  State<FlywindExample> createState() => _FlywindExampleState();
}

class _FlywindExampleState extends State<FlywindExample> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return Flywind(
      themeMode: _themeMode,
      themeData: FlyThemeData.withDefaults(),
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
    final colors = flyTheme.colors;
    final spacing = flyTheme.spacing;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: colors.white,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(flyTheme.spacing['lg'] ?? 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlyText(
                  'Theme Mode: ${_getThemeModeText(widget.themeMode)}',
                ).m(spacing.base).color(colors.blue600),

                // Container with text
                FlyContainer(
                  child: FlyText('Text In Box').color(colors.white),
                ).p(20).m(20).bg(colors.gray600).rounded(8),

                // Color toggle button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isGreen = !_isGreen;
                    });

                    final newColor = _isGreen
                        ? colors.green600
                        : colors.indigo600;
                    FlyTheme.putColor(context, 'primary', newColor);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: flyTheme.spacing.s4,
                      vertical: flyTheme.spacing.s4,
                    ),
                    decoration: BoxDecoration(
                      color: _isGreen ? colors.green600 : colors.indigo600,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      _isGreen ? 'Change to Indigo' : 'Change to Green',
                      style: const TextStyle(
                        color: Colors.white, // TODO: use color token
                        fontWeight:
                            FontWeight.w600, // TODO: use font weight token
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

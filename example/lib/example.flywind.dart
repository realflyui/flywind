import 'package:flutter/material.dart';
import 'package:flywind/flywind.dart';

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
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Simple FlyText with mixed value types
                FlyText('Flywind Examples')
                  .color(colors.blue500)      // Direct token access: colors.blue500
                  .m(spacing.s3),             // Direct token access: spacing.s3

                const SizedBox(height: 24),

                // FlyContainer with FlyText - showcasing all value types
                FlyContainer(
                  child: FlyText('Mixed Value Types')
                    .color(Colors.white)      // Color object
                    .p('12px'),               // CSS unit
                )
                  .bg('#FF6B35')             // Hex color
                  .p(20)                     // int
                  .px('1.5rem')              // CSS unit (rem)
                  .py(8)                     // int
                  .rounded('md')             // Token name
                  .roundedTl('lg')           // Token name
                  .m(spacing['s3'] ?? 16),   // Bracket access: spacing['s3']

                const SizedBox(height: 24),

                // Border Examples Section
                FlyText('Border Examples')
                  .color(colors.gray700)
                  .m(spacing.s3),

                const SizedBox(height: 16),

                // Solid Border
                FlyContainer(
                  child: FlyText('Solid Border')
                    .color(Colors.white)
                    .p(12),
                )
                  .bg(colors.blue500)
                  .border(10)
                  .borderColor(colors.blue700)
                  .borderStyle('solid')
                  .rounded(20)
                  .p(16)
                  .mb(spacing.s2),
                  

                // Dashed Border
                FlyContainer(
                  child: FlyText('Dashed Border')
                    .color(colors.green700)
                    .p(12),
                )
                  .bg(colors.green50)
                  .border(2)
                  .borderColor(colors.green500)
                  .borderStyle('dashed')
                  .rounded(8)
                  .p(16)
                  .mb(spacing.s2),

                // Dotted Border
                FlyContainer(
                  child: FlyText('Dotted Border')
                    .color(colors.orange700)
                    .p(12),
                )
                  .bg(colors.orange50)
                  .border(2)
                  .borderColor(colors.orange500)
                  .borderStyle('dotted')
                  .rounded(8)
                  .p(16)
                  .mb(spacing.s2),

                // Double Border
                FlyContainer(
                  child: FlyText('Custom Borders')
                    .color(colors.purple700)
                    .p(12),
                )
                  .bg(colors.purple50)
                  .borderT(10)
                  .borderR(5)
                  .borderB(10)
                  .borderColor(colors.purple500)
                  .p(16)
                  .mb(spacing.s2),

                // Complex Border Example
                FlyContainer(
                  child: FlyText('Complex Border with Rounded Corners')
                    .color(colors.red700)
                    .p(12),
                )
                  .bg(colors.red50)
                  .border(3)
                  .borderColor(colors.red500)
                  .borderStyle('dashed')
                  .rounded('xl')
                  .p(20)
                  .mb(spacing.s4),

                const SizedBox(height: 24),

                // Interactive button with theme switching
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

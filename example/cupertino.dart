import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flywind/flywind.dart';
import 'package:flywind/config/config.dart';

class FlywindExample extends StatefulWidget {
  const FlywindExample({super.key});

  @override
  State<FlywindExample> createState() => _FlywindExampleState();
}

class _FlywindExampleState extends State<FlywindExample> {
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
    return Flywind(
      themeMode: _themeMode,
      themeData: FlyThemeData.withDefaults(
        spacing: CustomSpacing.defaultSpacing(),
        colors: CustomColors.defaultColors(),
        radius: CustomRadius.defaultRadius(),
        breakpoints: CustomBreakpoint.defaultBreakpoint(),
        container: CustomContainer.defaultContainer(),
        text: CustomText.defaultText(),
        textLineHeight: CustomTextLineHeight.defaultTextLineHeight(),
        fontWeight: CustomFontWeight.defaultFontWeight(),
        tracking: CustomTracking.defaultTracking(),
        blur: CustomBlur.defaultBlur(),
        perspective: CustomPerspective.defaultPerspective(),
        leading: CustomLeading.defaultLeading(),
      ),
      darkThemeData: FlyThemeData.withDefaults(
        spacing: CustomSpacing.defaultSpacing(),
        colors: CustomColors.defaultColors()
            .put('primary', const Color(0xFF10B981)) // Green for dark mode
            .put('surface', const Color(0xFF1F2937)), // Dark surface
        radius: CustomRadius.defaultRadius(),
        breakpoints: CustomBreakpoint.defaultBreakpoint(),
        container: CustomContainer.defaultContainer(),
        text: CustomText.defaultText(),
        textLineHeight: CustomTextLineHeight.defaultTextLineHeight(),
        fontWeight: CustomFontWeight.defaultFontWeight(),
        tracking: CustomTracking.defaultTracking(),
        blur: CustomBlur.defaultBlur(),
        perspective: CustomPerspective.defaultPerspective(),
        leading: CustomLeading.defaultLeading(),
      ),
      appBuilder: (context) {
        final flyTheme = FlyTheme.of(context);

        return CupertinoApp(
          title: 'Fly App',
          theme: CupertinoThemeData(
            primaryColor: flyTheme.colors['primary'] ?? Colors.blue,
            brightness: _getCurrentBrightness(),
          ),
          home: FlywindApp(
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

class FlywindApp extends StatefulWidget {
  const FlywindApp({super.key, required this.onThemeModeChanged});

  final void Function(ThemeMode) onThemeModeChanged;

  @override
  State<FlywindApp> createState() => _FlywindAppState();
}

class _FlywindAppState extends State<FlywindApp> {
  bool _isGreen = false;

  @override
  Widget build(BuildContext context) {
    final flyTheme = FlyTheme.of(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Fly App'),
        backgroundColor: flyTheme.colors['primary'] ?? Colors.blue,
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(flyTheme.spacing['md'] ?? 8.0),
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
              SizedBox(height: flyTheme.spacing['md'] ?? 8.0),
              Text(
                'Your Fly theming library is ready to use.',
                style: TextStyle(
                  color:
                      flyTheme.colors['textSecondary'] ??
                      CupertinoColors.systemGrey,
                ),
              ),
              SizedBox(height: flyTheme.spacing['lg'] ?? 16.0),

              // Theme mode toggle
              Row(
                children: [
                  CupertinoButton.filled(
                    onPressed: () => widget.onThemeModeChanged(ThemeMode.light),
                    child: const Text('Light'),
                  ),
                  SizedBox(width: flyTheme.spacing['sm'] ?? 4.0),
                  CupertinoButton.filled(
                    onPressed: () => widget.onThemeModeChanged(ThemeMode.dark),
                    child: const Text('Dark'),
                  ),
                  SizedBox(width: flyTheme.spacing['sm'] ?? 4.0),
                  CupertinoButton.filled(
                    onPressed: () =>
                        widget.onThemeModeChanged(ThemeMode.system),
                    child: const Text('System'),
                  ),
                ],
              ),

              SizedBox(height: flyTheme.spacing['lg'] ?? 16.0),

              // Toggle primary color button
              Container(
                decoration: BoxDecoration(
                  color: _isGreen
                      ? CupertinoColors.systemGreen
                      : const Color(0xFF6366F1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CupertinoButton(
                  onPressed: () {
                    setState(() {
                      _isGreen = !_isGreen;
                    });

                    final newColor = _isGreen
                        ? CupertinoColors.systemGreen
                        : const Color(0xFF6366F1);
                    FlyTheme.putColor(context, 'primary', newColor);
                  },
                  child: Text(
                    _isGreen ? 'Change to Indigo' : 'Change to Green',
                    style: const TextStyle(color: CupertinoColors.white),
                  ),
                ),
              ),

              SizedBox(height: flyTheme.spacing['lg'] ?? 16.0),

              // Current spacing values display
              Container(
                padding: EdgeInsets.all(flyTheme.spacing['sm'] ?? 4.0),
                decoration: BoxDecoration(
                  color: flyTheme.colors['surface'] ?? Colors.white,
                  border: Border.all(
                    color:
                        flyTheme.colors['border'] ?? CupertinoColors.systemGrey,
                  ),
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
                    SizedBox(height: flyTheme.spacing['sm'] ?? 4.0),
                    Text('sm spacing: ${flyTheme.spacing['sm'] ?? 4.0}'),
                    Text('md spacing: ${flyTheme.spacing['md'] ?? 8.0}'),
                    Text('lg spacing: ${flyTheme.spacing['lg'] ?? 16.0}'),
                  ],
                ),
              ),

              SizedBox(height: flyTheme.spacing['md'] ?? 8.0),

              // Update spacing button
              CupertinoButton.filled(
                onPressed: () {
                  final currentSm = flyTheme.spacing['sm'] ?? 4.0;
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

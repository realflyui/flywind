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

        return MaterialApp(
          title: 'Fly App',
          themeMode: _themeMode,
          theme: ThemeData(
            extensions: [flyTheme],
            colorScheme: ColorScheme.fromSeed(
              seedColor: flyTheme.colors['primary'] ?? Colors.blue,
              brightness: Brightness.light,
            ),
          ),
          darkTheme: ThemeData(
            extensions: [flyTheme],
            colorScheme: ColorScheme.fromSeed(
              seedColor: flyTheme.colors['primary'] ?? Colors.blue,
              brightness: Brightness.dark,
            ),
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fly App'),
        backgroundColor: flyTheme.colors['primary'] ?? Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(flyTheme.spacing['md'] ?? 8.0),
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
            SizedBox(height: flyTheme.spacing['md'] ?? 8.0),
            Text(
              'Your Fly theming library is ready to use.',
              style: TextStyle(
                color: flyTheme.colors['textSecondary'] ?? Colors.grey,
              ),
            ),
            SizedBox(height: flyTheme.spacing['lg'] ?? 16.0),

            // Theme mode toggle
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => widget.onThemeModeChanged(ThemeMode.light),
                  child: const Text('Light'),
                ),
                SizedBox(width: flyTheme.spacing['sm'] ?? 4.0),
                ElevatedButton(
                  onPressed: () => widget.onThemeModeChanged(ThemeMode.dark),
                  child: const Text('Dark'),
                ),
                SizedBox(width: flyTheme.spacing['sm'] ?? 4.0),
                ElevatedButton(
                  onPressed: () => widget.onThemeModeChanged(ThemeMode.system),
                  child: const Text('System'),
                ),
              ],
            ),

            SizedBox(height: flyTheme.spacing['lg'] ?? 16.0),

            // Toggle primary color button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isGreen = !_isGreen;
                });

                final newColor = _isGreen
                    ? Colors.green
                    : const Color(0xFF6366F1);
                FlyTheme.putColor(context, 'primary', newColor);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _isGreen
                    ? Colors.green
                    : const Color(0xFF6366F1),
                foregroundColor: Colors.white,
              ),
              child: Text(_isGreen ? 'Change to Indigo' : 'Change to Green'),
            ),

            SizedBox(height: flyTheme.spacing['lg'] ?? 16.0),

            // Current spacing values display
            Container(
              padding: EdgeInsets.all(flyTheme.spacing['sm'] ?? 4.0),
              decoration: BoxDecoration(
                color: flyTheme.colors['surface'] ?? Colors.white,
                border: Border.all(
                  color: flyTheme.colors['border'] ?? Colors.grey,
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
                      color: flyTheme.colors['text'] ?? Colors.black,
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
            ElevatedButton(
              onPressed: () {
                final currentSm = flyTheme.spacing['sm'] ?? 4.0;
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

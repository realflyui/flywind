import 'package:flutter/material.dart';
import 'notifier.dart';
import 'theme.dart';

/// Main app widget that provides Fly theming
class Flywind extends StatelessWidget {
  const Flywind({
    super.key,
    this.themeMode = ThemeMode.system,
    this.themeData,
    this.darkThemeData,
    required this.appBuilder,
  });

  final ThemeMode themeMode;
  final FlyThemeData? themeData;
  final FlyThemeData? darkThemeData;
  final Widget Function(BuildContext context) appBuilder;

  @override
  Widget build(BuildContext context) {
    return _FlyProvider(
      themeMode: themeMode,
      lightTheme: themeData ?? FlyThemeData.fallback(),
      darkTheme: darkThemeData ?? themeData ?? FlyThemeData.fallback(),
      child: appBuilder,
    );
  }
}

/// Internal theme provider that handles light/dark mode switching
class _FlyProvider extends StatefulWidget {
  const _FlyProvider({
    required this.themeMode,
    required this.lightTheme,
    required this.darkTheme,
    required this.child,
  });

  final ThemeMode themeMode;
  final FlyThemeData lightTheme;
  final FlyThemeData darkTheme;
  final Widget Function(BuildContext context) child;

  @override
  State<_FlyProvider> createState() => _FlyProviderState();
}

class _FlyProviderState extends State<_FlyProvider> with WidgetsBindingObserver {
  late FlyNotifier _notifier;
  Brightness? _lastBrightness;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _notifier = _createController();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _notifier.dispose();
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    _updateThemeForBrightness();
  }

  @override
  void didUpdateWidget(_FlyProvider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.themeMode != widget.themeMode ||
        oldWidget.lightTheme != widget.lightTheme ||
        oldWidget.darkTheme != widget.darkTheme) {
      _updateThemeForBrightness();
    }
  }

  void _updateThemeForBrightness() {
    final brightness = _getCurrentBrightness();
    if (brightness != _lastBrightness) {
      _lastBrightness = brightness;
      final themeData = brightness == Brightness.dark 
          ? widget.darkTheme 
          : widget.lightTheme;
      
      // Debug information in debug mode
      assert(() {
        debugPrint('FlyTheme: Switching to ${brightness.name} theme');
        return true;
      }());
      
      _notifier.set(themeData);
    }
  }

  Brightness _getCurrentBrightness() {
    switch (widget.themeMode) {
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.system:
        return WidgetsBinding.instance.platformDispatcher.platformBrightness;
    }
  }

  FlyNotifier _createController() {
    final brightness = _getCurrentBrightness();
    _lastBrightness = brightness;
    final initialData = brightness == Brightness.dark 
        ? widget.darkTheme 
        : widget.lightTheme;
    
    return FlyNotifier(initialData: initialData);
  }

  @override
  Widget build(BuildContext context) {
    return FlyTheme(
      notifier: _notifier,
      child: widget.child(context),
    );
  }
}
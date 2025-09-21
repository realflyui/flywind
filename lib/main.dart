import 'package:flutter/material.dart';
import 'theme.dart';
import 'text.dart';
import 'container.dart';
import 'config.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flywind Demo',
      theme: ThemeData(
        // Standard Material theme
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        
        // Your custom Flywind theme
        extensions: [
          // FlyTheme.defaultTheme,
          FlyConfig.createTheme(),
        ],
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access Flywind theme via the new simplified system
    final flywind = context.flywind; // Using our new extension!
    final spacing = flywind.spacing;
    final colors = flywind.colors;
    final borderRadius = flywind.borderRadius;
    
    // Example usage - you can now use these values with type safety!
    print('Spacing 2 value: ${spacing.s2}'); // This will print 8.0 (default)
    print('Spacing 2 value (bracket): ${spacing[2]}'); // This will also print 8.0
    
    // Standard colors using dot notation (type-safe!)
    print('Blue600: ${colors.blue600}'); // This will print the blue color
    print('Gray800: ${colors.gray800}'); // This will print the gray color
    
    
    // Bracket notation still works
    print('Blue 600 color (bracket): ${colors['blue600']}'); // This will also print the blue color
    
    return Scaffold(
      body: SizedBox.expand(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Test the custom "leif" color
            FlyText('Custom "leif" Color Test:').color('gray800').pb('12'),
            
            // Background color examples
            FlyContainer(
              child: FlyText('Container with leif background').color('white'),
            ).bg('leif').p('12').pb('8'),
            
            FlyContainer(
              child: FlyText('Rounded container with leif background').color('white'),
            ).bg('leif').p('12').rounded('lg').pb('8'),
            
            // Text color examples
            FlyText('This text uses leif color').color('leif').pb('8'),
            FlyText('Large leif text').color('leif').pb('8'),
            
            // Mixed examples
            FlyContainer(
              child: FlyText('White text on leif background with padding').color('white'),
            ).bg('leif').p('16').rounded('xl').pb('8'),
            
            FlyContainer(
              child: FlyText('Leif text on white background').color('leif'),
            ).bg('white').p('12').rounded('md').pb('8'),
            
            // Show the actual color value
            FlyText('The "leif" color value: ${colors['leif']}').color('gray600').pb('8'),
            
            // Clean dot notation with full autocomplete!
            FlyText('Clean dot notation with autocomplete:').color('gray800').pb('8'),
            FlyText('colors.leif = ${colors.leif}').color('gray600').pb('4'),
            FlyText('colors.brand = ${colors.brand}').color('gray600').pb('4'),
            FlyText('colors.accent = ${colors.accent}').color('gray600').pb('4'),
            FlyText('spacing.leif = ${spacing.leif}').color('gray600').pb('4'),
            FlyText('spacing.brand = ${spacing.brand}').color('gray600').pb('12'),
            
            // Uniform padding
            FlyText('Uniform padding p(3)').p('10'),
            
            // Horizontal and vertical padding
            FlyText('Horizontal padding px(4)').px('4'),
            FlyText('Vertical padding py(2)').py('2'),
            FlyText('Both px and py').px('3').py('2'),
            
            // Individual directional padding
            FlyText('Left padding pl(5)').pl('5'),
            FlyText('Right padding pr(3)').pr('3'),
            FlyText('Top padding pt(2)').pt('2'),
            FlyText('Bottom padding pb(4)').pb('4'),
            
            // Mixed combinations
            FlyText('Mixed: p(1) + px(4)').p('1').px('4'),
            FlyText('Mixed: pl(2) + py(3)').pl('2').py('3'),
            FlyText('Mixed: pt(1) + pr(3) + pb(2)').pt('1').pr('3').pb('2'),
            
            // Complex combinations
            FlyText('Complex: p(2) + pl(5) + pt(1)').p('2').pl('5').pt('1'),
            
            // Color examples (separate section) - using pb for spacing
            FlyText('Blue text').color('blue600').mb('20'),
            FlyText('Red text').color('red600').pb('20'),
            FlyText('Green text').color('green600').pb('20'),
            
            // Container examples - using pb for spacing
            FlyText('Container Examples:').color('gray800').pb('12'),
            
            // Basic containers with background colors
            FlyContainer(
              child: FlyText('Basic container with blue background').color('white'),
            ).bg('blue600').pb('16'),
            
            FlyContainer(
              child: FlyText('Container with green background').color('white'),
            ).bg('green600').pb('8'),
            
            // Containers with padding
            FlyContainer(
              child: FlyText('Container with padding p(3)').color('white'),
            ).bg('red600').p('40').pb('8').m('16'),
            
            FlyContainer(
              child: FlyText('Container with horizontal padding px(4)').color('white'),
            ).bg('purple600').px('16').pb('8'),
            
            // Containers with mixed padding
            FlyContainer(
              child: FlyText('Container with mixed padding').color('white'),
            ).bg('orange600').p('8').px('24').pb('8'),
            
            // Complex container example
            FlyContainer(
              child: FlyText('Complex: p(3) + px(2) + bg(teal600)').color('white'),
            ).p('12').px('8').bg('teal600').pb('8'),
            
            // Test with white color (now available)
            FlyContainer(
              child: FlyText('White background with black text').color('black'),
            ).bg('white').p('8').pb('8'),
            
            // Margin examples - using pb for spacing
            FlyText('Margin Examples:').color('gray800').pb('12'),
            
            // Basic margin
            FlyContainer(
              child: FlyText('Container with margin m(2)').color('white'),
            ).bg('blue600').p('8').m('8'),
            
            // Horizontal margin
            FlyContainer(
              child: FlyText('Container with horizontal margin mx(3)').color('white'),
            ).bg('green600').p('8').mx('12'),
            
            // Vertical margin
            FlyContainer(
              child: FlyText('Container with vertical margin my(1)').color('white'),
            ).bg('red600').p('8').my('4'),
            
            // Individual margins
            FlyContainer(
              child: FlyText('Container with left margin ml(4)').color('white'),
            ).bg('purple600').p('8').ml('16'),
            
            // Complex margin + padding + background
            FlyContainer(
              child: FlyText('Complex: m(1) + p(3) + bg(orange600)').color('white'),
            ).m('4').p('12').bg('orange600').pb('8'),
            
            // Border Radius Examples - using pb for spacing
            FlyText('Border Radius Examples:').color('gray800').pb('12'),
            
            // Uniform border radius
            FlyContainer(
              child: FlyText('rounded("sm") - 2px all corners').color('white'),
            ).bg('blue600').p('8').rounded('sm').pb('8'),
            
            FlyContainer(
              child: FlyText('rounded("") - 4px all corners (default)').color('white'),
            ).bg('green600').p('8').rounded('').pb('8'),
            
            FlyContainer(
              child: FlyText('rounded("lg") - 8px all corners').color('white'),
            ).bg('red600').p('8').rounded('lg').pb('8'),
            
            FlyContainer(
              child: FlyText('rounded("xl") - 12px all corners').color('white'),
            ).bg('purple600').p('8').rounded('xl').pb('8'),
            
            FlyContainer(
              child: FlyText('rounded("2xl") - 16px all corners').color('white'),
            ).bg('orange600').p('8').rounded('2xl').pb('8'),
            
            FlyContainer(
              child: FlyText('rounded("full") - 9999px (circular)').color('white'),
            ).bg('teal600').p('8').rounded('full').pb('8'),
            
            // Directional border radius
            FlyText('Directional Border Radius:').color('gray800').pb('8'),
            
            FlyContainer(
              child: FlyText('roundedT("lg") - 8px top corners').color('white'),
            ).bg('blue600').p('8').roundedT('lg').pb('8'),
            
            FlyContainer(
              child: FlyText('roundedR("xl") - 12px right corners').color('white'),
            ).bg('green600').p('8').roundedR('xl').pb('8'),
            
            FlyContainer(
              child: FlyText('roundedB("md") - 6px bottom corners').color('white'),
            ).bg('red600').p('8').roundedB('md').pb('8'),
            
            FlyContainer(
              child: FlyText('roundedL("2xl") - 16px left corners').color('white'),
            ).bg('purple600').p('8').roundedL('2xl').pb('8'),
            
            // Individual corner border radius
            FlyText('Individual Corner Border Radius:').color('gray800').pb('8'),
            
            FlyContainer(
              child: FlyText('roundedTl("xl") - 12px top-left').color('white'),
            ).bg('blue600').p('8').roundedTl('xl').pb('8'),
            
            FlyContainer(
              child: FlyText('roundedTr("lg") - 8px top-right').color('white'),
            ).bg('green600').p('8').roundedTr('lg').pb('8'),
            
            FlyContainer(
              child: FlyText('roundedBl("md") - 6px bottom-left').color('white'),
            ).bg('red600').p('8').roundedBl('md').pb('8'),
            
            FlyContainer(
              child: FlyText('roundedBr("2xl") - 16px bottom-right').color('white'),
            ).bg('purple600').p('8').roundedBr('2xl').pb('8'),
            
            // Complex combinations
            FlyText('Complex Combinations:').color('gray800').pb('8'),
            
            FlyContainer(
              child: FlyText('rounded("sm") + roundedT("lg")').color('white'),
            ).bg('blue600').p('8').rounded('sm').roundedT('lg').pb('8'),
            
            FlyContainer(
              child: FlyText('roundedTl("xl") + roundedBr("2xl")').color('white'),
            ).bg('green600').p('8').roundedTl('xl').roundedBr('2xl').pb('8'),
            
            // Full example with padding, margin, color, and border radius
            FlyContainer(
              child: FlyText('Complete: p(3) + m(2) + bg(red600) + rounded("lg")').color('white'),
            ).p('12').m('8').bg('red600').rounded('lg').pb('8'),
            
            // Test error handling (uncomment to see error message)
            // FlyText('This will show an error').color('nonexistent'),
            
            // TwApp Custom Theme Demo
            FlyText('TwApp Custom Theme Demo:').color('gray800').pb('12'),
            
            // Show current theme values
            FlyText('Current Spacing Values:').color('gray800').pb('8'),
            FlyText('s0: ${spacing.s0}, s1: ${spacing.s1}, s2: ${spacing.s2}, s3: ${spacing.s3}').color('blue600').pb('4'),
            FlyText('s4: ${spacing.s4}, s5: ${spacing.s5}, s6: ${spacing.s6}, s7: ${spacing.s7}').color('blue600').pb('4'),
            FlyText('s8: ${spacing.s8}, s9: ${spacing.s9}, s10: ${spacing.s10}, s11: ${spacing.s11}, s12: ${spacing.s12}').color('blue600').pb('8'),
            
            // Show current color values
            FlyText('Current Color Values:').color('gray800').pb('8'),
            FlyContainer(
              child: FlyText('Blue 600: ${colors.blue600}').color('white'),
            ).bg('blue600').p('8').pb('4'),
            FlyContainer(
              child: FlyText('Red 600: ${colors.red600}').color('white'),
            ).bg('red600').p('8').pb('4'),
            FlyContainer(
              child: FlyText('Green 600: ${colors.green600}').color('white'),
            ).bg('green600').p('8').pb('8'),
            
            
            // Show border radius values
            FlyText('Current Border Radius Values:').color('gray800').pb('8'),
            FlyText('sm: ${borderRadius.sm}, md: ${borderRadius.md}, lg: ${borderRadius.lg}, xl: ${borderRadius.xl}').color('gray600').pb('8'),
            
            // Material button using Flywind theme
            FlyText('Material Button with Flywind Theme:').color('gray800').pb('8'),
            Padding(
              padding: EdgeInsets.only(bottom: spacing.s2),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.leif,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.all(spacing.s4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius.lg),
                  ),
                ),
                onPressed: () {},
                child: Text('Flywind Button'),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}


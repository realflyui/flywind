import 'package:flutter/material.dart';
import 'tw_config.dart';
import 'tw_text.dart';
import 'tw_container.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TwConfig(
        spacing: defaultSpacing,
        colors: defaultColors,
        borderRadius: defaultBorderRadius,
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Uniform padding
            TwText('Uniform padding p(3)').p(3),
            
            // Horizontal and vertical padding
            TwText('Horizontal padding px(4)').px(4),
            TwText('Vertical padding py(2)').py(2),
            TwText('Both px and py').px(3).py(2),
            
            // Individual directional padding
            TwText('Left padding pl(5)').pl(5),
            TwText('Right padding pr(3)').pr(3),
            TwText('Top padding pt(2)').pt(2),
            TwText('Bottom padding pb(4)').pb(4),
            
            // Mixed combinations
            TwText('Mixed: p(1) + px(4)').p(1).px(4),
            TwText('Mixed: pl(2) + py(3)').pl(2).py(3),
            TwText('Mixed: pt(1) + pr(3) + pb(2)').pt(1).pr(3).pb(2),
            
            // Complex combinations
            TwText('Complex: p(2) + pl(5) + pt(1)').p(2).pl(5).pt(1),
            
            // Color examples (separate section) - using pb for spacing
            TwText('Blue text').color('blue600').pb(5),
            TwText('Red text').color('red600').pb(5),
            TwText('Green text').color('green600').pb(5),
            
            // Container examples - using pb for spacing
            TwText('Container Examples:').color('gray800').pb(3),
            
            // Basic containers with background colors
            TwContainer(
              child: TwText('Basic container with blue background').color('white'),
            ).bg('blue600').pb(4),
            
            TwContainer(
              child: TwText('Container with green background').color('white'),
            ).bg('green600').pb(2),
            
            // Containers with padding
            TwContainer(
              child: TwText('Container with padding p(3)').color('white'),
            ).bg('red600').p(3).pb(2),
            
            TwContainer(
              child: TwText('Container with horizontal padding px(4)').color('white'),
            ).bg('purple600').px(4).pb(2),
            
            // Containers with mixed padding
            TwContainer(
              child: TwText('Container with mixed padding').color('white'),
            ).bg('orange600').p(2).px(6).pb(2),
            
            // Complex container example
            TwContainer(
              child: TwText('Complex: p(3) + px(2) + bg(teal600)').color('white'),
            ).p(3).px(2).bg('teal600').pb(2),
            
            // Test with white color (now available)
            TwContainer(
              child: TwText('White background with black text').color('black'),
            ).bg('white').p(2).pb(2),
            
            // Margin examples - using pb for spacing
            TwText('Margin Examples:').color('gray800').pb(3),
            
            // Basic margin
            TwContainer(
              child: TwText('Container with margin m(2)').color('white'),
            ).bg('blue600').p(2).m(2),
            
            // Horizontal margin
            TwContainer(
              child: TwText('Container with horizontal margin mx(3)').color('white'),
            ).bg('green600').p(2).mx(3),
            
            // Vertical margin
            TwContainer(
              child: TwText('Container with vertical margin my(1)').color('white'),
            ).bg('red600').p(2).my(1),
            
            // Individual margins
            TwContainer(
              child: TwText('Container with left margin ml(4)').color('white'),
            ).bg('purple600').p(2).ml(4),
            
            // Complex margin + padding + background
            TwContainer(
              child: TwText('Complex: m(1) + p(3) + bg(orange600)').color('white'),
            ).m(1).p(3).bg('orange600').pb(2),
            
            // Border Radius Examples - using pb for spacing
            TwText('Border Radius Examples:').color('gray800').pb(3),
            
            // Uniform border radius
            TwContainer(
              child: TwText('rounded("sm") - 2px all corners').color('white'),
            ).bg('blue600').p(2).rounded('sm').pb(2),
            
            TwContainer(
              child: TwText('rounded("") - 4px all corners (default)').color('white'),
            ).bg('green600').p(2).rounded('').pb(2),
            
            TwContainer(
              child: TwText('rounded("lg") - 8px all corners').color('white'),
            ).bg('red600').p(2).rounded('lg').pb(2),
            
            TwContainer(
              child: TwText('rounded("xl") - 12px all corners').color('white'),
            ).bg('purple600').p(2).rounded('xl').pb(2),
            
            TwContainer(
              child: TwText('rounded("2xl") - 16px all corners').color('white'),
            ).bg('orange600').p(2).rounded('2xl').pb(2),
            
            TwContainer(
              child: TwText('rounded("full") - 9999px (circular)').color('white'),
            ).bg('teal600').p(2).rounded('full').pb(2),
            
            // Directional border radius
            TwText('Directional Border Radius:').color('gray800').pb(2),
            
            TwContainer(
              child: TwText('roundedT("lg") - 8px top corners').color('white'),
            ).bg('blue600').p(2).roundedT('lg').pb(2),
            
            TwContainer(
              child: TwText('roundedR("xl") - 12px right corners').color('white'),
            ).bg('green600').p(2).roundedR('xl').pb(2),
            
            TwContainer(
              child: TwText('roundedB("md") - 6px bottom corners').color('white'),
            ).bg('red600').p(2).roundedB('md').pb(2),
            
            TwContainer(
              child: TwText('roundedL("2xl") - 16px left corners').color('white'),
            ).bg('purple600').p(2).roundedL('2xl').pb(2),
            
            // Individual corner border radius
            TwText('Individual Corner Border Radius:').color('gray800').pb(2),
            
            TwContainer(
              child: TwText('roundedTl("xl") - 12px top-left').color('white'),
            ).bg('blue600').p(2).roundedTl('xl').pb(2),
            
            TwContainer(
              child: TwText('roundedTr("lg") - 8px top-right').color('white'),
            ).bg('green600').p(2).roundedTr('lg').pb(2),
            
            TwContainer(
              child: TwText('roundedBl("md") - 6px bottom-left').color('white'),
            ).bg('red600').p(2).roundedBl('md').pb(2),
            
            TwContainer(
              child: TwText('roundedBr("2xl") - 16px bottom-right').color('white'),
            ).bg('purple600').p(2).roundedBr('2xl').pb(2),
            
            // Complex combinations
            TwText('Complex Combinations:').color('gray800').pb(2),
            
            TwContainer(
              child: TwText('rounded("sm") + roundedT("lg")').color('white'),
            ).bg('blue600').p(2).rounded('sm').roundedT('lg').pb(2),
            
            TwContainer(
              child: TwText('roundedTl("xl") + roundedBr("2xl")').color('white'),
            ).bg('green600').p(2).roundedTl('xl').roundedBr('2xl').pb(2),
            
            // Full example with padding, margin, color, and border radius
            TwContainer(
              child: TwText('Complete: p(3) + m(2) + bg(red600) + rounded("lg")').color('white'),
            ).p(3).m(2).bg('red600').rounded('lg').pb(2),
            
            // Test error handling (uncomment to see error message)
            // TwText('This will show an error').color('nonexistent'),
          ],
        ),
        ),
      ),
    );
  }
}


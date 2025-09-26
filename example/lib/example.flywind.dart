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
          child: SingleChildScrollView(
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

                // Size Examples Section
                FlyText('Size Examples')
                  .color(colors.gray700)
                  .m(spacing.s3),

                const SizedBox(height: 16),

                // Fixed size with spacing tokens
                FlyContainer(
                  child: FlyText('Fixed Size (s4 x s8)')
                    .color(Colors.white)
                    .p(8),
                )
                  .bg(colors.blue500)
                  .h('s8')    // 16px height
                  .w('s20')    // 32px width
                  .rounded(4)
                  .mb(spacing.s2),

                // Fixed size with pixel values
                FlyContainer(
                  child: FlyText('Fixed Size (100px x 200px)')
                    .color(Colors.white)
                    .p(8),
                )
                  .bg(colors.green500)
                  .h(100)     // 100px height
                  .w(200)     // 200px width
                  .rounded(8)
                  .mb(spacing.s2),

                // Fixed size with CSS units
                FlyContainer(
                  child: FlyText('Fixed Size (50px x 150px)')
                    .color(Colors.white)
                    .p(8),
                )
                  .bg(colors.purple500)
                  .h('50px')  // 50px height
                  .w('150px') // 150px width
                  .rounded(6)
                  .mb(spacing.s2),

                // Height only (width auto)
                FlyContainer(
                  child: FlyText('Height Only (60px)')
                    .color(Colors.white)
                    .p(8),
                )
                  .bg(colors.orange500)
                  .h(60)      // 60px height, width auto
                  .rounded(4)
                  .mb(spacing.s2),

                // Width only (height auto)
                FlyContainer(
                  child: FlyText('Width Only (120px)')
                    .color(Colors.white)
                    .p(8),
                )
                  .bg(colors.red500)
                  .w(120)     // 120px width, height auto
                  .rounded(4)
                  .mb(spacing.s2),

                // Size with borders and padding
                FlyContainer(
                  child: FlyText('Size + Border + Padding')
                    .color(Colors.white)
                    .p(12),
                )
                  .bg(colors.indigo500)
                  .h(80)      // 80px height
                  .w(160)     // 160px width
                  .border(2)
                  .borderColor(colors.indigo700)
                  .borderStyle('solid')
                  .rounded(8)
                  .p(16)
                  .mb(spacing.s4),

                // Max/Min Constraints Examples
                FlyText('Max/Min Constraints')
                  .color(colors.gray700)
                  .m(spacing.s3),

                const SizedBox(height: 16),

                // Max height constraint
                FlyContainer(
                  child: FlyText('Max Height 100px\nThis text might overflow\nand be constrained\nby the max height\nsetting.')
                    .color(Colors.white)
                    .p(8),
                )
                  .bg(colors.orange500)
                  .maxH(100)   // Max height 100px
                  .w(200)      // Fixed width
                  .rounded(4)
                  .mb(spacing.s2),

                // Min height constraint
                FlyContainer(
                  child: FlyText('Min Height 80px')
                    .color(Colors.white)
                    .p(8),
                )
                  .bg(colors.purple500)
                  .minH(80)    // Min height 80px
                  .w(200)      // Fixed width
                  .rounded(4)
                  .mb(spacing.s2),

                // Max width constraint
                FlyContainer(
                  child: FlyText('Max Width 150px - This text will wrap when it exceeds the max width constraint.')
                    .color(Colors.white)
                    .p(8),
                )
                  .bg(colors.teal500)
                  .h(60)       // Fixed height
                  .maxW(150)   // Max width 150px
                  .rounded(4)
                  .mb(spacing.s2),

                // Min width constraint
                FlyContainer(
                  child: FlyText('Min Width 200px')
                    .color(Colors.white)
                    .p(8),
                )
                  .bg(colors.pink500)
                  .h(60)       // Fixed height
                  .minW(200)   // Min width 200px
                  .rounded(4)
                  .mb(spacing.s2),

                // Combined max/min constraints
                FlyContainer(
                  child: FlyText('Max H: 80px, Min W: 120px')
                    .color(Colors.white)
                    .p(8),
                )
                  .bg(colors.cyan500)
                  .maxH(80)    // Max height 80px
                  .minW(120)   // Min width 120px
                  .rounded(4)
                  .mb(spacing.s4),

                const SizedBox(height: 24),

                // Text Style Examples Section
                FlyText('Text Style Examples')
                  .color(colors.gray700)
                  .m(spacing.s3),

                const SizedBox(height: 16),

                // Different text sizes
                FlyText('Extra Small Text (xs)')
                  .text('xs')
                  .color(colors.blue600)
                  .mb(spacing.s2),

                FlyText('Small Text (sm)')
                  .text('sm')
                  .color(colors.green600)
                  .mb(spacing.s2),

                FlyText('Base Text (base)')
                  .text('base')
                  .color(colors.purple600)
                  .mb(spacing.s2),

                FlyText('Large Text (lg)')
                  .text('lg')
                  .color(colors.orange600)
                  .mb(spacing.s2),

                FlyText('Extra Large Text (xl)')
                  .text('xl')
                  .color(colors.red600)
                  .mb(spacing.s2),

                FlyText('2XL Text (xl2)')
                  .text('xl2')
                  .color(colors.indigo600)
                  .mb(spacing.s2),

                FlyText('3XL Text (xl3)')
                  .text('xl3')
                  .color(colors.teal600)
                  .mb(spacing.s2),

                const SizedBox(height: 16),

                // Text with color overrides
                FlyText('Text with Color Override')
                  .text('lg')
                  .color(colors.pink600)  // This overrides the color from the text style token
                  .mb(spacing.s2),

                // Text with multiple properties
                FlyText('Styled Text with Multiple Properties')
                  .text('base')
                  .color(colors.white)
                  .p(12)
                  .bg(colors.blue500)
                  .rounded(8)
                  .mb(spacing.s2),

                // Text in containers with different styles
                FlyContainer(
                  child: FlyText('Container with Text Style')
                    .text('xl')
                    .color(colors.white)
                    .p(16),
                )
                  .bg(colors.green500)
                  .rounded(12)
                  .p(20)
                  .mb(spacing.s2),

                FlyContainer(
                  child: FlyText('Small Text in Container')
                    .text('sm')
                    .color(colors.gray700)
                    .p(12),
                )
                  .bg(colors.gray100)
                  .border(1)
                  .borderColor(colors.gray300)
                  .rounded(6)
                  .p(16)
                  .mb(spacing.s2),

                // Text with custom styling over text style
                FlyText('Custom Styling Over Text Style')
                  .text('base')
                  .color(colors.white)
                  .p(8)
                  .bg(colors.purple500)
                  .rounded(4)
                  .mb(spacing.s2),

                const SizedBox(height: 16),

                // Text Alignment Examples
                FlyText('Text Alignment Examples')
                  .color(colors.gray700)
                  .m(spacing.s3),

                const SizedBox(height: 16),

                // Left aligned text in container
                FlyContainer(
                  child: FlyText('Left Aligned Text')
                    .align('left')
                    .color(colors.blue600)
                    .p(8),
                )
                  .w(300)
                  .border(1)
                  .borderColor(colors.blue300)
                  .rounded(4)
                  .mb(spacing.s2),

                // Center aligned text in container
                FlyContainer(
                  child: FlyText('Center Aligned Text')
                    .align('center')
                    .color(colors.green600)
                    .p(8),
                )
                  .w(300)
                  .border(1)
                  .borderColor(colors.green300)
                  .rounded(4)
                  .mb(spacing.s2),

                // Right aligned text in container
                FlyContainer(
                  child: FlyText('Right Aligned Text')
                    .align('right')
                    .color(colors.purple600)
                    .p(8),
                )
                  .w(300)
                  .border(1)
                  .borderColor(colors.purple300)
                  .rounded(4)
                  .mb(spacing.s2),

                // Justify aligned text in container
                FlyContainer(
                  child: FlyText('Justify Aligned Text - This is a longer text that will demonstrate how justify alignment works by spreading the text across the full width of the container.')
                    .align('justify')
                    .color(colors.orange600)
                    .p(8),
                )
                  .w(300)
                  .border(1)
                  .borderColor(colors.orange300)
                  .rounded(4)
                  .mb(spacing.s2),

                // TextAlign enum example in container
                FlyContainer(
                  child: FlyText('TextAlign Enum Example')
                    .align(TextAlign.center)
                    .color(colors.red600)
                    .p(8),
                )
                  .w(300)
                  .border(1)
                  .borderColor(colors.red300)
                  .rounded(4)
                  .mb(spacing.s2),

                // Combined with other properties
                FlyContainer(
                  child: FlyText('Styled Text with Alignment')
                    .text('lg')
                    .align('center')
                    .color(colors.white)
                    .p(12),
                )
                  .w(300)
                  .bg(colors.indigo500)
                  .rounded(8)
                  .mb(spacing.s2),

                const SizedBox(height: 16),

                // Text Transformation Examples
                FlyText('Text Transformation Examples')
                  .color(colors.gray700)
                  .m(spacing.s3),

                const SizedBox(height: 16),

                // Uppercase transformation
                FlyText('uppercase transformation')
                  .uppercase()
                  .color(colors.blue600)
                  .mb(spacing.s2),

                // Lowercase transformation
                FlyText('LOWERCASE TRANSFORMATION')
                  .lowercase()
                  .color(colors.green600)
                  .mb(spacing.s2),

                // Capitalize transformation
                FlyText('capitalize transformation')
                  .capitalize()
                  .color(colors.purple600)
                  .mb(spacing.s2),

                // Combined with other properties
                FlyText('Styled Text with Transformation')
                  .text('lg')
                  .uppercase()
                  .color(colors.white)
                  .p(12)
                  .bg(colors.indigo500)
                  .rounded(8)
                  .mb(spacing.s2),

                // Multiple transformations (last one wins)
                FlyText('Multiple Transformations')
                  .uppercase()
                  .lowercase()  // This will override uppercase
                  .color(colors.red600)
                  .mb(spacing.s2),

                // In containers with alignment
                FlyContainer(
                  child: FlyText('Centered Uppercase Text')
                    .uppercase()
                    .align('center')
                    .color(colors.white)
                    .p(8),
                )
                  .w(300)
                  .bg(colors.teal500)
                  .rounded(8)
                  .mb(spacing.s2),

                const SizedBox(height: 16),

                // Line Height (Leading) Examples
                FlyText('Line Height (Leading) Examples')
                  .color(colors.gray700)
                  .m(spacing.s3),

                const SizedBox(height: 16),

                // Different leading values using tokens
                FlyText('Tight Leading (1.25x)\nThis is a longer text block that spans multiple lines to demonstrate the tight line spacing. Notice how the lines are closer together for compact layouts.')
                  .text('base')
                  .leading('tight')
                  .color(colors.blue600)
                  .mb(spacing.s2),

                FlyText('Snug Leading (1.375x)\nThis is a longer text block that spans multiple lines to demonstrate the snug line spacing. Notice how there is slightly more breathing room between lines.')
                  .text('base')
                  .leading('snug')
                  .color(colors.green600)
                  .mb(spacing.s2),

                FlyText('Normal Leading (1.5x)\nThis is a longer text block that spans multiple lines to demonstrate the normal line spacing. This provides comfortable reading with standard line height.')
                  .text('base')
                  .leading('normal')
                  .color(colors.purple600)
                  .mb(spacing.s2),

                FlyText('Relaxed Leading (1.625x)\nThis is a longer text block that spans multiple lines to demonstrate the relaxed line spacing. Notice the increased space between lines for better readability.')
                  .text('base')
                  .leading('relaxed')
                  .color(colors.orange600)
                  .mb(spacing.s2),

                FlyText('Loose Leading (2.0x)\nThis is a longer text block that spans multiple lines to demonstrate the loose line spacing. Notice the maximum spacing between lines for optimal readability.')
                  .text('base')
                  .leading('loose')
                  .color(colors.red600)
                  .mb(spacing.s2),

                const SizedBox(height: 16),

                // Custom numeric leading values
                FlyText('Custom Leading (1.2x) - This text uses a custom numeric leading value.')
                  .leading(1.2)
                  .color(colors.indigo600)
                  .mb(spacing.s2),

                FlyText('Custom Leading (2.5x) - This text uses a very loose custom leading value.')
                  .leading(2.5)
                  .color(colors.teal600)
                  .mb(spacing.s2),

                const SizedBox(height: 16),

                // Leading with different text sizes
                FlyText('Leading with Text Sizes')
                  .color(colors.gray700)
                  .m(spacing.s3),

                const SizedBox(height: 16),

                FlyText('Small Text with Tight Leading')
                  .text('sm')
                  .leading('tight')
                  .color(colors.blue600)
                  .mb(spacing.s2),

                FlyText('Large Text with Relaxed Leading')
                  .text('lg')
                  .leading('relaxed')
                  .color(colors.green600)
                  .mb(spacing.s2),

                FlyText('Extra Large Text with Loose Leading')
                  .text('xl')
                  .leading('loose')
                  .color(colors.purple600)
                  .mb(spacing.s2),

                const SizedBox(height: 16),

                // Leading in containers
                FlyContainer(
                  child: FlyText('Container with Leading')
                    .leading('snug')
                    .color(colors.white)
                    .p(12),
                )
                  .bg(colors.blue500)
                  .rounded(8)
                  .p(16)
                  .mb(spacing.s2),

                FlyContainer(
                  child: FlyText('Container with Custom Leading')
                    .leading(1.8)
                    .color(colors.white)
                    .p(12),
                )
                  .bg(colors.green500)
                  .rounded(8)
                  .p(16)
                  .mb(spacing.s2),

                const SizedBox(height: 16),

                // Leading with other text properties
                FlyText('Leading with Multiple Properties')
                  .text('lg')
                  .leading('relaxed')
                  .color(colors.white)
                  .p(12)
                  .bg(colors.purple500)
                  .rounded(8)
                  .mb(spacing.s2),

                FlyText('Leading with Alignment and Color')
                  .leading('snug')
                  .align('center')
                  .color(colors.orange600)
                  .p(8)
                  .bg(colors.orange50)
                  .rounded(6)
                  .mb(spacing.s2),

                const SizedBox(height: 16),

                // Direct TextStyle test
                FlyText('TextStyle Test')
                  .text(const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red))
                  .mb(spacing.s2),

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

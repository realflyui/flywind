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

class FlywindApp extends StatelessWidget {
  const FlywindApp({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  final ThemeMode themeMode;
  final void Function(ThemeMode) onThemeModeChanged;

  @override
  Widget build(BuildContext context) {
    final flyTheme = FlyTheme.of(context);
    final colors = flyTheme.colors;
    final spacing = flyTheme.spacing;
    final radius = flyTheme.radius;
    final textStyle = flyTheme.textStyle;
    final font = flyTheme.font;
    final fontWeight = flyTheme.fontWeight;
    final leading = flyTheme.leading;
    final tracking = flyTheme.tracking;

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
                // ========================================
                // 1. BASIC USAGE
                // ========================================
                _buildSectionHeader('Basic Usage'),
                
                // Simple FlyText
                FlyText('Hello Flywind!')
                  .color('blue600')
                  .text('lg')
                  .mb('s4'),

                // Simple FlyContainer
                FlyContainer(
                  child: FlyText('Container with utilities')
                    .color('white')
                    .p('s4'),
                )
                  .bg('green500')
                  .rounded('md')
                  .p('s5')
                  .mb('s4'),

                // Utility chaining
                FlyText('Chained utilities')
                  .color('purple600')
                  .text('base')
                  .weight('bold')
                  .p('s3')
                  .bg('purple50')
                  .rounded('sm')
                  .mb('s6'),

                // ========================================
                // 2. TEXT UTILITIES
                // ========================================
                _buildSectionHeader('Text Utilities'),

                // Text Sizes
                _buildSubsectionHeader('Text Sizes'),
                FlyText('Extra Small (xs)').text('xs').color('gray700').mb('s2'),
                FlyText('Small (sm)').text('sm').color('gray700').mb('s2'),
                FlyText('Base (base)').text('base').color('gray700').mb('s2'),
                FlyText('Large (lg)').text('lg').color('gray700').mb('s2'),
                FlyText('Extra Large (xl)').text('xl').color('gray700').mb('s2'),
                FlyText('2XL (xl2)').text('xl2').color('gray700').mb('s4'),

                // Font Families
                _buildSubsectionHeader('Font Families'),
                FlyText('Sans Font').font('sans').color('blue600').mb('s2'),
                FlyText('Serif Font').font('serif').color('green600').mb('s2'),
                FlyText('Mono Font').font('mono').color('purple600').mb('s2'),
                FlyText('Custom Stack').font(['Inter', 'system-ui', 'sans-serif']).color('orange600').mb('s4'),

                // Font Weights
                _buildSubsectionHeader('Font Weights'),
                FlyText('Thin').weight('thin').color('gray700').mb('s2'),
                FlyText('Light').weight('light').color('gray700').mb('s2'),
                FlyText('Normal').weight('normal').color('gray700').mb('s2'),
                FlyText('Medium').weight('medium').color('gray700').mb('s2'),
                FlyText('Bold').weight('bold').color('gray700').mb('s2'),
                FlyText('Black').weight('black').color('gray700').mb('s4'),

                // Text Alignment
                _buildSubsectionHeader('Text Alignment'),
                FlyContainer(
                  child: FlyText('Left Aligned').align('left').color('blue600').p('s2'),
                ).w('s80').border(1).borderColor('blue300').rounded('sm').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Center Aligned').align('center').color('green600').p('s2'),
                ).w('s80').border(1).borderColor('green300').rounded('sm').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Right Aligned').align('right').color('purple600').p('s2'),
                ).w('s80').border(1).borderColor('purple300').rounded('sm').mb('s4'),

                // Text Transformations
                _buildSubsectionHeader('Text Transformations'),
                FlyText('uppercase text').uppercase().color('blue600').mb('s2'),
                FlyText('LOWERCASE TEXT').lowercase().color('green600').mb('s2'),
                FlyText('capitalize text').capitalize().color('purple600').mb('s4'),

                // Text Decorations
                _buildSubsectionHeader('Text Decorations'),
                FlyText('Underlined Text').underline().color('blue600').mb('s2'),
                FlyText('Strikethrough Text').lineThrough().color('red600').mb('s2'),
                FlyText('Overlined Text').overline().color('green600').mb('s4'),

                // Line Height (Leading)
                _buildSubsectionHeader('Line Height (Leading)'),
                FlyText('Tight Leading (1.25x)\nThis is a longer text block that spans multiple lines to demonstrate the tight line spacing. Notice how the lines are closer together for compact layouts.')
                  .text('base').leading('tight').color('blue600').mb('s2'),
                FlyText('Snug Leading (1.375x)\nThis is a longer text block that spans multiple lines to demonstrate the snug line spacing. Notice how there is slightly more breathing room between lines.')
                  .text('base').leading('snug').color('green600').mb('s2'),
                FlyText('Normal Leading (1.5x)\nThis is a longer text block that spans multiple lines to demonstrate the normal line spacing. This provides comfortable reading with standard line height.')
                  .text('base').leading('normal').color('purple600').mb('s2'),
                FlyText('Relaxed Leading (1.625x)\nThis is a longer text block that spans multiple lines to demonstrate the relaxed line spacing. Notice the increased space between lines for better readability.')
                  .text('base').leading('relaxed').color('orange600').mb('s2'),
                FlyText('Loose Leading (2.0x)\nThis is a longer text block that spans multiple lines to demonstrate the loose line spacing. Notice the maximum spacing between lines for optimal readability.')
                  .text('base').leading('loose').color('red600').mb('s2'),
                FlyText('Custom Leading (1.2x) - This text uses a custom numeric leading value.')
                  .leading(1.2).color('indigo600').mb('s2'),
                FlyText('Custom Leading (2.5x) - This text uses a very loose custom leading value.')
                  .leading(2.5).color('teal600').mb('s4'),

                // Letter Spacing (Tracking)
                _buildSubsectionHeader('Letter Spacing (Tracking)'),
                FlyText('Tighter Tracking').tracking('tighter').color('blue600').mb('s2'),
                FlyText('Tight Tracking').tracking('tight').color('green600').mb('s2'),
                FlyText('Normal Tracking').tracking('normal').color('purple600').mb('s2'),
                FlyText('Wide Tracking').tracking('wide').color('orange600').mb('s2'),
                FlyText('Wider Tracking').tracking('wider').color('red600').mb('s2'),
                FlyText('Widest Tracking').tracking('widest').color('indigo600').mb('s2'),
                FlyText('Custom Tracking (-1.0)').tracking(-1.0).color('teal600').mb('s2'),
                FlyText('Custom Tracking (2.0)').tracking(2.0).color('cyan600').mb('s2'),
                FlyText('Custom Tracking (0.1em)').tracking('0.1em').color('pink600').mb('s6'),

                // ========================================
                // 3. CONTAINER UTILITIES
                // ========================================
                _buildSectionHeader('Container Utilities'),

                // Background Colors
                _buildSubsectionHeader('Background Colors'),
                FlyContainer(
                  child: FlyText('Blue Background').color('white').p('s3'),
                ).bg('blue500').rounded('sm').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Green Background').color('white').p('s3'),
                ).bg('green500').rounded('sm').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Purple Background').color('white').p('s3'),
                ).bg('purple500').rounded('sm').mb('s4'),

                // Padding and Margins
                _buildSubsectionHeader('Padding and Margins'),
                
                // Basic Padding
                FlyContainer(
                  child: FlyText('Small Padding').color('white').p('s2'),
                ).bg('blue500').p('s2').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Medium Padding').color('white').p('s2'),
                ).bg('green500').p('s4').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Large Padding').color('white').p('s2'),
                ).bg('purple500').p('s6').mb('s2'),

                // Directional Padding
                FlyContainer(
                  child: FlyText('Horizontal Padding').color('white').p('s2'),
                ).bg('blue500').px('s4').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Vertical Padding').color('white').p('s2'),
                ).bg('green500').py('s3').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Top Padding Only').color('white').p('s2'),
                ).bg('purple500').pt('s6').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Right Padding Only').color('white').p('s2'),
                ).bg('orange500').pr('s4').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Bottom Padding Only').color('white').p('s2'),
                ).bg('teal500').pb('s5').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Left Padding Only').color('white').p('s2'),
                ).bg('pink500').pl('s3').mb('s4'),

                // Margins
                FlyContainer(
                  child: FlyText('With Margin').color('white').p('s2'),
                ).bg('indigo500').p('s4').m('s2').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Horizontal Margin').color('white').p('s2'),
                ).bg('cyan500').p('s3').mx('s4').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Vertical Margin').color('white').p('s2'),
                ).bg('amber500').p('s3').my('s2').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Top Margin Only').color('white').p('s2'),
                ).bg('red500').p('s3').mt('s6').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Right Margin Only').color('white').p('s2'),
                ).bg('lime500').p('s3').mr('s4').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Bottom Margin Only').color('white').p('s2'),
                ).bg('purple500').p('s3').mb('s5').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Left Margin Only').color('white').p('s2'),
                ).bg('gray500').p('s3').ml('s3').mb('s4'),

                // Border Radius
                _buildSubsectionHeader('Border Radius'),
                
                // Basic Border Radius
                FlyContainer(
                  child: FlyText('Small Radius').color('white').p('s3'),
                ).bg('blue500').rounded('sm').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Medium Radius').color('white').p('s3'),
                ).bg('green500').rounded('md').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Large Radius').color('white').p('s3'),
                ).bg('purple500').rounded('lg').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Extra Large Radius').color('white').p('s3'),
                ).bg('orange500').rounded('xl').mb('s4'),

                // Selective Border Radius
                _buildSubsectionHeader('Selective Border Radius'),
                FlyContainer(
                  child: FlyText('Top Corners Only').color('white').p('s3'),
                ).bg('blue500').roundedT('lg').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Right Corners Only').color('white').p('s3'),
                ).bg('green500').roundedR('md').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Bottom Corners Only').color('white').p('s3'),
                ).bg('purple500').roundedB('lg').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Left Corners Only').color('white').p('s3'),
                ).bg('orange500').roundedL('md').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Top-Left Corner Only').color('white').p('s3'),
                ).bg('teal500').roundedTl('xl').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Top-Right Corner Only').color('white').p('s3'),
                ).bg('pink500').roundedTr('xl').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Bottom-Left Corner Only').color('white').p('s3'),
                ).bg('indigo500').roundedBl('xl').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Bottom-Right Corner Only').color('white').p('s3'),
                ).bg('cyan500').roundedBr('xl').mb('s4'),

                // Borders
                _buildSubsectionHeader('Borders'),
                FlyContainer(
                  child: FlyText('Solid Border').color('blue700').p('s3'),
                ).bg('blue50').border(2).borderColor('blue500').borderStyle('solid').rounded('sm').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Dashed Border').color('green700').p('s3'),
                ).bg('green50').border(2).borderColor('green500').borderStyle('dashed').rounded('sm').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Dotted Border').color('purple700').p('s3'),
                ).bg('purple50').border(2).borderColor('purple500').borderStyle('dotted').rounded('sm').mb('s2'),

                // Selective Borders
                _buildSubsectionHeader('Selective Borders'),
                FlyContainer(
                  child: FlyText('Custom Borders (Top + Right + Bottom)').color('purple700').p('s3'),
                ).bg('purple50').borderT(10).borderR(5).borderB(10).borderColor('purple500').p('s4').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Left Border Only').color('orange700').p('s3'),
                ).bg('orange50').borderL(8).borderColor('orange500').p('s4').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Top Border Only').color('teal700').p('s3'),
                ).bg('teal50').borderT(6).borderColor('teal500').p('s4').mb('s4'),

                // Sizes
                _buildSubsectionHeader('Sizes'),
                FlyContainer(
                  child: FlyText('Fixed Size').color('white').p('s2'),
                ).bg('blue500').w('s32').h('s16').rounded('sm').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Max Width').color('white').p('s2'),
                ).bg('green500').maxW('s40').h('s16').rounded('sm').mb('s2'),
                
                FlyContainer(
                  child: FlyText('Min Height').color('white').p('s2'),
                ).bg('purple500').minH('s20').w('s52').rounded('sm').mb('s4'),

                // Complex Example
                _buildSubsectionHeader('Complex Example'),
                FlyContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FlyText('Card Title')
                        .text('lg')
                        .weight('bold')
                        .color('gray900')
                        .mb('s2'),
                      FlyText('This is a complex card with multiple utilities applied.')
                        .text('sm')
                        .color('gray600')
                        .leading('relaxed')
                        .mb('s3'),
                      FlyContainer(
                        child: FlyText('Action Button')
                          .color('white')
                          .text('sm')
                          .weight('medium')
                          .p('s2'),
                      ).bg('blue500').rounded('sm').p('s3'),
                    ],
                  ),
                )
                  .bg('white')
                  .border(1)
                  .borderColor('gray200')
                  .rounded('lg')
                  .p('s5')
                  .mb('s6'),

                // ========================================
                // 4. ADVANCED SYNTAX
                // ========================================
                _buildSectionHeader('Advanced Syntax'),

                // Theme Token Access Patterns
                _buildSubsectionHeader('Theme Token Access'),
                
                // Dot access
                FlyText('Dot Access: font.sans, colors.blue500')
                  .font(font.sans)
                  .color(colors.blue500)
                  .mb('s2'),
                
                // Bracket access
                FlyText('Bracket Access: font[\'serif\'], colors[\'green500\']')
                  .font(font['serif'])
                  .color(colors['green500'])
                  .mb('s2'),
                
                // String tokens
                FlyText('String Tokens: \'mono\', \'purple500\'')
                  .font('mono')
                  .color('purple500')
                  .mb('s4'),

                // Value Type Flexibility
                _buildSubsectionHeader('Value Type Flexibility'),
                
                // Font examples
                FlyText('Font: String token vs dot access vs raw string')
                  .font('sans')
                  .color('gray700')
                  .mb('s1'),
                FlyText('Font: font.serif')
                  .font(font.serif)
                  .color('gray700')
                  .mb('s1'),
                FlyText('Font: \'Inter\'')
                  .font('Inter')
                  .color('gray700')
                  .mb('s2'),
                
                // Font weight examples
                FlyText('Weight: String token vs dot access vs FontWeight')
                  .weight('bold')
                  .color('gray700')
                  .mb('s1'),
                FlyText('Weight: fontWeight.medium')
                  .weight(fontWeight.medium)
                  .color('gray700')
                  .mb('s1'),
                FlyText('Weight: FontWeight.w600')
                  .weight(FontWeight.w600)
                  .color('gray700')
                  .mb('s2'),
                
                // Text style examples
                FlyText('Text Style: String token vs dot access vs TextStyle')
                  .text('lg')
                  .color('gray700')
                  .mb('s1'),
                FlyText('Text Style: textStyle.base')
                  .text(textStyle.base)
                  .color('gray700')
                  .mb('s1'),
                FlyText('Text Style: TextStyle(fontSize: 20)')
                  .text(TextStyle(fontSize: 20))
                  .color('gray700')
                  .mb('s2'),
                
                // Tracking examples
                FlyText('Tracking: String token vs dot access vs numeric')
                  .tracking('wide')
                  .color('gray700')
                  .mb('s1'),
                FlyText('Tracking: tracking.tight')
                  .tracking(tracking.tight)
                  .color('gray700')
                  .mb('s1'),
                FlyText('Tracking: 2.0')
                  .tracking(2.0)
                  .color('gray700')
                  .mb('s2'),
                
                // Spacing examples
                FlyText('Spacing: String token vs dot access vs numeric vs CSS vs raw')
                  .color('gray700')
                  .mb('s1'),
                FlyContainer(
                  child: FlyText('p(\'s4\')').color('white').p('s1'),
                ).bg('blue500').p('s4').mb('s1'),
                FlyContainer(
                  child: FlyText('p(spacing.s3)').color('white').p('s1'),
                ).bg('green500').p(spacing.s3).mb('s1'),
                FlyContainer(
                  child: FlyText('p(16)').color('white').p('s1'),
                ).bg('purple500').p(16).mb('s1'),
                FlyContainer(
                  child: FlyText('p(\'20px\')').color('white').p('s1'),
                ).bg('orange500').p('20px').mb('s1'),
                FlyContainer(
                  child: FlyText('p(32)').color('white').p('s1'),
                ).bg('indigo500').p(32).mb('s2'),
                
                // Color examples
                FlyText('Colors: String token vs dot access vs Color object vs hex vs raw')
                  .color('gray700')
                  .mb('s1'),
                FlyText('String: \'red500\'')
                  .color('red500')
                  .mb('s1'),
                FlyText('Dot: colors.teal500')
                  .color(colors.teal500)
                  .mb('s1'),
                FlyText('Object: Colors.pink')
                  .color(Colors.pink)
                  .mb('s1'),
                FlyText('Hex: \'#FF6B35\'')
                  .color('#FF6B35')
                  .mb('s1'),
                FlyText('Raw: Color(0xFF8B5CF6)')
                  .color(Color(0xFF8B5CF6))
                  .mb('s4'),

                // Mixed Syntax Example
                _buildSubsectionHeader('Mixed Syntax Example'),
                FlyContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FlyText('Mixed Syntax Card')
                        .text('lg')
                        .weight(fontWeight.bold)
                        .color(colors.gray900)
                        .mb('s2'),
                      FlyText('This card uses different syntax patterns:\n• font(font.sans) - dot access\n• color(\'blue600\') - string token\n• p(spacing.s4) - dot access\n• bg(\'blue50\') - string token\n• rounded(radius.md) - dot access')
                        .text('sm')
                        .color('gray600')
                        .leading(leading.relaxed)
                        .mb('s3'),
                      FlyContainer(
                        child: FlyText('Mixed Button')
                          .color(Colors.white)
                          .text('sm')
                          .weight('medium')
                          .p('s2'),
                      ).bg('#FF6B35').rounded(radius.sm).p('s3'),
                    ],
                  ),
                )
                  .bg('white')
                  .border(1)
                  .borderColor(colors.gray200)
                  .rounded('lg')
                  .p('s5')
                  .mb('s6'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlyText(title)
          .text('xl2')
          .weight('bold')
          .color('gray900')
          .mb('s2'),
      ],
    );
  }

  Widget _buildSubsectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlyText(title)
          .text('lg')
          .weight('semibold')
          .color('gray800')
          .mb('s3'),
      ],
    );
  }
}

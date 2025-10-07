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
                FlyText('Hello Flywind!').color('blue600').text('lg').mb('s4'),

                // Simple FlyBox (container mode)
                FlyBox(
                  child: FlyText(
                    'Container with utilities',
                  ).color('white').p('s4'),
                ).bg('green500').rounded('md').p('s5').mb('s4'),

                // Utility chaining
                FlyBox(
                  child: FlyText(
                    'Chained utilities',
                  ).color('purple600').text('base').weight('bold').p('s3'),
                ).bg('purple50').mb('s6'),

                // ========================================
                // 2. TEXT UTILITIES
                // ========================================
                _buildSectionHeader('Text Utilities'),

                // Text Sizes
                _buildSubsectionHeader('Text Sizes'),
                FlyText(
                  'Extra Small (xs)',
                ).text('xs').color('gray700').mb('s2'),
                FlyText('Small (sm)').text('sm').color('gray700').mb('s2'),
                FlyText('Base (base)').text('base').color('gray700').mb('s2'),
                FlyText('Large (lg)').text('lg').color('gray700').mb('s2'),
                FlyText(
                  'Extra Large (xl)',
                ).text('xl').color('gray700').mb('s2'),
                FlyText('2XL (xl2)').text('xl2').color('gray700').mb('s4'),

                // Font Families
                _buildSubsectionHeader('Font Families'),
                FlyText('Sans Font').font('sans').color('blue600').mb('s2'),
                FlyText('Serif Font').font('serif').color('green600').mb('s2'),
                FlyText('Mono Font').font('mono').color('purple600').mb('s2'),
                FlyText('Custom Stack')
                    .font(['Inter', 'system-ui', 'sans-serif'])
                    .color('orange600')
                    .mb('s4'),

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
                FlyBox(
                      child: FlyText(
                        'Left Aligned',
                      ).align('left').color('blue600').p('s3'),
                    )
                    .w('s80')
                    .border(1)
                    .borderColor('blue300')
                    .rounded('sm')
                    .mb('s2'),

                FlyBox(
                      child: FlyText(
                        'Center Aligned',
                      ).align('center').color('green600').p('s2'),
                    )
                    .w('s80')
                    .border(1)
                    .borderColor('green300')
                    .rounded('sm')
                    .mb('s2'),

                FlyBox(
                      child: FlyText(
                        'Right Aligned',
                      ).align('right').color('purple600').p('s2'),
                    )
                    .w('s80')
                    .border(1)
                    .borderColor('purple300')
                    .rounded('sm')
                    .mb('s4'),

                // Text Transformations
                _buildSubsectionHeader('Text Transformations'),
                FlyText('uppercase text').uppercase().color('blue600').mb('s2'),
                FlyText(
                  'LOWERCASE TEXT',
                ).lowercase().color('green600').mb('s2'),
                FlyText(
                  'capitalize text',
                ).capitalize().color('purple600').mb('s4'),

                // Text Decorations
                _buildSubsectionHeader('Text Decorations'),
                FlyText(
                  'Underlined Text',
                ).underline().color('blue600').mb('s2'),
                FlyText(
                  'Strikethrough Text',
                ).lineThrough().color('red600').mb('s2'),
                FlyText('Overlined Text').overline().color('green600').mb('s4'),

                // Line Height (Leading)
                _buildSubsectionHeader('Line Height (Leading)'),
                FlyText(
                  'Tight Leading (1.25x)\nThis is a longer text block that spans multiple lines to demonstrate the tight line spacing. Notice how the lines are closer together for compact layouts.',
                ).text('base').leading('tight').color('blue600').mb('s2'),
                FlyText(
                  'Snug Leading (1.375x)\nThis is a longer text block that spans multiple lines to demonstrate the snug line spacing. Notice how there is slightly more breathing room between lines.',
                ).text('base').leading('snug').color('green600').mb('s2'),
                FlyText(
                  'Normal Leading (1.5x)\nThis is a longer text block that spans multiple lines to demonstrate the normal line spacing. This provides comfortable reading with standard line height.',
                ).text('base').leading('normal').color('purple600').mb('s2'),
                FlyText(
                  'Relaxed Leading (1.625x)\nThis is a longer text block that spans multiple lines to demonstrate the relaxed line spacing. Notice the increased space between lines for better readability.',
                ).text('base').leading('relaxed').color('orange600').mb('s2'),
                FlyText(
                  'Loose Leading (2.0x)\nThis is a longer text block that spans multiple lines to demonstrate the loose line spacing. Notice the maximum spacing between lines for optimal readability.',
                ).text('base').leading('loose').color('red600').mb('s2'),
                FlyText(
                  'Custom Leading (1.2x) - This text uses a custom numeric leading value.',
                ).leading(1.2).color('indigo600').mb('s2'),
                FlyText(
                  'Custom Leading (2.5x) - This text uses a very loose custom leading value.',
                ).leading(2.5).color('teal600').mb('s4'),

                // Letter Spacing (Tracking)
                _buildSubsectionHeader('Letter Spacing (Tracking)'),
                FlyText(
                  'Tighter Tracking',
                ).tracking('tighter').color('blue600').mb('s2'),
                FlyText(
                  'Tight Tracking',
                ).tracking('tight').color('green600').mb('s2'),
                FlyText(
                  'Normal Tracking',
                ).tracking('normal').color('purple600').mb('s2'),
                FlyText(
                  'Wide Tracking',
                ).tracking('wide').color('orange600').mb('s2'),
                FlyText(
                  'Wider Tracking',
                ).tracking('wider').color('red600').mb('s2'),
                FlyText(
                  'Widest Tracking',
                ).tracking('widest').color('indigo600').mb('s2'),
                FlyText(
                  'Custom Tracking (-1.0)',
                ).tracking(-1.0).color('teal600').mb('s2'),
                FlyText(
                  'Custom Tracking (2.0)',
                ).tracking(2.0).color('cyan600').mb('s2'),
                FlyText(
                  'Custom Tracking (0.1em)',
                ).tracking('0.1em').color('pink600').mb('s6'),

                // ========================================
                // 3. ICON UTILITIES
                // ========================================
                _buildSectionHeader('Icon Utilities'),

                // Basic Icon Examples
                _buildSubsectionHeader('Basic Icons'),
                FlyIcon(Icons.star).color('yellow500').mb('s2'),
                FlyIcon(Icons.favorite).color('red500').mb('s2'),
                FlyIcon(Icons.home).color('blue500').mb('s2'),
                FlyIcon(Icons.settings).color('gray500').mb('s4'),

                // Icon Sizes
                _buildSubsectionHeader('Icon Sizes'),
                FlyIcon(Icons.star).w('s4').color('yellow500').mb('s2'),
                FlyIcon(Icons.star).w('s6').color('yellow500').mb('s2'),
                FlyIcon(Icons.star).w('s8').color('yellow500').mb('s2'),
                FlyIcon(Icons.star).w('s10').color('yellow500').mb('s2'),
                FlyIcon(Icons.star).w('s12').color('yellow500').mb('s4'),

                // Icon Colors
                _buildSubsectionHeader('Icon Colors'),
                FlyIcon(Icons.circle).color('red500').mb('s2'),
                FlyIcon(Icons.circle).color('green500').mb('s2'),
                FlyIcon(Icons.circle).color('blue500').mb('s2'),
                FlyIcon(Icons.circle).color('purple500').mb('s2'),
                FlyIcon(Icons.circle).color('orange500').mb('s4'),

                // Icon with Padding and Margin
                _buildSubsectionHeader('Icon with Spacing'),
                FlyBox(
                  child: FlyIcon(Icons.star).color('yellow500').p('s2'),
                ).bg('yellow50').rounded('sm').mb('s2'),
                FlyBox(
                  child: FlyIcon(Icons.favorite).color('red500').p('s3'),
                ).bg('red50').rounded('md').mb('s2'),
                FlyBox(
                  child: FlyIcon(Icons.home).color('blue500').p('s4'),
                ).bg('blue50').rounded('lg').mb('s2'),
                FlyBox(
                  child: FlyIcon(Icons.settings).color('gray500').p('s2'),
                ).bg('gray50').rounded('sm').m('s2').mb('s2'),

                // Hybrid Mode Test (direct size + styled color + styled padding)
                FlyBox(
                  child: FlyIcon(
                    Icons.star,
                    iconSize: 24,
                  ).color('red500').p('s4'),
                ).bg('red50').rounded('sm').mb('s2'),

                // Hybrid Mode Test for Text (direct style + styled color + styled padding)
                FlyBox(
                  child: FlyText(
                    'Hybrid Text',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ).color('blue500').p('s3'),
                ).bg('blue50').rounded('sm').mb('s2'),

                // Another Hybrid Mode Test for Text (direct fontSize + styled color + styled padding)
                FlyBox(
                  child: FlyText(
                    'Hello',
                    style: TextStyle(fontSize: 18),
                  ).color('blue500').p('s3'),
                ).bg('blue50').rounded('sm').mb('s2'),

                // Hybrid Mode Test for Container (direct decoration + styled padding + styled margin)
                FlyBox(
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FlyText('Hybrid Container').color('white').p('s2'),
                ).p('s4').m('s2').mb('s4'),

                // Icon Layout Examples
                _buildSubsectionHeader('Icon Layout'),
                FlyBox(
                  children: [
                    FlyIcon(Icons.star).color('yellow500').flex('none'),
                    FlyText('Star Rating').color('gray700').flex('auto'),
                    FlyIcon(Icons.arrow_forward).color('gray400').flex('none'),
                  ],
                ).row().items('center').gap('s2').mb('s2'),

                FlyBox(
                  children: [
                    FlyIcon(Icons.notifications).color('blue500').flex('none'),
                    FlyText('Notifications').color('gray700').flex('auto'),
                    FlyIcon(Icons.badge).color('green500').flex('none'),
                  ],
                ).row().items('center').gap('s2').mb('s2'),

                FlyBox(
                  children: [
                    FlyIcon(Icons.person).color('purple500').flex('none'),
                    FlyText('Profile').color('gray700').flex('auto'),
                    FlyIcon(Icons.edit).color('orange500').flex('none'),
                  ],
                ).row().items('center').gap('s2').mb('s4'),

                // ========================================
                // 3. CONTAINER UTILITIES
                // ========================================
                _buildSectionHeader('Container Utilities'),

                // Background Colors
                _buildSubsectionHeader('Background Colors'),
                FlyBox(
                  child: FlyText('Blue Background').color('white').p('s3'),
                ).bg('blue500').rounded('sm').mb('s2'),

                FlyBox(
                  child: FlyText('Green Background').color('white').p('s3'),
                ).bg('green500').rounded('sm').mb('s2'),

                FlyBox(
                  child: FlyText('Purple Background').color('white').p('s3'),
                ).bg('purple500').rounded('sm').mb('s4'),

                // Padding and Margins
                _buildSubsectionHeader('Padding and Margins'),

                // Basic Padding
                FlyBox(
                  child: FlyText('Small Padding').color('white').p('s2'),
                ).bg('blue500').p('s2').mb('s2'),

                FlyBox(
                  child: FlyText('Medium Padding').color('white').p('s2'),
                ).bg('green500').p('s4').mb('s2'),

                FlyBox(
                  child: FlyText('Large Padding').color('white').p('s2'),
                ).bg('purple500').p('s6').mb('s2'),

                // Directional Padding
                FlyBox(
                  child: FlyText('Horizontal Padding').color('white').p('s2'),
                ).bg('blue500').px('s4').mb('s2'),

                FlyBox(
                  child: FlyText('Vertical Padding').color('white').p('s2'),
                ).bg('green500').py('s3').mb('s2'),

                FlyBox(
                  child: FlyText('Top Padding Only').color('white').p('s2'),
                ).bg('purple500').pt('s6').mb('s2'),

                FlyBox(
                  child: FlyText('Right Padding Only').color('white').p('s2'),
                ).bg('orange500').pr('s4').mb('s2'),

                FlyBox(
                  child: FlyText('Bottom Padding Only').color('white').p('s2'),
                ).bg('teal500').pb('s5').mb('s2'),

                FlyBox(
                  child: FlyText('Left Padding Only').color('white').p('s2'),
                ).bg('pink500').pl('s3').mb('s4'),

                // Margins
                FlyBox(
                  child: FlyText('With Margin').color('white').p('s2'),
                ).bg('indigo500').p('s4').m('s2').mb('s2'),

                FlyBox(
                  child: FlyText('Horizontal Margin').color('white').p('s2'),
                ).bg('cyan500').p('s3').mx('s4').mb('s2'),

                FlyBox(
                  child: FlyText('Vertical Margin').color('white').p('s2'),
                ).bg('amber500').p('s3').my('s2').mb('s2'),

                FlyBox(
                  child: FlyText('Top Margin Only').color('white').p('s2'),
                ).bg('red500').p('s3').mt('s6').mb('s2'),

                FlyBox(
                  child: FlyText('Right Margin Only').color('white').p('s2'),
                ).bg('lime500').p('s3').mr('s4').mb('s2'),

                FlyBox(
                  child: FlyText('Bottom Margin Only').color('white').p('s2'),
                ).bg('purple500').p('s3').mb('s5').mb('s2'),

                FlyBox(
                  child: FlyText('Left Margin Only').color('white').p('s2'),
                ).bg('gray500').p('s3').ml('s3').mb('s4'),

                // Border Radius
                _buildSubsectionHeader('Border Radius'),

                // Basic Border Radius
                FlyBox(
                  child: FlyText('Small Radius').color('white').p('s3'),
                ).bg('blue500').rounded('sm').mb('s2'),

                FlyBox(
                  child: FlyText('Medium Radius').color('white').p('s3'),
                ).bg('green500').rounded('md').mb('s2'),

                FlyBox(
                  child: FlyText('Large Radius').color('white').p('s3'),
                ).bg('purple500').rounded('lg').mb('s2'),

                FlyBox(
                  child: FlyText('Extra Large Radius').color('white').p('s3'),
                ).bg('orange500').rounded('xl').mb('s4'),

                // Selective Border Radius
                _buildSubsectionHeader('Selective Border Radius'),
                FlyBox(
                  child: FlyText('Top Corners Only').color('white').p('s3'),
                ).bg('blue500').roundedT('lg').mb('s2'),

                FlyBox(
                  child: FlyText('Right Corners Only').color('white').p('s3'),
                ).bg('green500').roundedR('md').mb('s2'),

                FlyBox(
                  child: FlyText('Bottom Corners Only').color('white').p('s3'),
                ).bg('purple500').roundedB('lg').mb('s2'),

                FlyBox(
                  child: FlyText('Left Corners Only').color('white').p('s3'),
                ).bg('orange500').roundedL('md').mb('s2'),

                FlyBox(
                  child: FlyText('Top-Left Corner Only').color('white').p('s3'),
                ).bg('teal500').roundedTl('xl').mb('s2'),

                FlyBox(
                  child: FlyText(
                    'Top-Right Corner Only',
                  ).color('white').p('s3'),
                ).bg('pink500').roundedTr('xl').mb('s2'),

                FlyBox(
                  child: FlyText(
                    'Bottom-Left Corner Only',
                  ).color('white').p('s3'),
                ).bg('indigo500').roundedBl('xl').mb('s2'),

                FlyBox(
                  child: FlyText(
                    'Bottom-Right Corner Only',
                  ).color('white').p('s3'),
                ).bg('cyan500').roundedBr('xl').mb('s4'),

                // Borders
                _buildSubsectionHeader('Borders'),
                FlyBox(child: FlyText('Solid Border').color('blue700').p('s3'))
                    .bg('blue50')
                    .border(2)
                    .borderColor('blue500')
                    .borderStyle('solid')
                    .rounded('sm')
                    .mb('s2'),

                FlyBox(
                      child: FlyText('Dashed Border').color('green700').p('s3'),
                    )
                    .bg('green50')
                    .border(2)
                    .borderColor('green500')
                    .borderStyle('dashed')
                    .rounded('sm')
                    .mb('s2'),

                FlyBox(
                      child: FlyText(
                        'Dotted Border',
                      ).color('purple700').p('s3'),
                    )
                    .bg('purple50')
                    .border(2)
                    .borderColor('purple500')
                    .borderStyle('dotted')
                    .rounded('sm')
                    .mb('s2'),

                // Selective Borders
                _buildSubsectionHeader('Selective Borders'),
                FlyBox(
                      child: FlyText(
                        'Custom Borders (Top + Right + Bottom)',
                      ).color('purple700').p('s3'),
                    )
                    .bg('purple50')
                    .borderT(10)
                    .borderR(5)
                    .borderB(10)
                    .borderColor('purple500')
                    .p('s4')
                    .mb('s2'),

                FlyBox(
                      child: FlyText(
                        'Left Border Only',
                      ).color('orange700').p('s3'),
                    )
                    .bg('orange50')
                    .borderL(8)
                    .borderColor('orange500')
                    .p('s4')
                    .mb('s2'),

                FlyBox(
                      child: FlyText(
                        'Top Border Only',
                      ).color('teal700').p('s3'),
                    )
                    .bg('teal50')
                    .borderT(6)
                    .borderColor('teal500')
                    .p('s4')
                    .mb('s4'),

                // Sizes
                _buildSubsectionHeader('Sizes'),
                FlyBox(
                  child: FlyText('Fixed Size').color('white').p('s2'),
                ).bg('blue500').w('s32').h('s16').rounded('sm').mb('s2'),

                FlyBox(
                  child: FlyText('Max Width').color('white').p('s2'),
                ).bg('green500').maxW('s40').h('s16').rounded('sm').mb('s2'),

                FlyBox(
                  child: FlyText('Min Height').color('white').p('s2'),
                ).bg('purple500').minH('s20').w('s52').rounded('sm').mb('s4'),

                // Complex Example
                _buildSubsectionHeader('Complex Example'),
                FlyBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FlyText(
                            'Card Title',
                          ).text('lg').weight('bold').color('gray900').mb('s2'),
                          FlyText(
                            'This is a complex card with multiple utilities applied.',
                          ).text('sm').color('gray600').leading('relaxed').mb('s3'),
                          FlyBox(
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
                FlyText(
                  'Dot Access: font.sans, colors.blue500',
                ).font(font.sans).color(colors.blue500).mb('s2'),

                // Bracket access
                FlyText(
                  'Bracket Access: font[\'serif\'], colors[\'green500\']',
                ).font(font['serif']).color(colors['green500']).mb('s2'),

                // String tokens
                FlyText(
                  'String Tokens: \'mono\', \'purple500\'',
                ).font('mono').color('purple500').mb('s4'),

                // Value Type Flexibility
                _buildSubsectionHeader('Value Type Flexibility'),

                // Font examples
                FlyText(
                  'Font: String token vs dot access vs raw string',
                ).font('sans').color('gray700').mb('s1'),
                FlyText(
                  'Font: font.serif',
                ).font(font.serif).color('gray700').mb('s1'),
                FlyText(
                  'Font: \'Inter\'',
                ).font('Inter').color('gray700').mb('s2'),

                // Font weight examples
                FlyText(
                  'Weight: String token vs dot access vs FontWeight',
                ).weight('bold').color('gray700').mb('s1'),
                FlyText(
                  'Weight: fontWeight.medium',
                ).weight(fontWeight.medium).color('gray700').mb('s1'),
                FlyText(
                  'Weight: FontWeight.w600',
                ).weight(FontWeight.w600).color('gray700').mb('s2'),

                // Text style examples
                FlyText(
                  'Text Style: String token vs dot access vs TextStyle',
                ).text('lg').color('gray700').mb('s1'),
                FlyText(
                  'Text Style: textStyle.base',
                ).text(textStyle.base).color('gray700').mb('s1'),
                FlyText(
                  'Text Style: TextStyle(fontSize: 20)',
                ).text(TextStyle(fontSize: 20)).color('gray700').mb('s2'),

                // Tracking examples
                FlyText(
                  'Tracking: String token vs dot access vs numeric',
                ).tracking('wide').color('gray700').mb('s1'),
                FlyText(
                  'Tracking: tracking.tight',
                ).tracking(tracking.tight).color('gray700').mb('s1'),
                FlyText(
                  'Tracking: 2.0',
                ).tracking(2.0).color('gray700').mb('s2'),

                // Spacing examples
                FlyText(
                  'Spacing: String token vs dot access vs numeric vs CSS vs raw',
                ).color('gray700').mb('s1'),
                FlyBox(
                  child: FlyText('p(\'s4\')').color('white').p('s1'),
                ).bg('blue500').p('s4').mb('s1'),
                FlyBox(
                  child: FlyText('p(spacing.s3)').color('white').p('s1'),
                ).bg('green500').p(spacing.s3).mb('s1'),
                FlyBox(
                  child: FlyText('p(16)').color('white').p('s1'),
                ).bg('purple500').p(16).mb('s1'),
                FlyBox(
                  child: FlyText('p(\'20px\')').color('white').p('s1'),
                ).bg('orange500').p('20px').mb('s1'),
                FlyBox(
                  child: FlyText('p(32)').color('white').p('s1'),
                ).bg('indigo500').p(32).mb('s2'),

                // Color examples
                FlyText(
                  'Colors: String token vs dot access vs Color object vs hex vs raw',
                ).color('gray700').mb('s1'),
                FlyText('String: \'red500\'').color('red500').mb('s1'),
                FlyText('Dot: colors.teal500').color(colors.teal500).mb('s1'),
                FlyText('Object: Colors.pink').color(Colors.pink).mb('s1'),
                FlyText('Hex: \'#FF6B35\'').color('#FF6B35').mb('s1'),
                FlyText(
                  'Raw: Color(0xFF8B5CF6)',
                ).color(Color(0xFF8B5CF6)).mb('s4'),

                // Mixed Syntax Example
                _buildSubsectionHeader('Mixed Syntax Example'),
                FlyBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FlyText('Mixed Syntax Card')
                              .text('lg')
                              .weight(fontWeight.bold)
                              .color(colors.gray900)
                              .mb('s2'),
                          FlyText(
                                'This card uses different syntax patterns:\n• font(font.sans) - dot access\n• color(\'blue600\') - string token\n• p(spacing.s4) - dot access\n• bg(\'blue50\') - string token\n• rounded(radius.md) - dot access',
                              )
                              .text('sm')
                              .color('gray600')
                              .leading(leading.relaxed)
                              .mb('s3'),
                          FlyBox(
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

                // ========================================
                // 5. LAYOUT UTILITIES
                // ========================================
                _buildSectionHeader('Layout Utilities'),

                // Column Layout Examples
                _buildSubsectionHeader('Column Layout'),

                // Basic Column
                FlyBox(
                  children: [
                    FlyText('Header').color('white').p('s2'),
                    FlyText('Content').color('white').p('s2'),
                    FlyText('Footer').color('white').p('s2'),
                  ],
                ).col().bg('blue500').rounded('md').p('s4').mb('s4'),

                // Column with alignment
                FlyBox(
                      children: [
                        FlyText('Centered Header').color('white').p('s2'),
                        FlyText('Centered Content').color('white').p('s2'),
                        FlyText('Centered Footer').color('white').p('s2'),
                      ],
                    )
                    .col()
                    .justify('center')
                    .items('center')
                    .bg('green500')
                    .rounded('md')
                    .p('s4')
                    .mb('s4'),

                // Column with gap
                FlyBox(
                      children: [
                        FlyText('Item 1').color('white').p('s2'),
                        FlyText('Item 2').color('white').p('s2'),
                        FlyText('Item 3').color('white').p('s2'),
                      ],
                    )
                    .col()
                    .gap('s3')
                    .bg('purple500')
                    .rounded('md')
                    .p('s4')
                    .mb('s4'),

                // Column with space between
                FlyBox(
                      children: [
                        FlyText('Top').color('white').p('s2'),
                        FlyText('Middle').color('white').p('s2'),
                        FlyText('Bottom').color('white').p('s2'),
                      ],
                    )
                    .col()
                    .justify('between')
                    .items('stretch')
                    .bg('orange500')
                    .rounded('md')
                    .p('s4')
                    .h('s40')
                    .mb('s4'),

                // Row Layout Examples
                _buildSubsectionHeader('Row Layout'),

                // Basic Row
                FlyBox(
                  children: [
                    FlyText('Left').color('white').p('s2'),
                    FlyText('Center').color('white').p('s2'),
                    FlyText('Right').color('white').p('s2'),
                  ],
                ).row().bg('teal500').rounded('md').p('s4').mb('s4'),

                // Row with space between
                FlyBox(
                      children: [
                        FlyText('Start').color('white').p('s2'),
                        FlyText('End').color('white').p('s2'),
                      ],
                    )
                    .row()
                    .justify('between')
                    .items('center')
                    .bg('pink500')
                    .rounded('md')
                    .p('s4')
                    .mb('s4'),

                // Row with gap
                FlyBox(
                      children: [
                        FlyText('A').color('white').p('s2'),
                        FlyText('B').color('white').p('s2'),
                        FlyText('C').color('white').p('s2'),
                      ],
                    )
                    .row()
                    .gap('s2')
                    .bg('indigo500')
                    .rounded('md')
                    .p('s4')
                    .mb('s4'),

                // Row with center alignment
                FlyBox(
                      children: [
                        FlyText('Left').color('white').p('s2'),
                        FlyText('Center').color('white').p('s2'),
                        FlyText('Right').color('white').p('s2'),
                      ],
                    )
                    .row()
                    .justify('center')
                    .items('center')
                    .bg('red500')
                    .rounded('md')
                    .p('s4')
                    .mb('s4'),

                // ========================================
                // 6. FLEX UTILITIES
                // ========================================
                _buildSectionHeader('Flex Utilities'),

                // Basic Flex Examples
                _buildSubsectionHeader('Basic Flex'),

                // Equal flex
                FlyBox(
                  children: [
                    FlyBox(
                      child: FlyText('Flex 1').color('white').p('s2'),
                    ).bg('blue500').rounded('sm').flex(1),
                    FlyBox(
                      child: FlyText('Flex 1').color('white').p('s2'),
                    ).bg('green500').rounded('sm').flex(1),
                    FlyBox(
                      child: FlyText('Flex 1').color('white').p('s2'),
                    ).bg('purple500').rounded('sm').flex(1),
                  ],
                ).row().gap('s1').mb('s4'),

                // Different flex values
                FlyBox(
                  children: [
                    FlyBox(
                      child: FlyText('Flex 1').color('white').p('s2'),
                    ).bg('red500').rounded('sm').flex(1),
                    FlyBox(
                      child: FlyText('Flex 2').color('white').p('s2'),
                    ).bg('yellow500').rounded('sm').flex(2),
                    FlyBox(
                      child: FlyText('Flex 1').color('white').p('s2'),
                    ).bg('teal500').rounded('sm').flex(1),
                  ],
                ).row().gap('s1').mb('s4'),

                // Auto flex
                FlyBox(
                  children: [
                    FlyBox(
                      child: FlyText('Fixed').color('white').p('s2'),
                    ).bg('indigo500').rounded('sm'),
                    FlyBox(
                      child: FlyText('Auto').color('white').p('s2'),
                    ).bg('pink500').rounded('sm').flex('auto'),
                    FlyBox(
                      child: FlyText('Fixed').color('white').p('s2'),
                    ).bg('cyan500').rounded('sm'),
                  ],
                ).row().gap('s1').mb('s4'),

                // None flex (fixed size)
                FlyBox(
                  children: [
                    FlyBox(
                      child: FlyText('Fixed').color('white').p('s2'),
                    ).bg('amber500').rounded('sm'),
                    FlyBox(
                      child: FlyText('None').color('white').p('s2'),
                    ).bg('lime500').rounded('sm').flex('none'),
                    FlyBox(
                      child: FlyText('Auto').color('white').p('s2'),
                    ).bg('emerald500').rounded('sm').flex('auto'),
                  ],
                ).row().gap('s1').mb('s4'),

                // Flex Grow Examples
                _buildSubsectionHeader('Flex Grow'),

                FlyBox(
                  children: [
                    FlyBox(
                      child: FlyText('Grow 1').color('white').p('s2'),
                    ).bg('violet500').rounded('sm').grow(1),
                    FlyBox(
                      child: FlyText('Grow 2').color('white').p('s2'),
                    ).bg('fuchsia500').rounded('sm').grow(2),
                    FlyBox(
                      child: FlyText('Grow 1').color('white').p('s2'),
                    ).bg('rose500').rounded('sm').grow(1),
                  ],
                ).row().gap('s1').mb('s4'),

                // Flex Shrink Examples
                _buildSubsectionHeader('Flex Shrink'),

                FlyBox(
                  children: [
                    FlyBox(
                      child: FlyText('No Shrink').color('white').p('s2'),
                    ).bg('sky500').rounded('sm').shrink(0),
                    FlyBox(
                      child: FlyText('Shrink 1').color('white').p('s2'),
                    ).bg('orange500').rounded('sm').shrink(1),
                    FlyBox(
                      child: FlyText('No Shrink').color('white').p('s2'),
                    ).bg('slate500').rounded('sm').shrink(0),
                  ],
                ).row().gap('s1').mb('s4'),

                // Flex Basis Examples
                _buildSubsectionHeader('Flex Basis'),

                FlyBox(
                  children: [
                    FlyBox(
                      child: FlyText('Basis s20').color('white').p('s2'),
                    ).bg('zinc500').rounded('sm').basis('s20'),
                    FlyBox(
                      child: FlyText('Basis s32').color('white').p('s2'),
                    ).bg('stone500').rounded('sm').basis('s32'),
                    FlyBox(
                      child: FlyText('Basis s24').color('white').p('s2'),
                    ).bg('neutral500').rounded('sm').basis('s24'),
                  ],
                ).row().gap('s1').mb('s4'),

                // Wrap Layout Examples
                _buildSubsectionHeader('Wrap Layout'),

                // Basic Wrap
                FlyBox(
                  children: [
                    FlyBox(
                      child: FlyText('Tag 1').color('white').p('s2'),
                    ).bg('blue500'),
                    FlyBox(
                      child: FlyText('Tag 2').color('white').p('s2'),
                    ).bg('green500'),
                    FlyBox(
                      child: FlyText('Tag 3').color('white').p('s2'),
                    ).bg('purple500'),
                    FlyBox(
                      child: FlyText('Tag 4').color('white').p('s2'),
                    ).bg('orange500'),
                    FlyBox(
                      child: FlyText('Tag 5').color('white').p('s2'),
                    ).bg('red500'),
                  ],
                ).wrap().gap('s2').bg('gray100').rounded('md').p('s4').mb('s4'),

                // Wrap with reverse
                FlyBox(
                      children: [
                        FlyBox(
                          child: FlyText('Tag 1').color('white').p('s2'),
                        ).bg('blue500'),
                        FlyBox(
                          child: FlyText('Tag 2').color('white').p('s2'),
                        ).bg('green500'),
                        FlyBox(
                          child: FlyText('Tag 3').color('white').p('s2'),
                        ).bg('purple500'),
                      ],
                    )
                    .wrap()
                    .reverse()
                    .gap('s2')
                    .bg('gray100')
                    .rounded('md')
                    .p('s4')
                    .mb('s4'),

                // Complex Layout Examples
                _buildSubsectionHeader('Complex Layout Examples'),

                // Card with header, content, and actions
                FlyBox(
                      children: [
                        FlyText(
                          'Card Title',
                        ).text('lg').weight('bold').color('white').p('s2'),
                        FlyText(
                          'This is a complex card with flex layout and multiple utilities applied.',
                        ).text('sm').color('white').leading('relaxed').p('s2'),
                        Row(
                          children: [
                            FlyText(
                              'Cancel',
                            ).color('white').p('s2').flex('none'),
                            FlyText('Save').color('white').p('s2').flex(1),
                          ],
                        ),
                      ],
                    )
                    .col()
                    .justify('between')
                    .items('stretch')
                    .gap('s2')
                    .bg('gray800')
                    .rounded('lg')
                    .p('s4')
                    .h('s48')
                    .mb('s4'),

                // Navigation bar with flex
                FlyBox(
                      children: [
                        FlyText('Logo').color('white').p('s2').flex('none'),
                        FlyText('Search').color('white').p('s2').flex('auto'),
                        FlyText('Profile').color('white').p('s2').flex('none'),
                      ],
                    )
                    .row()
                    .justify('between')
                    .items('center')
                    .gap('s3')
                    .bg('blue600')
                    .rounded('md')
                    .p('s4')
                    .mb('s4'),

                // Form layout with labels and inputs
                FlyBox(
                  children: [
                    FlyBox(
                      children: [
                        FlyText('Name:').color('white').p('s2').flex('none'),
                        FlyText('John Doe').color('white').p('s2').flex('auto'),
                      ],
                    ).row(),
                    FlyBox(
                      children: [
                        FlyText('Email:').color('white').p('s2').flex('none'),
                        FlyText(
                          'john@example.com',
                        ).color('white').p('s2').flex('auto'),
                      ],
                    ).row(),
                    FlyBox(
                      children: [
                        FlyText('Phone:').color('white').p('s2').flex('none'),
                        FlyText(
                          '+1 234 567 8900',
                        ).color('white').p('s2').flex('auto'),
                      ],
                    ).row(),
                  ],
                ).col().gap('s2').bg('green600').rounded('md').p('s4').mb('s4'),

                // Direct Flutter API Examples
                _buildSubsectionHeader('Direct Flutter API Access'),

                // Column with direct Flutter API
                FlyBox(
                      children: [
                        FlyText('Direct API Column').color('white').p('s2'),
                        FlyText('Custom Properties').color('white').p('s2'),
                      ],
                    )
                    .col(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                    )
                    .bg('red600')
                    .rounded('md')
                    .p('s4')
                    .h('s32')
                    .mb('s4'),

                // Row with direct Flutter API
                FlyBox(
                      children: [
                        FlyText('Left').color('white').p('s2'),
                        FlyText('Right').color('white').p('s2'),
                      ],
                    )
                    .row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                    )
                    .bg('purple600')
                    .rounded('md')
                    .p('s4')
                    .mb('s4'),

                // Position Examples
                _buildSubsectionHeader('Position Examples'),

                // Stack with four positioned containers
                FlyBox(
                  children: [
                    // Background container
                    FlyBox(child: FlyText('Background').color('black').p('s4'))
                        .col()
                        .justify('center')
                        .items('center')
                        .bg('gray200')
                        .rounded('md')
                        .w('s80')
                        .h('s48'),

                    // Top-left positioned container
                    FlyBox(
                      child: FlyText('Top-Left').color('white').p('s2'),
                    ).bg('red500').rounded('sm').top('s2').left('s2'),

                    // Top-right positioned container
                    FlyBox(
                      child: FlyText('Top-Right').color('white').p('s2'),
                    ).bg('blue500').rounded('sm').top('s2').right('s2'),

                    // Bottom-left positioned container
                    FlyBox(
                      child: FlyText('Bottom-Left').color('white').p('s2'),
                    ).bg('green500').rounded('sm').bottom('s2').left('s2'),

                    // Bottom-right positioned container
                    FlyBox(
                      child: FlyText('Bottom-Right').color('white').p('s2'),
                    ).bg('purple500').rounded('sm').bottom('s2').right('s2'),
                  ],
                ).stack().mb('s4'),

                // Stack with inset example
                FlyBox(
                  children: [
                    // Background container
                    FlyBox(
                          child: FlyText(
                            'Background',
                          ).color('white').p('s4').align('center'),
                        )
                        .justify('center')
                        .items('center')
                        .bg('gray200')
                        .rounded('md')
                        .w('s80')
                        .h('s48'),

                    // Inset container (fills with margin)
                    FlyBox(
                      child: FlyText('Inset').color('white').p('s2'),
                    ).bg('orange500').rounded('sm').inset('s5'),
                  ],
                ).stack().mb('s4'),
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
        FlyText(title).text('xl2').weight('bold').color('gray900').mb('s2'),
      ],
    );
  }

  Widget _buildSubsectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlyText(title).text('lg').weight('semibold').color('gray800').mb('s3'),
      ],
    );
  }
}

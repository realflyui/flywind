import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flywind/theme/color_generator.dart';
import 'package:flywind/theme/radix_colors.dart';

/// Example page to visualize Radix color generation
class RadixColorsExample extends StatefulWidget {
  const RadixColorsExample({super.key});

  @override
  State<RadixColorsExample> createState() => _RadixColorsExampleState();
}

class _RadixColorsExampleState extends State<RadixColorsExample> {
  String _appearance = 'light';
  String _accentColor = '#0090FF';
  String _grayColor = '#8B8D98';
  String _backgroundColor = '#FFFFFF';

  late RadixGeneratedColors _generatedColors;

  @override
  void initState() {
    super.initState();
    _generateColors();
  }

  void _generateColors() {
    setState(() {
      _generatedColors = RadixColorGenerator.generate(
        appearance: _appearance,
        accent: _accentColor,
        gray: _grayColor,
        background: _backgroundColor,
      );
    });
  }

  void _resetToDefaults() {
    setState(() {
      _appearance = 'light';
      _accentColor = '#0090FF';
      _grayColor = '#8B8D98';
      _backgroundColor = '#FFFFFF';
      _generateColors();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radix Color Generator'),
        backgroundColor: _generatedColors.background,
      ),
      backgroundColor: _generatedColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Controls
            _buildControls(),
            const SizedBox(height: 24),

            // Solid Colors
            _buildSectionHeader('Solid (12 steps)'),
            _buildColorScaleRow(_generatedColors.accentScale, 'Accent'),
            const SizedBox(height: 4),
            _buildColorScaleRow(_generatedColors.grayScale, 'Gray'),
            const SizedBox(height: 24),

            // Alpha Colors
            _buildSectionHeader('Alpha (12 steps)'),
            _buildColorScaleRow(_generatedColors.accentScaleAlpha, 'Accent'),
            const SizedBox(height: 4),
            _buildColorScaleRow(_generatedColors.grayScaleAlpha, 'Gray'),
            const SizedBox(height: 24),

            // Special Colors
            _buildSectionHeader('Special Colors'),
            _buildSpecialColors(),
            const SizedBox(height: 24),

            // Color Values (for comparison)
            _buildSectionHeader('Color Values (Hex)'),
            _buildColorValues(),
          ],
        ),
      ),
    );
  }

  Widget _buildControls() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Generator Controls',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                OutlinedButton.icon(
                  onPressed: _resetToDefaults,
                  icon: const Icon(Icons.refresh, size: 16),
                  label: const Text('Reset'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Appearance toggle
            Row(
              children: [
                const Text('Appearance: '),
                const SizedBox(width: 8),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'light', label: Text('Light')),
                    ButtonSegment(value: 'dark', label: Text('Dark')),
                  ],
                  selected: {_appearance},
                  onSelectionChanged: (Set<String> newSelection) {
                    setState(() {
                      _appearance = newSelection.first;
                      _backgroundColor = _appearance == 'light'
                          ? RadixGeneratorDefaults.backgroundLightHex
                          : RadixGeneratorDefaults.backgroundDarkHex;
                      _generateColors();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Accent color picker
            _buildColorPicker('Accent Color', _accentColor, (color) {
              _accentColor = color;
              _generateColors();
            }),
            const SizedBox(height: 12),

            // Gray color picker
            _buildColorPicker('Gray Color', _grayColor, (color) {
              _grayColor = color;
              _generateColors();
            }),
            const SizedBox(height: 12),

            // Background color picker
            _buildColorPicker('Background', _backgroundColor, (color) {
              _backgroundColor = color;
              _generateColors();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildColorPicker(
    String label,
    String currentColor,
    void Function(String) onColorChanged,
  ) {
    final isAccent = label == 'Accent Color';
    final isGray = label == 'Gray Color';

    // Get preset colors based on label
    final presetColors = isAccent
        ? [
            RadixColorScale.colorToHex(RadixColors.blue.step9),
            RadixColorScale.colorToHex(RadixColors.green.step9),
            RadixColorScale.colorToHex(RadixColors.red.step9),
            RadixColorScale.colorToHex(RadixColors.purple.step9),
            RadixColorScale.colorToHex(RadixColors.orange.step9),
            RadixColorScale.colorToHex(RadixColors.cyan.step9),
            RadixColorScale.colorToHex(RadixColors.violet.step9),
            RadixColorScale.colorToHex(RadixColors.pink.step9),
          ]
        : isGray
        ? [
            RadixColorScale.colorToHex(RadixColors.gray.step9),
            RadixColorScale.colorToHex(RadixColors.slate.step9),
            RadixColorScale.colorToHex(RadixColors.mauve.step9),
            RadixColorScale.colorToHex(RadixColors.sage.step9),
            RadixColorScale.colorToHex(RadixColors.olive.step9),
            RadixColorScale.colorToHex(RadixColors.sand.step9),
          ]
        : [
            RadixGeneratorDefaults.backgroundLightHex,
            RadixGeneratorDefaults.backgroundDarkHex,
            '#F5F5F5',
            '#000000',
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 100, child: Text('$label: ')),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _hexToColor(currentColor),
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: TextEditingController(text: currentColor),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                onChanged: (value) {
                  if (value.startsWith('#') && value.length == 7) {
                    onColorChanged(value);
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Preset seed buttons
        Padding(
          padding: const EdgeInsets.only(left: 108.0),
          child: Wrap(
            spacing: 4,
            runSpacing: 4,
            children: presetColors.map((color) {
              return _buildQuickColorButton(
                color,
                currentColor,
                onColorChanged,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickColorButton(
    String color,
    String currentColor,
    void Function(String) onColorChanged,
  ) {
    final isSelected = color == currentColor;
    return GestureDetector(
      onTap: () => onColorChanged(color),
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: _hexToColor(color),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildColorScaleRow(List<Color> colors, String label) {
    return Row(
      children: [
        // Label column
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        // Color swatches
        Expanded(
          child: Row(
            children: colors.asMap().entries.map((entry) {
              final index = entry.key;
              final color = entry.value;
              final hex = _colorToHex(color);
              return Expanded(
                child: Container(
                  height: 80,
                  color: color,
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: _getContrastColor(color),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        hex,
                        style: TextStyle(
                          color: _getContrastColor(color),
                          fontSize: 9,
                          fontFamily: 'monospace',
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialColors() {
    return Column(
      children: [
        _buildColorSwatch('Contrast', _generatedColors.accentContrast),
        const SizedBox(height: 8),
        _buildColorSwatch('Surface', _generatedColors.accentSurface),
        const SizedBox(height: 8),
        _buildColorSwatch('Background', _generatedColors.background),
      ],
    );
  }

  Widget _buildColorSwatch(String label, Color color) {
    return Row(
      children: [
        SizedBox(width: 100, child: Text(label)),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          _colorToHex(color),
          style: const TextStyle(fontFamily: 'monospace'),
        ),
      ],
    );
  }

  Widget _buildColorValues() {
    final map = _generatedColors.toMap();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Accent Scale:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            ...(map['accentScale'] as List).asMap().entries.map((entry) {
              return Text(
                '  ${entry.key + 1}: ${entry.value}',
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              );
            }),
            const SizedBox(height: 16),
            const Text(
              'Gray Scale:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            ...(map['grayScale'] as List).asMap().entries.map((entry) {
              return Text(
                '  ${entry.key + 1}: ${entry.value}',
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              );
            }),
            const SizedBox(height: 16),
            Text(
              'Contrast: ${map['accentContrast']}',
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
            Text(
              'Surface: ${map['accentSurface']}',
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
            Text(
              'Background: ${map['background']}',
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 3) {
      hex = hex.split('').map((c) => c + c).join('');
    }
    return Color(int.parse(hex, radix: 16) | 0xFF000000);
  }

  String _colorToHex(Color color) {
    final argb = color.toARGB32();
    final hex = argb.toRadixString(16).padLeft(8, '0');
    // Return full ARGB hex if alpha is not fully opaque, otherwise return RGB
    final alpha = hex.substring(0, 2);
    if (alpha == 'ff') {
      // Fully opaque, return RGB only
      return '#${hex.substring(2).toUpperCase()}';
    } else {
      // Has transparency, return ARGB
      return '#${hex.toUpperCase()}';
    }
  }

  Color _getContrastColor(Color color) {
    final luminance = _getLuminance(color);
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  double _getLuminance(Color color) {
    final r = (color.r * 255.0).round() / 255.0;
    final g = (color.g * 255.0).round() / 255.0;
    final b = (color.b * 255.0).round() / 255.0;

    final rLin = r <= 0.03928 ? r / 12.92 : pow((r + 0.055) / 1.055, 2.4);
    final gLin = g <= 0.03928 ? g / 12.92 : pow((g + 0.055) / 1.055, 2.4);
    final bLin = b <= 0.03928 ? b / 12.92 : pow((b + 0.055) / 1.055, 2.4);

    return 0.2126 * rLin + 0.7152 * gLin + 0.0722 * bLin;
  }
}

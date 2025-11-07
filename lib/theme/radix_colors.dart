import 'package:flutter/material.dart';

import 'radix_color_constants.dart';

/// Radix color scales accessible like Material Colors
///
/// Usage:
/// ```dart
/// // Light variant (static const Color with IDE preview)
/// RadixColors.amber1
/// RadixColors.blue9
///
/// // Dark variant (static const Color with IDE preview)
/// RadixDarkColors.amber1
/// RadixDarkColors.blue9
///
/// // Context-aware ColorScheme (auto light/dark based on theme)
/// RadixColorScheme.of(context).amber1
/// RadixColorScheme.of(context).blue9
/// ```
class RadixColors {
  RadixColors._();

  /// Get a color scale by name and mode
  static RadixColorScale _getScale(String name, bool isLight) {
    return RadixColorScale(name, isLight);
  }

  // Direct const Color properties for IDE autocomplete are in radix_color_steps_generated.dart
  // Usage: RadixColors.blue9, RadixColors.gray1, RadixColors.sage5, etc.
  // These provide autocomplete with color previews like Material colors
  // BEGIN GENERATED STEP PROPERTIES
  /// Gray step 1 (light)
  static const Color gray1 = RadixColorSteps.gray1;

  /// Gray step 2 (light)
  static const Color gray2 = RadixColorSteps.gray2;

  /// Gray step 3 (light)
  static const Color gray3 = RadixColorSteps.gray3;

  /// Gray step 4 (light)
  static const Color gray4 = RadixColorSteps.gray4;

  /// Gray step 5 (light)
  static const Color gray5 = RadixColorSteps.gray5;

  /// Gray step 6 (light)
  static const Color gray6 = RadixColorSteps.gray6;

  /// Gray step 7 (light)
  static const Color gray7 = RadixColorSteps.gray7;

  /// Gray step 8 (light)
  static const Color gray8 = RadixColorSteps.gray8;

  /// Gray step 9 (light) - base color
  static const Color gray9 = RadixColorSteps.gray9;

  /// Gray step 10 (light)
  static const Color gray10 = RadixColorSteps.gray10;

  /// Gray step 11 (light)
  static const Color gray11 = RadixColorSteps.gray11;

  /// Gray step 12 (light)
  static const Color gray12 = RadixColorSteps.gray12;

  /// Mauve step 1 (light)
  static const Color mauve1 = RadixColorSteps.mauve1;

  /// Mauve step 2 (light)
  static const Color mauve2 = RadixColorSteps.mauve2;

  /// Mauve step 3 (light)
  static const Color mauve3 = RadixColorSteps.mauve3;

  /// Mauve step 4 (light)
  static const Color mauve4 = RadixColorSteps.mauve4;

  /// Mauve step 5 (light)
  static const Color mauve5 = RadixColorSteps.mauve5;

  /// Mauve step 6 (light)
  static const Color mauve6 = RadixColorSteps.mauve6;

  /// Mauve step 7 (light)
  static const Color mauve7 = RadixColorSteps.mauve7;

  /// Mauve step 8 (light)
  static const Color mauve8 = RadixColorSteps.mauve8;

  /// Mauve step 9 (light) - base color
  static const Color mauve9 = RadixColorSteps.mauve9;

  /// Mauve step 10 (light)
  static const Color mauve10 = RadixColorSteps.mauve10;

  /// Mauve step 11 (light)
  static const Color mauve11 = RadixColorSteps.mauve11;

  /// Mauve step 12 (light)
  static const Color mauve12 = RadixColorSteps.mauve12;

  /// Slate step 1 (light)
  static const Color slate1 = RadixColorSteps.slate1;

  /// Slate step 2 (light)
  static const Color slate2 = RadixColorSteps.slate2;

  /// Slate step 3 (light)
  static const Color slate3 = RadixColorSteps.slate3;

  /// Slate step 4 (light)
  static const Color slate4 = RadixColorSteps.slate4;

  /// Slate step 5 (light)
  static const Color slate5 = RadixColorSteps.slate5;

  /// Slate step 6 (light)
  static const Color slate6 = RadixColorSteps.slate6;

  /// Slate step 7 (light)
  static const Color slate7 = RadixColorSteps.slate7;

  /// Slate step 8 (light)
  static const Color slate8 = RadixColorSteps.slate8;

  /// Slate step 9 (light) - base color
  static const Color slate9 = RadixColorSteps.slate9;

  /// Slate step 10 (light)
  static const Color slate10 = RadixColorSteps.slate10;

  /// Slate step 11 (light)
  static const Color slate11 = RadixColorSteps.slate11;

  /// Slate step 12 (light)
  static const Color slate12 = RadixColorSteps.slate12;

  /// Sage step 1 (light)
  static const Color sage1 = RadixColorSteps.sage1;

  /// Sage step 2 (light)
  static const Color sage2 = RadixColorSteps.sage2;

  /// Sage step 3 (light)
  static const Color sage3 = RadixColorSteps.sage3;

  /// Sage step 4 (light)
  static const Color sage4 = RadixColorSteps.sage4;

  /// Sage step 5 (light)
  static const Color sage5 = RadixColorSteps.sage5;

  /// Sage step 6 (light)
  static const Color sage6 = RadixColorSteps.sage6;

  /// Sage step 7 (light)
  static const Color sage7 = RadixColorSteps.sage7;

  /// Sage step 8 (light)
  static const Color sage8 = RadixColorSteps.sage8;

  /// Sage step 9 (light) - base color
  static const Color sage9 = RadixColorSteps.sage9;

  /// Sage step 10 (light)
  static const Color sage10 = RadixColorSteps.sage10;

  /// Sage step 11 (light)
  static const Color sage11 = RadixColorSteps.sage11;

  /// Sage step 12 (light)
  static const Color sage12 = RadixColorSteps.sage12;

  /// Olive step 1 (light)
  static const Color olive1 = RadixColorSteps.olive1;

  /// Olive step 2 (light)
  static const Color olive2 = RadixColorSteps.olive2;

  /// Olive step 3 (light)
  static const Color olive3 = RadixColorSteps.olive3;

  /// Olive step 4 (light)
  static const Color olive4 = RadixColorSteps.olive4;

  /// Olive step 5 (light)
  static const Color olive5 = RadixColorSteps.olive5;

  /// Olive step 6 (light)
  static const Color olive6 = RadixColorSteps.olive6;

  /// Olive step 7 (light)
  static const Color olive7 = RadixColorSteps.olive7;

  /// Olive step 8 (light)
  static const Color olive8 = RadixColorSteps.olive8;

  /// Olive step 9 (light) - base color
  static const Color olive9 = RadixColorSteps.olive9;

  /// Olive step 10 (light)
  static const Color olive10 = RadixColorSteps.olive10;

  /// Olive step 11 (light)
  static const Color olive11 = RadixColorSteps.olive11;

  /// Olive step 12 (light)
  static const Color olive12 = RadixColorSteps.olive12;

  /// Sand step 1 (light)
  static const Color sand1 = RadixColorSteps.sand1;

  /// Sand step 2 (light)
  static const Color sand2 = RadixColorSteps.sand2;

  /// Sand step 3 (light)
  static const Color sand3 = RadixColorSteps.sand3;

  /// Sand step 4 (light)
  static const Color sand4 = RadixColorSteps.sand4;

  /// Sand step 5 (light)
  static const Color sand5 = RadixColorSteps.sand5;

  /// Sand step 6 (light)
  static const Color sand6 = RadixColorSteps.sand6;

  /// Sand step 7 (light)
  static const Color sand7 = RadixColorSteps.sand7;

  /// Sand step 8 (light)
  static const Color sand8 = RadixColorSteps.sand8;

  /// Sand step 9 (light) - base color
  static const Color sand9 = RadixColorSteps.sand9;

  /// Sand step 10 (light)
  static const Color sand10 = RadixColorSteps.sand10;

  /// Sand step 11 (light)
  static const Color sand11 = RadixColorSteps.sand11;

  /// Sand step 12 (light)
  static const Color sand12 = RadixColorSteps.sand12;

  /// Tomato step 1 (light)
  static const Color tomato1 = RadixColorSteps.tomato1;

  /// Tomato step 2 (light)
  static const Color tomato2 = RadixColorSteps.tomato2;

  /// Tomato step 3 (light)
  static const Color tomato3 = RadixColorSteps.tomato3;

  /// Tomato step 4 (light)
  static const Color tomato4 = RadixColorSteps.tomato4;

  /// Tomato step 5 (light)
  static const Color tomato5 = RadixColorSteps.tomato5;

  /// Tomato step 6 (light)
  static const Color tomato6 = RadixColorSteps.tomato6;

  /// Tomato step 7 (light)
  static const Color tomato7 = RadixColorSteps.tomato7;

  /// Tomato step 8 (light)
  static const Color tomato8 = RadixColorSteps.tomato8;

  /// Tomato step 9 (light) - base color
  static const Color tomato9 = RadixColorSteps.tomato9;

  /// Tomato step 10 (light)
  static const Color tomato10 = RadixColorSteps.tomato10;

  /// Tomato step 11 (light)
  static const Color tomato11 = RadixColorSteps.tomato11;

  /// Tomato step 12 (light)
  static const Color tomato12 = RadixColorSteps.tomato12;

  /// Red step 1 (light)
  static const Color red1 = RadixColorSteps.red1;

  /// Red step 2 (light)
  static const Color red2 = RadixColorSteps.red2;

  /// Red step 3 (light)
  static const Color red3 = RadixColorSteps.red3;

  /// Red step 4 (light)
  static const Color red4 = RadixColorSteps.red4;

  /// Red step 5 (light)
  static const Color red5 = RadixColorSteps.red5;

  /// Red step 6 (light)
  static const Color red6 = RadixColorSteps.red6;

  /// Red step 7 (light)
  static const Color red7 = RadixColorSteps.red7;

  /// Red step 8 (light)
  static const Color red8 = RadixColorSteps.red8;

  /// Red step 9 (light) - base color
  static const Color red9 = RadixColorSteps.red9;

  /// Red step 10 (light)
  static const Color red10 = RadixColorSteps.red10;

  /// Red step 11 (light)
  static const Color red11 = RadixColorSteps.red11;

  /// Red step 12 (light)
  static const Color red12 = RadixColorSteps.red12;

  /// Ruby step 1 (light)
  static const Color ruby1 = RadixColorSteps.ruby1;

  /// Ruby step 2 (light)
  static const Color ruby2 = RadixColorSteps.ruby2;

  /// Ruby step 3 (light)
  static const Color ruby3 = RadixColorSteps.ruby3;

  /// Ruby step 4 (light)
  static const Color ruby4 = RadixColorSteps.ruby4;

  /// Ruby step 5 (light)
  static const Color ruby5 = RadixColorSteps.ruby5;

  /// Ruby step 6 (light)
  static const Color ruby6 = RadixColorSteps.ruby6;

  /// Ruby step 7 (light)
  static const Color ruby7 = RadixColorSteps.ruby7;

  /// Ruby step 8 (light)
  static const Color ruby8 = RadixColorSteps.ruby8;

  /// Ruby step 9 (light) - base color
  static const Color ruby9 = RadixColorSteps.ruby9;

  /// Ruby step 10 (light)
  static const Color ruby10 = RadixColorSteps.ruby10;

  /// Ruby step 11 (light)
  static const Color ruby11 = RadixColorSteps.ruby11;

  /// Ruby step 12 (light)
  static const Color ruby12 = RadixColorSteps.ruby12;

  /// Crimson step 1 (light)
  static const Color crimson1 = RadixColorSteps.crimson1;

  /// Crimson step 2 (light)
  static const Color crimson2 = RadixColorSteps.crimson2;

  /// Crimson step 3 (light)
  static const Color crimson3 = RadixColorSteps.crimson3;

  /// Crimson step 4 (light)
  static const Color crimson4 = RadixColorSteps.crimson4;

  /// Crimson step 5 (light)
  static const Color crimson5 = RadixColorSteps.crimson5;

  /// Crimson step 6 (light)
  static const Color crimson6 = RadixColorSteps.crimson6;

  /// Crimson step 7 (light)
  static const Color crimson7 = RadixColorSteps.crimson7;

  /// Crimson step 8 (light)
  static const Color crimson8 = RadixColorSteps.crimson8;

  /// Crimson step 9 (light) - base color
  static const Color crimson9 = RadixColorSteps.crimson9;

  /// Crimson step 10 (light)
  static const Color crimson10 = RadixColorSteps.crimson10;

  /// Crimson step 11 (light)
  static const Color crimson11 = RadixColorSteps.crimson11;

  /// Crimson step 12 (light)
  static const Color crimson12 = RadixColorSteps.crimson12;

  /// Pink step 1 (light)
  static const Color pink1 = RadixColorSteps.pink1;

  /// Pink step 2 (light)
  static const Color pink2 = RadixColorSteps.pink2;

  /// Pink step 3 (light)
  static const Color pink3 = RadixColorSteps.pink3;

  /// Pink step 4 (light)
  static const Color pink4 = RadixColorSteps.pink4;

  /// Pink step 5 (light)
  static const Color pink5 = RadixColorSteps.pink5;

  /// Pink step 6 (light)
  static const Color pink6 = RadixColorSteps.pink6;

  /// Pink step 7 (light)
  static const Color pink7 = RadixColorSteps.pink7;

  /// Pink step 8 (light)
  static const Color pink8 = RadixColorSteps.pink8;

  /// Pink step 9 (light) - base color
  static const Color pink9 = RadixColorSteps.pink9;

  /// Pink step 10 (light)
  static const Color pink10 = RadixColorSteps.pink10;

  /// Pink step 11 (light)
  static const Color pink11 = RadixColorSteps.pink11;

  /// Pink step 12 (light)
  static const Color pink12 = RadixColorSteps.pink12;

  /// Plum step 1 (light)
  static const Color plum1 = RadixColorSteps.plum1;

  /// Plum step 2 (light)
  static const Color plum2 = RadixColorSteps.plum2;

  /// Plum step 3 (light)
  static const Color plum3 = RadixColorSteps.plum3;

  /// Plum step 4 (light)
  static const Color plum4 = RadixColorSteps.plum4;

  /// Plum step 5 (light)
  static const Color plum5 = RadixColorSteps.plum5;

  /// Plum step 6 (light)
  static const Color plum6 = RadixColorSteps.plum6;

  /// Plum step 7 (light)
  static const Color plum7 = RadixColorSteps.plum7;

  /// Plum step 8 (light)
  static const Color plum8 = RadixColorSteps.plum8;

  /// Plum step 9 (light) - base color
  static const Color plum9 = RadixColorSteps.plum9;

  /// Plum step 10 (light)
  static const Color plum10 = RadixColorSteps.plum10;

  /// Plum step 11 (light)
  static const Color plum11 = RadixColorSteps.plum11;

  /// Plum step 12 (light)
  static const Color plum12 = RadixColorSteps.plum12;

  /// Purple step 1 (light)
  static const Color purple1 = RadixColorSteps.purple1;

  /// Purple step 2 (light)
  static const Color purple2 = RadixColorSteps.purple2;

  /// Purple step 3 (light)
  static const Color purple3 = RadixColorSteps.purple3;

  /// Purple step 4 (light)
  static const Color purple4 = RadixColorSteps.purple4;

  /// Purple step 5 (light)
  static const Color purple5 = RadixColorSteps.purple5;

  /// Purple step 6 (light)
  static const Color purple6 = RadixColorSteps.purple6;

  /// Purple step 7 (light)
  static const Color purple7 = RadixColorSteps.purple7;

  /// Purple step 8 (light)
  static const Color purple8 = RadixColorSteps.purple8;

  /// Purple step 9 (light) - base color
  static const Color purple9 = RadixColorSteps.purple9;

  /// Purple step 10 (light)
  static const Color purple10 = RadixColorSteps.purple10;

  /// Purple step 11 (light)
  static const Color purple11 = RadixColorSteps.purple11;

  /// Purple step 12 (light)
  static const Color purple12 = RadixColorSteps.purple12;

  /// Violet step 1 (light)
  static const Color violet1 = RadixColorSteps.violet1;

  /// Violet step 2 (light)
  static const Color violet2 = RadixColorSteps.violet2;

  /// Violet step 3 (light)
  static const Color violet3 = RadixColorSteps.violet3;

  /// Violet step 4 (light)
  static const Color violet4 = RadixColorSteps.violet4;

  /// Violet step 5 (light)
  static const Color violet5 = RadixColorSteps.violet5;

  /// Violet step 6 (light)
  static const Color violet6 = RadixColorSteps.violet6;

  /// Violet step 7 (light)
  static const Color violet7 = RadixColorSteps.violet7;

  /// Violet step 8 (light)
  static const Color violet8 = RadixColorSteps.violet8;

  /// Violet step 9 (light) - base color
  static const Color violet9 = RadixColorSteps.violet9;

  /// Violet step 10 (light)
  static const Color violet10 = RadixColorSteps.violet10;

  /// Violet step 11 (light)
  static const Color violet11 = RadixColorSteps.violet11;

  /// Violet step 12 (light)
  static const Color violet12 = RadixColorSteps.violet12;

  /// Iris step 1 (light)
  static const Color iris1 = RadixColorSteps.iris1;

  /// Iris step 2 (light)
  static const Color iris2 = RadixColorSteps.iris2;

  /// Iris step 3 (light)
  static const Color iris3 = RadixColorSteps.iris3;

  /// Iris step 4 (light)
  static const Color iris4 = RadixColorSteps.iris4;

  /// Iris step 5 (light)
  static const Color iris5 = RadixColorSteps.iris5;

  /// Iris step 6 (light)
  static const Color iris6 = RadixColorSteps.iris6;

  /// Iris step 7 (light)
  static const Color iris7 = RadixColorSteps.iris7;

  /// Iris step 8 (light)
  static const Color iris8 = RadixColorSteps.iris8;

  /// Iris step 9 (light) - base color
  static const Color iris9 = RadixColorSteps.iris9;

  /// Iris step 10 (light)
  static const Color iris10 = RadixColorSteps.iris10;

  /// Iris step 11 (light)
  static const Color iris11 = RadixColorSteps.iris11;

  /// Iris step 12 (light)
  static const Color iris12 = RadixColorSteps.iris12;

  /// Indigo step 1 (light)
  static const Color indigo1 = RadixColorSteps.indigo1;

  /// Indigo step 2 (light)
  static const Color indigo2 = RadixColorSteps.indigo2;

  /// Indigo step 3 (light)
  static const Color indigo3 = RadixColorSteps.indigo3;

  /// Indigo step 4 (light)
  static const Color indigo4 = RadixColorSteps.indigo4;

  /// Indigo step 5 (light)
  static const Color indigo5 = RadixColorSteps.indigo5;

  /// Indigo step 6 (light)
  static const Color indigo6 = RadixColorSteps.indigo6;

  /// Indigo step 7 (light)
  static const Color indigo7 = RadixColorSteps.indigo7;

  /// Indigo step 8 (light)
  static const Color indigo8 = RadixColorSteps.indigo8;

  /// Indigo step 9 (light) - base color
  static const Color indigo9 = RadixColorSteps.indigo9;

  /// Indigo step 10 (light)
  static const Color indigo10 = RadixColorSteps.indigo10;

  /// Indigo step 11 (light)
  static const Color indigo11 = RadixColorSteps.indigo11;

  /// Indigo step 12 (light)
  static const Color indigo12 = RadixColorSteps.indigo12;

  /// Blue step 1 (light)
  static const Color blue1 = RadixColorSteps.blue1;

  /// Blue step 2 (light)
  static const Color blue2 = RadixColorSteps.blue2;

  /// Blue step 3 (light)
  static const Color blue3 = RadixColorSteps.blue3;

  /// Blue step 4 (light)
  static const Color blue4 = RadixColorSteps.blue4;

  /// Blue step 5 (light)
  static const Color blue5 = RadixColorSteps.blue5;

  /// Blue step 6 (light)
  static const Color blue6 = RadixColorSteps.blue6;

  /// Blue step 7 (light)
  static const Color blue7 = RadixColorSteps.blue7;

  /// Blue step 8 (light)
  static const Color blue8 = RadixColorSteps.blue8;

  /// Blue step 9 (light) - base color
  static const Color blue9 = RadixColorSteps.blue9;

  /// Blue step 10 (light)
  static const Color blue10 = RadixColorSteps.blue10;

  /// Blue step 11 (light)
  static const Color blue11 = RadixColorSteps.blue11;

  /// Blue step 12 (light)
  static const Color blue12 = RadixColorSteps.blue12;

  /// Cyan step 1 (light)
  static const Color cyan1 = RadixColorSteps.cyan1;

  /// Cyan step 2 (light)
  static const Color cyan2 = RadixColorSteps.cyan2;

  /// Cyan step 3 (light)
  static const Color cyan3 = RadixColorSteps.cyan3;

  /// Cyan step 4 (light)
  static const Color cyan4 = RadixColorSteps.cyan4;

  /// Cyan step 5 (light)
  static const Color cyan5 = RadixColorSteps.cyan5;

  /// Cyan step 6 (light)
  static const Color cyan6 = RadixColorSteps.cyan6;

  /// Cyan step 7 (light)
  static const Color cyan7 = RadixColorSteps.cyan7;

  /// Cyan step 8 (light)
  static const Color cyan8 = RadixColorSteps.cyan8;

  /// Cyan step 9 (light) - base color
  static const Color cyan9 = RadixColorSteps.cyan9;

  /// Cyan step 10 (light)
  static const Color cyan10 = RadixColorSteps.cyan10;

  /// Cyan step 11 (light)
  static const Color cyan11 = RadixColorSteps.cyan11;

  /// Cyan step 12 (light)
  static const Color cyan12 = RadixColorSteps.cyan12;

  /// Teal step 1 (light)
  static const Color teal1 = RadixColorSteps.teal1;

  /// Teal step 2 (light)
  static const Color teal2 = RadixColorSteps.teal2;

  /// Teal step 3 (light)
  static const Color teal3 = RadixColorSteps.teal3;

  /// Teal step 4 (light)
  static const Color teal4 = RadixColorSteps.teal4;

  /// Teal step 5 (light)
  static const Color teal5 = RadixColorSteps.teal5;

  /// Teal step 6 (light)
  static const Color teal6 = RadixColorSteps.teal6;

  /// Teal step 7 (light)
  static const Color teal7 = RadixColorSteps.teal7;

  /// Teal step 8 (light)
  static const Color teal8 = RadixColorSteps.teal8;

  /// Teal step 9 (light) - base color
  static const Color teal9 = RadixColorSteps.teal9;

  /// Teal step 10 (light)
  static const Color teal10 = RadixColorSteps.teal10;

  /// Teal step 11 (light)
  static const Color teal11 = RadixColorSteps.teal11;

  /// Teal step 12 (light)
  static const Color teal12 = RadixColorSteps.teal12;

  /// Jade step 1 (light)
  static const Color jade1 = RadixColorSteps.jade1;

  /// Jade step 2 (light)
  static const Color jade2 = RadixColorSteps.jade2;

  /// Jade step 3 (light)
  static const Color jade3 = RadixColorSteps.jade3;

  /// Jade step 4 (light)
  static const Color jade4 = RadixColorSteps.jade4;

  /// Jade step 5 (light)
  static const Color jade5 = RadixColorSteps.jade5;

  /// Jade step 6 (light)
  static const Color jade6 = RadixColorSteps.jade6;

  /// Jade step 7 (light)
  static const Color jade7 = RadixColorSteps.jade7;

  /// Jade step 8 (light)
  static const Color jade8 = RadixColorSteps.jade8;

  /// Jade step 9 (light) - base color
  static const Color jade9 = RadixColorSteps.jade9;

  /// Jade step 10 (light)
  static const Color jade10 = RadixColorSteps.jade10;

  /// Jade step 11 (light)
  static const Color jade11 = RadixColorSteps.jade11;

  /// Jade step 12 (light)
  static const Color jade12 = RadixColorSteps.jade12;

  /// Green step 1 (light)
  static const Color green1 = RadixColorSteps.green1;

  /// Green step 2 (light)
  static const Color green2 = RadixColorSteps.green2;

  /// Green step 3 (light)
  static const Color green3 = RadixColorSteps.green3;

  /// Green step 4 (light)
  static const Color green4 = RadixColorSteps.green4;

  /// Green step 5 (light)
  static const Color green5 = RadixColorSteps.green5;

  /// Green step 6 (light)
  static const Color green6 = RadixColorSteps.green6;

  /// Green step 7 (light)
  static const Color green7 = RadixColorSteps.green7;

  /// Green step 8 (light)
  static const Color green8 = RadixColorSteps.green8;

  /// Green step 9 (light) - base color
  static const Color green9 = RadixColorSteps.green9;

  /// Green step 10 (light)
  static const Color green10 = RadixColorSteps.green10;

  /// Green step 11 (light)
  static const Color green11 = RadixColorSteps.green11;

  /// Green step 12 (light)
  static const Color green12 = RadixColorSteps.green12;

  /// Grass step 1 (light)
  static const Color grass1 = RadixColorSteps.grass1;

  /// Grass step 2 (light)
  static const Color grass2 = RadixColorSteps.grass2;

  /// Grass step 3 (light)
  static const Color grass3 = RadixColorSteps.grass3;

  /// Grass step 4 (light)
  static const Color grass4 = RadixColorSteps.grass4;

  /// Grass step 5 (light)
  static const Color grass5 = RadixColorSteps.grass5;

  /// Grass step 6 (light)
  static const Color grass6 = RadixColorSteps.grass6;

  /// Grass step 7 (light)
  static const Color grass7 = RadixColorSteps.grass7;

  /// Grass step 8 (light)
  static const Color grass8 = RadixColorSteps.grass8;

  /// Grass step 9 (light) - base color
  static const Color grass9 = RadixColorSteps.grass9;

  /// Grass step 10 (light)
  static const Color grass10 = RadixColorSteps.grass10;

  /// Grass step 11 (light)
  static const Color grass11 = RadixColorSteps.grass11;

  /// Grass step 12 (light)
  static const Color grass12 = RadixColorSteps.grass12;

  /// Brown step 1 (light)
  static const Color brown1 = RadixColorSteps.brown1;

  /// Brown step 2 (light)
  static const Color brown2 = RadixColorSteps.brown2;

  /// Brown step 3 (light)
  static const Color brown3 = RadixColorSteps.brown3;

  /// Brown step 4 (light)
  static const Color brown4 = RadixColorSteps.brown4;

  /// Brown step 5 (light)
  static const Color brown5 = RadixColorSteps.brown5;

  /// Brown step 6 (light)
  static const Color brown6 = RadixColorSteps.brown6;

  /// Brown step 7 (light)
  static const Color brown7 = RadixColorSteps.brown7;

  /// Brown step 8 (light)
  static const Color brown8 = RadixColorSteps.brown8;

  /// Brown step 9 (light) - base color
  static const Color brown9 = RadixColorSteps.brown9;

  /// Brown step 10 (light)
  static const Color brown10 = RadixColorSteps.brown10;

  /// Brown step 11 (light)
  static const Color brown11 = RadixColorSteps.brown11;

  /// Brown step 12 (light)
  static const Color brown12 = RadixColorSteps.brown12;

  /// Orange step 1 (light)
  static const Color orange1 = RadixColorSteps.orange1;

  /// Orange step 2 (light)
  static const Color orange2 = RadixColorSteps.orange2;

  /// Orange step 3 (light)
  static const Color orange3 = RadixColorSteps.orange3;

  /// Orange step 4 (light)
  static const Color orange4 = RadixColorSteps.orange4;

  /// Orange step 5 (light)
  static const Color orange5 = RadixColorSteps.orange5;

  /// Orange step 6 (light)
  static const Color orange6 = RadixColorSteps.orange6;

  /// Orange step 7 (light)
  static const Color orange7 = RadixColorSteps.orange7;

  /// Orange step 8 (light)
  static const Color orange8 = RadixColorSteps.orange8;

  /// Orange step 9 (light) - base color
  static const Color orange9 = RadixColorSteps.orange9;

  /// Orange step 10 (light)
  static const Color orange10 = RadixColorSteps.orange10;

  /// Orange step 11 (light)
  static const Color orange11 = RadixColorSteps.orange11;

  /// Orange step 12 (light)
  static const Color orange12 = RadixColorSteps.orange12;

  /// Sky step 1 (light)
  static const Color sky1 = RadixColorSteps.sky1;

  /// Sky step 2 (light)
  static const Color sky2 = RadixColorSteps.sky2;

  /// Sky step 3 (light)
  static const Color sky3 = RadixColorSteps.sky3;

  /// Sky step 4 (light)
  static const Color sky4 = RadixColorSteps.sky4;

  /// Sky step 5 (light)
  static const Color sky5 = RadixColorSteps.sky5;

  /// Sky step 6 (light)
  static const Color sky6 = RadixColorSteps.sky6;

  /// Sky step 7 (light)
  static const Color sky7 = RadixColorSteps.sky7;

  /// Sky step 8 (light)
  static const Color sky8 = RadixColorSteps.sky8;

  /// Sky step 9 (light) - base color
  static const Color sky9 = RadixColorSteps.sky9;

  /// Sky step 10 (light)
  static const Color sky10 = RadixColorSteps.sky10;

  /// Sky step 11 (light)
  static const Color sky11 = RadixColorSteps.sky11;

  /// Sky step 12 (light)
  static const Color sky12 = RadixColorSteps.sky12;

  /// Mint step 1 (light)
  static const Color mint1 = RadixColorSteps.mint1;

  /// Mint step 2 (light)
  static const Color mint2 = RadixColorSteps.mint2;

  /// Mint step 3 (light)
  static const Color mint3 = RadixColorSteps.mint3;

  /// Mint step 4 (light)
  static const Color mint4 = RadixColorSteps.mint4;

  /// Mint step 5 (light)
  static const Color mint5 = RadixColorSteps.mint5;

  /// Mint step 6 (light)
  static const Color mint6 = RadixColorSteps.mint6;

  /// Mint step 7 (light)
  static const Color mint7 = RadixColorSteps.mint7;

  /// Mint step 8 (light)
  static const Color mint8 = RadixColorSteps.mint8;

  /// Mint step 9 (light) - base color
  static const Color mint9 = RadixColorSteps.mint9;

  /// Mint step 10 (light)
  static const Color mint10 = RadixColorSteps.mint10;

  /// Mint step 11 (light)
  static const Color mint11 = RadixColorSteps.mint11;

  /// Mint step 12 (light)
  static const Color mint12 = RadixColorSteps.mint12;

  /// Lime step 1 (light)
  static const Color lime1 = RadixColorSteps.lime1;

  /// Lime step 2 (light)
  static const Color lime2 = RadixColorSteps.lime2;

  /// Lime step 3 (light)
  static const Color lime3 = RadixColorSteps.lime3;

  /// Lime step 4 (light)
  static const Color lime4 = RadixColorSteps.lime4;

  /// Lime step 5 (light)
  static const Color lime5 = RadixColorSteps.lime5;

  /// Lime step 6 (light)
  static const Color lime6 = RadixColorSteps.lime6;

  /// Lime step 7 (light)
  static const Color lime7 = RadixColorSteps.lime7;

  /// Lime step 8 (light)
  static const Color lime8 = RadixColorSteps.lime8;

  /// Lime step 9 (light) - base color
  static const Color lime9 = RadixColorSteps.lime9;

  /// Lime step 10 (light)
  static const Color lime10 = RadixColorSteps.lime10;

  /// Lime step 11 (light)
  static const Color lime11 = RadixColorSteps.lime11;

  /// Lime step 12 (light)
  static const Color lime12 = RadixColorSteps.lime12;

  /// Yellow step 1 (light)
  static const Color yellow1 = RadixColorSteps.yellow1;

  /// Yellow step 2 (light)
  static const Color yellow2 = RadixColorSteps.yellow2;

  /// Yellow step 3 (light)
  static const Color yellow3 = RadixColorSteps.yellow3;

  /// Yellow step 4 (light)
  static const Color yellow4 = RadixColorSteps.yellow4;

  /// Yellow step 5 (light)
  static const Color yellow5 = RadixColorSteps.yellow5;

  /// Yellow step 6 (light)
  static const Color yellow6 = RadixColorSteps.yellow6;

  /// Yellow step 7 (light)
  static const Color yellow7 = RadixColorSteps.yellow7;

  /// Yellow step 8 (light)
  static const Color yellow8 = RadixColorSteps.yellow8;

  /// Yellow step 9 (light) - base color
  static const Color yellow9 = RadixColorSteps.yellow9;

  /// Yellow step 10 (light)
  static const Color yellow10 = RadixColorSteps.yellow10;

  /// Yellow step 11 (light)
  static const Color yellow11 = RadixColorSteps.yellow11;

  /// Yellow step 12 (light)
  static const Color yellow12 = RadixColorSteps.yellow12;

  /// Amber step 1 (light)
  static const Color amber1 = RadixColorSteps.amber1;

  /// Amber step 2 (light)
  static const Color amber2 = RadixColorSteps.amber2;

  /// Amber step 3 (light)
  static const Color amber3 = RadixColorSteps.amber3;

  /// Amber step 4 (light)
  static const Color amber4 = RadixColorSteps.amber4;

  /// Amber step 5 (light)
  static const Color amber5 = RadixColorSteps.amber5;

  /// Amber step 6 (light)
  static const Color amber6 = RadixColorSteps.amber6;

  /// Amber step 7 (light)
  static const Color amber7 = RadixColorSteps.amber7;

  /// Amber step 8 (light)
  static const Color amber8 = RadixColorSteps.amber8;

  /// Amber step 9 (light) - base color
  static const Color amber9 = RadixColorSteps.amber9;

  /// Amber step 10 (light)
  static const Color amber10 = RadixColorSteps.amber10;

  /// Amber step 11 (light)
  static const Color amber11 = RadixColorSteps.amber11;

  /// Amber step 12 (light)
  static const Color amber12 = RadixColorSteps.amber12;

  // END GENERATED STEP PROPERTIES

  /// Gray color scale (light)
  static RadixColorScale get gray => _getScale('gray', true);

  /// Mauve color scale (light)
  static RadixColorScale get mauve => _getScale('mauve', true);

  /// Slate color scale (light)
  static RadixColorScale get slate => _getScale('slate', true);

  /// Sage color scale (light)
  static RadixColorScale get sage => _getScale('sage', true);

  /// Olive color scale (light)
  static RadixColorScale get olive => _getScale('olive', true);

  /// Sand color scale (light)
  static RadixColorScale get sand => _getScale('sand', true);

  /// Tomato color scale (light)
  static RadixColorScale get tomato => _getScale('tomato', true);

  /// Red color scale (light)
  static RadixColorScale get red => _getScale('red', true);

  /// Ruby color scale (light)
  static RadixColorScale get ruby => _getScale('ruby', true);

  /// Crimson color scale (light)
  static RadixColorScale get crimson => _getScale('crimson', true);

  /// Pink color scale (light)
  static RadixColorScale get pink => _getScale('pink', true);

  /// Plum color scale (light)
  static RadixColorScale get plum => _getScale('plum', true);

  /// Purple color scale (light)
  static RadixColorScale get purple => _getScale('purple', true);

  /// Violet color scale (light)
  static RadixColorScale get violet => _getScale('violet', true);

  /// Iris color scale (light)
  static RadixColorScale get iris => _getScale('iris', true);

  /// Indigo color scale (light)
  static RadixColorScale get indigo => _getScale('indigo', true);

  /// Blue color scale (light)
  static RadixColorScale get blue => _getScale('blue', true);

  /// Cyan color scale (light)
  static RadixColorScale get cyan => _getScale('cyan', true);

  /// Teal color scale (light)
  static RadixColorScale get teal => _getScale('teal', true);

  /// Jade color scale (light)
  static RadixColorScale get jade => _getScale('jade', true);

  /// Green color scale (light)
  static RadixColorScale get green => _getScale('green', true);

  /// Grass color scale (light)
  static RadixColorScale get grass => _getScale('grass', true);

  /// Brown color scale (light)
  static RadixColorScale get brown => _getScale('brown', true);

  /// Orange color scale (light)
  static RadixColorScale get orange => _getScale('orange', true);

  /// Sky color scale (light)
  static RadixColorScale get sky => _getScale('sky', true);

  /// Mint color scale (light)
  static RadixColorScale get mint => _getScale('mint', true);

  /// Lime color scale (light)
  static RadixColorScale get lime => _getScale('lime', true);

  /// Yellow color scale (light)
  static RadixColorScale get yellow => _getScale('yellow', true);

  /// Amber color scale (light)
  static RadixColorScale get amber => _getScale('amber', true);
}

/// Dark mode Radix colors (static const Color with IDE previews)
///
/// Usage:
/// ```dart
/// RadixDarkColors.amber1
/// RadixDarkColors.blue9
/// ```
class RadixDarkColors {
  RadixDarkColors._();

  /// Gray color scale (dark)
  RadixColorScale get gray => RadixColors._getScale('gray', false);

  /// Mauve color scale (dark)
  RadixColorScale get mauve => RadixColors._getScale('mauve', false);

  /// Slate color scale (dark)
  RadixColorScale get slate => RadixColors._getScale('slate', false);

  /// Sage color scale (dark)
  RadixColorScale get sage => RadixColors._getScale('sage', false);

  /// Olive color scale (dark)
  RadixColorScale get olive => RadixColors._getScale('olive', false);

  /// Sand color scale (dark)
  RadixColorScale get sand => RadixColors._getScale('sand', false);

  /// Tomato color scale (dark)
  RadixColorScale get tomato => RadixColors._getScale('tomato', false);

  /// Red color scale (dark)
  RadixColorScale get red => RadixColors._getScale('red', false);

  /// Ruby color scale (dark)
  RadixColorScale get ruby => RadixColors._getScale('ruby', false);

  /// Crimson color scale (dark)
  RadixColorScale get crimson => RadixColors._getScale('crimson', false);

  /// Pink color scale (dark)
  RadixColorScale get pink => RadixColors._getScale('pink', false);

  /// Plum color scale (dark)
  RadixColorScale get plum => RadixColors._getScale('plum', false);

  /// Purple color scale (dark)
  RadixColorScale get purple => RadixColors._getScale('purple', false);

  /// Violet color scale (dark)
  RadixColorScale get violet => RadixColors._getScale('violet', false);

  /// Iris color scale (dark)
  RadixColorScale get iris => RadixColors._getScale('iris', false);

  /// Indigo color scale (dark)
  RadixColorScale get indigo => RadixColors._getScale('indigo', false);

  /// Blue color scale (dark)
  RadixColorScale get blue => RadixColors._getScale('blue', false);

  /// Cyan color scale (dark)
  RadixColorScale get cyan => RadixColors._getScale('cyan', false);

  /// Teal color scale (dark)
  RadixColorScale get teal => RadixColors._getScale('teal', false);

  /// Jade color scale (dark)
  RadixColorScale get jade => RadixColors._getScale('jade', false);

  /// Green color scale (dark)
  RadixColorScale get green => RadixColors._getScale('green', false);

  /// Grass color scale (dark)
  RadixColorScale get grass => RadixColors._getScale('grass', false);

  /// Brown color scale (dark)
  RadixColorScale get brown => RadixColors._getScale('brown', false);

  /// Orange color scale (dark)
  RadixColorScale get orange => RadixColors._getScale('orange', false);

  /// Sky color scale (dark)
  RadixColorScale get sky => RadixColors._getScale('sky', false);

  /// Mint color scale (dark)
  RadixColorScale get mint => RadixColors._getScale('mint', false);

  /// Lime color scale (dark)
  RadixColorScale get lime => RadixColors._getScale('lime', false);

  /// Yellow color scale (dark)
  RadixColorScale get yellow => RadixColors._getScale('yellow', false);

  /// Amber color scale (dark)
  RadixColorScale get amber => RadixColors._getScale('amber', false);

  // BEGIN GENERATED DARK STEP PROPERTIES
  /// Gray step 1 (dark)
  static const Color gray1 = RadixColorSteps.darkGray1;

  /// Gray step 2 (dark)
  static const Color gray2 = RadixColorSteps.darkGray2;

  /// Gray step 3 (dark)
  static const Color gray3 = RadixColorSteps.darkGray3;

  /// Gray step 4 (dark)
  static const Color gray4 = RadixColorSteps.darkGray4;

  /// Gray step 5 (dark)
  static const Color gray5 = RadixColorSteps.darkGray5;

  /// Gray step 6 (dark)
  static const Color gray6 = RadixColorSteps.darkGray6;

  /// Gray step 7 (dark)
  static const Color gray7 = RadixColorSteps.darkGray7;

  /// Gray step 8 (dark)
  static const Color gray8 = RadixColorSteps.darkGray8;

  /// Gray step 9 (dark) - base color
  static const Color gray9 = RadixColorSteps.darkGray9;

  /// Gray step 10 (dark)
  static const Color gray10 = RadixColorSteps.darkGray10;

  /// Gray step 11 (dark)
  static const Color gray11 = RadixColorSteps.darkGray11;

  /// Gray step 12 (dark)
  static const Color gray12 = RadixColorSteps.darkGray12;

  /// Mauve step 1 (dark)
  static const Color mauve1 = RadixColorSteps.darkMauve1;

  /// Mauve step 2 (dark)
  static const Color mauve2 = RadixColorSteps.darkMauve2;

  /// Mauve step 3 (dark)
  static const Color mauve3 = RadixColorSteps.darkMauve3;

  /// Mauve step 4 (dark)
  static const Color mauve4 = RadixColorSteps.darkMauve4;

  /// Mauve step 5 (dark)
  static const Color mauve5 = RadixColorSteps.darkMauve5;

  /// Mauve step 6 (dark)
  static const Color mauve6 = RadixColorSteps.darkMauve6;

  /// Mauve step 7 (dark)
  static const Color mauve7 = RadixColorSteps.darkMauve7;

  /// Mauve step 8 (dark)
  static const Color mauve8 = RadixColorSteps.darkMauve8;

  /// Mauve step 9 (dark) - base color
  static const Color mauve9 = RadixColorSteps.darkMauve9;

  /// Mauve step 10 (dark)
  static const Color mauve10 = RadixColorSteps.darkMauve10;

  /// Mauve step 11 (dark)
  static const Color mauve11 = RadixColorSteps.darkMauve11;

  /// Mauve step 12 (dark)
  static const Color mauve12 = RadixColorSteps.darkMauve12;

  /// Slate step 1 (dark)
  static const Color slate1 = RadixColorSteps.darkSlate1;

  /// Slate step 2 (dark)
  static const Color slate2 = RadixColorSteps.darkSlate2;

  /// Slate step 3 (dark)
  static const Color slate3 = RadixColorSteps.darkSlate3;

  /// Slate step 4 (dark)
  static const Color slate4 = RadixColorSteps.darkSlate4;

  /// Slate step 5 (dark)
  static const Color slate5 = RadixColorSteps.darkSlate5;

  /// Slate step 6 (dark)
  static const Color slate6 = RadixColorSteps.darkSlate6;

  /// Slate step 7 (dark)
  static const Color slate7 = RadixColorSteps.darkSlate7;

  /// Slate step 8 (dark)
  static const Color slate8 = RadixColorSteps.darkSlate8;

  /// Slate step 9 (dark) - base color
  static const Color slate9 = RadixColorSteps.darkSlate9;

  /// Slate step 10 (dark)
  static const Color slate10 = RadixColorSteps.darkSlate10;

  /// Slate step 11 (dark)
  static const Color slate11 = RadixColorSteps.darkSlate11;

  /// Slate step 12 (dark)
  static const Color slate12 = RadixColorSteps.darkSlate12;

  /// Sage step 1 (dark)
  static const Color sage1 = RadixColorSteps.darkSage1;

  /// Sage step 2 (dark)
  static const Color sage2 = RadixColorSteps.darkSage2;

  /// Sage step 3 (dark)
  static const Color sage3 = RadixColorSteps.darkSage3;

  /// Sage step 4 (dark)
  static const Color sage4 = RadixColorSteps.darkSage4;

  /// Sage step 5 (dark)
  static const Color sage5 = RadixColorSteps.darkSage5;

  /// Sage step 6 (dark)
  static const Color sage6 = RadixColorSteps.darkSage6;

  /// Sage step 7 (dark)
  static const Color sage7 = RadixColorSteps.darkSage7;

  /// Sage step 8 (dark)
  static const Color sage8 = RadixColorSteps.darkSage8;

  /// Sage step 9 (dark) - base color
  static const Color sage9 = RadixColorSteps.darkSage9;

  /// Sage step 10 (dark)
  static const Color sage10 = RadixColorSteps.darkSage10;

  /// Sage step 11 (dark)
  static const Color sage11 = RadixColorSteps.darkSage11;

  /// Sage step 12 (dark)
  static const Color sage12 = RadixColorSteps.darkSage12;

  /// Olive step 1 (dark)
  static const Color olive1 = RadixColorSteps.darkOlive1;

  /// Olive step 2 (dark)
  static const Color olive2 = RadixColorSteps.darkOlive2;

  /// Olive step 3 (dark)
  static const Color olive3 = RadixColorSteps.darkOlive3;

  /// Olive step 4 (dark)
  static const Color olive4 = RadixColorSteps.darkOlive4;

  /// Olive step 5 (dark)
  static const Color olive5 = RadixColorSteps.darkOlive5;

  /// Olive step 6 (dark)
  static const Color olive6 = RadixColorSteps.darkOlive6;

  /// Olive step 7 (dark)
  static const Color olive7 = RadixColorSteps.darkOlive7;

  /// Olive step 8 (dark)
  static const Color olive8 = RadixColorSteps.darkOlive8;

  /// Olive step 9 (dark) - base color
  static const Color olive9 = RadixColorSteps.darkOlive9;

  /// Olive step 10 (dark)
  static const Color olive10 = RadixColorSteps.darkOlive10;

  /// Olive step 11 (dark)
  static const Color olive11 = RadixColorSteps.darkOlive11;

  /// Olive step 12 (dark)
  static const Color olive12 = RadixColorSteps.darkOlive12;

  /// Sand step 1 (dark)
  static const Color sand1 = RadixColorSteps.darkSand1;

  /// Sand step 2 (dark)
  static const Color sand2 = RadixColorSteps.darkSand2;

  /// Sand step 3 (dark)
  static const Color sand3 = RadixColorSteps.darkSand3;

  /// Sand step 4 (dark)
  static const Color sand4 = RadixColorSteps.darkSand4;

  /// Sand step 5 (dark)
  static const Color sand5 = RadixColorSteps.darkSand5;

  /// Sand step 6 (dark)
  static const Color sand6 = RadixColorSteps.darkSand6;

  /// Sand step 7 (dark)
  static const Color sand7 = RadixColorSteps.darkSand7;

  /// Sand step 8 (dark)
  static const Color sand8 = RadixColorSteps.darkSand8;

  /// Sand step 9 (dark) - base color
  static const Color sand9 = RadixColorSteps.darkSand9;

  /// Sand step 10 (dark)
  static const Color sand10 = RadixColorSteps.darkSand10;

  /// Sand step 11 (dark)
  static const Color sand11 = RadixColorSteps.darkSand11;

  /// Sand step 12 (dark)
  static const Color sand12 = RadixColorSteps.darkSand12;

  /// Tomato step 1 (dark)
  static const Color tomato1 = RadixColorSteps.darkTomato1;

  /// Tomato step 2 (dark)
  static const Color tomato2 = RadixColorSteps.darkTomato2;

  /// Tomato step 3 (dark)
  static const Color tomato3 = RadixColorSteps.darkTomato3;

  /// Tomato step 4 (dark)
  static const Color tomato4 = RadixColorSteps.darkTomato4;

  /// Tomato step 5 (dark)
  static const Color tomato5 = RadixColorSteps.darkTomato5;

  /// Tomato step 6 (dark)
  static const Color tomato6 = RadixColorSteps.darkTomato6;

  /// Tomato step 7 (dark)
  static const Color tomato7 = RadixColorSteps.darkTomato7;

  /// Tomato step 8 (dark)
  static const Color tomato8 = RadixColorSteps.darkTomato8;

  /// Tomato step 9 (dark) - base color
  static const Color tomato9 = RadixColorSteps.darkTomato9;

  /// Tomato step 10 (dark)
  static const Color tomato10 = RadixColorSteps.darkTomato10;

  /// Tomato step 11 (dark)
  static const Color tomato11 = RadixColorSteps.darkTomato11;

  /// Tomato step 12 (dark)
  static const Color tomato12 = RadixColorSteps.darkTomato12;

  /// Red step 1 (dark)
  static const Color red1 = RadixColorSteps.darkRed1;

  /// Red step 2 (dark)
  static const Color red2 = RadixColorSteps.darkRed2;

  /// Red step 3 (dark)
  static const Color red3 = RadixColorSteps.darkRed3;

  /// Red step 4 (dark)
  static const Color red4 = RadixColorSteps.darkRed4;

  /// Red step 5 (dark)
  static const Color red5 = RadixColorSteps.darkRed5;

  /// Red step 6 (dark)
  static const Color red6 = RadixColorSteps.darkRed6;

  /// Red step 7 (dark)
  static const Color red7 = RadixColorSteps.darkRed7;

  /// Red step 8 (dark)
  static const Color red8 = RadixColorSteps.darkRed8;

  /// Red step 9 (dark) - base color
  static const Color red9 = RadixColorSteps.darkRed9;

  /// Red step 10 (dark)
  static const Color red10 = RadixColorSteps.darkRed10;

  /// Red step 11 (dark)
  static const Color red11 = RadixColorSteps.darkRed11;

  /// Red step 12 (dark)
  static const Color red12 = RadixColorSteps.darkRed12;

  /// Ruby step 1 (dark)
  static const Color ruby1 = RadixColorSteps.darkRuby1;

  /// Ruby step 2 (dark)
  static const Color ruby2 = RadixColorSteps.darkRuby2;

  /// Ruby step 3 (dark)
  static const Color ruby3 = RadixColorSteps.darkRuby3;

  /// Ruby step 4 (dark)
  static const Color ruby4 = RadixColorSteps.darkRuby4;

  /// Ruby step 5 (dark)
  static const Color ruby5 = RadixColorSteps.darkRuby5;

  /// Ruby step 6 (dark)
  static const Color ruby6 = RadixColorSteps.darkRuby6;

  /// Ruby step 7 (dark)
  static const Color ruby7 = RadixColorSteps.darkRuby7;

  /// Ruby step 8 (dark)
  static const Color ruby8 = RadixColorSteps.darkRuby8;

  /// Ruby step 9 (dark) - base color
  static const Color ruby9 = RadixColorSteps.darkRuby9;

  /// Ruby step 10 (dark)
  static const Color ruby10 = RadixColorSteps.darkRuby10;

  /// Ruby step 11 (dark)
  static const Color ruby11 = RadixColorSteps.darkRuby11;

  /// Ruby step 12 (dark)
  static const Color ruby12 = RadixColorSteps.darkRuby12;

  /// Crimson step 1 (dark)
  static const Color crimson1 = RadixColorSteps.darkCrimson1;

  /// Crimson step 2 (dark)
  static const Color crimson2 = RadixColorSteps.darkCrimson2;

  /// Crimson step 3 (dark)
  static const Color crimson3 = RadixColorSteps.darkCrimson3;

  /// Crimson step 4 (dark)
  static const Color crimson4 = RadixColorSteps.darkCrimson4;

  /// Crimson step 5 (dark)
  static const Color crimson5 = RadixColorSteps.darkCrimson5;

  /// Crimson step 6 (dark)
  static const Color crimson6 = RadixColorSteps.darkCrimson6;

  /// Crimson step 7 (dark)
  static const Color crimson7 = RadixColorSteps.darkCrimson7;

  /// Crimson step 8 (dark)
  static const Color crimson8 = RadixColorSteps.darkCrimson8;

  /// Crimson step 9 (dark) - base color
  static const Color crimson9 = RadixColorSteps.darkCrimson9;

  /// Crimson step 10 (dark)
  static const Color crimson10 = RadixColorSteps.darkCrimson10;

  /// Crimson step 11 (dark)
  static const Color crimson11 = RadixColorSteps.darkCrimson11;

  /// Crimson step 12 (dark)
  static const Color crimson12 = RadixColorSteps.darkCrimson12;

  /// Pink step 1 (dark)
  static const Color pink1 = RadixColorSteps.darkPink1;

  /// Pink step 2 (dark)
  static const Color pink2 = RadixColorSteps.darkPink2;

  /// Pink step 3 (dark)
  static const Color pink3 = RadixColorSteps.darkPink3;

  /// Pink step 4 (dark)
  static const Color pink4 = RadixColorSteps.darkPink4;

  /// Pink step 5 (dark)
  static const Color pink5 = RadixColorSteps.darkPink5;

  /// Pink step 6 (dark)
  static const Color pink6 = RadixColorSteps.darkPink6;

  /// Pink step 7 (dark)
  static const Color pink7 = RadixColorSteps.darkPink7;

  /// Pink step 8 (dark)
  static const Color pink8 = RadixColorSteps.darkPink8;

  /// Pink step 9 (dark) - base color
  static const Color pink9 = RadixColorSteps.darkPink9;

  /// Pink step 10 (dark)
  static const Color pink10 = RadixColorSteps.darkPink10;

  /// Pink step 11 (dark)
  static const Color pink11 = RadixColorSteps.darkPink11;

  /// Pink step 12 (dark)
  static const Color pink12 = RadixColorSteps.darkPink12;

  /// Plum step 1 (dark)
  static const Color plum1 = RadixColorSteps.darkPlum1;

  /// Plum step 2 (dark)
  static const Color plum2 = RadixColorSteps.darkPlum2;

  /// Plum step 3 (dark)
  static const Color plum3 = RadixColorSteps.darkPlum3;

  /// Plum step 4 (dark)
  static const Color plum4 = RadixColorSteps.darkPlum4;

  /// Plum step 5 (dark)
  static const Color plum5 = RadixColorSteps.darkPlum5;

  /// Plum step 6 (dark)
  static const Color plum6 = RadixColorSteps.darkPlum6;

  /// Plum step 7 (dark)
  static const Color plum7 = RadixColorSteps.darkPlum7;

  /// Plum step 8 (dark)
  static const Color plum8 = RadixColorSteps.darkPlum8;

  /// Plum step 9 (dark) - base color
  static const Color plum9 = RadixColorSteps.darkPlum9;

  /// Plum step 10 (dark)
  static const Color plum10 = RadixColorSteps.darkPlum10;

  /// Plum step 11 (dark)
  static const Color plum11 = RadixColorSteps.darkPlum11;

  /// Plum step 12 (dark)
  static const Color plum12 = RadixColorSteps.darkPlum12;

  /// Purple step 1 (dark)
  static const Color purple1 = RadixColorSteps.darkPurple1;

  /// Purple step 2 (dark)
  static const Color purple2 = RadixColorSteps.darkPurple2;

  /// Purple step 3 (dark)
  static const Color purple3 = RadixColorSteps.darkPurple3;

  /// Purple step 4 (dark)
  static const Color purple4 = RadixColorSteps.darkPurple4;

  /// Purple step 5 (dark)
  static const Color purple5 = RadixColorSteps.darkPurple5;

  /// Purple step 6 (dark)
  static const Color purple6 = RadixColorSteps.darkPurple6;

  /// Purple step 7 (dark)
  static const Color purple7 = RadixColorSteps.darkPurple7;

  /// Purple step 8 (dark)
  static const Color purple8 = RadixColorSteps.darkPurple8;

  /// Purple step 9 (dark) - base color
  static const Color purple9 = RadixColorSteps.darkPurple9;

  /// Purple step 10 (dark)
  static const Color purple10 = RadixColorSteps.darkPurple10;

  /// Purple step 11 (dark)
  static const Color purple11 = RadixColorSteps.darkPurple11;

  /// Purple step 12 (dark)
  static const Color purple12 = RadixColorSteps.darkPurple12;

  /// Violet step 1 (dark)
  static const Color violet1 = RadixColorSteps.darkViolet1;

  /// Violet step 2 (dark)
  static const Color violet2 = RadixColorSteps.darkViolet2;

  /// Violet step 3 (dark)
  static const Color violet3 = RadixColorSteps.darkViolet3;

  /// Violet step 4 (dark)
  static const Color violet4 = RadixColorSteps.darkViolet4;

  /// Violet step 5 (dark)
  static const Color violet5 = RadixColorSteps.darkViolet5;

  /// Violet step 6 (dark)
  static const Color violet6 = RadixColorSteps.darkViolet6;

  /// Violet step 7 (dark)
  static const Color violet7 = RadixColorSteps.darkViolet7;

  /// Violet step 8 (dark)
  static const Color violet8 = RadixColorSteps.darkViolet8;

  /// Violet step 9 (dark) - base color
  static const Color violet9 = RadixColorSteps.darkViolet9;

  /// Violet step 10 (dark)
  static const Color violet10 = RadixColorSteps.darkViolet10;

  /// Violet step 11 (dark)
  static const Color violet11 = RadixColorSteps.darkViolet11;

  /// Violet step 12 (dark)
  static const Color violet12 = RadixColorSteps.darkViolet12;

  /// Iris step 1 (dark)
  static const Color iris1 = RadixColorSteps.darkIris1;

  /// Iris step 2 (dark)
  static const Color iris2 = RadixColorSteps.darkIris2;

  /// Iris step 3 (dark)
  static const Color iris3 = RadixColorSteps.darkIris3;

  /// Iris step 4 (dark)
  static const Color iris4 = RadixColorSteps.darkIris4;

  /// Iris step 5 (dark)
  static const Color iris5 = RadixColorSteps.darkIris5;

  /// Iris step 6 (dark)
  static const Color iris6 = RadixColorSteps.darkIris6;

  /// Iris step 7 (dark)
  static const Color iris7 = RadixColorSteps.darkIris7;

  /// Iris step 8 (dark)
  static const Color iris8 = RadixColorSteps.darkIris8;

  /// Iris step 9 (dark) - base color
  static const Color iris9 = RadixColorSteps.darkIris9;

  /// Iris step 10 (dark)
  static const Color iris10 = RadixColorSteps.darkIris10;

  /// Iris step 11 (dark)
  static const Color iris11 = RadixColorSteps.darkIris11;

  /// Iris step 12 (dark)
  static const Color iris12 = RadixColorSteps.darkIris12;

  /// Indigo step 1 (dark)
  static const Color indigo1 = RadixColorSteps.darkIndigo1;

  /// Indigo step 2 (dark)
  static const Color indigo2 = RadixColorSteps.darkIndigo2;

  /// Indigo step 3 (dark)
  static const Color indigo3 = RadixColorSteps.darkIndigo3;

  /// Indigo step 4 (dark)
  static const Color indigo4 = RadixColorSteps.darkIndigo4;

  /// Indigo step 5 (dark)
  static const Color indigo5 = RadixColorSteps.darkIndigo5;

  /// Indigo step 6 (dark)
  static const Color indigo6 = RadixColorSteps.darkIndigo6;

  /// Indigo step 7 (dark)
  static const Color indigo7 = RadixColorSteps.darkIndigo7;

  /// Indigo step 8 (dark)
  static const Color indigo8 = RadixColorSteps.darkIndigo8;

  /// Indigo step 9 (dark) - base color
  static const Color indigo9 = RadixColorSteps.darkIndigo9;

  /// Indigo step 10 (dark)
  static const Color indigo10 = RadixColorSteps.darkIndigo10;

  /// Indigo step 11 (dark)
  static const Color indigo11 = RadixColorSteps.darkIndigo11;

  /// Indigo step 12 (dark)
  static const Color indigo12 = RadixColorSteps.darkIndigo12;

  /// Blue step 1 (dark)
  static const Color blue1 = RadixColorSteps.darkBlue1;

  /// Blue step 2 (dark)
  static const Color blue2 = RadixColorSteps.darkBlue2;

  /// Blue step 3 (dark)
  static const Color blue3 = RadixColorSteps.darkBlue3;

  /// Blue step 4 (dark)
  static const Color blue4 = RadixColorSteps.darkBlue4;

  /// Blue step 5 (dark)
  static const Color blue5 = RadixColorSteps.darkBlue5;

  /// Blue step 6 (dark)
  static const Color blue6 = RadixColorSteps.darkBlue6;

  /// Blue step 7 (dark)
  static const Color blue7 = RadixColorSteps.darkBlue7;

  /// Blue step 8 (dark)
  static const Color blue8 = RadixColorSteps.darkBlue8;

  /// Blue step 9 (dark) - base color
  static const Color blue9 = RadixColorSteps.darkBlue9;

  /// Blue step 10 (dark)
  static const Color blue10 = RadixColorSteps.darkBlue10;

  /// Blue step 11 (dark)
  static const Color blue11 = RadixColorSteps.darkBlue11;

  /// Blue step 12 (dark)
  static const Color blue12 = RadixColorSteps.darkBlue12;

  /// Cyan step 1 (dark)
  static const Color cyan1 = RadixColorSteps.darkCyan1;

  /// Cyan step 2 (dark)
  static const Color cyan2 = RadixColorSteps.darkCyan2;

  /// Cyan step 3 (dark)
  static const Color cyan3 = RadixColorSteps.darkCyan3;

  /// Cyan step 4 (dark)
  static const Color cyan4 = RadixColorSteps.darkCyan4;

  /// Cyan step 5 (dark)
  static const Color cyan5 = RadixColorSteps.darkCyan5;

  /// Cyan step 6 (dark)
  static const Color cyan6 = RadixColorSteps.darkCyan6;

  /// Cyan step 7 (dark)
  static const Color cyan7 = RadixColorSteps.darkCyan7;

  /// Cyan step 8 (dark)
  static const Color cyan8 = RadixColorSteps.darkCyan8;

  /// Cyan step 9 (dark) - base color
  static const Color cyan9 = RadixColorSteps.darkCyan9;

  /// Cyan step 10 (dark)
  static const Color cyan10 = RadixColorSteps.darkCyan10;

  /// Cyan step 11 (dark)
  static const Color cyan11 = RadixColorSteps.darkCyan11;

  /// Cyan step 12 (dark)
  static const Color cyan12 = RadixColorSteps.darkCyan12;

  /// Teal step 1 (dark)
  static const Color teal1 = RadixColorSteps.darkTeal1;

  /// Teal step 2 (dark)
  static const Color teal2 = RadixColorSteps.darkTeal2;

  /// Teal step 3 (dark)
  static const Color teal3 = RadixColorSteps.darkTeal3;

  /// Teal step 4 (dark)
  static const Color teal4 = RadixColorSteps.darkTeal4;

  /// Teal step 5 (dark)
  static const Color teal5 = RadixColorSteps.darkTeal5;

  /// Teal step 6 (dark)
  static const Color teal6 = RadixColorSteps.darkTeal6;

  /// Teal step 7 (dark)
  static const Color teal7 = RadixColorSteps.darkTeal7;

  /// Teal step 8 (dark)
  static const Color teal8 = RadixColorSteps.darkTeal8;

  /// Teal step 9 (dark) - base color
  static const Color teal9 = RadixColorSteps.darkTeal9;

  /// Teal step 10 (dark)
  static const Color teal10 = RadixColorSteps.darkTeal10;

  /// Teal step 11 (dark)
  static const Color teal11 = RadixColorSteps.darkTeal11;

  /// Teal step 12 (dark)
  static const Color teal12 = RadixColorSteps.darkTeal12;

  /// Jade step 1 (dark)
  static const Color jade1 = RadixColorSteps.darkJade1;

  /// Jade step 2 (dark)
  static const Color jade2 = RadixColorSteps.darkJade2;

  /// Jade step 3 (dark)
  static const Color jade3 = RadixColorSteps.darkJade3;

  /// Jade step 4 (dark)
  static const Color jade4 = RadixColorSteps.darkJade4;

  /// Jade step 5 (dark)
  static const Color jade5 = RadixColorSteps.darkJade5;

  /// Jade step 6 (dark)
  static const Color jade6 = RadixColorSteps.darkJade6;

  /// Jade step 7 (dark)
  static const Color jade7 = RadixColorSteps.darkJade7;

  /// Jade step 8 (dark)
  static const Color jade8 = RadixColorSteps.darkJade8;

  /// Jade step 9 (dark) - base color
  static const Color jade9 = RadixColorSteps.darkJade9;

  /// Jade step 10 (dark)
  static const Color jade10 = RadixColorSteps.darkJade10;

  /// Jade step 11 (dark)
  static const Color jade11 = RadixColorSteps.darkJade11;

  /// Jade step 12 (dark)
  static const Color jade12 = RadixColorSteps.darkJade12;

  /// Green step 1 (dark)
  static const Color green1 = RadixColorSteps.darkGreen1;

  /// Green step 2 (dark)
  static const Color green2 = RadixColorSteps.darkGreen2;

  /// Green step 3 (dark)
  static const Color green3 = RadixColorSteps.darkGreen3;

  /// Green step 4 (dark)
  static const Color green4 = RadixColorSteps.darkGreen4;

  /// Green step 5 (dark)
  static const Color green5 = RadixColorSteps.darkGreen5;

  /// Green step 6 (dark)
  static const Color green6 = RadixColorSteps.darkGreen6;

  /// Green step 7 (dark)
  static const Color green7 = RadixColorSteps.darkGreen7;

  /// Green step 8 (dark)
  static const Color green8 = RadixColorSteps.darkGreen8;

  /// Green step 9 (dark) - base color
  static const Color green9 = RadixColorSteps.darkGreen9;

  /// Green step 10 (dark)
  static const Color green10 = RadixColorSteps.darkGreen10;

  /// Green step 11 (dark)
  static const Color green11 = RadixColorSteps.darkGreen11;

  /// Green step 12 (dark)
  static const Color green12 = RadixColorSteps.darkGreen12;

  /// Grass step 1 (dark)
  static const Color grass1 = RadixColorSteps.darkGrass1;

  /// Grass step 2 (dark)
  static const Color grass2 = RadixColorSteps.darkGrass2;

  /// Grass step 3 (dark)
  static const Color grass3 = RadixColorSteps.darkGrass3;

  /// Grass step 4 (dark)
  static const Color grass4 = RadixColorSteps.darkGrass4;

  /// Grass step 5 (dark)
  static const Color grass5 = RadixColorSteps.darkGrass5;

  /// Grass step 6 (dark)
  static const Color grass6 = RadixColorSteps.darkGrass6;

  /// Grass step 7 (dark)
  static const Color grass7 = RadixColorSteps.darkGrass7;

  /// Grass step 8 (dark)
  static const Color grass8 = RadixColorSteps.darkGrass8;

  /// Grass step 9 (dark) - base color
  static const Color grass9 = RadixColorSteps.darkGrass9;

  /// Grass step 10 (dark)
  static const Color grass10 = RadixColorSteps.darkGrass10;

  /// Grass step 11 (dark)
  static const Color grass11 = RadixColorSteps.darkGrass11;

  /// Grass step 12 (dark)
  static const Color grass12 = RadixColorSteps.darkGrass12;

  /// Brown step 1 (dark)
  static const Color brown1 = RadixColorSteps.darkBrown1;

  /// Brown step 2 (dark)
  static const Color brown2 = RadixColorSteps.darkBrown2;

  /// Brown step 3 (dark)
  static const Color brown3 = RadixColorSteps.darkBrown3;

  /// Brown step 4 (dark)
  static const Color brown4 = RadixColorSteps.darkBrown4;

  /// Brown step 5 (dark)
  static const Color brown5 = RadixColorSteps.darkBrown5;

  /// Brown step 6 (dark)
  static const Color brown6 = RadixColorSteps.darkBrown6;

  /// Brown step 7 (dark)
  static const Color brown7 = RadixColorSteps.darkBrown7;

  /// Brown step 8 (dark)
  static const Color brown8 = RadixColorSteps.darkBrown8;

  /// Brown step 9 (dark) - base color
  static const Color brown9 = RadixColorSteps.darkBrown9;

  /// Brown step 10 (dark)
  static const Color brown10 = RadixColorSteps.darkBrown10;

  /// Brown step 11 (dark)
  static const Color brown11 = RadixColorSteps.darkBrown11;

  /// Brown step 12 (dark)
  static const Color brown12 = RadixColorSteps.darkBrown12;

  /// Orange step 1 (dark)
  static const Color orange1 = RadixColorSteps.darkOrange1;

  /// Orange step 2 (dark)
  static const Color orange2 = RadixColorSteps.darkOrange2;

  /// Orange step 3 (dark)
  static const Color orange3 = RadixColorSteps.darkOrange3;

  /// Orange step 4 (dark)
  static const Color orange4 = RadixColorSteps.darkOrange4;

  /// Orange step 5 (dark)
  static const Color orange5 = RadixColorSteps.darkOrange5;

  /// Orange step 6 (dark)
  static const Color orange6 = RadixColorSteps.darkOrange6;

  /// Orange step 7 (dark)
  static const Color orange7 = RadixColorSteps.darkOrange7;

  /// Orange step 8 (dark)
  static const Color orange8 = RadixColorSteps.darkOrange8;

  /// Orange step 9 (dark) - base color
  static const Color orange9 = RadixColorSteps.darkOrange9;

  /// Orange step 10 (dark)
  static const Color orange10 = RadixColorSteps.darkOrange10;

  /// Orange step 11 (dark)
  static const Color orange11 = RadixColorSteps.darkOrange11;

  /// Orange step 12 (dark)
  static const Color orange12 = RadixColorSteps.darkOrange12;

  /// Sky step 1 (dark)
  static const Color sky1 = RadixColorSteps.darkSky1;

  /// Sky step 2 (dark)
  static const Color sky2 = RadixColorSteps.darkSky2;

  /// Sky step 3 (dark)
  static const Color sky3 = RadixColorSteps.darkSky3;

  /// Sky step 4 (dark)
  static const Color sky4 = RadixColorSteps.darkSky4;

  /// Sky step 5 (dark)
  static const Color sky5 = RadixColorSteps.darkSky5;

  /// Sky step 6 (dark)
  static const Color sky6 = RadixColorSteps.darkSky6;

  /// Sky step 7 (dark)
  static const Color sky7 = RadixColorSteps.darkSky7;

  /// Sky step 8 (dark)
  static const Color sky8 = RadixColorSteps.darkSky8;

  /// Sky step 9 (dark) - base color
  static const Color sky9 = RadixColorSteps.darkSky9;

  /// Sky step 10 (dark)
  static const Color sky10 = RadixColorSteps.darkSky10;

  /// Sky step 11 (dark)
  static const Color sky11 = RadixColorSteps.darkSky11;

  /// Sky step 12 (dark)
  static const Color sky12 = RadixColorSteps.darkSky12;

  /// Mint step 1 (dark)
  static const Color mint1 = RadixColorSteps.darkMint1;

  /// Mint step 2 (dark)
  static const Color mint2 = RadixColorSteps.darkMint2;

  /// Mint step 3 (dark)
  static const Color mint3 = RadixColorSteps.darkMint3;

  /// Mint step 4 (dark)
  static const Color mint4 = RadixColorSteps.darkMint4;

  /// Mint step 5 (dark)
  static const Color mint5 = RadixColorSteps.darkMint5;

  /// Mint step 6 (dark)
  static const Color mint6 = RadixColorSteps.darkMint6;

  /// Mint step 7 (dark)
  static const Color mint7 = RadixColorSteps.darkMint7;

  /// Mint step 8 (dark)
  static const Color mint8 = RadixColorSteps.darkMint8;

  /// Mint step 9 (dark) - base color
  static const Color mint9 = RadixColorSteps.darkMint9;

  /// Mint step 10 (dark)
  static const Color mint10 = RadixColorSteps.darkMint10;

  /// Mint step 11 (dark)
  static const Color mint11 = RadixColorSteps.darkMint11;

  /// Mint step 12 (dark)
  static const Color mint12 = RadixColorSteps.darkMint12;

  /// Lime step 1 (dark)
  static const Color lime1 = RadixColorSteps.darkLime1;

  /// Lime step 2 (dark)
  static const Color lime2 = RadixColorSteps.darkLime2;

  /// Lime step 3 (dark)
  static const Color lime3 = RadixColorSteps.darkLime3;

  /// Lime step 4 (dark)
  static const Color lime4 = RadixColorSteps.darkLime4;

  /// Lime step 5 (dark)
  static const Color lime5 = RadixColorSteps.darkLime5;

  /// Lime step 6 (dark)
  static const Color lime6 = RadixColorSteps.darkLime6;

  /// Lime step 7 (dark)
  static const Color lime7 = RadixColorSteps.darkLime7;

  /// Lime step 8 (dark)
  static const Color lime8 = RadixColorSteps.darkLime8;

  /// Lime step 9 (dark) - base color
  static const Color lime9 = RadixColorSteps.darkLime9;

  /// Lime step 10 (dark)
  static const Color lime10 = RadixColorSteps.darkLime10;

  /// Lime step 11 (dark)
  static const Color lime11 = RadixColorSteps.darkLime11;

  /// Lime step 12 (dark)
  static const Color lime12 = RadixColorSteps.darkLime12;

  /// Yellow step 1 (dark)
  static const Color yellow1 = RadixColorSteps.darkYellow1;

  /// Yellow step 2 (dark)
  static const Color yellow2 = RadixColorSteps.darkYellow2;

  /// Yellow step 3 (dark)
  static const Color yellow3 = RadixColorSteps.darkYellow3;

  /// Yellow step 4 (dark)
  static const Color yellow4 = RadixColorSteps.darkYellow4;

  /// Yellow step 5 (dark)
  static const Color yellow5 = RadixColorSteps.darkYellow5;

  /// Yellow step 6 (dark)
  static const Color yellow6 = RadixColorSteps.darkYellow6;

  /// Yellow step 7 (dark)
  static const Color yellow7 = RadixColorSteps.darkYellow7;

  /// Yellow step 8 (dark)
  static const Color yellow8 = RadixColorSteps.darkYellow8;

  /// Yellow step 9 (dark) - base color
  static const Color yellow9 = RadixColorSteps.darkYellow9;

  /// Yellow step 10 (dark)
  static const Color yellow10 = RadixColorSteps.darkYellow10;

  /// Yellow step 11 (dark)
  static const Color yellow11 = RadixColorSteps.darkYellow11;

  /// Yellow step 12 (dark)
  static const Color yellow12 = RadixColorSteps.darkYellow12;

  /// Amber step 1 (dark)
  static const Color amber1 = RadixColorSteps.darkAmber1;

  /// Amber step 2 (dark)
  static const Color amber2 = RadixColorSteps.darkAmber2;

  /// Amber step 3 (dark)
  static const Color amber3 = RadixColorSteps.darkAmber3;

  /// Amber step 4 (dark)
  static const Color amber4 = RadixColorSteps.darkAmber4;

  /// Amber step 5 (dark)
  static const Color amber5 = RadixColorSteps.darkAmber5;

  /// Amber step 6 (dark)
  static const Color amber6 = RadixColorSteps.darkAmber6;

  /// Amber step 7 (dark)
  static const Color amber7 = RadixColorSteps.darkAmber7;

  /// Amber step 8 (dark)
  static const Color amber8 = RadixColorSteps.darkAmber8;

  /// Amber step 9 (dark) - base color
  static const Color amber9 = RadixColorSteps.darkAmber9;

  /// Amber step 10 (dark)
  static const Color amber10 = RadixColorSteps.darkAmber10;

  /// Amber step 11 (dark)
  static const Color amber11 = RadixColorSteps.darkAmber11;

  /// Amber step 12 (dark)
  static const Color amber12 = RadixColorSteps.darkAmber12;

  // END GENERATED DARK STEP PROPERTIES
}

/// Context-aware Radix ColorScheme that auto-resolves light/dark based on theme
///
/// Similar to Material's ColorScheme, this provides theme-aware colors.
///
/// Usage:
/// ```dart
/// RadixColorScheme.of(context).amber1  // Auto light/dark based on theme
/// RadixColorScheme.of(context).blue9
/// ```
class RadixColorScheme {
  final BuildContext context;

  RadixColorScheme._(this.context);

  /// Get the RadixColorScheme for the given context
  ///
  /// Similar to Material's `Theme.of(context).colorScheme`
  static RadixColorScheme of(BuildContext context) {
    return RadixColorScheme._(context);
  }

  /// Check if current theme is light
  bool get _isLight {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.light;
  }

  // BEGIN GENERATED CONTEXT STEP PROPERTIES
  /// Gray step 1 (context-aware)
  Color get gray1 =>
      _isLight ? RadixColorSteps.gray1 : RadixColorSteps.darkGray1;

  /// Gray step 2 (context-aware)
  Color get gray2 =>
      _isLight ? RadixColorSteps.gray2 : RadixColorSteps.darkGray2;

  /// Gray step 3 (context-aware)
  Color get gray3 =>
      _isLight ? RadixColorSteps.gray3 : RadixColorSteps.darkGray3;

  /// Gray step 4 (context-aware)
  Color get gray4 =>
      _isLight ? RadixColorSteps.gray4 : RadixColorSteps.darkGray4;

  /// Gray step 5 (context-aware)
  Color get gray5 =>
      _isLight ? RadixColorSteps.gray5 : RadixColorSteps.darkGray5;

  /// Gray step 6 (context-aware)
  Color get gray6 =>
      _isLight ? RadixColorSteps.gray6 : RadixColorSteps.darkGray6;

  /// Gray step 7 (context-aware)
  Color get gray7 =>
      _isLight ? RadixColorSteps.gray7 : RadixColorSteps.darkGray7;

  /// Gray step 8 (context-aware)
  Color get gray8 =>
      _isLight ? RadixColorSteps.gray8 : RadixColorSteps.darkGray8;

  /// Gray step 9 (context-aware) - base color
  Color get gray9 =>
      _isLight ? RadixColorSteps.gray9 : RadixColorSteps.darkGray9;

  /// Gray step 10 (context-aware)
  Color get gray10 =>
      _isLight ? RadixColorSteps.gray10 : RadixColorSteps.darkGray10;

  /// Gray step 11 (context-aware)
  Color get gray11 =>
      _isLight ? RadixColorSteps.gray11 : RadixColorSteps.darkGray11;

  /// Gray step 12 (context-aware)
  Color get gray12 =>
      _isLight ? RadixColorSteps.gray12 : RadixColorSteps.darkGray12;

  /// Mauve step 1 (context-aware)
  Color get mauve1 =>
      _isLight ? RadixColorSteps.mauve1 : RadixColorSteps.darkMauve1;

  /// Mauve step 2 (context-aware)
  Color get mauve2 =>
      _isLight ? RadixColorSteps.mauve2 : RadixColorSteps.darkMauve2;

  /// Mauve step 3 (context-aware)
  Color get mauve3 =>
      _isLight ? RadixColorSteps.mauve3 : RadixColorSteps.darkMauve3;

  /// Mauve step 4 (context-aware)
  Color get mauve4 =>
      _isLight ? RadixColorSteps.mauve4 : RadixColorSteps.darkMauve4;

  /// Mauve step 5 (context-aware)
  Color get mauve5 =>
      _isLight ? RadixColorSteps.mauve5 : RadixColorSteps.darkMauve5;

  /// Mauve step 6 (context-aware)
  Color get mauve6 =>
      _isLight ? RadixColorSteps.mauve6 : RadixColorSteps.darkMauve6;

  /// Mauve step 7 (context-aware)
  Color get mauve7 =>
      _isLight ? RadixColorSteps.mauve7 : RadixColorSteps.darkMauve7;

  /// Mauve step 8 (context-aware)
  Color get mauve8 =>
      _isLight ? RadixColorSteps.mauve8 : RadixColorSteps.darkMauve8;

  /// Mauve step 9 (context-aware) - base color
  Color get mauve9 =>
      _isLight ? RadixColorSteps.mauve9 : RadixColorSteps.darkMauve9;

  /// Mauve step 10 (context-aware)
  Color get mauve10 =>
      _isLight ? RadixColorSteps.mauve10 : RadixColorSteps.darkMauve10;

  /// Mauve step 11 (context-aware)
  Color get mauve11 =>
      _isLight ? RadixColorSteps.mauve11 : RadixColorSteps.darkMauve11;

  /// Mauve step 12 (context-aware)
  Color get mauve12 =>
      _isLight ? RadixColorSteps.mauve12 : RadixColorSteps.darkMauve12;

  /// Slate step 1 (context-aware)
  Color get slate1 =>
      _isLight ? RadixColorSteps.slate1 : RadixColorSteps.darkSlate1;

  /// Slate step 2 (context-aware)
  Color get slate2 =>
      _isLight ? RadixColorSteps.slate2 : RadixColorSteps.darkSlate2;

  /// Slate step 3 (context-aware)
  Color get slate3 =>
      _isLight ? RadixColorSteps.slate3 : RadixColorSteps.darkSlate3;

  /// Slate step 4 (context-aware)
  Color get slate4 =>
      _isLight ? RadixColorSteps.slate4 : RadixColorSteps.darkSlate4;

  /// Slate step 5 (context-aware)
  Color get slate5 =>
      _isLight ? RadixColorSteps.slate5 : RadixColorSteps.darkSlate5;

  /// Slate step 6 (context-aware)
  Color get slate6 =>
      _isLight ? RadixColorSteps.slate6 : RadixColorSteps.darkSlate6;

  /// Slate step 7 (context-aware)
  Color get slate7 =>
      _isLight ? RadixColorSteps.slate7 : RadixColorSteps.darkSlate7;

  /// Slate step 8 (context-aware)
  Color get slate8 =>
      _isLight ? RadixColorSteps.slate8 : RadixColorSteps.darkSlate8;

  /// Slate step 9 (context-aware) - base color
  Color get slate9 =>
      _isLight ? RadixColorSteps.slate9 : RadixColorSteps.darkSlate9;

  /// Slate step 10 (context-aware)
  Color get slate10 =>
      _isLight ? RadixColorSteps.slate10 : RadixColorSteps.darkSlate10;

  /// Slate step 11 (context-aware)
  Color get slate11 =>
      _isLight ? RadixColorSteps.slate11 : RadixColorSteps.darkSlate11;

  /// Slate step 12 (context-aware)
  Color get slate12 =>
      _isLight ? RadixColorSteps.slate12 : RadixColorSteps.darkSlate12;

  /// Sage step 1 (context-aware)
  Color get sage1 =>
      _isLight ? RadixColorSteps.sage1 : RadixColorSteps.darkSage1;

  /// Sage step 2 (context-aware)
  Color get sage2 =>
      _isLight ? RadixColorSteps.sage2 : RadixColorSteps.darkSage2;

  /// Sage step 3 (context-aware)
  Color get sage3 =>
      _isLight ? RadixColorSteps.sage3 : RadixColorSteps.darkSage3;

  /// Sage step 4 (context-aware)
  Color get sage4 =>
      _isLight ? RadixColorSteps.sage4 : RadixColorSteps.darkSage4;

  /// Sage step 5 (context-aware)
  Color get sage5 =>
      _isLight ? RadixColorSteps.sage5 : RadixColorSteps.darkSage5;

  /// Sage step 6 (context-aware)
  Color get sage6 =>
      _isLight ? RadixColorSteps.sage6 : RadixColorSteps.darkSage6;

  /// Sage step 7 (context-aware)
  Color get sage7 =>
      _isLight ? RadixColorSteps.sage7 : RadixColorSteps.darkSage7;

  /// Sage step 8 (context-aware)
  Color get sage8 =>
      _isLight ? RadixColorSteps.sage8 : RadixColorSteps.darkSage8;

  /// Sage step 9 (context-aware) - base color
  Color get sage9 =>
      _isLight ? RadixColorSteps.sage9 : RadixColorSteps.darkSage9;

  /// Sage step 10 (context-aware)
  Color get sage10 =>
      _isLight ? RadixColorSteps.sage10 : RadixColorSteps.darkSage10;

  /// Sage step 11 (context-aware)
  Color get sage11 =>
      _isLight ? RadixColorSteps.sage11 : RadixColorSteps.darkSage11;

  /// Sage step 12 (context-aware)
  Color get sage12 =>
      _isLight ? RadixColorSteps.sage12 : RadixColorSteps.darkSage12;

  /// Olive step 1 (context-aware)
  Color get olive1 =>
      _isLight ? RadixColorSteps.olive1 : RadixColorSteps.darkOlive1;

  /// Olive step 2 (context-aware)
  Color get olive2 =>
      _isLight ? RadixColorSteps.olive2 : RadixColorSteps.darkOlive2;

  /// Olive step 3 (context-aware)
  Color get olive3 =>
      _isLight ? RadixColorSteps.olive3 : RadixColorSteps.darkOlive3;

  /// Olive step 4 (context-aware)
  Color get olive4 =>
      _isLight ? RadixColorSteps.olive4 : RadixColorSteps.darkOlive4;

  /// Olive step 5 (context-aware)
  Color get olive5 =>
      _isLight ? RadixColorSteps.olive5 : RadixColorSteps.darkOlive5;

  /// Olive step 6 (context-aware)
  Color get olive6 =>
      _isLight ? RadixColorSteps.olive6 : RadixColorSteps.darkOlive6;

  /// Olive step 7 (context-aware)
  Color get olive7 =>
      _isLight ? RadixColorSteps.olive7 : RadixColorSteps.darkOlive7;

  /// Olive step 8 (context-aware)
  Color get olive8 =>
      _isLight ? RadixColorSteps.olive8 : RadixColorSteps.darkOlive8;

  /// Olive step 9 (context-aware) - base color
  Color get olive9 =>
      _isLight ? RadixColorSteps.olive9 : RadixColorSteps.darkOlive9;

  /// Olive step 10 (context-aware)
  Color get olive10 =>
      _isLight ? RadixColorSteps.olive10 : RadixColorSteps.darkOlive10;

  /// Olive step 11 (context-aware)
  Color get olive11 =>
      _isLight ? RadixColorSteps.olive11 : RadixColorSteps.darkOlive11;

  /// Olive step 12 (context-aware)
  Color get olive12 =>
      _isLight ? RadixColorSteps.olive12 : RadixColorSteps.darkOlive12;

  /// Sand step 1 (context-aware)
  Color get sand1 =>
      _isLight ? RadixColorSteps.sand1 : RadixColorSteps.darkSand1;

  /// Sand step 2 (context-aware)
  Color get sand2 =>
      _isLight ? RadixColorSteps.sand2 : RadixColorSteps.darkSand2;

  /// Sand step 3 (context-aware)
  Color get sand3 =>
      _isLight ? RadixColorSteps.sand3 : RadixColorSteps.darkSand3;

  /// Sand step 4 (context-aware)
  Color get sand4 =>
      _isLight ? RadixColorSteps.sand4 : RadixColorSteps.darkSand4;

  /// Sand step 5 (context-aware)
  Color get sand5 =>
      _isLight ? RadixColorSteps.sand5 : RadixColorSteps.darkSand5;

  /// Sand step 6 (context-aware)
  Color get sand6 =>
      _isLight ? RadixColorSteps.sand6 : RadixColorSteps.darkSand6;

  /// Sand step 7 (context-aware)
  Color get sand7 =>
      _isLight ? RadixColorSteps.sand7 : RadixColorSteps.darkSand7;

  /// Sand step 8 (context-aware)
  Color get sand8 =>
      _isLight ? RadixColorSteps.sand8 : RadixColorSteps.darkSand8;

  /// Sand step 9 (context-aware) - base color
  Color get sand9 =>
      _isLight ? RadixColorSteps.sand9 : RadixColorSteps.darkSand9;

  /// Sand step 10 (context-aware)
  Color get sand10 =>
      _isLight ? RadixColorSteps.sand10 : RadixColorSteps.darkSand10;

  /// Sand step 11 (context-aware)
  Color get sand11 =>
      _isLight ? RadixColorSteps.sand11 : RadixColorSteps.darkSand11;

  /// Sand step 12 (context-aware)
  Color get sand12 =>
      _isLight ? RadixColorSteps.sand12 : RadixColorSteps.darkSand12;

  /// Tomato step 1 (context-aware)
  Color get tomato1 =>
      _isLight ? RadixColorSteps.tomato1 : RadixColorSteps.darkTomato1;

  /// Tomato step 2 (context-aware)
  Color get tomato2 =>
      _isLight ? RadixColorSteps.tomato2 : RadixColorSteps.darkTomato2;

  /// Tomato step 3 (context-aware)
  Color get tomato3 =>
      _isLight ? RadixColorSteps.tomato3 : RadixColorSteps.darkTomato3;

  /// Tomato step 4 (context-aware)
  Color get tomato4 =>
      _isLight ? RadixColorSteps.tomato4 : RadixColorSteps.darkTomato4;

  /// Tomato step 5 (context-aware)
  Color get tomato5 =>
      _isLight ? RadixColorSteps.tomato5 : RadixColorSteps.darkTomato5;

  /// Tomato step 6 (context-aware)
  Color get tomato6 =>
      _isLight ? RadixColorSteps.tomato6 : RadixColorSteps.darkTomato6;

  /// Tomato step 7 (context-aware)
  Color get tomato7 =>
      _isLight ? RadixColorSteps.tomato7 : RadixColorSteps.darkTomato7;

  /// Tomato step 8 (context-aware)
  Color get tomato8 =>
      _isLight ? RadixColorSteps.tomato8 : RadixColorSteps.darkTomato8;

  /// Tomato step 9 (context-aware) - base color
  Color get tomato9 =>
      _isLight ? RadixColorSteps.tomato9 : RadixColorSteps.darkTomato9;

  /// Tomato step 10 (context-aware)
  Color get tomato10 =>
      _isLight ? RadixColorSteps.tomato10 : RadixColorSteps.darkTomato10;

  /// Tomato step 11 (context-aware)
  Color get tomato11 =>
      _isLight ? RadixColorSteps.tomato11 : RadixColorSteps.darkTomato11;

  /// Tomato step 12 (context-aware)
  Color get tomato12 =>
      _isLight ? RadixColorSteps.tomato12 : RadixColorSteps.darkTomato12;

  /// Red step 1 (context-aware)
  Color get red1 => _isLight ? RadixColorSteps.red1 : RadixColorSteps.darkRed1;

  /// Red step 2 (context-aware)
  Color get red2 => _isLight ? RadixColorSteps.red2 : RadixColorSteps.darkRed2;

  /// Red step 3 (context-aware)
  Color get red3 => _isLight ? RadixColorSteps.red3 : RadixColorSteps.darkRed3;

  /// Red step 4 (context-aware)
  Color get red4 => _isLight ? RadixColorSteps.red4 : RadixColorSteps.darkRed4;

  /// Red step 5 (context-aware)
  Color get red5 => _isLight ? RadixColorSteps.red5 : RadixColorSteps.darkRed5;

  /// Red step 6 (context-aware)
  Color get red6 => _isLight ? RadixColorSteps.red6 : RadixColorSteps.darkRed6;

  /// Red step 7 (context-aware)
  Color get red7 => _isLight ? RadixColorSteps.red7 : RadixColorSteps.darkRed7;

  /// Red step 8 (context-aware)
  Color get red8 => _isLight ? RadixColorSteps.red8 : RadixColorSteps.darkRed8;

  /// Red step 9 (context-aware) - base color
  Color get red9 => _isLight ? RadixColorSteps.red9 : RadixColorSteps.darkRed9;

  /// Red step 10 (context-aware)
  Color get red10 =>
      _isLight ? RadixColorSteps.red10 : RadixColorSteps.darkRed10;

  /// Red step 11 (context-aware)
  Color get red11 =>
      _isLight ? RadixColorSteps.red11 : RadixColorSteps.darkRed11;

  /// Red step 12 (context-aware)
  Color get red12 =>
      _isLight ? RadixColorSteps.red12 : RadixColorSteps.darkRed12;

  /// Ruby step 1 (context-aware)
  Color get ruby1 =>
      _isLight ? RadixColorSteps.ruby1 : RadixColorSteps.darkRuby1;

  /// Ruby step 2 (context-aware)
  Color get ruby2 =>
      _isLight ? RadixColorSteps.ruby2 : RadixColorSteps.darkRuby2;

  /// Ruby step 3 (context-aware)
  Color get ruby3 =>
      _isLight ? RadixColorSteps.ruby3 : RadixColorSteps.darkRuby3;

  /// Ruby step 4 (context-aware)
  Color get ruby4 =>
      _isLight ? RadixColorSteps.ruby4 : RadixColorSteps.darkRuby4;

  /// Ruby step 5 (context-aware)
  Color get ruby5 =>
      _isLight ? RadixColorSteps.ruby5 : RadixColorSteps.darkRuby5;

  /// Ruby step 6 (context-aware)
  Color get ruby6 =>
      _isLight ? RadixColorSteps.ruby6 : RadixColorSteps.darkRuby6;

  /// Ruby step 7 (context-aware)
  Color get ruby7 =>
      _isLight ? RadixColorSteps.ruby7 : RadixColorSteps.darkRuby7;

  /// Ruby step 8 (context-aware)
  Color get ruby8 =>
      _isLight ? RadixColorSteps.ruby8 : RadixColorSteps.darkRuby8;

  /// Ruby step 9 (context-aware) - base color
  Color get ruby9 =>
      _isLight ? RadixColorSteps.ruby9 : RadixColorSteps.darkRuby9;

  /// Ruby step 10 (context-aware)
  Color get ruby10 =>
      _isLight ? RadixColorSteps.ruby10 : RadixColorSteps.darkRuby10;

  /// Ruby step 11 (context-aware)
  Color get ruby11 =>
      _isLight ? RadixColorSteps.ruby11 : RadixColorSteps.darkRuby11;

  /// Ruby step 12 (context-aware)
  Color get ruby12 =>
      _isLight ? RadixColorSteps.ruby12 : RadixColorSteps.darkRuby12;

  /// Crimson step 1 (context-aware)
  Color get crimson1 =>
      _isLight ? RadixColorSteps.crimson1 : RadixColorSteps.darkCrimson1;

  /// Crimson step 2 (context-aware)
  Color get crimson2 =>
      _isLight ? RadixColorSteps.crimson2 : RadixColorSteps.darkCrimson2;

  /// Crimson step 3 (context-aware)
  Color get crimson3 =>
      _isLight ? RadixColorSteps.crimson3 : RadixColorSteps.darkCrimson3;

  /// Crimson step 4 (context-aware)
  Color get crimson4 =>
      _isLight ? RadixColorSteps.crimson4 : RadixColorSteps.darkCrimson4;

  /// Crimson step 5 (context-aware)
  Color get crimson5 =>
      _isLight ? RadixColorSteps.crimson5 : RadixColorSteps.darkCrimson5;

  /// Crimson step 6 (context-aware)
  Color get crimson6 =>
      _isLight ? RadixColorSteps.crimson6 : RadixColorSteps.darkCrimson6;

  /// Crimson step 7 (context-aware)
  Color get crimson7 =>
      _isLight ? RadixColorSteps.crimson7 : RadixColorSteps.darkCrimson7;

  /// Crimson step 8 (context-aware)
  Color get crimson8 =>
      _isLight ? RadixColorSteps.crimson8 : RadixColorSteps.darkCrimson8;

  /// Crimson step 9 (context-aware) - base color
  Color get crimson9 =>
      _isLight ? RadixColorSteps.crimson9 : RadixColorSteps.darkCrimson9;

  /// Crimson step 10 (context-aware)
  Color get crimson10 =>
      _isLight ? RadixColorSteps.crimson10 : RadixColorSteps.darkCrimson10;

  /// Crimson step 11 (context-aware)
  Color get crimson11 =>
      _isLight ? RadixColorSteps.crimson11 : RadixColorSteps.darkCrimson11;

  /// Crimson step 12 (context-aware)
  Color get crimson12 =>
      _isLight ? RadixColorSteps.crimson12 : RadixColorSteps.darkCrimson12;

  /// Pink step 1 (context-aware)
  Color get pink1 =>
      _isLight ? RadixColorSteps.pink1 : RadixColorSteps.darkPink1;

  /// Pink step 2 (context-aware)
  Color get pink2 =>
      _isLight ? RadixColorSteps.pink2 : RadixColorSteps.darkPink2;

  /// Pink step 3 (context-aware)
  Color get pink3 =>
      _isLight ? RadixColorSteps.pink3 : RadixColorSteps.darkPink3;

  /// Pink step 4 (context-aware)
  Color get pink4 =>
      _isLight ? RadixColorSteps.pink4 : RadixColorSteps.darkPink4;

  /// Pink step 5 (context-aware)
  Color get pink5 =>
      _isLight ? RadixColorSteps.pink5 : RadixColorSteps.darkPink5;

  /// Pink step 6 (context-aware)
  Color get pink6 =>
      _isLight ? RadixColorSteps.pink6 : RadixColorSteps.darkPink6;

  /// Pink step 7 (context-aware)
  Color get pink7 =>
      _isLight ? RadixColorSteps.pink7 : RadixColorSteps.darkPink7;

  /// Pink step 8 (context-aware)
  Color get pink8 =>
      _isLight ? RadixColorSteps.pink8 : RadixColorSteps.darkPink8;

  /// Pink step 9 (context-aware) - base color
  Color get pink9 =>
      _isLight ? RadixColorSteps.pink9 : RadixColorSteps.darkPink9;

  /// Pink step 10 (context-aware)
  Color get pink10 =>
      _isLight ? RadixColorSteps.pink10 : RadixColorSteps.darkPink10;

  /// Pink step 11 (context-aware)
  Color get pink11 =>
      _isLight ? RadixColorSteps.pink11 : RadixColorSteps.darkPink11;

  /// Pink step 12 (context-aware)
  Color get pink12 =>
      _isLight ? RadixColorSteps.pink12 : RadixColorSteps.darkPink12;

  /// Plum step 1 (context-aware)
  Color get plum1 =>
      _isLight ? RadixColorSteps.plum1 : RadixColorSteps.darkPlum1;

  /// Plum step 2 (context-aware)
  Color get plum2 =>
      _isLight ? RadixColorSteps.plum2 : RadixColorSteps.darkPlum2;

  /// Plum step 3 (context-aware)
  Color get plum3 =>
      _isLight ? RadixColorSteps.plum3 : RadixColorSteps.darkPlum3;

  /// Plum step 4 (context-aware)
  Color get plum4 =>
      _isLight ? RadixColorSteps.plum4 : RadixColorSteps.darkPlum4;

  /// Plum step 5 (context-aware)
  Color get plum5 =>
      _isLight ? RadixColorSteps.plum5 : RadixColorSteps.darkPlum5;

  /// Plum step 6 (context-aware)
  Color get plum6 =>
      _isLight ? RadixColorSteps.plum6 : RadixColorSteps.darkPlum6;

  /// Plum step 7 (context-aware)
  Color get plum7 =>
      _isLight ? RadixColorSteps.plum7 : RadixColorSteps.darkPlum7;

  /// Plum step 8 (context-aware)
  Color get plum8 =>
      _isLight ? RadixColorSteps.plum8 : RadixColorSteps.darkPlum8;

  /// Plum step 9 (context-aware) - base color
  Color get plum9 =>
      _isLight ? RadixColorSteps.plum9 : RadixColorSteps.darkPlum9;

  /// Plum step 10 (context-aware)
  Color get plum10 =>
      _isLight ? RadixColorSteps.plum10 : RadixColorSteps.darkPlum10;

  /// Plum step 11 (context-aware)
  Color get plum11 =>
      _isLight ? RadixColorSteps.plum11 : RadixColorSteps.darkPlum11;

  /// Plum step 12 (context-aware)
  Color get plum12 =>
      _isLight ? RadixColorSteps.plum12 : RadixColorSteps.darkPlum12;

  /// Purple step 1 (context-aware)
  Color get purple1 =>
      _isLight ? RadixColorSteps.purple1 : RadixColorSteps.darkPurple1;

  /// Purple step 2 (context-aware)
  Color get purple2 =>
      _isLight ? RadixColorSteps.purple2 : RadixColorSteps.darkPurple2;

  /// Purple step 3 (context-aware)
  Color get purple3 =>
      _isLight ? RadixColorSteps.purple3 : RadixColorSteps.darkPurple3;

  /// Purple step 4 (context-aware)
  Color get purple4 =>
      _isLight ? RadixColorSteps.purple4 : RadixColorSteps.darkPurple4;

  /// Purple step 5 (context-aware)
  Color get purple5 =>
      _isLight ? RadixColorSteps.purple5 : RadixColorSteps.darkPurple5;

  /// Purple step 6 (context-aware)
  Color get purple6 =>
      _isLight ? RadixColorSteps.purple6 : RadixColorSteps.darkPurple6;

  /// Purple step 7 (context-aware)
  Color get purple7 =>
      _isLight ? RadixColorSteps.purple7 : RadixColorSteps.darkPurple7;

  /// Purple step 8 (context-aware)
  Color get purple8 =>
      _isLight ? RadixColorSteps.purple8 : RadixColorSteps.darkPurple8;

  /// Purple step 9 (context-aware) - base color
  Color get purple9 =>
      _isLight ? RadixColorSteps.purple9 : RadixColorSteps.darkPurple9;

  /// Purple step 10 (context-aware)
  Color get purple10 =>
      _isLight ? RadixColorSteps.purple10 : RadixColorSteps.darkPurple10;

  /// Purple step 11 (context-aware)
  Color get purple11 =>
      _isLight ? RadixColorSteps.purple11 : RadixColorSteps.darkPurple11;

  /// Purple step 12 (context-aware)
  Color get purple12 =>
      _isLight ? RadixColorSteps.purple12 : RadixColorSteps.darkPurple12;

  /// Violet step 1 (context-aware)
  Color get violet1 =>
      _isLight ? RadixColorSteps.violet1 : RadixColorSteps.darkViolet1;

  /// Violet step 2 (context-aware)
  Color get violet2 =>
      _isLight ? RadixColorSteps.violet2 : RadixColorSteps.darkViolet2;

  /// Violet step 3 (context-aware)
  Color get violet3 =>
      _isLight ? RadixColorSteps.violet3 : RadixColorSteps.darkViolet3;

  /// Violet step 4 (context-aware)
  Color get violet4 =>
      _isLight ? RadixColorSteps.violet4 : RadixColorSteps.darkViolet4;

  /// Violet step 5 (context-aware)
  Color get violet5 =>
      _isLight ? RadixColorSteps.violet5 : RadixColorSteps.darkViolet5;

  /// Violet step 6 (context-aware)
  Color get violet6 =>
      _isLight ? RadixColorSteps.violet6 : RadixColorSteps.darkViolet6;

  /// Violet step 7 (context-aware)
  Color get violet7 =>
      _isLight ? RadixColorSteps.violet7 : RadixColorSteps.darkViolet7;

  /// Violet step 8 (context-aware)
  Color get violet8 =>
      _isLight ? RadixColorSteps.violet8 : RadixColorSteps.darkViolet8;

  /// Violet step 9 (context-aware) - base color
  Color get violet9 =>
      _isLight ? RadixColorSteps.violet9 : RadixColorSteps.darkViolet9;

  /// Violet step 10 (context-aware)
  Color get violet10 =>
      _isLight ? RadixColorSteps.violet10 : RadixColorSteps.darkViolet10;

  /// Violet step 11 (context-aware)
  Color get violet11 =>
      _isLight ? RadixColorSteps.violet11 : RadixColorSteps.darkViolet11;

  /// Violet step 12 (context-aware)
  Color get violet12 =>
      _isLight ? RadixColorSteps.violet12 : RadixColorSteps.darkViolet12;

  /// Iris step 1 (context-aware)
  Color get iris1 =>
      _isLight ? RadixColorSteps.iris1 : RadixColorSteps.darkIris1;

  /// Iris step 2 (context-aware)
  Color get iris2 =>
      _isLight ? RadixColorSteps.iris2 : RadixColorSteps.darkIris2;

  /// Iris step 3 (context-aware)
  Color get iris3 =>
      _isLight ? RadixColorSteps.iris3 : RadixColorSteps.darkIris3;

  /// Iris step 4 (context-aware)
  Color get iris4 =>
      _isLight ? RadixColorSteps.iris4 : RadixColorSteps.darkIris4;

  /// Iris step 5 (context-aware)
  Color get iris5 =>
      _isLight ? RadixColorSteps.iris5 : RadixColorSteps.darkIris5;

  /// Iris step 6 (context-aware)
  Color get iris6 =>
      _isLight ? RadixColorSteps.iris6 : RadixColorSteps.darkIris6;

  /// Iris step 7 (context-aware)
  Color get iris7 =>
      _isLight ? RadixColorSteps.iris7 : RadixColorSteps.darkIris7;

  /// Iris step 8 (context-aware)
  Color get iris8 =>
      _isLight ? RadixColorSteps.iris8 : RadixColorSteps.darkIris8;

  /// Iris step 9 (context-aware) - base color
  Color get iris9 =>
      _isLight ? RadixColorSteps.iris9 : RadixColorSteps.darkIris9;

  /// Iris step 10 (context-aware)
  Color get iris10 =>
      _isLight ? RadixColorSteps.iris10 : RadixColorSteps.darkIris10;

  /// Iris step 11 (context-aware)
  Color get iris11 =>
      _isLight ? RadixColorSteps.iris11 : RadixColorSteps.darkIris11;

  /// Iris step 12 (context-aware)
  Color get iris12 =>
      _isLight ? RadixColorSteps.iris12 : RadixColorSteps.darkIris12;

  /// Indigo step 1 (context-aware)
  Color get indigo1 =>
      _isLight ? RadixColorSteps.indigo1 : RadixColorSteps.darkIndigo1;

  /// Indigo step 2 (context-aware)
  Color get indigo2 =>
      _isLight ? RadixColorSteps.indigo2 : RadixColorSteps.darkIndigo2;

  /// Indigo step 3 (context-aware)
  Color get indigo3 =>
      _isLight ? RadixColorSteps.indigo3 : RadixColorSteps.darkIndigo3;

  /// Indigo step 4 (context-aware)
  Color get indigo4 =>
      _isLight ? RadixColorSteps.indigo4 : RadixColorSteps.darkIndigo4;

  /// Indigo step 5 (context-aware)
  Color get indigo5 =>
      _isLight ? RadixColorSteps.indigo5 : RadixColorSteps.darkIndigo5;

  /// Indigo step 6 (context-aware)
  Color get indigo6 =>
      _isLight ? RadixColorSteps.indigo6 : RadixColorSteps.darkIndigo6;

  /// Indigo step 7 (context-aware)
  Color get indigo7 =>
      _isLight ? RadixColorSteps.indigo7 : RadixColorSteps.darkIndigo7;

  /// Indigo step 8 (context-aware)
  Color get indigo8 =>
      _isLight ? RadixColorSteps.indigo8 : RadixColorSteps.darkIndigo8;

  /// Indigo step 9 (context-aware) - base color
  Color get indigo9 =>
      _isLight ? RadixColorSteps.indigo9 : RadixColorSteps.darkIndigo9;

  /// Indigo step 10 (context-aware)
  Color get indigo10 =>
      _isLight ? RadixColorSteps.indigo10 : RadixColorSteps.darkIndigo10;

  /// Indigo step 11 (context-aware)
  Color get indigo11 =>
      _isLight ? RadixColorSteps.indigo11 : RadixColorSteps.darkIndigo11;

  /// Indigo step 12 (context-aware)
  Color get indigo12 =>
      _isLight ? RadixColorSteps.indigo12 : RadixColorSteps.darkIndigo12;

  /// Blue step 1 (context-aware)
  Color get blue1 =>
      _isLight ? RadixColorSteps.blue1 : RadixColorSteps.darkBlue1;

  /// Blue step 2 (context-aware)
  Color get blue2 =>
      _isLight ? RadixColorSteps.blue2 : RadixColorSteps.darkBlue2;

  /// Blue step 3 (context-aware)
  Color get blue3 =>
      _isLight ? RadixColorSteps.blue3 : RadixColorSteps.darkBlue3;

  /// Blue step 4 (context-aware)
  Color get blue4 =>
      _isLight ? RadixColorSteps.blue4 : RadixColorSteps.darkBlue4;

  /// Blue step 5 (context-aware)
  Color get blue5 =>
      _isLight ? RadixColorSteps.blue5 : RadixColorSteps.darkBlue5;

  /// Blue step 6 (context-aware)
  Color get blue6 =>
      _isLight ? RadixColorSteps.blue6 : RadixColorSteps.darkBlue6;

  /// Blue step 7 (context-aware)
  Color get blue7 =>
      _isLight ? RadixColorSteps.blue7 : RadixColorSteps.darkBlue7;

  /// Blue step 8 (context-aware)
  Color get blue8 =>
      _isLight ? RadixColorSteps.blue8 : RadixColorSteps.darkBlue8;

  /// Blue step 9 (context-aware) - base color
  Color get blue9 =>
      _isLight ? RadixColorSteps.blue9 : RadixColorSteps.darkBlue9;

  /// Blue step 10 (context-aware)
  Color get blue10 =>
      _isLight ? RadixColorSteps.blue10 : RadixColorSteps.darkBlue10;

  /// Blue step 11 (context-aware)
  Color get blue11 =>
      _isLight ? RadixColorSteps.blue11 : RadixColorSteps.darkBlue11;

  /// Blue step 12 (context-aware)
  Color get blue12 =>
      _isLight ? RadixColorSteps.blue12 : RadixColorSteps.darkBlue12;

  /// Cyan step 1 (context-aware)
  Color get cyan1 =>
      _isLight ? RadixColorSteps.cyan1 : RadixColorSteps.darkCyan1;

  /// Cyan step 2 (context-aware)
  Color get cyan2 =>
      _isLight ? RadixColorSteps.cyan2 : RadixColorSteps.darkCyan2;

  /// Cyan step 3 (context-aware)
  Color get cyan3 =>
      _isLight ? RadixColorSteps.cyan3 : RadixColorSteps.darkCyan3;

  /// Cyan step 4 (context-aware)
  Color get cyan4 =>
      _isLight ? RadixColorSteps.cyan4 : RadixColorSteps.darkCyan4;

  /// Cyan step 5 (context-aware)
  Color get cyan5 =>
      _isLight ? RadixColorSteps.cyan5 : RadixColorSteps.darkCyan5;

  /// Cyan step 6 (context-aware)
  Color get cyan6 =>
      _isLight ? RadixColorSteps.cyan6 : RadixColorSteps.darkCyan6;

  /// Cyan step 7 (context-aware)
  Color get cyan7 =>
      _isLight ? RadixColorSteps.cyan7 : RadixColorSteps.darkCyan7;

  /// Cyan step 8 (context-aware)
  Color get cyan8 =>
      _isLight ? RadixColorSteps.cyan8 : RadixColorSteps.darkCyan8;

  /// Cyan step 9 (context-aware) - base color
  Color get cyan9 =>
      _isLight ? RadixColorSteps.cyan9 : RadixColorSteps.darkCyan9;

  /// Cyan step 10 (context-aware)
  Color get cyan10 =>
      _isLight ? RadixColorSteps.cyan10 : RadixColorSteps.darkCyan10;

  /// Cyan step 11 (context-aware)
  Color get cyan11 =>
      _isLight ? RadixColorSteps.cyan11 : RadixColorSteps.darkCyan11;

  /// Cyan step 12 (context-aware)
  Color get cyan12 =>
      _isLight ? RadixColorSteps.cyan12 : RadixColorSteps.darkCyan12;

  /// Teal step 1 (context-aware)
  Color get teal1 =>
      _isLight ? RadixColorSteps.teal1 : RadixColorSteps.darkTeal1;

  /// Teal step 2 (context-aware)
  Color get teal2 =>
      _isLight ? RadixColorSteps.teal2 : RadixColorSteps.darkTeal2;

  /// Teal step 3 (context-aware)
  Color get teal3 =>
      _isLight ? RadixColorSteps.teal3 : RadixColorSteps.darkTeal3;

  /// Teal step 4 (context-aware)
  Color get teal4 =>
      _isLight ? RadixColorSteps.teal4 : RadixColorSteps.darkTeal4;

  /// Teal step 5 (context-aware)
  Color get teal5 =>
      _isLight ? RadixColorSteps.teal5 : RadixColorSteps.darkTeal5;

  /// Teal step 6 (context-aware)
  Color get teal6 =>
      _isLight ? RadixColorSteps.teal6 : RadixColorSteps.darkTeal6;

  /// Teal step 7 (context-aware)
  Color get teal7 =>
      _isLight ? RadixColorSteps.teal7 : RadixColorSteps.darkTeal7;

  /// Teal step 8 (context-aware)
  Color get teal8 =>
      _isLight ? RadixColorSteps.teal8 : RadixColorSteps.darkTeal8;

  /// Teal step 9 (context-aware) - base color
  Color get teal9 =>
      _isLight ? RadixColorSteps.teal9 : RadixColorSteps.darkTeal9;

  /// Teal step 10 (context-aware)
  Color get teal10 =>
      _isLight ? RadixColorSteps.teal10 : RadixColorSteps.darkTeal10;

  /// Teal step 11 (context-aware)
  Color get teal11 =>
      _isLight ? RadixColorSteps.teal11 : RadixColorSteps.darkTeal11;

  /// Teal step 12 (context-aware)
  Color get teal12 =>
      _isLight ? RadixColorSteps.teal12 : RadixColorSteps.darkTeal12;

  /// Jade step 1 (context-aware)
  Color get jade1 =>
      _isLight ? RadixColorSteps.jade1 : RadixColorSteps.darkJade1;

  /// Jade step 2 (context-aware)
  Color get jade2 =>
      _isLight ? RadixColorSteps.jade2 : RadixColorSteps.darkJade2;

  /// Jade step 3 (context-aware)
  Color get jade3 =>
      _isLight ? RadixColorSteps.jade3 : RadixColorSteps.darkJade3;

  /// Jade step 4 (context-aware)
  Color get jade4 =>
      _isLight ? RadixColorSteps.jade4 : RadixColorSteps.darkJade4;

  /// Jade step 5 (context-aware)
  Color get jade5 =>
      _isLight ? RadixColorSteps.jade5 : RadixColorSteps.darkJade5;

  /// Jade step 6 (context-aware)
  Color get jade6 =>
      _isLight ? RadixColorSteps.jade6 : RadixColorSteps.darkJade6;

  /// Jade step 7 (context-aware)
  Color get jade7 =>
      _isLight ? RadixColorSteps.jade7 : RadixColorSteps.darkJade7;

  /// Jade step 8 (context-aware)
  Color get jade8 =>
      _isLight ? RadixColorSteps.jade8 : RadixColorSteps.darkJade8;

  /// Jade step 9 (context-aware) - base color
  Color get jade9 =>
      _isLight ? RadixColorSteps.jade9 : RadixColorSteps.darkJade9;

  /// Jade step 10 (context-aware)
  Color get jade10 =>
      _isLight ? RadixColorSteps.jade10 : RadixColorSteps.darkJade10;

  /// Jade step 11 (context-aware)
  Color get jade11 =>
      _isLight ? RadixColorSteps.jade11 : RadixColorSteps.darkJade11;

  /// Jade step 12 (context-aware)
  Color get jade12 =>
      _isLight ? RadixColorSteps.jade12 : RadixColorSteps.darkJade12;

  /// Green step 1 (context-aware)
  Color get green1 =>
      _isLight ? RadixColorSteps.green1 : RadixColorSteps.darkGreen1;

  /// Green step 2 (context-aware)
  Color get green2 =>
      _isLight ? RadixColorSteps.green2 : RadixColorSteps.darkGreen2;

  /// Green step 3 (context-aware)
  Color get green3 =>
      _isLight ? RadixColorSteps.green3 : RadixColorSteps.darkGreen3;

  /// Green step 4 (context-aware)
  Color get green4 =>
      _isLight ? RadixColorSteps.green4 : RadixColorSteps.darkGreen4;

  /// Green step 5 (context-aware)
  Color get green5 =>
      _isLight ? RadixColorSteps.green5 : RadixColorSteps.darkGreen5;

  /// Green step 6 (context-aware)
  Color get green6 =>
      _isLight ? RadixColorSteps.green6 : RadixColorSteps.darkGreen6;

  /// Green step 7 (context-aware)
  Color get green7 =>
      _isLight ? RadixColorSteps.green7 : RadixColorSteps.darkGreen7;

  /// Green step 8 (context-aware)
  Color get green8 =>
      _isLight ? RadixColorSteps.green8 : RadixColorSteps.darkGreen8;

  /// Green step 9 (context-aware) - base color
  Color get green9 =>
      _isLight ? RadixColorSteps.green9 : RadixColorSteps.darkGreen9;

  /// Green step 10 (context-aware)
  Color get green10 =>
      _isLight ? RadixColorSteps.green10 : RadixColorSteps.darkGreen10;

  /// Green step 11 (context-aware)
  Color get green11 =>
      _isLight ? RadixColorSteps.green11 : RadixColorSteps.darkGreen11;

  /// Green step 12 (context-aware)
  Color get green12 =>
      _isLight ? RadixColorSteps.green12 : RadixColorSteps.darkGreen12;

  /// Grass step 1 (context-aware)
  Color get grass1 =>
      _isLight ? RadixColorSteps.grass1 : RadixColorSteps.darkGrass1;

  /// Grass step 2 (context-aware)
  Color get grass2 =>
      _isLight ? RadixColorSteps.grass2 : RadixColorSteps.darkGrass2;

  /// Grass step 3 (context-aware)
  Color get grass3 =>
      _isLight ? RadixColorSteps.grass3 : RadixColorSteps.darkGrass3;

  /// Grass step 4 (context-aware)
  Color get grass4 =>
      _isLight ? RadixColorSteps.grass4 : RadixColorSteps.darkGrass4;

  /// Grass step 5 (context-aware)
  Color get grass5 =>
      _isLight ? RadixColorSteps.grass5 : RadixColorSteps.darkGrass5;

  /// Grass step 6 (context-aware)
  Color get grass6 =>
      _isLight ? RadixColorSteps.grass6 : RadixColorSteps.darkGrass6;

  /// Grass step 7 (context-aware)
  Color get grass7 =>
      _isLight ? RadixColorSteps.grass7 : RadixColorSteps.darkGrass7;

  /// Grass step 8 (context-aware)
  Color get grass8 =>
      _isLight ? RadixColorSteps.grass8 : RadixColorSteps.darkGrass8;

  /// Grass step 9 (context-aware) - base color
  Color get grass9 =>
      _isLight ? RadixColorSteps.grass9 : RadixColorSteps.darkGrass9;

  /// Grass step 10 (context-aware)
  Color get grass10 =>
      _isLight ? RadixColorSteps.grass10 : RadixColorSteps.darkGrass10;

  /// Grass step 11 (context-aware)
  Color get grass11 =>
      _isLight ? RadixColorSteps.grass11 : RadixColorSteps.darkGrass11;

  /// Grass step 12 (context-aware)
  Color get grass12 =>
      _isLight ? RadixColorSteps.grass12 : RadixColorSteps.darkGrass12;

  /// Brown step 1 (context-aware)
  Color get brown1 =>
      _isLight ? RadixColorSteps.brown1 : RadixColorSteps.darkBrown1;

  /// Brown step 2 (context-aware)
  Color get brown2 =>
      _isLight ? RadixColorSteps.brown2 : RadixColorSteps.darkBrown2;

  /// Brown step 3 (context-aware)
  Color get brown3 =>
      _isLight ? RadixColorSteps.brown3 : RadixColorSteps.darkBrown3;

  /// Brown step 4 (context-aware)
  Color get brown4 =>
      _isLight ? RadixColorSteps.brown4 : RadixColorSteps.darkBrown4;

  /// Brown step 5 (context-aware)
  Color get brown5 =>
      _isLight ? RadixColorSteps.brown5 : RadixColorSteps.darkBrown5;

  /// Brown step 6 (context-aware)
  Color get brown6 =>
      _isLight ? RadixColorSteps.brown6 : RadixColorSteps.darkBrown6;

  /// Brown step 7 (context-aware)
  Color get brown7 =>
      _isLight ? RadixColorSteps.brown7 : RadixColorSteps.darkBrown7;

  /// Brown step 8 (context-aware)
  Color get brown8 =>
      _isLight ? RadixColorSteps.brown8 : RadixColorSteps.darkBrown8;

  /// Brown step 9 (context-aware) - base color
  Color get brown9 =>
      _isLight ? RadixColorSteps.brown9 : RadixColorSteps.darkBrown9;

  /// Brown step 10 (context-aware)
  Color get brown10 =>
      _isLight ? RadixColorSteps.brown10 : RadixColorSteps.darkBrown10;

  /// Brown step 11 (context-aware)
  Color get brown11 =>
      _isLight ? RadixColorSteps.brown11 : RadixColorSteps.darkBrown11;

  /// Brown step 12 (context-aware)
  Color get brown12 =>
      _isLight ? RadixColorSteps.brown12 : RadixColorSteps.darkBrown12;

  /// Orange step 1 (context-aware)
  Color get orange1 =>
      _isLight ? RadixColorSteps.orange1 : RadixColorSteps.darkOrange1;

  /// Orange step 2 (context-aware)
  Color get orange2 =>
      _isLight ? RadixColorSteps.orange2 : RadixColorSteps.darkOrange2;

  /// Orange step 3 (context-aware)
  Color get orange3 =>
      _isLight ? RadixColorSteps.orange3 : RadixColorSteps.darkOrange3;

  /// Orange step 4 (context-aware)
  Color get orange4 =>
      _isLight ? RadixColorSteps.orange4 : RadixColorSteps.darkOrange4;

  /// Orange step 5 (context-aware)
  Color get orange5 =>
      _isLight ? RadixColorSteps.orange5 : RadixColorSteps.darkOrange5;

  /// Orange step 6 (context-aware)
  Color get orange6 =>
      _isLight ? RadixColorSteps.orange6 : RadixColorSteps.darkOrange6;

  /// Orange step 7 (context-aware)
  Color get orange7 =>
      _isLight ? RadixColorSteps.orange7 : RadixColorSteps.darkOrange7;

  /// Orange step 8 (context-aware)
  Color get orange8 =>
      _isLight ? RadixColorSteps.orange8 : RadixColorSteps.darkOrange8;

  /// Orange step 9 (context-aware) - base color
  Color get orange9 =>
      _isLight ? RadixColorSteps.orange9 : RadixColorSteps.darkOrange9;

  /// Orange step 10 (context-aware)
  Color get orange10 =>
      _isLight ? RadixColorSteps.orange10 : RadixColorSteps.darkOrange10;

  /// Orange step 11 (context-aware)
  Color get orange11 =>
      _isLight ? RadixColorSteps.orange11 : RadixColorSteps.darkOrange11;

  /// Orange step 12 (context-aware)
  Color get orange12 =>
      _isLight ? RadixColorSteps.orange12 : RadixColorSteps.darkOrange12;

  /// Sky step 1 (context-aware)
  Color get sky1 => _isLight ? RadixColorSteps.sky1 : RadixColorSteps.darkSky1;

  /// Sky step 2 (context-aware)
  Color get sky2 => _isLight ? RadixColorSteps.sky2 : RadixColorSteps.darkSky2;

  /// Sky step 3 (context-aware)
  Color get sky3 => _isLight ? RadixColorSteps.sky3 : RadixColorSteps.darkSky3;

  /// Sky step 4 (context-aware)
  Color get sky4 => _isLight ? RadixColorSteps.sky4 : RadixColorSteps.darkSky4;

  /// Sky step 5 (context-aware)
  Color get sky5 => _isLight ? RadixColorSteps.sky5 : RadixColorSteps.darkSky5;

  /// Sky step 6 (context-aware)
  Color get sky6 => _isLight ? RadixColorSteps.sky6 : RadixColorSteps.darkSky6;

  /// Sky step 7 (context-aware)
  Color get sky7 => _isLight ? RadixColorSteps.sky7 : RadixColorSteps.darkSky7;

  /// Sky step 8 (context-aware)
  Color get sky8 => _isLight ? RadixColorSteps.sky8 : RadixColorSteps.darkSky8;

  /// Sky step 9 (context-aware) - base color
  Color get sky9 => _isLight ? RadixColorSteps.sky9 : RadixColorSteps.darkSky9;

  /// Sky step 10 (context-aware)
  Color get sky10 =>
      _isLight ? RadixColorSteps.sky10 : RadixColorSteps.darkSky10;

  /// Sky step 11 (context-aware)
  Color get sky11 =>
      _isLight ? RadixColorSteps.sky11 : RadixColorSteps.darkSky11;

  /// Sky step 12 (context-aware)
  Color get sky12 =>
      _isLight ? RadixColorSteps.sky12 : RadixColorSteps.darkSky12;

  /// Mint step 1 (context-aware)
  Color get mint1 =>
      _isLight ? RadixColorSteps.mint1 : RadixColorSteps.darkMint1;

  /// Mint step 2 (context-aware)
  Color get mint2 =>
      _isLight ? RadixColorSteps.mint2 : RadixColorSteps.darkMint2;

  /// Mint step 3 (context-aware)
  Color get mint3 =>
      _isLight ? RadixColorSteps.mint3 : RadixColorSteps.darkMint3;

  /// Mint step 4 (context-aware)
  Color get mint4 =>
      _isLight ? RadixColorSteps.mint4 : RadixColorSteps.darkMint4;

  /// Mint step 5 (context-aware)
  Color get mint5 =>
      _isLight ? RadixColorSteps.mint5 : RadixColorSteps.darkMint5;

  /// Mint step 6 (context-aware)
  Color get mint6 =>
      _isLight ? RadixColorSteps.mint6 : RadixColorSteps.darkMint6;

  /// Mint step 7 (context-aware)
  Color get mint7 =>
      _isLight ? RadixColorSteps.mint7 : RadixColorSteps.darkMint7;

  /// Mint step 8 (context-aware)
  Color get mint8 =>
      _isLight ? RadixColorSteps.mint8 : RadixColorSteps.darkMint8;

  /// Mint step 9 (context-aware) - base color
  Color get mint9 =>
      _isLight ? RadixColorSteps.mint9 : RadixColorSteps.darkMint9;

  /// Mint step 10 (context-aware)
  Color get mint10 =>
      _isLight ? RadixColorSteps.mint10 : RadixColorSteps.darkMint10;

  /// Mint step 11 (context-aware)
  Color get mint11 =>
      _isLight ? RadixColorSteps.mint11 : RadixColorSteps.darkMint11;

  /// Mint step 12 (context-aware)
  Color get mint12 =>
      _isLight ? RadixColorSteps.mint12 : RadixColorSteps.darkMint12;

  /// Lime step 1 (context-aware)
  Color get lime1 =>
      _isLight ? RadixColorSteps.lime1 : RadixColorSteps.darkLime1;

  /// Lime step 2 (context-aware)
  Color get lime2 =>
      _isLight ? RadixColorSteps.lime2 : RadixColorSteps.darkLime2;

  /// Lime step 3 (context-aware)
  Color get lime3 =>
      _isLight ? RadixColorSteps.lime3 : RadixColorSteps.darkLime3;

  /// Lime step 4 (context-aware)
  Color get lime4 =>
      _isLight ? RadixColorSteps.lime4 : RadixColorSteps.darkLime4;

  /// Lime step 5 (context-aware)
  Color get lime5 =>
      _isLight ? RadixColorSteps.lime5 : RadixColorSteps.darkLime5;

  /// Lime step 6 (context-aware)
  Color get lime6 =>
      _isLight ? RadixColorSteps.lime6 : RadixColorSteps.darkLime6;

  /// Lime step 7 (context-aware)
  Color get lime7 =>
      _isLight ? RadixColorSteps.lime7 : RadixColorSteps.darkLime7;

  /// Lime step 8 (context-aware)
  Color get lime8 =>
      _isLight ? RadixColorSteps.lime8 : RadixColorSteps.darkLime8;

  /// Lime step 9 (context-aware) - base color
  Color get lime9 =>
      _isLight ? RadixColorSteps.lime9 : RadixColorSteps.darkLime9;

  /// Lime step 10 (context-aware)
  Color get lime10 =>
      _isLight ? RadixColorSteps.lime10 : RadixColorSteps.darkLime10;

  /// Lime step 11 (context-aware)
  Color get lime11 =>
      _isLight ? RadixColorSteps.lime11 : RadixColorSteps.darkLime11;

  /// Lime step 12 (context-aware)
  Color get lime12 =>
      _isLight ? RadixColorSteps.lime12 : RadixColorSteps.darkLime12;

  /// Yellow step 1 (context-aware)
  Color get yellow1 =>
      _isLight ? RadixColorSteps.yellow1 : RadixColorSteps.darkYellow1;

  /// Yellow step 2 (context-aware)
  Color get yellow2 =>
      _isLight ? RadixColorSteps.yellow2 : RadixColorSteps.darkYellow2;

  /// Yellow step 3 (context-aware)
  Color get yellow3 =>
      _isLight ? RadixColorSteps.yellow3 : RadixColorSteps.darkYellow3;

  /// Yellow step 4 (context-aware)
  Color get yellow4 =>
      _isLight ? RadixColorSteps.yellow4 : RadixColorSteps.darkYellow4;

  /// Yellow step 5 (context-aware)
  Color get yellow5 =>
      _isLight ? RadixColorSteps.yellow5 : RadixColorSteps.darkYellow5;

  /// Yellow step 6 (context-aware)
  Color get yellow6 =>
      _isLight ? RadixColorSteps.yellow6 : RadixColorSteps.darkYellow6;

  /// Yellow step 7 (context-aware)
  Color get yellow7 =>
      _isLight ? RadixColorSteps.yellow7 : RadixColorSteps.darkYellow7;

  /// Yellow step 8 (context-aware)
  Color get yellow8 =>
      _isLight ? RadixColorSteps.yellow8 : RadixColorSteps.darkYellow8;

  /// Yellow step 9 (context-aware) - base color
  Color get yellow9 =>
      _isLight ? RadixColorSteps.yellow9 : RadixColorSteps.darkYellow9;

  /// Yellow step 10 (context-aware)
  Color get yellow10 =>
      _isLight ? RadixColorSteps.yellow10 : RadixColorSteps.darkYellow10;

  /// Yellow step 11 (context-aware)
  Color get yellow11 =>
      _isLight ? RadixColorSteps.yellow11 : RadixColorSteps.darkYellow11;

  /// Yellow step 12 (context-aware)
  Color get yellow12 =>
      _isLight ? RadixColorSteps.yellow12 : RadixColorSteps.darkYellow12;

  /// Amber step 1 (context-aware)
  Color get amber1 =>
      _isLight ? RadixColorSteps.amber1 : RadixColorSteps.darkAmber1;

  /// Amber step 2 (context-aware)
  Color get amber2 =>
      _isLight ? RadixColorSteps.amber2 : RadixColorSteps.darkAmber2;

  /// Amber step 3 (context-aware)
  Color get amber3 =>
      _isLight ? RadixColorSteps.amber3 : RadixColorSteps.darkAmber3;

  /// Amber step 4 (context-aware)
  Color get amber4 =>
      _isLight ? RadixColorSteps.amber4 : RadixColorSteps.darkAmber4;

  /// Amber step 5 (context-aware)
  Color get amber5 =>
      _isLight ? RadixColorSteps.amber5 : RadixColorSteps.darkAmber5;

  /// Amber step 6 (context-aware)
  Color get amber6 =>
      _isLight ? RadixColorSteps.amber6 : RadixColorSteps.darkAmber6;

  /// Amber step 7 (context-aware)
  Color get amber7 =>
      _isLight ? RadixColorSteps.amber7 : RadixColorSteps.darkAmber7;

  /// Amber step 8 (context-aware)
  Color get amber8 =>
      _isLight ? RadixColorSteps.amber8 : RadixColorSteps.darkAmber8;

  /// Amber step 9 (context-aware) - base color
  Color get amber9 =>
      _isLight ? RadixColorSteps.amber9 : RadixColorSteps.darkAmber9;

  /// Amber step 10 (context-aware)
  Color get amber10 =>
      _isLight ? RadixColorSteps.amber10 : RadixColorSteps.darkAmber10;

  /// Amber step 11 (context-aware)
  Color get amber11 =>
      _isLight ? RadixColorSteps.amber11 : RadixColorSteps.darkAmber11;

  /// Amber step 12 (context-aware)
  Color get amber12 =>
      _isLight ? RadixColorSteps.amber12 : RadixColorSteps.darkAmber12;

  // END GENERATED CONTEXT STEP PROPERTIES
}

/// Context-aware Radix colors that adapt to theme brightness
/// A Radix color scale with 12 steps
class RadixColorScale {
  final String name;
  final bool isLight;

  RadixColorScale(this.name, this.isLight);

  /// Get the color scale as a list from const Color constants
  /// This enables IDE color previews like Material colors
  List<Color> get _scale {
    if (isLight) {
      switch (name) {
        case 'gray':
          return LightColors.gray;
        case 'mauve':
          return LightColors.mauve;
        case 'slate':
          return LightColors.slate;
        case 'sage':
          return LightColors.sage;
        case 'olive':
          return LightColors.olive;
        case 'sand':
          return LightColors.sand;
        case 'tomato':
          return LightColors.tomato;
        case 'red':
          return LightColors.red;
        case 'ruby':
          return LightColors.ruby;
        case 'crimson':
          return LightColors.crimson;
        case 'pink':
          return LightColors.pink;
        case 'plum':
          return LightColors.plum;
        case 'purple':
          return LightColors.purple;
        case 'violet':
          return LightColors.violet;
        case 'iris':
          return LightColors.iris;
        case 'indigo':
          return LightColors.indigo;
        case 'blue':
          return LightColors.blue;
        case 'cyan':
          return LightColors.cyan;
        case 'teal':
          return LightColors.teal;
        case 'jade':
          return LightColors.jade;
        case 'green':
          return LightColors.green;
        case 'grass':
          return LightColors.grass;
        case 'brown':
          return LightColors.brown;
        case 'orange':
          return LightColors.orange;
        case 'sky':
          return LightColors.sky;
        case 'mint':
          return LightColors.mint;
        case 'lime':
          return LightColors.lime;
        case 'yellow':
          return LightColors.yellow;
        case 'amber':
          return LightColors.amber;
        default:
          throw ArgumentError('Unknown color scale: $name');
      }
    } else {
      switch (name) {
        case 'gray':
          return DarkColors.gray;
        case 'mauve':
          return DarkColors.mauve;
        case 'slate':
          return DarkColors.slate;
        case 'sage':
          return DarkColors.sage;
        case 'olive':
          return DarkColors.olive;
        case 'sand':
          return DarkColors.sand;
        case 'tomato':
          return DarkColors.tomato;
        case 'red':
          return DarkColors.red;
        case 'ruby':
          return DarkColors.ruby;
        case 'crimson':
          return DarkColors.crimson;
        case 'pink':
          return DarkColors.pink;
        case 'plum':
          return DarkColors.plum;
        case 'purple':
          return DarkColors.purple;
        case 'violet':
          return DarkColors.violet;
        case 'iris':
          return DarkColors.iris;
        case 'indigo':
          return DarkColors.indigo;
        case 'blue':
          return DarkColors.blue;
        case 'cyan':
          return DarkColors.cyan;
        case 'teal':
          return DarkColors.teal;
        case 'jade':
          return DarkColors.jade;
        case 'green':
          return DarkColors.green;
        case 'grass':
          return DarkColors.grass;
        case 'brown':
          return DarkColors.brown;
        case 'orange':
          return DarkColors.orange;
        case 'sky':
          return DarkColors.sky;
        case 'mint':
          return DarkColors.mint;
        case 'lime':
          return DarkColors.lime;
        case 'yellow':
          return DarkColors.yellow;
        case 'amber':
          return DarkColors.amber;
        default:
          throw ArgumentError('Unknown color scale: $name');
      }
    }
  }

  /// Step 1 (lightest in light mode, darkest in dark mode)
  Color get step1 => _scale[0];

  /// Step 2
  Color get step2 => _scale[1];

  /// Step 3
  Color get step3 => _scale[2];

  /// Step 4
  Color get step4 => _scale[3];

  /// Step 5
  Color get step5 => _scale[4];

  /// Step 6
  Color get step6 => _scale[5];

  /// Step 7
  Color get step7 => _scale[6];

  /// Step 8
  Color get step8 => _scale[7];

  /// Step 9 (base color)
  Color get step9 => _scale[8];

  /// Step 10
  Color get step10 => _scale[9];

  /// Step 11
  Color get step11 => _scale[10];

  /// Step 12 (darkest in light mode, lightest in dark mode)
  Color get step12 => _scale[11];

  /// Get all steps as a list
  List<Color> get steps => _scale;

  /// Get a specific step by number (1-12)
  Color step(int stepNumber) {
    if (stepNumber < 1 || stepNumber > 12) {
      throw RangeError('Step must be between 1 and 12, got $stepNumber');
    }
    return _scale[stepNumber - 1];
  }

  /// Convert Color to hex string
  static String colorToHex(Color color) {
    final argb = color.value;
    final hex = argb.toRadixString(16).padLeft(8, '0');
    return '#${hex.substring(2).toUpperCase()}';
  }
}

/// Radix generator defaults
class RadixGeneratorDefaults {
  /// Default gray color (step 9 from light gray scale)
  static Color get gray => RadixColors.gray.step9;

  /// Default gray color as hex string
  static String get grayHex => RadixColorScale.colorToHex(gray);

  /// Default light background
  static Color get backgroundLight => RadixColors.gray.step1;

  /// Default light background as hex string
  static String get backgroundLightHex =>
      RadixColorScale.colorToHex(backgroundLight);

  /// Default dark background
  static Color get backgroundDark => RadixDarkColors.gray1;

  /// Default dark background as hex string
  static String get backgroundDarkHex =>
      RadixColorScale.colorToHex(backgroundDark);
}

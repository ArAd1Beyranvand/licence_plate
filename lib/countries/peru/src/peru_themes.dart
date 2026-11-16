import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'peru_colors.dart';

/// One theme per category: the body field, the header band (the theme's
/// divider colour, which the specs' background paints above y 78), and one
/// ink for the frame and every glyph.
///
/// Frame 0.03 of the height and corners 0.07 are read off the artwork's
/// 3-pixel frame and ~6-pixel corner on its 87-pixel height; neither was
/// measured on a photograph.
abstract final class PeruThemes {
  static final PlateTheme automobile = _plate(
    header: PeruColors.white,
    body: PeruColors.white,
    ink: PeruColors.black,
  );

  /// Green header over white.
  static final PlateTheme cityBus = _plate(
    header: PeruColors.busGreen,
    body: PeruColors.white,
    ink: PeruColors.black,
  );

  /// Orange header over white.
  static final PlateTheme interprovincialBus = _plate(
    header: PeruColors.orange,
    body: PeruColors.white,
    ink: PeruColors.black,
  );

  /// Yellow header over white.
  static final PlateTheme taxi = _plate(
    header: PeruColors.yellow,
    body: PeruColors.white,
    ink: PeruColors.black,
  );

  static final PlateTheme truck = _plate(
    header: PeruColors.yellow,
    body: PeruColors.yellow,
    ink: PeruColors.black,
  );

  /// White header over yellow.
  static final PlateTheme trailer = _plate(
    header: PeruColors.white,
    body: PeruColors.yellow,
    ink: PeruColors.black,
  );

  /// Small motorcycle: cyan throughout.
  static final PlateTheme smallMotorcycle = _plate(
    header: PeruColors.cyan,
    body: PeruColors.cyan,
    ink: PeruColors.black,
  );

  /// Large motorcycle: yellow header over cyan.
  static final PlateTheme largeMotorcycle = _plate(
    header: PeruColors.yellow,
    body: PeruColors.cyan,
    ink: PeruColors.black,
  );

  static final PlateTheme emergency = _plate(
    header: PeruColors.red,
    body: PeruColors.red,
    ink: PeruColors.emergencyInk,
  );

  static final PlateTheme exhibition = _plate(
    header: PeruColors.orange,
    body: PeruColors.orange,
    ink: PeruColors.exhibitionInk,
  );

  static final PlateTheme temporary = _plate(
    header: PeruColors.yellow,
    body: PeruColors.yellow,
    ink: PeruColors.temporaryBlue,
  );

  /// Red on white.
  static final PlateTheme diplomatic = _plate(
    header: PeruColors.white,
    body: PeruColors.white,
    ink: PeruColors.diplomaticRed,
  );

  static final PlateTheme government = _plate(
    header: PeruColors.white,
    body: PeruColors.white,
    ink: PeruColors.black,
  );

  static final PlateTheme police = _plate(
    header: PeruColors.policeGreen,
    body: PeruColors.policeGreen,
    ink: PeruColors.black,
  );

  /// Blue on white.
  static final PlateTheme imported = _plate(
    header: PeruColors.white,
    body: PeruColors.white,
    ink: PeruColors.importedBlue,
  );
}

PlateTheme _plate({
  required Color header,
  required Color body,
  required Color ink,
}) => PlateTheme(
  plateBackground: body,
  plateBorder: ink,
  ink: ink,
  dividerColor: header,
  borderWidthRatio: 0.03,
  plateRadiusRatio: 0.07,
  activeColor: ink,
  inactiveColor: PeruColors.inactive,
);

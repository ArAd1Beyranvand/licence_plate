import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'moldova_colors.dart';

/// One ink on a white field, framed in black.
///
/// Only the 2015 private plate has a heavy frame (~0.045 of the 110 height,
/// read off the flat); every other plate has a hairline edge.
abstract final class MoldovaThemes {
  static PlateTheme _theme(Color ink, double border) => PlateTheme(
    plateBackground: MoldovaColors.white,
    plateBorder: MoldovaColors.black,
    ink: ink,
    dividerColor: ink,
    borderWidthRatio: border,
    plateRadiusRatio: 0.06,
    activeColor: ink,
    inactiveColor: MoldovaColors.inactive,
  );

  /// Black on white inside a heavy black frame.
  static final PlateTheme private = _theme(MoldovaColors.black, 0.045);

  /// State bodies and the armed forces.
  static final PlateTheme state = _theme(MoldovaColors.black, 0.01);

  /// Red on white: foreign entities, temporary import, export, residents.
  static final PlateTheme foreign = _theme(MoldovaColors.red, 0.01);

  /// Blue on white: diplomatic and consular.
  static final PlateTheme diplomatic = _theme(
    MoldovaColors.diplomaticBlue,
    0.01,
  );
}

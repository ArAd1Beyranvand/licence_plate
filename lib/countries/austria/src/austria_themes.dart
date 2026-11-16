import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'austria_colors.dart';

/// One ink on one field. The frame is the face's own: the red-white-red
/// triband is painted by the spec's background, so the theme's border is only
/// a hairline.
abstract final class AustriaThemes {
  /// Black on white: ordinary, personalised, federal, fire brigade, diplomatic.
  static final PlateTheme standard = _theme(
    AustriaColors.white,
    AustriaColors.black,
  );

  /// Electric: green on white.
  static final PlateTheme electric = _theme(
    AustriaColors.white,
    AustriaColors.electricInk,
  );

  /// Export transit: white on turquoise.
  static final PlateTheme export = _theme(
    AustriaColors.exportField,
    AustriaColors.exportInk,
  );

  /// Foreign-trailer cover plate: white on red.
  static final PlateTheme trailer = _theme(
    AustriaColors.trailerField,
    AustriaColors.trailerInk,
  );

  /// Temporary: white on cyan.
  static final PlateTheme temporary = _theme(
    AustriaColors.temporaryField,
    AustriaColors.temporaryInk,
  );

  /// Moped: white on red, inside a white rim.
  static final PlateTheme moped = _theme(
    AustriaColors.mopedField,
    AustriaColors.mopedInk,
    border: 0.03,
  );
}

PlateTheme _theme(Color field, Color ink, {double border = 0.005}) =>
    PlateTheme.monochrome(
      field: field,
      ink: ink,
      borderWidthRatio: border,
      plateRadiusRatio: 0.1,
    );

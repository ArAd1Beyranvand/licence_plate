import 'package:flutter/widgets.dart' show Color;
import 'package:license_plate/core/plate_core.dart';

import 'san_marino_colors.dart';

/// The digits' ink on the plate's field, with a thin frame in the same ink.
/// The frame is a bevelled rim in the photos; its width (2% of the height) and
/// corner radius (6%) are estimated, not measured. A coloured prefix is the
/// spec's, not the theme's.
abstract final class SanMarinoThemes {
  static final PlateTheme private = _theme(
    SanMarinoColors.field,
    SanMarinoColors.blue,
  );
  static final PlateTheme trailer = _theme(
    SanMarinoColors.field,
    SanMarinoColors.blueTrailer,
  );
  static final PlateTheme export = _theme(
    SanMarinoColors.fieldGrey,
    SanMarinoColors.black,
  );
  static final PlateTheme electric = _theme(
    SanMarinoColors.fieldElectric,
    SanMarinoColors.green,
  );
  static final PlateTheme diplomatic = _theme(
    SanMarinoColors.fieldDiplomatic,
    SanMarinoColors.blueLight,
  );
  static final PlateTheme redCross = trailer;
  static final PlateTheme police = _theme(
    SanMarinoColors.field,
    SanMarinoColors.bluePolice,
  );
}

PlateTheme _theme(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.02,
  plateRadiusRatio: 0.06,
);

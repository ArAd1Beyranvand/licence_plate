import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'estonia_colors.dart';

/// One ink on one field, frame in the ink colour.
abstract final class EstoniaThemes {
  static final PlateTheme private = _theme(
    EstoniaColors.white,
    EstoniaColors.black,
  );

  static final PlateTheme diplomatic = _theme(
    EstoniaColors.diplomaticField,
    EstoniaColors.diplomaticInk,
  );

  static final PlateTheme defence = _theme(
    EstoniaColors.defenceField,
    EstoniaColors.defenceInk,
  );

  static final PlateTheme president = _theme(
    EstoniaColors.presidentField,
    EstoniaColors.presidentFrame,
  );
}

/// The frame is about 4 of the 110 units of height.
PlateTheme _theme(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.036,
  plateRadiusRatio: 0.08,
);

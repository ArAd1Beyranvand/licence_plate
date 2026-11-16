import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'abkhazia_colors.dart';

abstract final class AbkhaziaThemes {
  static PlateTheme _field(Color field, Color ink, Color inactive) =>
      PlateTheme.monochrome(
        field: field,
        ink: ink,
        inactive: inactive,
        borderWidthRatio: 0.02,
        plateRadiusRatio: 0.05,
      );

  static final PlateTheme private = _field(
    AbkhaziaColors.white,
    AbkhaziaColors.black,
    AbkhaziaColors.inactiveOnLight,
  );

  static final PlateTheme diplomatic = _field(
    AbkhaziaColors.diplomaticRed,
    AbkhaziaColors.diplomaticInk,
    AbkhaziaColors.inactiveOnDark,
  );
}

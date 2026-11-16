import 'package:flutter/widgets.dart' show Color;
import 'package:license_plate/core/plate_core.dart';

import 'saint_lucia_colors.dart';

/// One ink on one field, no printed border.
abstract final class SaintLuciaThemes {
  static final PlateTheme private = _theme(
    SaintLuciaColors.black,
    SaintLuciaColors.white,
    const Color(0xFF666666),
  );
  static final PlateTheme taxi = _theme(
    SaintLuciaColors.taxiBlue,
    SaintLuciaColors.white,
    const Color(0xFF9DB8DC),
  );
  static final PlateTheme minibus = _theme(
    SaintLuciaColors.minibusGreen,
    SaintLuciaColors.white,
    const Color(0xFFA9D3A1),
  );
  static final PlateTheme demonstration = _theme(
    SaintLuciaColors.white,
    SaintLuciaColors.dealerRed,
    const Color(0xFFF2B3AF),
  );
  static final PlateTheme government = _theme(
    SaintLuciaColors.governmentYellow,
    SaintLuciaColors.black,
    const Color(0xFFB08F31),
  );
  static final PlateTheme parliament = _theme(
    SaintLuciaColors.parliamentBlue,
    SaintLuciaColors.parliamentYellow,
    const Color(0xFF8A8FD6),
  );

  static PlateTheme _theme(Color field, Color ink, Color inactive) =>
      PlateTheme.monochrome(
        field: field,
        ink: ink,
        inactive: inactive,
        borderWidthRatio: 0,
        plateRadiusRatio: 0.05,
      );
}

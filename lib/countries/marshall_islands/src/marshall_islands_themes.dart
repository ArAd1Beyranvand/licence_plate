import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'marshall_islands_colors.dart';

/// One ink on one field, the frame in the ink.
///
/// The dark outer rim of the green plate and the raised rim of the 1972 plate
/// are not modelled; border 0.02 and corner 0.04 of the height are not measured.
abstract final class MarshallIslandsThemes {
  /// Majuro Atoll plate: white on green.
  static final PlateTheme current = _ink(
    MarshallIslandsColors.field,
    MarshallIslandsColors.ink,
  );

  /// 1972 Trust Territory plate: black on cream.
  static final PlateTheme trustTerritory = _ink(
    MarshallIslandsColors.trustField,
    MarshallIslandsColors.trustInk,
  );
}

PlateTheme _ink(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.02,
  plateRadiusRatio: 0.04,
);

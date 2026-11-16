import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'south_africa_colors.dart';

/// One ink on one field, the frame in the ink colour. The Eastern Cape, Free
/// State and North West fields are the sampled sky of their printed
/// landscapes, flat here.
abstract final class SouthAfricaThemes {
  /// Black on white: Western Cape, Mpumalanga, Limpopo and most provinces.
  static final PlateTheme standard = _ink(
    SouthAfricaColors.white,
    SouthAfricaColors.black,
  );

  /// Gauteng and KwaZulu-Natal: blue on white.
  static final PlateTheme blue = _ink(
    SouthAfricaColors.white,
    SouthAfricaColors.blue,
  );

  /// Northern Cape: green on white.
  static final PlateTheme northernCape = _ink(
    SouthAfricaColors.white,
    SouthAfricaColors.green,
  );

  /// Government and defence force vehicles: black on yellow.
  static final PlateTheme government = _ink(
    SouthAfricaColors.yellow,
    SouthAfricaColors.black,
  );

  static final PlateTheme easternCape = _ink(
    SouthAfricaColors.easternCapeField,
    SouthAfricaColors.black,
  );

  static final PlateTheme freeState = _ink(
    SouthAfricaColors.freeStateField,
    SouthAfricaColors.black,
  );

  static final PlateTheme northWest = _ink(
    SouthAfricaColors.northWestField,
    SouthAfricaColors.black,
  );
}

PlateTheme _ink(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.03,
  plateRadiusRatio: 0.09,
);

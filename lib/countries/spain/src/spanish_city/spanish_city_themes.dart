import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'spanish_city_colors.dart';

/// One ink on one field, the frame in the ink.
///
/// The vector reference's frame is about 4.25 of 110 thick (0.04) with a corner
/// arc near 10 (0.09). The photographed plates show no printed frame, so theirs
/// is none and a small radius; neither is measured beyond looking at the flats.
abstract final class SpanishCityThemes {
  /// Registration plate: black on white, with the euroband.
  static final PlateTheme private = _framed(
    SpanishCityColors.white,
    SpanishCityColors.black,
  );

  /// Historic `H`: black on white, as the private plate.
  static final PlateTheme historic = _framed(
    SpanishCityColors.white,
    SpanishCityColors.black,
  );

  static final PlateTheme taxi = _flat(
    SpanishCityColors.taxiBlue,
    SpanishCityColors.taxiInk,
  );
  static final PlateTheme trailer = _flat(
    SpanishCityColors.trailerRed,
    SpanishCityColors.trailerInk,
  );
  static final PlateTheme provisional = _flat(
    SpanishCityColors.provisionalTeal,
    SpanishCityColors.provisionalInk,
  );
  static final PlateTheme dealer = _flat(
    SpanishCityColors.dealerRed,
    SpanishCityColors.dealerInk,
  );
  static final PlateTheme police = _flat(
    SpanishCityColors.policeField,
    SpanishCityColors.policeInk,
  );

  /// `CD`, diplomatic.
  static final PlateTheme diplomatic = _flat(
    SpanishCityColors.diplomaticRed,
    SpanishCityColors.diplomaticRedInk,
  );

  /// `CC`, consular.
  static final PlateTheme consular = _flat(
    SpanishCityColors.consularGreen,
    SpanishCityColors.consularGreenInk,
  );

  /// `OI`, international organisation.
  static final PlateTheme organisation = _flat(
    SpanishCityColors.organisationBlue,
    SpanishCityColors.organisationBlueInk,
  );
}

PlateTheme _framed(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.04,
  plateRadiusRatio: 0.09,
);

PlateTheme _flat(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0,
  plateRadiusRatio: 0.06,
);

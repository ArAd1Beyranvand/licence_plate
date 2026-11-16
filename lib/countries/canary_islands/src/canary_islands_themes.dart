import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'canary_islands_colors.dart';

/// One ink on one field, the frame in the ink.
///
/// The vector reference's frame is about 4.25 of 110 thick (0.04) with a corner
/// arc near 10 (0.09). The photographed plates show no printed frame, so theirs
/// is none and a small radius; neither is measured beyond looking at the flats.
abstract final class CanaryIslandsThemes {
  /// Registration plate: black on white, with the euroband.
  static final PlateTheme private = _framed(
    CanaryIslandsColors.white,
    CanaryIslandsColors.black,
  );

  /// Historic `H`: black on white, as the private plate.
  static final PlateTheme historic = private;

  static final PlateTheme taxi = _flat(
    CanaryIslandsColors.taxiBlue,
    CanaryIslandsColors.taxiInk,
  );
  static final PlateTheme trailer = _flat(
    CanaryIslandsColors.trailerRed,
    CanaryIslandsColors.trailerInk,
  );
  static final PlateTheme provisional = _flat(
    CanaryIslandsColors.provisionalTeal,
    CanaryIslandsColors.provisionalInk,
  );

  /// The class letter picks the livery: `R` trailer, `P` provisional.
  static PlateTheme byClass(
    PlateTheme base,
    String Function(String key) group,
  ) {
    final PlateTheme t = group('class') == 'P' ? provisional : trailer;
    return base.copyWith(
      plateBackground: t.plateBackground,
      plateBorder: t.plateBorder,
      ink: t.ink,
      dividerColor: t.dividerColor,
      activeColor: t.activeColor,
      inactiveColor: t.inactiveColor,
    );
  }

  static final PlateTheme dealer = _flat(
    CanaryIslandsColors.dealerRed,
    CanaryIslandsColors.dealerInk,
  );
  static final PlateTheme police = _flat(
    CanaryIslandsColors.policeField,
    CanaryIslandsColors.policeInk,
  );

  /// `CD`, diplomatic.
  static final PlateTheme diplomatic = _flat(
    CanaryIslandsColors.diplomaticRed,
    CanaryIslandsColors.diplomaticRedInk,
  );

  /// `CC`, consular.
  static final PlateTheme consular = _flat(
    CanaryIslandsColors.consularGreen,
    CanaryIslandsColors.consularGreenInk,
  );

  /// `OI`, international organisation.
  static final PlateTheme organisation = _flat(
    CanaryIslandsColors.organisationBlue,
    CanaryIslandsColors.organisationBlueInk,
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

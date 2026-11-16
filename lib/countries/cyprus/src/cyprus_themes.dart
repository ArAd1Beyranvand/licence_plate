import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'cyprus_colors.dart';

/// One ink on one field. The artwork shows no frame line, so the border is 0
/// and the corners round at 0.04 of the height; neither is measured. The SBA
/// plate alone carries a frame (the brief's `border=True`).
abstract final class CyprusThemes {
  /// Front plate: black on white. Also the trailer and diplomatic plates.
  static final PlateTheme front = _ink(CyprusColors.white, CyprusColors.black);

  /// Rear, taxi and commercial plate: black on yellow.
  static final PlateTheme rear = _ink(CyprusColors.yellow, CyprusColors.black);

  /// Rental car: black on dark red.
  static final PlateTheme rental = _ink(
    CyprusColors.rentalRed,
    CyprusColors.black,
  );

  /// Historic vehicle (over 30 years): white on black.
  static final PlateTheme historic = _ink(
    CyprusColors.black,
    CyprusColors.white,
  );

  /// Dealer plate: red on white.
  static final PlateTheme dealer = _ink(
    CyprusColors.white,
    CyprusColors.dealerRed,
  );

  /// Sovereign Base Areas: black on white in a thin frame.
  static final PlateTheme sba = _ink(
    CyprusColors.white,
    CyprusColors.black,
    border: 0.03,
  );
}

PlateTheme _ink(Color field, Color ink, {double border = 0}) =>
    PlateTheme.monochrome(
      field: field,
      ink: ink,
      borderWidthRatio: border,
      plateRadiusRatio: 0.04,
    );

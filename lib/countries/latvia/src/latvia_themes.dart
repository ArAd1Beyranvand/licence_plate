import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'latvia_colors.dart';

/// One ink on one field, frame in the ink colour. The motorcycle plate is
/// black on white as the prose says; its photograph is colour-cast.
abstract final class LatviaThemes {
  static final PlateTheme private = _theme(
    LatviaColors.white,
    LatviaColors.black,
  );

  static final PlateTheme taxi = _theme(
    LatviaColors.taxiField,
    LatviaColors.black,
  );

  static final PlateTheme electric = _theme(
    LatviaColors.electricField,
    LatviaColors.electricInk,
  );

  static final PlateTheme diplomatic = _theme(
    LatviaColors.diplomaticField,
    LatviaColors.black,
  );

  static final PlateTheme motorcycle = private;

  static PlateTheme byLetters(PlateTheme base, String Function(String) group) =>
      switch (group('letters')) {
        'TX' || 'TQ' => taxi,
        'EX' => electric,
        _ => base,
      };
}

/// The frame is about 4 of the 110 units of height.
PlateTheme _theme(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.036,
  plateRadiusRatio: 0.08,
);

import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'new_zealand_colors.dart';

/// One ink on one field, the frame in the ink.
///
/// The embossed rim is not measurable in the photos, so the border is a thin
/// 0.02 of the height and the corners round at 0.04.
abstract final class NewZealandThemes {
  static final PlateTheme standard = _ink(
    NewZealandColors.white,
    NewZealandColors.black,
  );

  static final PlateTheme europlate = _ink(
    NewZealandColors.europlateField,
    NewZealandColors.europlateInk,
  );

  /// Older silver-on-black plate; also the black personalised option.
  static final PlateTheme black = _ink(
    NewZealandColors.darkField,
    NewZealandColors.silver,
  );
}

PlateTheme _ink(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.02,
  plateRadiusRatio: 0.04,
);

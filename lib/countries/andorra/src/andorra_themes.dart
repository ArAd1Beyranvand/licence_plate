import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'andorra_colors.dart';

/// One ink on one field. The photographs show no printed frame, so the border
/// is 0.
abstract final class AndorraThemes {
  static final PlateTheme standard = _theme(
    AndorraColors.standardField,
    AndorraColors.standardInk,
  );

  static final PlateTheme temporary = _theme(
    AndorraColors.temporaryField,
    AndorraColors.temporaryInk,
  );
}

PlateTheme _theme(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0,
  plateRadiusRatio: 0.07,
);

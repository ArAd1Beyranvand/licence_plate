import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'madagascar_colors.dart';

/// One ink on one field. The photographs are cropped to the plate edge, so the
/// rim is an unmeasured thin line in the ink colour; the military plate has
/// none.
abstract final class MadagascarThemes {
  static PlateTheme _theme({
    required Color field,
    required Color ink,
    double border = 0.03,
  }) => PlateTheme(
    plateBackground: field,
    plateBorder: ink,
    ink: ink,
    dividerColor: ink,
    borderWidthRatio: border,
    plateRadiusRatio: 0.06,
    activeColor: ink,
    inactiveColor: MadagascarColors.inactive,
  );

  static final PlateTheme standard = _theme(
    field: MadagascarColors.field,
    ink: MadagascarColors.ink,
  );
  static final PlateTheme legacy = _theme(
    field: MadagascarColors.legacyField,
    ink: MadagascarColors.legacyInk,
    border: 0,
  );
  static final PlateTheme temporary = standard, dealer = standard;
  static final PlateTheme military = _theme(
    field: MadagascarColors.militaryField,
    ink: MadagascarColors.militaryInk,
    border: 0,
  );
  static final PlateTheme diplomatic = _theme(
    field: MadagascarColors.diplomaticField,
    ink: MadagascarColors.diplomaticInk,
  );
}

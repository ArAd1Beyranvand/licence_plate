import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'luxembourg_colors.dart';

/// One ink on one field, framed in the ink. The rim (~2 mm) and corner radius
/// are estimated by eye off the flat references.
abstract final class LuxembourgThemes {
  static PlateTheme _livery(Color field, Color ink) => PlateTheme(
    plateBackground: field,
    plateBorder: ink,
    ink: ink,
    dividerColor: ink,
    borderWidthRatio: 0.02,
    plateRadiusRatio: 0.04,
    activeColor: ink,
    inactiveColor: LuxembourgColors.inactive,
    alertColor: const Color(0xFFD32F2F),
  );

  /// Black on yellow: standard and diplomatic.
  static final PlateTheme standard = _livery(
    LuxembourgColors.yellow,
    LuxembourgColors.black,
  );

  static final PlateTheme diplomatic = standard;

  /// White on black.
  static final PlateTheme military = _livery(
    LuxembourgColors.militaryField,
    LuxembourgColors.militaryInk,
  );
}

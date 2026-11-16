import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'saint_helena_colors.dart';

abstract final class SaintHelenaThemes {
  static PlateTheme _plate(Color field) => PlateTheme.monochrome(
    field: field,
    ink: SaintHelenaColors.black,
    borderWidthRatio: 0.025,
    plateRadiusRatio: 0.06,
  );

  /// Black on white: the front plate.
  static final PlateTheme front = _plate(SaintHelenaColors.white);

  /// Black on yellow: the rear plate.
  static final PlateTheme rear = _plate(SaintHelenaColors.rearYellow);
}

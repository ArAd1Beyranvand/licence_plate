import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'rwanda_colors.dart';

/// Black on one field, the frame in the ink. Frame thickness and corner radius
/// are estimated.
abstract final class RwandaThemes {
  /// Front plate: black on white.
  static final PlateTheme front = _ink(RwandaColors.white);

  /// Back plate: black on yellow.
  static final PlateTheme back = _ink(RwandaColors.yellow);
}

PlateTheme _ink(Color field) => PlateTheme.monochrome(
  field: field,
  ink: RwandaColors.black,
  borderWidthRatio: 0.03,
  plateRadiusRatio: 0.06,
);

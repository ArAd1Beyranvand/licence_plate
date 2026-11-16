import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'burundi_colors.dart';

/// Black ink and frame on one field.
///
/// Frame ratio and corner radius are the European-size values the neighbouring
/// 520×110 packages use; the photographs are too small to measure them.
abstract final class BurundiThemes {
  static final PlateTheme front = _ink(BurundiColors.white);

  static final PlateTheme rear = _ink(BurundiColors.yellow);
}

PlateTheme _ink(Color field) => PlateTheme.monochrome(
  field: field,
  ink: BurundiColors.black,
  borderWidthRatio: 0.04,
  plateRadiusRatio: 0.09,
);

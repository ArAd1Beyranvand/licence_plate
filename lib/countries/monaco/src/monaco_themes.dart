import 'package:flutter/widgets.dart' show Color;
import 'package:license_plate/core/plate_core.dart';

import 'monaco_colors.dart';

/// One ink on one field with a frame in the same ink. The frame is about 3% of
/// the height in the photos; its corner radius (6%) is estimated.
abstract final class MonacoThemes {
  static final PlateTheme car = _theme(MonacoColors.field, MonacoColors.blue);
  static final PlateTheme motorcycle = _theme(
    MonacoColors.fieldMotorcycle,
    MonacoColors.blueMotorcycle,
  );
}

PlateTheme _theme(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.03,
  plateRadiusRatio: 0.06,
);

import 'package:license_plate/core/plate_core.dart';

import 'tonga_colors.dart';

/// White ink on black, the frame in the ink.
///
/// The frame is about 3 of the 134 units in the reference (0.022 of the
/// height) and the corners about 0.04; both read off the flattened graphic,
/// not measured against a drawing.
abstract final class TongaThemes {
  static final PlateTheme standard = PlateTheme.monochrome(
    field: TongaColors.field,
    ink: TongaColors.ink,
    inactive: TongaColors.inactive,
    borderWidthRatio: 0.022,
    plateRadiusRatio: 0.04,
  );
}

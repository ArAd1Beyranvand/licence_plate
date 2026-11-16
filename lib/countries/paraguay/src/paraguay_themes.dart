import 'package:license_plate/core/plate_core.dart';

import 'paraguay_colors.dart';

/// Black on white, the frame in the ink. Border and corner are estimated from
/// the photograph (thin frame, small radius), not measured.
abstract final class ParaguayThemes {
  static final PlateTheme mercosur = PlateTheme.monochrome(
    field: ParaguayColors.white,
    ink: ParaguayColors.black,
    borderWidthRatio: 0.02,
    plateRadiusRatio: 0.06,
  );
}

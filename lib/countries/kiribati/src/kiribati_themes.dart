import 'package:license_plate/core/plate_core.dart';

import 'kiribati_colors.dart';

/// White on black. The standard plate has a white frame; the Betio plate is
/// painted edge to edge with none.
abstract final class KiribatiThemes {
  static final PlateTheme standard = _ink(0.03);

  static final PlateTheme betio = _ink(0);
}

PlateTheme _ink(double border) => PlateTheme.monochrome(
  field: KiribatiColors.field,
  ink: KiribatiColors.ink,
  inactive: KiribatiColors.inactive,
  borderWidthRatio: border,
  plateRadiusRatio: 0.05,
);

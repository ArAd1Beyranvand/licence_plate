import 'package:license_plate/core/plate_core.dart';

import 'saint_kitts_and_nevis_colors.dart';

abstract final class SaintKittsAndNevisThemes {
  static final PlateTheme private = PlateTheme.monochrome(
    field: SaintKittsAndNevisColors.blackField,
    ink: SaintKittsAndNevisColors.creamInk,
    inactive: SaintKittsAndNevisColors.inactive,
    borderWidthRatio: 0,
    plateRadiusRatio: 0.03,
  );
}

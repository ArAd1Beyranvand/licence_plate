import 'package:license_plate/core/plate_core.dart';

import 'pakistan_colors.dart';

/// Black on one field, framed in black. The rim measures 4.75 of 287 units
/// (0.0165) and the outer corner radius ~20 (0.07) on the flattened plates.
abstract final class PakistanThemes {
  /// Black on white: Balochistan, Azad Jammu & Kashmir, Islamabad, Khyber
  /// Pakhtunkhwa and Punjab.
  static const PlateTheme white = PlateTheme.monochrome(
    field: PakistanColors.white,
    ink: PakistanColors.black,
    borderWidthRatio: 0.0165,
    plateRadiusRatio: 0.07,
  );

  /// Black on yellow: Sindh.
  static const PlateTheme sindh = PlateTheme.monochrome(
    field: PakistanColors.sindhYellow,
    ink: PakistanColors.black,
    borderWidthRatio: 0.0165,
    plateRadiusRatio: 0.07,
  );
}

import 'package:flutter/painting.dart';
import 'package:license_plate/core/plate_core.dart';

import 'ethiopia_colors.dart';

/// One ink on a white field, the frame in the ink. The frame ratios are the
/// photos' hairline outline (about one plate unit) over each canvas height.
abstract final class EthiopiaThemes {
  static final PlateTheme regional = _ink(EthiopiaColors.blue, 0.01);

  static final PlateTheme private = _ink(EthiopiaColors.blue, 0.007);

  static final PlateTheme diplomatic = _ink(EthiopiaColors.black, 0.009);

  static PlateTheme themeOf(PlateSpec spec) => switch (spec.id) {
    'et.private' => private,
    'et.diplomatic' => diplomatic,
    _ => regional,
  };
}

PlateTheme _ink(Color ink, double border) => PlateTheme.monochrome(
  field: EthiopiaColors.white,
  ink: ink,
  inactive: EthiopiaColors.inactive,
  borderWidthRatio: border,
  plateRadiusRatio: 0.04,
);

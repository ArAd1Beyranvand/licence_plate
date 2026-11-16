import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'bangladesh_colors.dart';

/// One ink on one field, the frame in the ink colour (the photograph shows a
/// black frame of about 0.03 of the height).
abstract final class BangladeshThemes {
  /// Black on white: private vehicles.
  static final PlateTheme private = _ink(
    BangladeshColors.white,
    BangladeshColors.black,
  );

  /// Black on green: fare-hire vehicles.
  static final PlateTheme commercial = _ink(
    BangladeshColors.green,
    BangladeshColors.black,
  );

  /// White on green: electric vehicles.
  static final PlateTheme electric = _ink(
    BangladeshColors.green,
    BangladeshColors.white,
  );
}

PlateTheme _ink(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.03,
  plateRadiusRatio: 0.06,
);

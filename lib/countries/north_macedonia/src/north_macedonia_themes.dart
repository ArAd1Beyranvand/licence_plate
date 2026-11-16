import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'north_macedonia_colors.dart';

/// One ink on one field, with the frame in the ink's colour.
///
/// The one-line frame is 5 of 110 (0.045) measured off the Demir Kapija flat;
/// the two-row photo's is about 5 of 153 (0.034). The diplomatic plate is
/// embossed with no printed frame.
abstract final class NorthMacedoniaThemes {
  static final PlateTheme standard = _theme(
    NorthMacedoniaColors.white,
    NorthMacedoniaColors.black,
    0.045,
  );
  static final PlateTheme twoRow = _theme(
    NorthMacedoniaColors.white,
    NorthMacedoniaColors.black,
    0.034,
  );
  static final PlateTheme diplomatic = _theme(
    NorthMacedoniaColors.black,
    NorthMacedoniaColors.diplomaticInk,
    0,
  );
}

PlateTheme _theme(Color field, Color ink, double border) =>
    PlateTheme.monochrome(
      field: field,
      ink: ink,
      borderWidthRatio: border,
      plateRadiusRatio: 0.08,
    );

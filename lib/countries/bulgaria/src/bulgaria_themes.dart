import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'bulgaria_colors.dart';

/// One ink on one field inside a thin frame; the frame is black on the white
/// plates and white on the coloured ones.
///
/// The frame (about 0.025 of the 110 height) and the corner arc (about 0.05)
/// are read off the flats, not measured more closely.
abstract final class BulgariaThemes {
  /// Registration: black on white.
  static final PlateTheme private = _theme(
    BulgariaColors.white,
    BulgariaColors.black,
    BulgariaColors.black,
  );

  /// Electric car or motorcycle: dark green on white.
  static final PlateTheme electric = _theme(
    BulgariaColors.white,
    BulgariaColors.electricGreen,
    BulgariaColors.electricGreen,
  );

  /// Repeater (bicycle-rack) plate: red on white.
  static final PlateTheme repeater = _theme(
    BulgariaColors.white,
    BulgariaColors.repeaterRed,
    BulgariaColors.repeaterRed,
  );

  /// Army: black on white.
  static final PlateTheme military = _theme(
    BulgariaColors.white,
    BulgariaColors.black,
    BulgariaColors.black,
  );

  /// Civil protection: blue on white.
  static final PlateTheme civilProtection = _theme(
    BulgariaColors.white,
    BulgariaColors.euroBlue,
    BulgariaColors.black,
  );

  /// Foreigner: white on light blue.
  static final PlateTheme foreigner = _theme(
    BulgariaColors.foreignBlue,
    BulgariaColors.white,
    BulgariaColors.white,
  );

  /// Diplomatic and consular: white on red.
  static final PlateTheme diplomatic = _theme(
    BulgariaColors.diplomaticRed,
    BulgariaColors.white,
    BulgariaColors.white,
  );
}

PlateTheme _theme(Color field, Color ink, Color frame) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  borderWidthRatio: 0.025,
  plateRadiusRatio: 0.05,
).copyWith(plateBorder: frame);

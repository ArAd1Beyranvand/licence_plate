import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'croatia_colors.dart';

/// One ink on one field. Private, customized and classic plates have no frame
/// (their edge lines are painted by the spec); the special plates carry a thin
/// frame in the ink colour.
///
/// Frame width 0.025 and corner arc 0.07 of the 110 height are read off the
/// flats at about that precision, not measured more closely.
abstract final class CroatiaThemes {
  /// Private, customized and classic: black on white.
  static final PlateTheme private = _theme(
    CroatiaColors.white,
    CroatiaColors.black,
    CroatiaColors.black,
    0,
  );

  static final PlateTheme army = _theme(
    CroatiaColors.armyYellow,
    CroatiaColors.armyInk,
    CroatiaColors.armyInk,
    0.025,
  );

  static final PlateTheme exportPlate = _theme(
    CroatiaColors.exportField,
    CroatiaColors.exportInk,
    CroatiaColors.exportInk,
    0.025,
  );

  static final PlateTheme oversize = _theme(
    CroatiaColors.oversizeField,
    CroatiaColors.oversizeInk,
    CroatiaColors.oversizeInk,
    0.025,
  );

  static final PlateTheme police = _theme(
    CroatiaColors.white,
    CroatiaColors.policeInk,
    CroatiaColors.policeInk,
    0.025,
  );

  static final PlateTheme diplomatic = _theme(
    CroatiaColors.diplomaticField,
    CroatiaColors.diplomaticInk,
    CroatiaColors.diplomaticInk,
    0,
  );
}

PlateTheme _theme(Color field, Color ink, Color frame, double border) =>
    PlateTheme.monochrome(
      field: field,
      ink: ink,
      borderWidthRatio: border,
      plateRadiusRatio: 0.07,
    ).copyWith(plateBorder: frame);

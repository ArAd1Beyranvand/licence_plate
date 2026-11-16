import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'albania_colors.dart';

/// One ink on one field, the frame in the ink. The frame ratio is set per
/// spec (`borderWidthRatioOverride`) because the one- and two-line plates have
/// different heights; the corner ratio is an estimate.
abstract final class AlbaniaThemes {
  static PlateTheme _ink(Color field, Color ink, {bool dark = false}) =>
      PlateTheme.monochrome(
        field: field,
        ink: ink,
        inactive: dark
            ? AlbaniaColors.inactiveOnDark
            : AlbaniaColors.inactiveOnLight,
        borderWidthRatio: 0.045,
        plateRadiusRatio: 0.07,
      );

  /// Private and motorcycle: black on white.
  static final PlateTheme private = _ink(
    AlbaniaColors.white,
    AlbaniaColors.black,
  );

  /// Repetitive plate: red on white.
  static final PlateTheme repetitive = _ink(
    AlbaniaColors.white,
    AlbaniaColors.red,
  );

  /// Agricultural, technological and trailer: white on green.
  static final PlateTheme agricultural = _ink(
    AlbaniaColors.green,
    AlbaniaColors.white,
    dark: true,
  );

  /// Diplomatic, service-diplomatic and military: green on white.
  static final PlateTheme diplomatic = _ink(
    AlbaniaColors.white,
    AlbaniaColors.green,
  );

  /// Police and Ministry of the Interior: navy on white.
  static final PlateTheme police = _ink(
    AlbaniaColors.white,
    AlbaniaColors.policeBlue,
  );

  /// Taxi: red on yellow.
  static final PlateTheme taxi = _ink(AlbaniaColors.yellow, AlbaniaColors.red);

  /// Temporary and test plates: red on white.
  static final PlateTheme temporary = _ink(
    AlbaniaColors.white,
    AlbaniaColors.red,
  );
}

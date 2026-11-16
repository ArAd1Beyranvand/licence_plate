import 'package:flutter/widgets.dart' show Color;
import 'package:license_plate/core/plate_core.dart';

import 'barbados_colors.dart';

/// Ink and frame share one colour on both plates, so each theme is one
/// monochrome call.
abstract final class BarbadosThemes {
  static final PlateTheme black = _theme(
    BarbadosColors.blackField,
    BarbadosColors.silverInk,
    BarbadosColors.inactiveOnBlack,
  );

  static final PlateTheme white = _theme(
    BarbadosColors.whiteField,
    BarbadosColors.blackInk,
    BarbadosColors.inactiveOnWhite,
  );

  static PlateTheme _theme(Color field, Color ink, Color inactive) =>
      PlateTheme.monochrome(
        field: field,
        ink: ink,
        inactive: inactive,
        borderWidthRatio: 0.02,
        plateRadiusRatio: 0.06,
      );
}

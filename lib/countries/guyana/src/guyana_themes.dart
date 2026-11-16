import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'guyana_colors.dart';

/// Two liveries: white on black, and gold on a warm black.
///
/// The Private Car photo shows a thin white rim; `____1` and the two state
/// plates show none, so the rim is the field colour there. Rim ratio is of the
/// canvas height, estimated at ~3% from the photo (not measured).
abstract final class GuyanaThemes {
  /// White on black: every standard plate.
  static final PlateTheme standard = _theme(
    field: GuyanaColors.black,
    ink: GuyanaColors.white,
    inactive: GuyanaColors.inactiveOnDark,
  );

  /// Gold crown on warm black: the Presidential plate.
  static final PlateTheme president = _theme(
    field: GuyanaColors.stateField,
    ink: GuyanaColors.crownGold,
    inactive: GuyanaColors.inactiveOnDark,
  );

  /// Gold arms on warm black: the Prime Minister's plate.
  static final PlateTheme primeMinister = _theme(
    field: GuyanaColors.stateField,
    ink: GuyanaColors.arms,
    inactive: GuyanaColors.inactiveOnDark,
  );
}

PlateTheme _theme({
  required Color field,
  required Color ink,
  required Color inactive,
}) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  inactive: inactive,
  borderWidthRatio: 0.03,
  plateRadiusRatio: 0.05,
);

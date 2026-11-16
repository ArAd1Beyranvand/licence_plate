import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'haiti_colors.dart';

/// The Haitian liveries: one ink on one field, framed in the ink (the 2014 and
/// 2006 plates in the ink's colour too; the 1998 plates in red).
///
/// Rim and corner ratios are of the 520×264 canvas height, read off the
/// flattened photos (rim ~4 units, corner ~12).
abstract final class HaitiThemes {
  static PlateTheme _field({
    required Color field,
    required Color ink,
    required Color inactive,
    Color? border,
    double borderWidthRatio = 0.016,
  }) => PlateTheme(
    plateBackground: field,
    plateBorder: border ?? ink,
    ink: ink,
    dividerColor: ink,
    borderWidthRatio: borderWidthRatio,
    plateRadiusRatio: 0.045,
    activeColor: ink,
    inactiveColor: inactive,
    alertColor: const Color(0xFFD32F2F),
  );

  /// Black on salmon, 2014 passenger transport.
  static final PlateTheme transport2014 = _field(
    field: HaitiColors.salmon,
    ink: HaitiColors.salmonInk,
    inactive: HaitiColors.inactiveOnLight,
    borderWidthRatio: 0,
  );

  /// Dark green on grey, the 2006 regional plate.
  static final PlateTheme regional2006 = _field(
    field: HaitiColors.grey,
    ink: HaitiColors.greenInk,
    inactive: HaitiColors.inactiveOnLight,
    borderWidthRatio: 0,
  );

  /// Navy on white, the 2003 private, location and transport plates.
  static final PlateTheme series2003 = _field(
    field: HaitiColors.white,
    ink: HaitiColors.navy,
    inactive: HaitiColors.inactiveOnLight,
  );

  /// Red on white in a red rim, the 1998 taxi, transport and international
  /// organisation plates.
  static final PlateTheme series1998 = _field(
    field: HaitiColors.cream,
    ink: HaitiColors.red,
    inactive: HaitiColors.inactiveOnLight,
  );
}

import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'nigeria_colors.dart';

/// One ink on a white field. No reference shows a rim line, so the border is
/// a thin 0.015 of the height and the corners round at 0.05; neither is
/// measured.
abstract final class NigeriaThemes {
  /// Private vehicles: blue.
  static final PlateTheme private = _ink(NigeriaColors.blue);

  /// Commercial vehicles: red (Lagos commercial artwork).
  static final PlateTheme commercial = _ink(NigeriaColors.red);
}

PlateTheme _ink(Color ink) => PlateTheme(
  plateBackground: NigeriaColors.white,
  plateBorder: NigeriaColors.rim,
  ink: ink,
  dividerColor: ink,
  borderWidthRatio: 0.015,
  plateRadiusRatio: 0.05,
  activeColor: ink,
  inactiveColor: NigeriaColors.inactive,
  alertColor: const Color(0xFFD32F2F),
);

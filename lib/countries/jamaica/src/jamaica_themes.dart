import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'jamaica_colors.dart';

abstract final class JamaicaThemes {
  /// Blue on white, framed in the blue.
  static final PlateTheme private = PlateTheme(
    plateBackground: JamaicaColors.white,
    plateBorder: JamaicaColors.blue,
    ink: JamaicaColors.blue,
    dividerColor: JamaicaColors.blue,
    borderWidthRatio: 0.03,
    plateRadiusRatio: 0.06,
    activeColor: JamaicaColors.blue,
    inactiveColor: JamaicaColors.inactiveOnLight,
    alertColor: const Color(0xFFD32F2F),
  );
}

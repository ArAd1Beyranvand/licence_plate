import 'package:flutter/widgets.dart' show Color;
import 'package:license_plate/core/plate_core.dart';

import 'canada_colors.dart';

/// One ink on one field with the rim in its own colour.
abstract final class CanadaThemes {
  static const Color _alert = Color(0xFFD32F2F);

  /// The reference has a white rim outside the green line; here the line sits
  /// on the edge.
  static final PlateTheme federal = PlateTheme(
    plateBackground: CanadaColors.federalField,
    plateBorder: CanadaColors.federalGreen,
    ink: CanadaColors.federalInk,
    dividerColor: CanadaColors.federalGreen,
    borderWidthRatio: 0.012,
    plateRadiusRatio: 0.06,
    activeColor: CanadaColors.federalInk,
    inactiveColor: CanadaColors.inactive,
    alertColor: _alert,
  );

  /// Square corners: the permit is a paper sticker.
  static final PlateTheme permit = PlateTheme(
    plateBackground: CanadaColors.permitField,
    plateBorder: CanadaColors.permitBlue,
    ink: CanadaColors.permitInk,
    dividerColor: CanadaColors.permitBlue,
    borderWidthRatio: 0.025,
    plateRadiusRatio: 0,
    activeColor: CanadaColors.permitBlue,
    inactiveColor: CanadaColors.inactive,
    alertColor: _alert,
  );
}

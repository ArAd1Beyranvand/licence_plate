import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'australia_colors.dart';

/// The Australian liveries: one ink on one field, framed in the ink.
///
/// Rim and corner ratios are of the canvas height (183): a ~4 unit embossed
/// rim and a ~8 unit corner. **Not measured** — the flattened photographs
/// carry the mount's shadow at the edge; `// CALIBRATE`.
abstract final class AustraliaThemes {
  static PlateTheme _field(Color field, Color ink) => PlateTheme(
    plateBackground: field,
    plateBorder: ink,
    ink: ink,
    dividerColor: ink,
    borderWidthRatio: 0.022,
    plateRadiusRatio: 0.044,
    activeColor: ink,
    inactiveColor: AustraliaColors.inactiveOnLight,
    alertColor: const Color(0xFFD32F2F),
  );

  static final PlateTheme nsw = _field(
    AustraliaColors.nswYellow,
    AustraliaColors.nswBlack,
  );
  static final PlateTheme nt = _field(
    AustraliaColors.ntField,
    AustraliaColors.ntRed,
  );
  static final PlateTheme federalInterstate = _field(
    AustraliaColors.firsYellow,
    AustraliaColors.firsGreen,
  );
  static final PlateTheme act = _field(
    AustraliaColors.actField,
    AustraliaColors.actBlue,
  );
  static final PlateTheme qld = _field(
    AustraliaColors.qldField,
    AustraliaColors.qldMaroon,
  );
  static final PlateTheme sa = _field(
    AustraliaColors.saField,
    AustraliaColors.saBlack,
  );
  static final PlateTheme tas = _field(
    AustraliaColors.tasField,
    AustraliaColors.tasBlue,
  );
  static final PlateTheme vic = _field(
    AustraliaColors.vicField,
    AustraliaColors.vicBlue,
  );
  static final PlateTheme wa = _field(
    AustraliaColors.waField,
    AustraliaColors.waBlue,
  );
  static final PlateTheme nationalHeavyVehicle = _field(
    AustraliaColors.heavyField,
    AustraliaColors.heavyBlack,
  );
  static final PlateTheme army = _field(
    AustraliaColors.armyField,
    AustraliaColors.armyGreen,
  );
  static final PlateTheme airForce = _field(
    AustraliaColors.airForceField,
    AustraliaColors.airForceNavy,
  );
  static final PlateTheme defence = _field(
    AustraliaColors.defenceField,
    AustraliaColors.defenceBlue,
  );
  static final PlateTheme diplomatic = _field(
    AustraliaColors.diplomaticBlue,
    AustraliaColors.diplomaticBlack,
  );
}

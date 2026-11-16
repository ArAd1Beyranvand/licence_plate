import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'palau_colors.dart';

/// The Palauan liveries: one ink on one field, framed in the ink.
///
/// Rim and corner are **not measured**: the flattened photos do not isolate
/// the rim, so both ratios are one estimate from the sheet (a thin rim, a
/// ~5% corner) shared by every livery.
abstract final class PalauThemes {
  static PlateTheme _livery(Color field, Color ink, {bool dark = false}) =>
      PlateTheme.monochrome(
        field: field,
        ink: ink,
        inactive: dark
            ? PalauColors.inactiveOnDark
            : PalauColors.inactiveOnLight,
        borderWidthRatio: 0.012,
        plateRadiusRatio: 0.05,
      );

  static final PlateTheme airai = _livery(
    PalauColors.airaiField,
    PalauColors.airaiInk,
    dark: true,
  );
  static final PlateTheme angaur = _livery(
    PalauColors.angaurField,
    PalauColors.angaurInk,
  );
  static final PlateTheme kayangel = _livery(
    PalauColors.kayangelField,
    PalauColors.kayangelInk,
  );
  static final PlateTheme koror = _livery(
    PalauColors.kororField,
    PalauColors.kororInk,
  );
  static final PlateTheme kororBlack = _livery(
    PalauColors.kororBlackField,
    PalauColors.kororBlackInk,
  );
  static final PlateTheme melekeok = _livery(
    PalauColors.melekeokField,
    PalauColors.melekeokInk,
  );
  static final PlateTheme ngaraard = _livery(
    PalauColors.ngaraardField,
    PalauColors.ngaraardInk,
  );
  static final PlateTheme ngarchelong = _livery(
    PalauColors.ngarchelongField,
    PalauColors.ngarchelongInk,
  );
  static final PlateTheme ngardmau = _livery(
    PalauColors.ngardmauField,
    PalauColors.ngardmauInk,
  );
  static final PlateTheme ngardmauGovernment = _livery(
    PalauColors.ngardmauGovernmentField,
    PalauColors.ngardmauGovernmentInk,
  );
  static final PlateTheme ngatpang = _livery(
    PalauColors.ngatpangField,
    PalauColors.ngatpangInk,
  );
  static final PlateTheme ngeremlengui = _livery(
    PalauColors.ngeremlenguiField,
    PalauColors.ngeremlenguiInk,
    dark: true,
  );
  static final PlateTheme ngiwal = _livery(
    PalauColors.ngiwalField,
    PalauColors.ngiwalInk,
    dark: true,
  );
  static final PlateTheme peleliu = _livery(
    PalauColors.peleliuField,
    PalauColors.peleliuInk,
  );
  static final PlateTheme aimeliik = _livery(
    PalauColors.aimeliikField,
    PalauColors.aimeliikInk,
  );
  static final PlateTheme government = _livery(
    PalauColors.governmentField,
    PalauColors.governmentInk,
  );
  static final PlateTheme judiciary = _livery(
    PalauColors.judiciaryField,
    PalauColors.judiciaryInk,
  );
  static final PlateTheme diplomatic = _livery(
    PalauColors.diplomaticField,
    PalauColors.diplomaticInk,
  );
  static final PlateTheme museum = _livery(
    PalauColors.museumField,
    PalauColors.museumInk,
  );
}

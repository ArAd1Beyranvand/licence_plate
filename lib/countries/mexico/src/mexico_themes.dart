import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'mexico_colors.dart';

/// The Mexican liveries: one ink on one field, framed in the ink.
///
/// The article's size is 300 × 150 mm. The rim and the corner are not
/// measured (every reference is a photograph): the rim is read as ~1% of the
/// height and the corner as ~8%, estimates by eye.
abstract final class MexicoThemes {
  static PlateTheme _livery({
    required Color field,
    required Color ink,
    required Color inactive,
    double borderWidthRatio = 0.01,
  }) => PlateTheme(
    plateBackground: field,
    plateBorder: ink,
    ink: ink,
    dividerColor: ink,
    borderWidthRatio: borderWidthRatio,
    plateRadiusRatio: 0.08,
    activeColor: ink,
    inactiveColor: inactive,
    alertColor: const Color(0xFFD32F2F),
  );

  /// Near-black on a cool white: most states.
  static final PlateTheme standard = _livery(
    field: MexicoColors.white,
    ink: MexicoColors.black,
    inactive: MexicoColors.inactiveOnLight,
  );

  static final PlateTheme campeche = _livery(
    field: MexicoColors.campecheField,
    ink: MexicoColors.black,
    inactive: MexicoColors.inactiveOnDark,
  );

  static final PlateTheme oaxaca = _livery(
    field: MexicoColors.oaxacaField,
    ink: MexicoColors.oaxacaInk,
    inactive: MexicoColors.inactiveOnLight,
  );

  static final PlateTheme sonora = _livery(
    field: MexicoColors.sonoraField,
    ink: MexicoColors.sonoraInk,
    inactive: MexicoColors.inactiveOnDark,
  );

  static final PlateTheme sanLuisPotosi = _livery(
    field: MexicoColors.slpField,
    ink: MexicoColors.slpInk,
    inactive: MexicoColors.inactiveOnLight,
  );

  static final PlateTheme veracruz = _livery(
    field: MexicoColors.veracruzField,
    ink: MexicoColors.veracruzInk,
    inactive: MexicoColors.inactiveOnLight,
  );

  static final PlateTheme antique = _livery(
    field: MexicoColors.antiqueField,
    ink: MexicoColors.antiqueInk,
    inactive: MexicoColors.inactiveOnLight,
  );

  static final PlateTheme tourism = _livery(
    field: MexicoColors.spfField,
    ink: MexicoColors.spfInk,
    inactive: MexicoColors.inactiveOnDark,
  );

  /// Green on white with a heavier rim: the 1992 national series.
  static final PlateTheme legacy = _livery(
    field: MexicoColors.legacyField,
    ink: MexicoColors.legacyInk,
    inactive: MexicoColors.inactiveOnLight,
    borderWidthRatio: 0.025,
  );

  /// Liveries that differ from [standard], by the state name on the plate.
  static final Map<String, PlateTheme> _byState = <String, PlateTheme>{
    'CAMPECHE': campeche,
    'OAXACA': oaxaca,
    'SONORA': sonora,
    'SAN LUIS POTOSÍ': sanLuisPotosi,
    'VERACRUZ': veracruz,
  };

  /// The name-row slot's alphabet: one chosen value per state.
  static PlateAlphabet states(List<String> names) => PlateAlphabet(
    id: 'mx.state.${names.length}',
    characters: names,
    input: AlphabetInput.chosen,
  );

  /// [PlateSpec.resolveTheme] for the state specs.
  static PlateTheme byState(
    PlateTheme base,
    String Function(String key) group,
  ) {
    final t = _byState[group('state')] ?? standard;
    return base.copyWith(
      plateBackground: t.plateBackground,
      plateBorder: t.plateBorder,
      ink: t.ink,
      dividerColor: t.dividerColor,
      activeColor: t.activeColor,
      inactiveColor: t.inactiveColor,
    );
  }
}

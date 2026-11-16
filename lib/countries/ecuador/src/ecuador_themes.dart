import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'ecuador_colors.dart';

/// The Ecuadorian liveries: black on a white-silver face, framed in a thin
/// grey rim, with the top band in the category's colour.
///
/// The band is the theme's `dividerColor`, which the spec's background paints
/// as `PlateFill.divider`; a private plate's band is the face colour, so it
/// shows no band. The rim is ~1 unit of the 200-unit height and the corner
/// radius ~6, off the artwork flattened to 520×200.
abstract final class EcuadorThemes {
  static PlateTheme _livery(Color band) => PlateTheme(
    plateBackground: EcuadorColors.face,
    plateBorder: EcuadorColors.rim,
    ink: EcuadorColors.ink,
    dividerColor: band,
    borderWidthRatio: 0.006,
    plateRadiusRatio: 0.03,
    activeColor: EcuadorColors.ink,
    inactiveColor: EcuadorColors.inactiveOnLight,
  );

  /// Private vehicles: no band.
  static final PlateTheme private = _livery(EcuadorColors.face);

  /// Commercial vehicles (second letter A, U, Z).
  static final PlateTheme commercial = _livery(EcuadorColors.orange);

  /// Government (E) and official-use (X) vehicles.
  static final PlateTheme government = _livery(EcuadorColors.gold);

  /// Decentralised autonomous governments (M, S).
  static final PlateTheme municipal = _livery(EcuadorColors.lime);

  /// Diplomatic service: CC, CD, OI, AT.
  static final PlateTheme diplomatic = _livery(EcuadorColors.blue);

  /// International organisations: IT.
  static final PlateTheme international = _livery(EcuadorColors.red);
}

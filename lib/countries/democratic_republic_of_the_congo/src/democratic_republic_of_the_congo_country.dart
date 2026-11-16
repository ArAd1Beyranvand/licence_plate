import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'democratic_republic_of_the_congo_colors.dart';

/// The DRC as a `PlateCountry`. No plate prints a country block — the private
/// plate's flag is a decal on the spec — so every spec sets `noPanel`.
abstract final class DemocraticRepublicOfTheCongoCountry {
  /// Sky-blue field, a yellow-edged red band from bottom left to top right, a
  /// yellow star top left. 920×680 matches the 46×34 box it is printed in.
  static const PlateDrawing flagDrawing = PlateDrawing(920, 680, <PlateShape>[
    PlateRectShape(0, 0, 920, 680, DemocraticRepublicOfTheCongoColors.flagBlue),
    PlatePolygonShape(<Offset>[
      Offset(0, 510),
      Offset(690, 0),
      Offset(920, 0),
      Offset(920, 170),
      Offset(230, 680),
      Offset(0, 680),
    ], DemocraticRepublicOfTheCongoColors.flagYellow),
    PlatePolygonShape(<Offset>[
      Offset(0, 560),
      Offset(757.65, 0),
      Offset(920, 0),
      Offset(920, 120),
      Offset(162.35, 680),
      Offset(0, 680),
    ], DemocraticRepublicOfTheCongoColors.flagRed),
    PlateStarShape(
      165,
      170,
      115,
      DemocraticRepublicOfTheCongoColors.flagYellow,
    ),
  ]);

  // ignore: constant_identifier_names
  static const PlateCountry democratic_republic_of_the_congo = PlateCountry(
    code: 'cd',
    panelColor: DemocraticRepublicOfTheCongoColors.flagBlue,
    panelTextColor: DemocraticRepublicOfTheCongoColors.white,
    flagAspectRatio: 3 / 2,
    flag: flagDrawing,
  );
}

import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'georgia_country_colors.dart';

/// Georgia as a `PlateCountry`.
///
/// The flag is drawn in code, 30×20 (Wikimedia `Flag_of_Georgia.svg`): a red
/// St George's cross over white, and a bolnur-katskhi cross in each quarter.
/// The small crosses are drawn as plain crosses, 1.4 × 4.2 — the flag is
/// ~25 units wide on a plate, where the splayed arms are not legible.
abstract final class GeorgiaCountryCountry {
  static const Color _r = GeorgiaCountryColors.flagRed;

  static const PlateDrawing _flag = PlateDrawing(30, 20, <PlateShape>[
    PlateRectShape(0, 0, 30, 20, GeorgiaCountryColors.white),
    PlateRectShape(13, 0, 4, 20, _r),
    PlateRectShape(0, 8, 30, 4, _r),
    // Quarter crosses, centred (6.5, 4) (23.5, 4) (6.5, 16) (23.5, 16).
    PlateRectShape(5.8, 1.9, 1.4, 4.2, _r),
    PlateRectShape(4.4, 3.3, 4.2, 1.4, _r),
    PlateRectShape(22.8, 1.9, 1.4, 4.2, _r),
    PlateRectShape(21.4, 3.3, 4.2, 1.4, _r),
    PlateRectShape(5.8, 13.9, 1.4, 4.2, _r),
    PlateRectShape(4.4, 15.3, 4.2, 1.4, _r),
    PlateRectShape(22.8, 13.9, 1.4, 4.2, _r),
    PlateRectShape(21.4, 15.3, 4.2, 1.4, _r),
  ]);

  /// The blue strip: flag over `GE`, white.
  static const PlateCountry georgia_country = PlateCountry(
    code: 'ge',
    captionLines: <String>['GE'],
    panelColor: GeorgiaCountryColors.euroBlue,
    panelTextColor: GeorgiaCountryColors.white,
    flagAspectRatio: 3 / 2,
    flag: _flag,
  );

  /// The transit plate prints the flag and `GE` in ink on the white field.
  static const PlateCountry transit = PlateCountry(
    code: 'ge',
    captionLines: <String>['GE'],
    panelColor: GeorgiaCountryColors.white,
    panelTextColor: GeorgiaCountryColors.black,
    flagAspectRatio: 3 / 2,
    flag: _flag,
  );

  /// Military: a green strip carrying a stacked `G A`, set on the spec.
  static const PlateCountry military = PlateCountry(
    code: 'ge',
    panelColor: GeorgiaCountryColors.militaryGreen,
    panelTextColor: GeorgiaCountryColors.militaryInk,
    flagAspectRatio: 3 / 2,
    flag: _flag,
  );

  /// Plates with no block: export, mission, embassy.
  static const PlateCountry plain = PlateCountry(
    code: 'ge',
    panelColor: GeorgiaCountryColors.white,
    panelTextColor: GeorgiaCountryColors.black,
    flagAspectRatio: 3 / 2,
    flag: _flag,
  );
}

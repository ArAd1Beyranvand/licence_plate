import 'package:license_plate/core/plate_core.dart';

import 'denmark_colors.dart';

/// Denmark's EU stripe (ring of stars over `DK`) and the Faroese panel (flag
/// over `FO`). Plates without a stripe set `noPanel`.
abstract final class DenmarkCountry {
  static const PlateCountry denmark = PlateCountry(
    code: 'dk',
    captionLines: <String>['DK'],
    panelColor: DenmarkColors.euBlue,
    panelTextColor: DenmarkColors.white,
    flagAspectRatio: 3 / 2,
    flag: EuropeanStars.flag,
  );

  /// 22:16, a red cross edged in blue on white; each bar is 2 wide with a
  /// 1-wide edge, centred 8 from the hoist and top.
  static const PlateDrawing _faroeFlag = PlateDrawing(220, 160, <PlateShape>[
    PlateRectShape(0, 0, 220, 160, DenmarkColors.white),
    PlateRectShape(60, 0, 40, 160, DenmarkColors.faroeFlagBlue),
    PlateRectShape(0, 60, 220, 40, DenmarkColors.faroeFlagBlue),
    PlateRectShape(70, 0, 20, 160, DenmarkColors.faroeFlagRed),
    PlateRectShape(0, 70, 220, 20, DenmarkColors.faroeFlagRed),
  ]);

  static const PlateCountry faroeIslands = PlateCountry(
    code: 'fo',
    captionLines: <String>['FO'],
    panelColor: DenmarkColors.faroePanel,
    panelTextColor: DenmarkColors.white,
    flagAspectRatio: 22 / 16,
    flag: _faroeFlag,
  );
}

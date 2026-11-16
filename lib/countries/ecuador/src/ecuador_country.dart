import 'package:license_plate/core/plate_core.dart';

import 'ecuador_colors.dart';

/// Ecuador as a `PlateCountry`. No Ecuadorian plate prints a country block
/// (the word ECUADOR is a caption and the ANT mark a decal), so every spec
/// sets `noPanel` and this carries only the flag for hosts that list
/// countries.
///
/// The flag is the tricolour in 2:1:1 stripes. The coat of arms at its centre
/// is not drawn: the crest is a 280 kB artwork and is on no plate.
abstract final class EcuadorCountry {
  static const PlateDrawing _flag = PlateDrawing(900, 600, <PlateShape>[
    PlateRectShape(0, 0, 900, 300, EcuadorColors.flagYellow),
    PlateRectShape(0, 300, 900, 150, EcuadorColors.flagBlue),
    PlateRectShape(0, 450, 900, 150, EcuadorColors.flagRed),
  ]);

  static const PlateCountry ecuador = PlateCountry(
    code: 'ec',
    panelColor: EcuadorColors.flagBlue,
    panelTextColor: EcuadorColors.face,
    flagAspectRatio: 3 / 2,
    flag: _flag,
  );
}

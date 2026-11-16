import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'rwanda_country.dart';

/// Ink positions in plate units (520×110), the mean of the front and back
/// photographs projected onto each axis; ink rows span y 19.8–89.
///
/// Ink is ~55% of its box, so 69-unit ink needs a 126-tall box, which the
/// 110-tall plate cannot hold. The box is 100 and the ink lands near 80% of
/// the photographs'.
abstract final class _Layout {
  static const double width = 520, height = 110, cy = 54.4, box = 100;
  static const double registerLeft = 65.5, registerRight = 213.6;
  static const double serialLeft = 261, serialRight = 456.9;
}

/// Text groups `register` and `serial`. Colour is the theme's: pair [plate]
/// with [RwandaThemes.front] or [RwandaThemes.back].
///
/// The photo prints `RAB 123C`, so the register is one three-letter run whose
/// first letter the validator expects to be `R`.
abstract final class RwandaPlates {
  static final PlateSpec plate = PlateSpec(
    id: 'rw.plate',
    country: RwandaCountry.rwanda,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    slots: <PlateSlot>[
      _field(
        RwandaAlphabets.letters,
        3,
        _Layout.registerLeft,
        _Layout.registerRight,
      ),
      _field(
        RwandaAlphabets.serial,
        4,
        _Layout.serialLeft,
        _Layout.serialRight,
      ),
    ],
    textGroups: PlateTextGroup.perSlot(<String>['register', 'serial']),
  );

  static List<PlateSpec> get all => <PlateSpec>[plate];

  static PlateSlot _field(
    PlateAlphabet alphabet,
    int count,
    double left,
    double right,
  ) => plateRun(
    alphabet,
    count,
    left: left,
    top: _Layout.cy - _Layout.box / 2,
    pitch: (right - left) / count,
    height: _Layout.box,
  );
}

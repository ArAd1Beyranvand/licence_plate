import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'zambia_country.dart';

/// Where the ink sits, in plate units.
///
/// `Zambia_plate_-_ADD4077T` flattened to 520×110 (the article's size) and
/// projected onto each axis. Ink y 19.25–95.25, centre 57.25. Ink x: letters
/// 58.25–196.5, digits 226.75–407.25, last letter 440.5–480.
///
/// The ink is 76 tall; at ~0.52 ink per box that needs a ~146 box on a 110
/// plate, so the box is capped near the canvas and the ink lands near 75% of
/// the photo's.
///
/// The photo's left badge (ZS mark, coat of arms, "ZAMBIA") is not drawn: no
/// vector of the coat of arms was fetched.
abstract final class _Layout {
  static const double width = 520, height = 110, cy = 57.25, box = 105;
  static const double lettersLeft = 58.25, lettersRight = 196.5;
  static const double digitsLeft = 226.75, digitsRight = 407.25;
  static const double suffixLeft = 440.5, suffixRight = 480;
}

/// The current plate, `ADD 4077 T`: three letters, four digits, one letter
/// (the picture; the article gives no format). Groups `prefix`, `serial`,
/// `suffix`. Older series are not implemented.
abstract final class ZambiaPlates {
  static final PlateSpec private = PlateSpec(
    id: 'zm.private',
    country: ZambiaCountry.zambia,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    slots: <PlateSlot>[
      _field(
        ZambiaAlphabets.letters,
        _Layout.lettersLeft,
        _Layout.lettersRight,
        3,
      ),
      _field(
        ZambiaAlphabets.digits,
        _Layout.digitsLeft,
        _Layout.digitsRight,
        4,
      ),
      _field(
        ZambiaAlphabets.letters,
        _Layout.suffixLeft,
        _Layout.suffixRight,
        1,
      ),
    ],
    textGroups: <PlateTextGroup>[
      PlateTextGroup(const <int>[0], key: 'prefix'),
      PlateTextGroup(const <int>[1], key: 'serial'),
      PlateTextGroup(const <int>[2], key: 'suffix'),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[private];

  static PlateSlot _field(
    PlateAlphabet alphabet,
    double left,
    double right,
    int length,
  ) => PlateSlot(
    alphabet: alphabet,
    box: PlateBox(
      left,
      _Layout.cy - _Layout.box / 2,
      right - left,
      _Layout.box,
    ),
    length: length,
  );
}

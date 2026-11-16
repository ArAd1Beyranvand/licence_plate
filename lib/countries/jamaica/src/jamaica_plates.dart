import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'jamaica_country.dart';

/// Where the ink sits, in plate units on a 520×260 canvas (the flattened
/// reference is 2.00; 152×300 mm is 1.97).
///
/// Measured off `License_plate_of_Jamaica`: one row, ink y 42–178.2, digits
/// x 26.2–310.5, letters x 357.8–492.8.
///
/// **Under-height serial, accepted.** The ink is 136 tall, which at ink ≈
/// 0.55 × box would need a ~248 box on a 260 canvas. The box is 140 (ink ~77,
/// ~57% of the reference); the real face is condensed, and a run wider than its
/// box is scaled down whole.
abstract final class _Layout {
  static const double width = 520, height = 260;

  static const double rowCenterY = 110.1, rowHeight = 140;

  static const double digitsLeft = 26.2, digitsWidth = 284.3;
  static const double lettersLeft = 357.8, lettersWidth = 135;
}

/// Jamaica's private-car plate: a four-digit field and a letter field.
///
/// Text groups: `serial` (four digits) and `letters`. The article gives
/// `1234 AB` for cars and `1234 A` for motorcycles in the same colours; the
/// picture is the two-letter form, so the letter field is one to two.
///
/// The other series (public red, commercial green, temporary blue, rental,
/// government yellow, military black, diplomatic) have no image, only prose
/// colours, so none is modelled.
abstract final class JamaicaPlates {
  static final PlateSpec private = PlateSpec(
    id: 'jm.private',
    country: JamaicaCountry.jamaica,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: JamaicaAlphabets.digits,
        box: PlateBox(
          _Layout.digitsLeft,
          _Layout.rowCenterY - _Layout.rowHeight / 2,
          _Layout.digitsWidth,
          _Layout.rowHeight,
        ),
        length: 4,
        group: 'serial',
      ),
      PlateSlot(
        alphabet: JamaicaAlphabets.letters,
        box: PlateBox(
          _Layout.lettersLeft,
          _Layout.rowCenterY - _Layout.rowHeight / 2,
          _Layout.lettersWidth,
          _Layout.rowHeight,
        ),
        length: 2,
        minLength: 1,
        group: 'letters',
      ),
    ],
  );
}

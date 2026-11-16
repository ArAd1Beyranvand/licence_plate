import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'grenada_country.dart';

/// Plate-unit measurements (300×152 mm) from the 392×196 artwork: six glyphs
/// at pitch 49.7, ink 64.4 tall centred at 76.4. Ink is ~55% of a box, so the
/// box is 117.
abstract final class _Layout {
  static const double width = 300, height = 152, box = 117, cy = 76.4;
  static const double pitch = 49.7, lettersLeft = 0.4, digitsLeft = 149.6;
}

/// Grenada's plates: [current] is `ABC 123`, black on yellow, one row.
///
/// Not implemented: the 1974 porcelain plate (historical) and the white front
/// plate (no picture or measurement).
abstract final class GrenadaPlates {
  /// The article's format is `ABC123`; the artwork prints `GAA 876`.
  static final PlateSpec current = PlateSpec(
    id: 'gd.current',
    country: GrenadaCountry.grenada,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    slots: const <PlateSlot>[
      PlateSlot(
        alphabet: GrenadaAlphabets.letters,
        box: PlateBox(
          _Layout.lettersLeft,
          _Layout.cy - _Layout.box / 2,
          3 * _Layout.pitch,
          _Layout.box,
        ),
        length: 3,
        group: 'letters',
      ),
      PlateSlot(
        alphabet: GrenadaAlphabets.digits,
        box: PlateBox(
          _Layout.digitsLeft,
          _Layout.cy - _Layout.box / 2,
          3 * _Layout.pitch,
          _Layout.box,
        ),
        length: 3,
        group: 'number',
      ),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[current];
}

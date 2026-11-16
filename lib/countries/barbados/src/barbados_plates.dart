import 'package:flutter/widgets.dart' show EdgeInsets;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'barbados_country.dart';
import 'barbados_regions.dart';

/// Where the ink sits, in plate units on a 520×110 canvas (the references
/// flattened at 4 px per unit).
///
/// Reference ink, white plate: letter `A` x 100.2–166.8, digits `4083`
/// x 217.5–418.8, both y 17.8–94. Black plate: `L` x 109.5–150.5, digits
/// `4159` x 239.8–406.5 (the narrow `1` shortens the run), y 17.8–90.8.
///
/// A box that tall (76) would need ~138 on a 110 plate, so each box is the full
/// canvas height and the ink lands near 60, about 79% of reference. That is the
/// engine's limit, not a measurement. Centres: letters 133 (A 133.5, L 130),
/// digits 318 (white 318.2).
///
/// The reference shows a single letter, but a second may follow (`MA 999`), so
/// the letters slot is `minLength: 1, length: 2`; digits run one to four.
abstract final class _Layout {
  static const double width = 520, height = 110;
  static const double lettersCx = 133, lettersWidth = 110;
  static const double digitsCx = 318, digitsWidth = 208;
}

PlateSpec _plate(String id) => PlateSpec(
  id: id,
  country: BarbadosCountry.barbados,
  canvasWidth: _Layout.width,
  canvasHeight: _Layout.height,
  panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
  noPanel: true,
  background: PlateSection.plain,
  slots: <PlateSlot>[
    PlateSlot(
      alphabet: BarbadosAlphabets.letters,
      box: PlateBox(
        _Layout.lettersCx - _Layout.lettersWidth / 2,
        0,
        _Layout.lettersWidth,
        _Layout.height,
      ),
      length: 2,
      minLength: 1,
      group: 'letters',
    ),
    PlateSlot(
      alphabet: BarbadosAlphabets.digits,
      box: PlateBox(
        _Layout.digitsCx - _Layout.digitsWidth / 2,
        0,
        _Layout.digitsWidth,
        _Layout.height,
      ),
      length: 4,
      minLength: 1,
      group: 'digits',
    ),
  ],
  resolveRegion: BarbadosRegions.captionOf,
);

/// The front and rear plates share one layout and differ only in the theme
/// the host passes (`BarbadosThemes.black` / `.white`). The special series are prefixes in the
/// same format with no reference graphics, so none is implemented.
abstract final class BarbadosPlates {
  static final PlateSpec standard = _plate('bb.standard');

  static List<PlateSpec> get all => <PlateSpec>[standard];
}

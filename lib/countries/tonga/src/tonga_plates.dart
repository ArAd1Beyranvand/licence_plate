import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'tonga_country.dart';

/// Where the ink sits, in plate units.
///
/// `Tonga_license_plate_graphic` flattened to 372×134 (the article's 372 mm ×
/// 134 mm): serial ink y 17–91.8 (74.8 tall, cy 54.4); letter ink x 27.2–66.5;
/// digit ink x 173.2–357 (five glyphs, `10792`); caption ink y 103–122 (19
/// tall, cy 112.5), x 134–219.8 (cx 176.9).
///
/// The reference serial would need a ~136-unit glyph box on a 134-unit plate,
/// so the box is 108 and the ink lands at ~79% of the reference. The caption
/// is sized from ink ÷ 0.55.
abstract final class _Layout {
  static const double width = 372, height = 134;

  static const double serialCy = 54.4, serialBox = 108;

  /// Centred on the letter ink; wide enough for the two-letter `MC`.
  static const double letterCx = 46.85, letterW = 60;

  /// Spans the digit ink, centred on it.
  static const double digitCx = 265.1, digitW = 192;

  static const double captionCx = 176.9, captionCy = 112.5;
  static const double captionW = 120, captionH = 34, captionGlyph = 34;
}

/// Tonga's current plate: a vehicle-type letter and up to five digits
/// (`C 12345`), white on black, with the word TONGA beneath. Groups `letters`,
/// `serial`. Pair with [TongaThemes.standard].
///
/// The letter field is one letter (B, C, G, H, J, L, P, R, T, V) or two (`MC`,
/// motorcycles; the royal and ministerial `HM`, `Q1`, `PM` are not modelled).
/// The article gives "1-5 digits"; the picture shows five.
///
/// Not implemented: the 1967 plate (`A 123`, white on black, no caption) and
/// the diplomatic plates (a country prefix such as AUST, EEC, NZ, UK, USA and a
/// number, black on white or yellow), for which no reference was measured. The
/// article names no Israel-specific value.
abstract final class TongaPlates {
  static final PlateSpec standard = PlateSpec(
    id: 'to.standard',
    country: TongaCountry.tonga,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: TongaAlphabets.letters,
        box: PlateBox.centered(
          _Layout.letterCx,
          _Layout.serialCy,
          _Layout.letterW,
          _Layout.serialBox,
        ),
        length: 2,
        minLength: 1,
        group: 'letters',
      ),
      PlateSlot(
        alphabet: TongaAlphabets.digits,
        box: PlateBox.centered(
          _Layout.digitCx,
          _Layout.serialCy,
          _Layout.digitW,
          _Layout.serialBox,
        ),
        length: 5,
        minLength: 1,
        group: 'serial',
      ),
    ],
    labels: <PlateLabel>[
      PlateLabel(
        text: 'TONGA',
        box: PlateBox.centered(
          _Layout.captionCx,
          _Layout.captionCy,
          _Layout.captionW,
          _Layout.captionH,
        ),
        glyphHeight: _Layout.captionGlyph,
      ),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[standard];
}

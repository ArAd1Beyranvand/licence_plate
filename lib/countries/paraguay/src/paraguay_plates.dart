import 'package:flutter/widgets.dart' show EdgeInsets;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'paraguay_colors.dart';
import 'paraguay_country.dart';

/// Where the ink sits, in plate units.
///
/// The canvas is the Mercosur size the article gives, 400×130. The reference
/// is the flat photograph (2080×652, plate units 500×157): x is scaled by 0.8
/// and y by 0.828.
///
/// Band: blue down to y 43.5 → 36 (the photograph's text-badge zone). `PARAGUAY`
/// in white, ink y 14.2–35 → 11.8–29, x 153–341 of the sheet → 122–273.
/// The flag sits at the right of the band, x 364–394, y 5.5–27.5.
///
/// Serial: ink y 48.8–145.2 → 40–120 (80 tall), column runs read off the
/// photograph: letters 19.5–235.6 (pitch 58.5 → 46.8), digits 276–439
/// (pitch 60.5 → 48.4). The brief's field spans (letters to 246.8, digits to
/// 499) include the sticker and the `D`; the column runs win. Ink is about 55%
/// of a box and the box cannot leave the canvas, so the serial is a 100-box
/// centred on the ink (~55 ink, 69%).
///
/// Not drawn: the Mercosur logo and stars at the band's left, the national
/// emblem on the flag, the QR sticker, the duplicate-circle `D` and the
/// motorcycle plate (`123 ABC`, 200×130, no photograph).
abstract final class _Layout {
  static const double width = 400, height = 130;

  static const double bandEnd = 36;

  static const double serialTop = 30, serialHeight = 100;

  static const double lettersLeft = 8.4, lettersPitch = 46.8;
  static const double digitsLeft = 213.3, digitsPitch = 48.4;

  static const double captionCx = 197.5, captionCy = 20.5, captionWidth = 200;
  static const double captionGlyph = 31;
}

/// The Paraguayan plates. The Mercosur plate is `AAAA 123`: groups `letters`
/// and `number`. Colour is a theme: see `ParaguayThemes`.
abstract final class ParaguayPlates {
  static final PlateSpec mercosur = PlateSpec(
    id: 'py.mercosur',
    country: ParaguayCountry.paraguay,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, _Layout.height),
      padding: EdgeInsets.zero,
    ),
    background: const PlateSection.rows(<PlatePart>[
      PlatePart(
        PlateSection.fill(PlateFill.color(ParaguayColors.band)),
        end: _Layout.bandEnd,
      ),
      PlatePart(PlateSection.plain),
    ]),
    slots: <PlateSlot>[
      plateRun(
        ParaguayAlphabets.letters,
        4,
        left: _Layout.lettersLeft,
        top: _Layout.serialTop,
        pitch: _Layout.lettersPitch,
        height: _Layout.serialHeight,
        group: 'letters',
      ),
      plateRun(
        ParaguayAlphabets.digits,
        3,
        left: _Layout.digitsLeft,
        top: _Layout.serialTop,
        pitch: _Layout.digitsPitch,
        height: _Layout.serialHeight,
        group: 'number',
      ),
    ],
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'PARAGUAY',
        box: PlateBox(
          _Layout.captionCx - _Layout.captionWidth / 2,
          _Layout.captionCy - 11,
          _Layout.captionWidth,
          22,
        ),
        glyphHeight: _Layout.captionGlyph,
        color: ParaguayColors.bandText,
      ),
    ],
    decals: const <PlateDecal>[
      PlateDecal(
        drawing: ParaguayCountry.flag,
        box: PlateBox(364, 5.5, 30, 22),
      ),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[mercosur];
}

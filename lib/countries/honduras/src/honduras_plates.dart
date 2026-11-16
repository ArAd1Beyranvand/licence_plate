import 'package:flutter/widgets.dart' show Color;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'honduras_colors.dart';
import 'honduras_country.dart';

/// Where the ink sits, in plate units.
///
/// One photograph, flattened to 2080×1004 (`platekit`) and scaled to the
/// canvas. The article's 520×110 mm is the old long plate; the photo's aspect
/// is 2.07, so the canvas is 520×251 (the article's prose says 6×12 in).
///
/// Band: blue y 0–58.5. Flag y 13.5–47, x 8–67. `HONDURAS` white, ink
/// x 156–365, y 9–35. Serial ink y 61–191: `H` x 20.8–71.5, `AB` x 93.2–230.5
/// (pitch ~69), `0123` x 249.5–499 (pitch ~62). `CENTROAMÉRICA` blue, ink
/// x 131–390, y 203–237.
///
/// The reference face is condensed and tall: serial ink is 130 units, which at
/// 0.55 ink per box unit would need a 236-unit box on a 251-unit plate. The box
/// is 130, so ink is about half the reference height; a deliberate shortfall.
/// The validity sticker and QR code are not plate content and are omitted.
abstract final class _Layout {
  static const double width = 520, height = 251;

  static const double bandEnd = 58.5;

  static const double serialTop = 61, serialHeight = 130;
  static const double classLeft = 13, classWidth = 66;
  static const double seriesLeft = 93.2, seriesWidth = 137.3;
  static const double numberLeft = 249.5, numberWidth = 249.5;
  static const double seriesPitch = seriesWidth / 2;
  static const double numberPitch = numberWidth / 4;
}

/// Honduras's 2018 plate: `H AB 0123`, black on white under a blue band with
/// the flag and `HONDURAS`, `CENTROAMÉRICA` beneath. Pair [private] with
/// [HondurasThemes.private].
///
/// Groups: `class`, `series`, `serial`. Only the 2018 private design has a
/// photo; the article's older commercial, diplomatic, government, trailer and
/// light-truck formats are not implemented, and says new plates use only the
/// code `H` (`B` for motorcycles). The article names no Israel-specific value.
abstract final class HondurasPlates {
  static final PlateSpec private = PlateSpec(
    id: 'hn.private',
    country: HondurasCountry.honduras,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    background: const PlateSection.rows(<PlatePart>[
      PlatePart(
        PlateSection.fill(PlateFill.color(HondurasColors.blue)),
        end: _Layout.bandEnd,
      ),
      PlatePart(PlateSection.plain),
    ]),
    slots: <PlateSlot>[
      _field(
        HondurasAlphabets.letters,
        _Layout.classLeft,
        _Layout.classWidth,
        1,
      ),
      _field(
        HondurasAlphabets.letters,
        _Layout.seriesLeft,
        _Layout.seriesWidth,
        2,
        pitch: _Layout.seriesPitch,
      ),
      _field(
        HondurasAlphabets.digits,
        _Layout.numberLeft,
        _Layout.numberWidth,
        4,
        pitch: _Layout.numberPitch,
      ),
    ],
    decals: const <PlateDecal>[
      PlateDecal(
        drawing: HondurasCountry.flag,
        box: PlateBox(8, 13.5, 59, 29.5),
      ),
    ],
    labels: <PlateLabel>[
      _label('HONDURAS', 260.5, 22, 230, 46, HondurasColors.white),
      _label('CENTROAMÉRICA', 260.5, 220, 270, 38, HondurasColors.blue),
    ],
    textGroups: PlateTextGroup.perSlot(<String>['class', 'series', 'serial']),
  );

  static List<PlateSpec> get all => <PlateSpec>[private];

  static PlateSlot _field(
    PlateAlphabet alphabet,
    double left,
    double width,
    int length, {
    double pitch = 0,
  }) => PlateSlot(
    alphabet: alphabet,
    box: PlateBox(left, _Layout.serialTop, width, _Layout.serialHeight),
    length: length,
    spacing: plateRunSpacing(pitch, _Layout.serialHeight),
  );

  static PlateLabel _label(
    String text,
    double cx,
    double cy,
    double w,
    double glyph,
    Color color,
  ) => PlateLabel(
    text: text,
    box: PlateBox.centered(cx, cy, w, glyph),
    glyphHeight: glyph,
    color: color,
  );
}

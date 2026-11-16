import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'north_macedonia_colors.dart';
import 'north_macedonia_country.dart';
import 'north_macedonia_missions.dart';
import 'north_macedonia_regions.dart';

/// Where the ink sits, in plate units.
///
/// One line (520 × 110 mm, the article's size). Measured off the flattened
/// vector plates `North_Macedonia_license_plate_of_Demir_Kapija`, `Sk-lp` and
/// `Ka-lp` by column runs of the ink in the window x 56–512, y 10–100:
/// glyph cells are 37–40 wide at a 47.5 pitch, centres region 81.25 / 128.2,
/// digits 224.25 / 271.75 / 319.4 / 366.7, letters 426.5 / 474; ink is
/// y 19.5–89.8 (70 tall). Ink is ~55% of the box, so a full 110 box gives ~60,
/// 86% of the reference; the engine cannot go further inside the canvas. A
/// 110 box at a 47.5 pitch needs no extra letter spacing (0.6 × 0.72 × 110 =
/// 47.5). The blue band ends at 51 under the 5-wide frame (blue pixels
/// 7–52), `MK`/`NMK` in white at y 72–98. The red emblem block is x 160–194.5,
/// y 37–79.5 (`ED1C24`), the Cyrillic echo of the area code in its top half
/// and of the series letters in its bottom half.
///
/// Two-row (the KS and VA photos, 140 × 89 px, aspect 1.57; the article gives
/// no size, so the canvas is 240 × 153 at the same aspect, ×1.714): the area
/// code on top (ink px y 9–40, cells 40–55 / 62–77), the number and series
/// below (px y 48–79, digits 10–25 … 70–85 at a 20 pitch, letters 93–108 /
/// 114–130), the band on the top row only (px x 5–23, y 5–41), the emblem
/// px x 93–108, y 16–32. Ink there is 31 px = 53 units; a 78 box gives ~43
/// (81%), so a row cannot be taller without crossing its neighbour.
///
/// Diplomatic (the `92-CMD-01` photo, flattened to 520 × 110, ink y 7.5–99.8):
/// `92` x 66.5–162.5, `CMD` x 189–334.5, `01` from x 361, dashes between. The
/// photo is a dark plate with white ink and no printed frame, and `MK` stacked
/// at the left edge. The serial box is 110 wide so a third digit (`001` on the
/// `09-CC-001` photo) shrinks to fit rather than running into the sticker.
abstract final class _Layout {
  // One line.
  static const double width = 520, height = 110, bandEnd = 51, pitch = 47.5;
  static const double regionLeft = 57.5, regionWidth = 95;
  static const double digitsLeft = 200.5, digitsWidth = 190;
  static const double lettersLeft = 402.75, lettersWidth = 95;
  static const double emblemLeft = 160, emblemTop = 37;
  static const double emblemWidth = 34.5, emblemHeight = 42.5, echoGlyph = 24;
  static const PlateBox codeBox = PlateBox(5, 72, 46, 26);
  static const double codeGlyph = 24;

  // Two rows.
  static const double rowsWidth = 240, rowsHeight = 153;
  static const double rowsBandEnd = 40.3, rowsBandBottom = 70;
  static const double rowTopTop = 3, rowBottomTop = 70, rowHeight = 78;
  static const double rowsRegionLeft = 62.6, rowsRegionWidth = 75.4;
  static const double rowsRegionPitch = 37.7;
  static const double rowsDigitsLeft = 12.9, rowsDigitsWidth = 137.1;
  static const double rowsDigitsPitch = 34.3;
  static const double rowsLettersLeft = 153.9, rowsLettersWidth = 73.7;
  static const double rowsLettersPitch = 36.9;
  static const double rowsEmblemLeft = 159.4, rowsEmblemTop = 27.5;
  static const double rowsEmblemWidth = 27.5, rowsEmblemHeight = 28;
  static const double rowsEchoGlyph = 16;
  static const PlateBox rowsCodeBox = PlateBox(7, 54, 33, 17);
  static const double rowsCodeGlyph = 18;

  // Diplomatic.
  static const double dipMissionLeft = 66.5, dipMissionWidth = 96;
  static const double dipTypeLeft = 189, dipTypeWidth = 146;
  static const double dipSerialLeft = 361, dipSerialWidth = 110;
  static const double dashWidth = 24, dashAt1 = 175, dashAt2 = 347;
  static const double mkLeft = 8, mkWidth = 30, mkHeight = 45, mkGlyph = 40;
}

/// Extra letter spacing that puts a run at its printed [pitch].
double _spacing(double pitch, double height) => plateRunSpacing(pitch, height);

/// The North Macedonian plates.
///
/// [standard] and [legacy] share [_oneLine]: `BT [emblem] 1234 AA`, the area
/// code, a red block echoing the code and the series in Cyrillic, the four
/// digits and two series letters; [standard] is the 2019 plate with `NMK` on
/// the band and [legacy] the 2012–2019 one with `MK`, which is still on the
/// road. [twoRow] is the short plate (`KS` over `1234 AB`). [diplomatic] is
/// `92 CMD 01` in white on black; the mission code `35` is refused.
///
/// Not implemented: the pre-2012 plate (superseded; its `BT-854-CH` layout
/// has a different structure), the square three-row motorcycle plates in the
/// `MB`/`MK` photos (no consistent size: 104 × 104 and 88 × 113 px), the
/// vanity `MACEDONIA` plate, the unofficial Cyrillic proposal, and the police
/// (blue ink, rear only), dealer and temporary series the article describes
/// without a reference. The emblem's Cyrillic echo is drawn in the theme's ink
/// (black), where the real block prints it in yellow, as a mirror cannot carry
/// its own colour.
///
/// Every field is one slot: area code (two letters), number (four digits),
/// series (two letters). The diplomatic class letters are two or three and the
/// serial two or three digits, one slot each with a `minLength`.
abstract final class NorthMacedoniaPlates {
  static final PlateSpec standard = _oneLine(id: 'mk.standard', code: 'NMK');

  static final PlateSpec legacy = _oneLine(id: 'mk.legacy', code: 'MK');

  static final PlateSpec twoRow = _twoRow();

  static final PlateSpec diplomatic = _diplomatic();

  static List<PlateSpec> get all => <PlateSpec>[
    standard,
    legacy,
    twoRow,
    diplomatic,
  ];
}

const PlateSection _bandedBackground = PlateSection.columns(<PlatePart>[
  PlatePart(PlateSection.fill(PlateFill.panel), end: _Layout.bandEnd),
  PlatePart(PlateSection.plain),
]);

const PlateSection _twoRowBackground = PlateSection.columns(<PlatePart>[
  PlatePart(
    PlateSection.rows(<PlatePart>[
      PlatePart(
        PlateSection.fill(PlateFill.panel),
        end: _Layout.rowsBandBottom,
      ),
      PlatePart(PlateSection.plain),
    ]),
    end: _Layout.rowsBandEnd,
  ),
  PlatePart(PlateSection.plain),
]);

const List<PlateTextGroup> _fieldGroups = <PlateTextGroup>[
  PlateTextGroup(<int>[0], key: 'region'),
  PlateTextGroup(<int>[1], key: 'digits'),
  PlateTextGroup(<int>[2], key: 'letters'),
];

PlateSpec _oneLine({required String id, required String code}) => PlateSpec(
  id: id,
  country: NorthMacedoniaCountry.north_macedonia,
  canvasWidth: _Layout.width,
  canvasHeight: _Layout.height,
  background: _bandedBackground,
  slots: <PlateSlot>[
    PlateSlot(
      alphabet: NorthMacedoniaAlphabets.regionLetters,
      box: const PlateBox(
        _Layout.regionLeft,
        0,
        _Layout.regionWidth,
        _Layout.height,
      ),
      length: 2,
      spacing: _spacing(_Layout.pitch, _Layout.height),
    ),
    PlateSlot(
      alphabet: NorthMacedoniaAlphabets.digits,
      box: const PlateBox(
        _Layout.digitsLeft,
        0,
        _Layout.digitsWidth,
        _Layout.height,
      ),
      length: 4,
      spacing: _spacing(_Layout.pitch, _Layout.height),
    ),
    PlateSlot(
      alphabet: NorthMacedoniaAlphabets.letters,
      box: const PlateBox(
        _Layout.lettersLeft,
        0,
        _Layout.lettersWidth,
        _Layout.height,
      ),
      length: 2,
      spacing: _spacing(_Layout.pitch, _Layout.height),
    ),
  ],
  mirrors: const <PlateMirror>[
    PlateMirror(
      source: 0,
      box: PlateBox(
        _Layout.emblemLeft,
        _Layout.emblemTop,
        _Layout.emblemWidth,
        _Layout.emblemHeight / 2,
      ),
      glyphHeight: _Layout.echoGlyph,
      alphabet: NorthMacedoniaAlphabets.regionCyrillic,
    ),
    PlateMirror(
      source: 2,
      box: PlateBox(
        _Layout.emblemLeft,
        _Layout.emblemTop + _Layout.emblemHeight / 2,
        _Layout.emblemWidth,
        _Layout.emblemHeight / 2,
      ),
      glyphHeight: _Layout.echoGlyph,
      alphabet: NorthMacedoniaAlphabets.lettersCyrillic,
    ),
  ],
  bands: const <PlateBand>[
    PlateBand(
      box: PlateBox(
        _Layout.emblemLeft,
        _Layout.emblemTop,
        _Layout.emblemWidth,
        _Layout.emblemHeight,
      ),
      color: NorthMacedoniaColors.emblem,
    ),
  ],
  labels: <PlateLabel>[
    PlateLabel(
      text: code,
      box: _Layout.codeBox,
      glyphHeight: _Layout.codeGlyph,
      color: NorthMacedoniaColors.white,
    ),
  ],
  textGroups: _fieldGroups,
  resolveRegion: NorthMacedoniaRegions.captionOf,
);

PlateSpec _twoRow() => PlateSpec(
  id: 'mk.two_row',
  country: NorthMacedoniaCountry.north_macedonia,
  canvasWidth: _Layout.rowsWidth,
  canvasHeight: _Layout.rowsHeight,
  background: _twoRowBackground,
  slots: <PlateSlot>[
    PlateSlot(
      alphabet: NorthMacedoniaAlphabets.regionLetters,
      box: const PlateBox(
        _Layout.rowsRegionLeft,
        _Layout.rowTopTop,
        _Layout.rowsRegionWidth,
        _Layout.rowHeight,
      ),
      length: 2,
      spacing: _spacing(_Layout.rowsRegionPitch, _Layout.rowHeight),
    ),
    PlateSlot(
      alphabet: NorthMacedoniaAlphabets.digits,
      box: const PlateBox(
        _Layout.rowsDigitsLeft,
        _Layout.rowBottomTop,
        _Layout.rowsDigitsWidth,
        _Layout.rowHeight,
      ),
      length: 4,
      spacing: _spacing(_Layout.rowsDigitsPitch, _Layout.rowHeight),
    ),
    PlateSlot(
      alphabet: NorthMacedoniaAlphabets.letters,
      box: const PlateBox(
        _Layout.rowsLettersLeft,
        _Layout.rowBottomTop,
        _Layout.rowsLettersWidth,
        _Layout.rowHeight,
      ),
      length: 2,
      spacing: _spacing(_Layout.rowsLettersPitch, _Layout.rowHeight),
    ),
  ],
  mirrors: const <PlateMirror>[
    PlateMirror(
      source: 0,
      box: PlateBox(
        _Layout.rowsEmblemLeft,
        _Layout.rowsEmblemTop,
        _Layout.rowsEmblemWidth,
        _Layout.rowsEmblemHeight / 2,
      ),
      glyphHeight: _Layout.rowsEchoGlyph,
      alphabet: NorthMacedoniaAlphabets.regionCyrillic,
    ),
    PlateMirror(
      source: 2,
      box: PlateBox(
        _Layout.rowsEmblemLeft,
        _Layout.rowsEmblemTop + _Layout.rowsEmblemHeight / 2,
        _Layout.rowsEmblemWidth,
        _Layout.rowsEmblemHeight / 2,
      ),
      glyphHeight: _Layout.rowsEchoGlyph,
      alphabet: NorthMacedoniaAlphabets.lettersCyrillic,
    ),
  ],
  bands: const <PlateBand>[
    PlateBand(
      box: PlateBox(
        _Layout.rowsEmblemLeft,
        _Layout.rowsEmblemTop,
        _Layout.rowsEmblemWidth,
        _Layout.rowsEmblemHeight,
      ),
      color: NorthMacedoniaColors.emblem,
    ),
  ],
  labels: const <PlateLabel>[
    PlateLabel(
      text: 'NMK',
      box: _Layout.rowsCodeBox,
      glyphHeight: _Layout.rowsCodeGlyph,
      color: NorthMacedoniaColors.white,
    ),
  ],
  textGroups: _fieldGroups,
  resolveRegion: NorthMacedoniaRegions.captionOf,
);

PlateSpec _diplomatic() => PlateSpec(
  id: 'mk.diplomatic',
  country: NorthMacedoniaCountry.north_macedonia,
  canvasWidth: _Layout.width,
  canvasHeight: _Layout.height,
  slots: <PlateSlot>[
    PlateSlot(
      alphabet: NorthMacedoniaAlphabets.digits,
      box: const PlateBox(
        _Layout.dipMissionLeft,
        0,
        _Layout.dipMissionWidth,
        _Layout.height,
      ),
      length: 2,
      spacing: _spacing(_Layout.dipMissionWidth / 2, _Layout.height),
      group: 'mission',
    ),
    const PlateSlot(
      alphabet: NorthMacedoniaAlphabets.diplomaticLetters,
      box: PlateBox(
        _Layout.dipTypeLeft,
        0,
        _Layout.dipTypeWidth,
        _Layout.height,
      ),
      length: 3,
      minLength: 2,
      group: 'type',
    ),
    const PlateSlot(
      alphabet: NorthMacedoniaAlphabets.digits,
      box: PlateBox(
        _Layout.dipSerialLeft,
        0,
        _Layout.dipSerialWidth,
        _Layout.height,
      ),
      length: 3,
      minLength: 2,
      group: 'serial',
    ),
  ],
  labels: const <PlateLabel>[
    PlateLabel(
      text: 'M',
      box: PlateBox(_Layout.mkLeft, 8, _Layout.mkWidth, _Layout.mkHeight),
      glyphHeight: _Layout.mkGlyph,
    ),
    PlateLabel(
      text: 'K',
      box: PlateBox(_Layout.mkLeft, 57, _Layout.mkWidth, _Layout.mkHeight),
      glyphHeight: _Layout.mkGlyph,
    ),
    PlateLabel(
      text: '-',
      box: PlateBox(
        _Layout.dashAt1 - _Layout.dashWidth / 2,
        0,
        _Layout.dashWidth,
        _Layout.height,
      ),
      glyphHeight: _Layout.height,
    ),
    PlateLabel(
      text: '-',
      box: PlateBox(
        _Layout.dashAt2 - _Layout.dashWidth / 2,
        0,
        _Layout.dashWidth,
        _Layout.height,
      ),
      glyphHeight: _Layout.height,
    ),
  ],
  restrictions: const <PlateRestriction>[NorthMacedoniaMissions.restriction],
);

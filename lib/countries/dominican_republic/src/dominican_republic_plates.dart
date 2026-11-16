import 'package:flutter/widgets.dart' show Color, EdgeInsets;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'dominican_republic_colors.dart';
import 'dominican_republic_country.dart';

/// Where the ink sits, in plate units. The article gives 300 x 152 mm (the
/// North American 6 x 12 in), used as the canvas. Every number was measured
/// off the colour-balanced flat photos in `.plateref/do/` (plate units =
/// mm); glyph heights are ink / 0.55 per the engine's glyph-to-ink ratio.
///
/// Classic `123-456` (1990 `953-147`, 1980 `122-066`, 1994 `185-435`):
/// digit ink y 48.8-108.2 (1990), 47.2-107.0 (1980); fields x 18.8-129.0 and
/// 174.0-284.0 (1990), pitch 41.5; the hyphen sits between at x 143-160.
/// The 1980 fields sit 4-6 units further in (13.8-121.8, 167.0-283.5); one
/// layout serves all three, centred on the 1990 measurement. The ink is
/// ~60 tall against a 110 glyph, so the box is 104: three digits at the
/// reference's 41.5 pitch need a narrower face than the engine's, and this is
/// the largest that stays inside the field. Captions (ink y 125-141 on 1990):
/// "REP.DOMINICANA" x 61.5-242. The references letter them in a condensed
/// face; the engine's is wider, so captions are sized to the measured width,
/// not the measured height. The 1980 plate prints "PRIVADO" over a split
/// caption `REP.DOMINICANA` x 52.8-180.8 and `1o 1980` x 189-244.8. The 1994
/// "PRIVADO" is embossed in the field's own colour and its validation tabs
/// are stickers; neither is drawn.
///
/// Lettered `P06-2686` (1986): top legend `R.D. 1o 86` ink y 26.5-60; big
/// row y 67.5-127; P x 17-56, `06` x 66.5-126.5 (pitch 25), dot x 131-141,
/// `2686` x 145.8-279.2 (pitch 36). The article's `P01-2345` has the same
/// shape: a letter, two digits, four digits.
///
/// Exempt (2017 `EA 01320`): dark green head to y 44, white face to 121,
/// light green foot; ink y 54-119.8; `EA` x 22.5-90, digits x 107.2-276.5
/// (pitch 34.5). `REPUBLICA DOMINICANA` white on the head, ink y 29-40,
/// x 68-232; `EXONERADA ESTATAL AUTOMOVIL` y 129.5-138, x 51-243.
///
/// Not implemented: the 1930-1989 passenger plates (one per semester, colours
/// only, no photo for most); the 1996-2003 `LA-B123` plate, whose only photo
/// is an unusable crop of a door-side reflection (`corners_*1996-2003.png`);
/// and the 2018 paper temporary plate `X123456`, a printed sheet in a
/// laminated pouch with a handwritten expiry rather than a plate.
abstract final class _Layout {
  static const double width = 300, height = 152;

  // Classic.
  static const double classicGlyph = 104, classicCy = 78.6;
  static const double classicFieldWidth = 110;
  static const double classicLeftCx = 73.9, classicRightCx = 229;
  static const double classicDashCx = 151.5, classicDashWidth = 24;
  static const double captionCy = 133;

  // Lettered.
  static const double letteredGlyph = 88, letteredCy = 97.25;
  static const double letterCx = 36.6, letterWidth = 42;
  static const double headCx = 96.5, headWidth = 62;
  static const double tailCx = 212.5, tailWidth = 136;
  static const double dotCx = 136, dotWidth = 14;
  static const double legendCx = 157, legendCy = 43.2, legendWidth = 200;
  static const double legendGlyph = 44;

  // Exempt.
  static const double exemptGlyph = 92, exemptCy = 87;
  static const double lettersCx = 56.2, lettersWidth = 70;
  static const double digitsCx = 191.9, digitsWidth = 172;
  static const double headEnd = 44, faceEnd = 121;
  static const double nameCx = 150, nameCy = 34.5, nameWidth = 180;
  static const double nameGlyph = 20;
  static const double footCx = 147, footCy = 134, footWidth = 204;
  static const double footGlyph = 15;
}

PlateBox _centred(double cx, double cy, double w, double h) =>
    PlateBox.centered(cx, cy, w, h);

PlateLabel _label(
  String text,
  double cx,
  double cy,
  double w,
  double glyph, {
  Color? color,
}) => PlateLabel(
  text: text,
  box: _centred(cx, cy, w, glyph),
  glyphHeight: glyph,
  color: color,
);

PlateSlot _field(
  PlateAlphabet alphabet,
  double cx,
  double cy,
  double w,
  double h, {
  required int length,
}) =>
    PlateSlot(alphabet: alphabet, box: _centred(cx, cy, w, h), length: length);

const PlatePanel _noPanel = PlatePanel(
  box: PlateBox(0, 0, 0, 0),
  padding: EdgeInsets.zero,
);

/// `123-456`: two three-digit fields with a printed hyphen between, a caption
/// under them, and optionally a "PRIVADO" legend over and a semester after.
///
/// The hyphen is lettering, not a cell.
PlateSpec _classic(
  String id, {
  String? legend,
  required String caption,
  required double captionCx,
  required double captionWidth,
  required double captionGlyph,
  String? period,
}) => PlateSpec(
  id: id,
  country: DominicanRepublicCountry.dominican_republic,
  canvasWidth: _Layout.width,
  canvasHeight: _Layout.height,
  panel: _noPanel,
  noPanel: true,
  background: PlateSection.plain,
  slots: <PlateSlot>[
    _field(
      DominicanRepublicAlphabets.digits,
      _Layout.classicLeftCx,
      _Layout.classicCy,
      _Layout.classicFieldWidth,
      _Layout.classicGlyph,
      length: 3,
    ),
    _field(
      DominicanRepublicAlphabets.digits,
      _Layout.classicRightCx,
      _Layout.classicCy,
      _Layout.classicFieldWidth,
      _Layout.classicGlyph,
      length: 3,
    ),
  ],
  labels: <PlateLabel>[
    _label(
      '-',
      _Layout.classicDashCx,
      _Layout.classicCy,
      _Layout.classicDashWidth,
      _Layout.classicGlyph,
    ),
    _label(caption, captionCx, _Layout.captionCy, captionWidth, captionGlyph),
    if (legend != null) _label(legend, 148, 20, 190, 34),
    if (period != null) _label(period, 217, _Layout.captionCy, 60, 24),
  ],
  textGroups: const <PlateTextGroup>[
    PlateTextGroup(<int>[0], key: 'first'),
    PlateTextGroup(<int>[1], key: 'last', prefix: '-'),
  ],
);

/// `R.D. 1o 86 / P 06 . 2686`: a letter, two digits and four digits, with the
/// semester lettered over them.
PlateSpec _lettered(String id) => PlateSpec(
  id: id,
  country: DominicanRepublicCountry.dominican_republic,
  canvasWidth: _Layout.width,
  canvasHeight: _Layout.height,
  panel: _noPanel,
  noPanel: true,
  background: PlateSection.plain,
  slots: <PlateSlot>[
    _field(
      DominicanRepublicAlphabets.letters,
      _Layout.letterCx,
      _Layout.letteredCy,
      _Layout.letterWidth,
      _Layout.letteredGlyph,
      length: 1,
    ),
    _field(
      DominicanRepublicAlphabets.digits,
      _Layout.headCx,
      _Layout.letteredCy,
      _Layout.headWidth,
      _Layout.letteredGlyph,
      length: 2,
    ),
    _field(
      DominicanRepublicAlphabets.digits,
      _Layout.tailCx,
      _Layout.letteredCy,
      _Layout.tailWidth,
      _Layout.letteredGlyph,
      length: 4,
    ),
  ],
  labels: <PlateLabel>[
    _label(
      '·',
      _Layout.dotCx,
      _Layout.letteredCy,
      _Layout.dotWidth,
      _Layout.letteredGlyph,
    ),
    _label(
      'R.D. 1º 86',
      _Layout.legendCx,
      _Layout.legendCy,
      _Layout.legendWidth,
      _Layout.legendGlyph,
    ),
  ],
  textGroups: const <PlateTextGroup>[
    PlateTextGroup(<int>[0], key: 'letter'),
    PlateTextGroup(<int>[1], key: 'head'),
    PlateTextGroup(<int>[2], key: 'tail', prefix: '-'),
  ],
);

/// `EA 01320` on a white face between a dark green head lettered
/// REPUBLICA DOMINICANA and a light green foot lettered EXONERADA ESTATAL
/// AUTOMOVIL. The bands run to the plate's edge, so they are the background.
PlateSpec _exempt(String id) => PlateSpec(
  id: id,
  country: DominicanRepublicCountry.dominican_republic,
  canvasWidth: _Layout.width,
  canvasHeight: _Layout.height,
  panel: _noPanel,
  noPanel: true,
  background: const PlateSection.rows(<PlatePart>[
    PlatePart(
      PlateSection.fill(PlateFill.color(DominicanRepublicColors.darkGreen)),
      end: _Layout.headEnd,
    ),
    PlatePart(PlateSection.plain, end: _Layout.faceEnd),
    PlatePart(
      PlateSection.fill(PlateFill.color(DominicanRepublicColors.lightGreen)),
    ),
  ]),
  slots: <PlateSlot>[
    _field(
      DominicanRepublicAlphabets.letters,
      _Layout.lettersCx,
      _Layout.exemptCy,
      _Layout.lettersWidth,
      _Layout.exemptGlyph,
      length: 2,
    ),
    _field(
      DominicanRepublicAlphabets.digits,
      _Layout.digitsCx,
      _Layout.exemptCy,
      _Layout.digitsWidth,
      _Layout.exemptGlyph,
      length: 5,
    ),
  ],
  labels: <PlateLabel>[
    _label(
      'REPUBLICA DOMINICANA',
      _Layout.nameCx,
      _Layout.nameCy,
      _Layout.nameWidth,
      _Layout.nameGlyph,
      color: DominicanRepublicColors.white,
    ),
    _label(
      'EXONERADA ESTATAL AUTOMOVIL',
      _Layout.footCx,
      _Layout.footCy,
      _Layout.footWidth,
      _Layout.footGlyph,
    ),
  ],
  textGroups: PlateTextGroup.perSlot(<String>['letters', 'digits']),
);

/// The Dominican plates this package draws. Each is one design with a theme
/// from `DominicanRepublicThemes` of the same name.
abstract final class DominicanRepublicPlates {
  /// 1990 private: `953-147`, cream, no legend.
  static final PlateSpec private1990 = _classic(
    'do.private1990',
    caption: 'REP.DOMINICANA',
    captionCx: 151.8,
    captionWidth: 190,
    captionGlyph: 29,
  );

  /// 1980 passenger: `122-066` under "PRIVADO", semester after the caption.
  static final PlateSpec passenger1980 = _classic(
    'do.passenger1980',
    legend: 'PRIVADO',
    caption: 'REP.DOMINICANA',
    captionCx: 116.8,
    captionWidth: 132,
    captionGlyph: 20,
    period: '1º 1980',
  );

  /// 1993-94 private: `185-435`, red.
  static final PlateSpec private1994 = _classic(
    'do.private1994',
    caption: 'REPUBLICA DOMINICANA',
    captionCx: 151,
    captionWidth: 182,
    captionGlyph: 20,
  );

  /// 1986 passenger: `P06-2686` under "R.D. 1o 86".
  static final PlateSpec passenger1986 = _lettered('do.passenger1986');

  /// 2017 exempt state vehicle: `EA 01320`.
  static final PlateSpec exempt = _exempt('do.exempt');

  static List<PlateSpec> get all => <PlateSpec>[
    private1990,
    passenger1980,
    private1994,
    passenger1986,
    exempt,
  ];
}

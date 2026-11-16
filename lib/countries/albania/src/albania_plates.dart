import 'dart:math';

import 'package:flutter/widgets.dart';

import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'albania_colors.dart';
import 'albania_country.dart';
import 'albania_missions.dart';

/// Where the ink sits. Every plate was flattened to a 520×110 sheet
/// (`.plateref/al/flat_*.png`, 4× scale) and projected onto each axis; the
/// numbers below are in that sheet's units and are scaled to each plate's real
/// size by `_spec`: ×1 for the 520×110 mm one-line plate, ×254/520 and
/// ×205/110 for the 254×205 mm two-line plate, ×177/520 and ×177/110 for the
/// 177×177 mm motorcycle plate (the photo is 1.01; the article gives 212×205
/// or 177×177).
///
/// Ink rows (private one-line): y 15.2–91.8, centre 54, height ~75; two-line
/// row 1 y 10.5–50.5, row 2 y 59.3–99.8, height ~40. At 0.55 ink per box the
/// glyphs would want a ~136-unit box on a 110 plate, so the box is capped at
/// the largest that fits the canvas around the row's centre and the ink lands
/// near 80% of the reference.
///
/// The photographed plates are squashed by the flattening (the two-line
/// digits look 2× wide), so only extents and centres are used, never glyph
/// shapes.
abstract final class _Layout {
  static const double flatWidth = 520, flatHeight = 110;

  /// Reference ink height per box. See `plate_creator`: glyph ≈ ink / 0.55.
  static const double inkPerBox = 0.55;
}

/// One plate geometry: where the strips, hologram and sticker ring sit, in
/// sheet units, and the rows' centres and ink height.
class _Frame {
  const _Frame({
    required this.width,
    required this.height,
    required this.bandEnd,
    required this.bandBottom,
    required this.stripStart,
    required this.border,
    required this.dotX,
    required this.dotY,
    required this.dotRadius,
    required this.ringX,
    required this.ringY,
    required this.ringRadius,
    required this.centres,
    required this.ink,
    required this.eagleWidth,
    required this.panelTop,
    required this.panelBottom,
  });

  /// The plate's canvas.
  final double width, height;

  /// Right edge of the national strip, and the bottom of the blue band (the
  /// whole height on a one-line plate); sheet units.
  final double bandEnd, bandBottom;

  /// Left edge of the sticker strip, sheet units.
  final double stripStart;

  /// Frame width over plate height.
  final double border;

  /// The hologram disc and the sticker ring: centre in sheet units, radius in
  /// canvas units (the sheet is squashed, so a circle is not a circle there).
  final double dotX, dotY, dotRadius;
  final double ringX, ringY, ringRadius;

  /// Row centres in sheet y, and the reference ink height in sheet y.
  final List<double> centres;
  final double ink;

  /// The eagle's width and the panel's top and bottom padding, canvas units.
  final double eagleWidth, panelTop, panelBottom;

  double get kx => width / _Layout.flatWidth;
  double get ky => height / _Layout.flatHeight;
}

const _Frame _oneLine = _Frame(
  width: 520,
  height: 110,
  bandEnd: 53,
  bandBottom: 110,
  stripStart: 471.5,
  border: 0.045,
  dotX: 198,
  dotY: 52.7,
  dotRadius: 9.7,
  ringX: 492.7,
  ringY: 79.3,
  ringRadius: 15,
  centres: <double>[54],
  ink: 75,
  eagleWidth: 39,
  panelTop: 18,
  panelBottom: 20,
);

const _Frame _twoLine = _Frame(
  width: 254,
  height: 205,
  bandEnd: 109.5,
  bandBottom: 55.5,
  stripStart: 419.5,
  border: 0.025,
  dotX: 169,
  dotY: 29,
  dotRadius: 9.7,
  ringX: 464,
  ringY: 41.2,
  ringRadius: 15.4,
  centres: <double>[30.5, 79.5],
  ink: 40,
  eagleWidth: 40,
  panelTop: 19,
  panelBottom: 16,
);

const _Frame _motorcycle = _Frame(
  width: 177,
  height: 177,
  bandEnd: 131,
  bandBottom: 55.1,
  stripStart: 399,
  border: 0.025,
  dotX: 159.8,
  dotY: 29,
  dotRadius: 8.4,
  ringX: 452,
  ringY: 41.2,
  ringRadius: 13.2,
  centres: <double>[30.5, 79.5],
  ink: 40,
  eagleWidth: 33.6,
  panelTop: 16.7,
  panelBottom: 13,
);

/// One field: a run printed and typed as a unit. [left]/[right] is the
/// measured ink span in sheet x; [row] indexes [_Frame.centres].
class _Field {
  const _Field(
    this.key,
    this.alphabet,
    this.left,
    this.right, {
    required this.length,
    int? minLength,
    this.row = 0,
  }) : minLength = minLength ?? length;

  final String key;
  final PlateAlphabet alphabet;
  final double left, right;
  final int length, minLength;
  final int row;
}

final PlateAlphabet _letters = AlbaniaAlphabets.letters;
final PlateAlphabet _digits = AlbaniaAlphabets.digits;

_Field _l(String key, double l, double r, int n, {int? min, int row = 0}) =>
    _Field(key, _letters, l, r, length: n, minLength: min, row: row);

_Field _d(String key, double l, double r, int n, {int? min, int row = 0}) =>
    _Field(key, _digits, l, r, length: n, minLength: min, row: row);

/// The plates of Albania.
///
/// Groups, in slot order, are named per field (`series`, `class`, `prefix`,
/// `code`, `number`, `suffix`, `word`); the validators read them.
///
/// Every spec has the same chrome: the national strip (flag panel, painted as
/// part of the background) on the left, a hologram disc between the series
/// and the number, and, where the reference has one, the blue sticker strip
/// with its ring on the right. Colours come from the theme; the strip is the
/// country's panel colour.
///
/// One-line plates are 520×110 mm, two-line 254×205 mm, motorcycle 177×177 mm.
///
/// Prose vs picture: the article gives the agricultural trailer, technological
/// vehicle and technological trailer formats (`AA RB 00`, `AA MT 00`,
/// `AA RT 00`) without a picture; they are the agricultural plate with another
/// class code, so the `class` field takes `MB`, `MT`, `RB`, `RT` or `R`.
/// Service-diplomatic (`TR`) shares the diplomatic spec, `CD` replaced by `TR`.
/// Repetitive shares the private spec in red. The 1995–2002 DIN 1451 plate
/// (Saranda) is a historic series and is not implemented.
abstract final class AlbaniaPlates {
  /// `AB 123 CD`, one line. Private and, in red, repetitive.
  static final PlateSpec private = _spec('al.private', _oneLine, <_Field>[
    _l('series', 79.5, 169.5, 2),
    _d('number', 216.5, 348, 3),
    _l('suffix', 380, 462, 2),
  ], strip: true);

  /// `AB 123 CD`, two lines (`AB` above, `123 CD` below).
  static final PlateSpec privateTwoLine = _spec(
    'al.privateTwoLine',
    _twoLine,
    <_Field>[
      _l('series', 214, 403, 2),
      _d('number', 17, 306, 3, row: 1),
      _l('suffix', 306, 499, 2, row: 1),
    ],
    strip: true,
  );

  /// `AB MB 78` / `AB R 456`. The class is `MB`, `MT`, `RB`, `RT` (two letters,
  /// two digits) or `R` (one letter, three digits), so the class is 1–2
  /// letters and the number 2–3 digits. The class and digit boxes sit between
  /// the two references' centres.
  static final PlateSpec agricultural = _spec(
    'al.agricultural',
    _oneLine,
    <_Field>[
      _l('series', 79, 169.5, 2),
      _l('class', 236, 304, 2, min: 1),
      _d('number', 320, 454, 3, min: 2),
    ],
    strip: true,
  );

  static final PlateSpec agriculturalTwoLine =
      _spec('al.agriculturalTwoLine', _twoLine, <_Field>[
        _l('series', 214, 403, 2),
        _l('class', 45, 237.5, 2, min: 1, row: 1),
        _d('number', 298, 486, 3, min: 2, row: 1),
      ], strip: true);

  /// `CD 12 03A` and, for service-diplomatic plates, `TR 12 03A`: the prefix,
  /// the two-digit mission `code` (see [AlbaniaMissions]), the two-digit
  /// number and the rank letter. No sticker strip.
  static final PlateSpec diplomatic = _spec(
    'al.diplomatic',
    _oneLine,
    <_Field>[
      _l('prefix', 80, 172, 2),
      _d('code', 227, 313, 2),
      _d('number', 347, 437, 2),
      _l('suffix', 448, 492, 1),
    ],
    strip: false,
    restrictions: const <PlateRestriction>[AlbaniaMissions.restriction],
  );

  static final PlateSpec diplomaticTwoLine = _spec(
    'al.diplomaticTwoLine',
    _twoLine,
    <_Field>[
      _l('prefix', 259, 452, 2),
      _d('code', 25.5, 205.5, 2, row: 1),
      _d('number', 221.5, 413, 2, row: 1),
      _l('suffix', 413, 494, 1, row: 1),
    ],
    strip: false,
    restrictions: const <PlateRestriction>[AlbaniaMissions.restriction],
  );

  /// `MM 123PU`: the ministry prefix, three digits and the branch letters
  /// (`FA`, `FD`, `FT`, `KM`, `PU`, `SP`).
  static final PlateSpec military = _spec('al.military', _oneLine, <_Field>[
    _l('prefix', 80, 173, 2),
    _d('number', 224, 357, 3),
    _l('suffix', 370, 460, 2),
  ], strip: false);

  static final PlateSpec militaryTwoLine = _spec(
    'al.militaryTwoLine',
    _twoLine,
    <_Field>[
      _l('prefix', 215, 413, 2),
      _d('number', 17, 306, 3, row: 1),
      _l('suffix', 306, 499, 2, row: 1),
    ],
    strip: false,
  );

  /// `MB 123 AB`: Ministry of the Interior.
  static final PlateSpec police = _spec('al.police', _oneLine, <_Field>[
    _l('prefix', 80, 170, 2),
    _d('number', 216.5, 348, 3),
    _l('suffix', 380, 462, 2),
  ], strip: false);

  static final PlateSpec policeTwoLine = _spec(
    'al.policeTwoLine',
    _twoLine,
    <_Field>[
      _l('prefix', 215, 403, 2),
      _d('number', 17, 306, 3, row: 1),
      _l('suffix', 306, 499, 2, row: 1),
    ],
    strip: false,
  );

  /// `AB 123 T`.
  static final PlateSpec taxi = _spec('al.taxi', _oneLine, <_Field>[
    _l('series', 79, 169.5, 2),
    _d('number', 224, 356, 3),
    _l('suffix', 388, 425, 1),
  ], strip: true);

  static final PlateSpec taxiTwoLine = _spec(
    'al.taxiTwoLine',
    _twoLine,
    <_Field>[
      _l('series', 214, 403, 2),
      _d('number', 55, 334, 3, row: 1),
      _l('suffix', 380, 457, 1, row: 1),
    ],
    strip: true,
  );

  /// `AB 0 PRK` (temporary) and `AB 0 PROV` (test): the word is three or four
  /// letters. The two references put the digit 12 units apart; its box sits
  /// between them. No sticker strip.
  static final PlateSpec provisional = _spec(
    'al.provisional',
    _oneLine,
    <_Field>[
      _l('series', 79.5, 170, 2),
      _d('number', 241, 281, 1),
      _l('word', 316, 499, 4, min: 3),
    ],
    strip: false,
  );

  /// `AB` over `0 PRK`.
  static final PlateSpec temporaryTwoLine = _spec(
    'al.temporaryTwoLine',
    _twoLine,
    <_Field>[
      _l('series', 259, 448, 2),
      _d('number', 53, 137, 1, row: 1),
      _l('word', 189.5, 474, 3, row: 1),
    ],
    strip: false,
  );

  /// `AB 0` over `PROV`.
  static final PlateSpec testTwoLine = _spec(
    'al.testTwoLine',
    _twoLine,
    <_Field>[
      _l('series', 188.5, 370, 2),
      _d('number', 414.5, 498, 1),
      _l('word', 64, 457, 4, row: 1),
    ],
    strip: false,
  );

  /// `AB` over `123`, on the 177×177 mm plate.
  static final PlateSpec motorcycle = _spec(
    'al.motorcycle',
    _motorcycle,
    <_Field>[_l('series', 197.5, 384.5, 2), _d('number', 87, 418.5, 3, row: 1)],
    strip: true,
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    privateTwoLine,
    agricultural,
    agriculturalTwoLine,
    diplomatic,
    diplomaticTwoLine,
    military,
    militaryTwoLine,
    police,
    policeTwoLine,
    taxi,
    taxiTwoLine,
    provisional,
    temporaryTwoLine,
    testTwoLine,
    motorcycle,
  ];
}

PlateSpec _spec(
  String id,
  _Frame f,
  List<_Field> fields, {
  required bool strip,
  List<PlateRestriction> restrictions = const <PlateRestriction>[],
}) {
  final double kx = f.kx, ky = f.ky;

  PlateSlot slot(_Field fld) {
    final double cy = f.centres[fld.row] * ky;
    final double box = min(
      f.ink * ky / _Layout.inkPerBox,
      2 * min(cy, f.height - cy),
    );
    final double width = (fld.right - fld.left) * kx;
    final double pitch = width / fld.length;
    return PlateSlot(
      alphabet: fld.alphabet,
      box: PlateBox(fld.left * kx, cy - box / 2, width, box),
      length: fld.length,
      minLength: fld.minLength,
      spacing: fld.minLength == fld.length ? plateRunSpacing(pitch, box) : 0,
      group: fld.key,
    );
  }

  final PlateSection blue = PlateSection.fill(
    PlateFill.color(AlbaniaColors.blue),
  );
  final PlateSection top = PlateSection.columns(<PlatePart>[
    PlatePart(const PlateSection.fill(PlateFill.panel), end: f.bandEnd * kx),
    if (strip) ...<PlatePart>[
      PlatePart(PlateSection.plain, end: f.stripStart * kx),
      PlatePart(blue),
    ] else
      const PlatePart(PlateSection.plain),
  ]);
  final bool oneLine = f.centres.length == 1;

  final double bandW = f.bandEnd * kx, bandH = f.bandBottom * ky;

  return PlateSpec(
    id: id,
    country: AlbaniaCountry.albania,
    canvasWidth: f.width,
    canvasHeight: f.height,
    panel: PlatePanel(
      box: PlateBox(0, 0, bandW, bandH),
      padding: EdgeInsets.fromLTRB(
        (bandW - f.eagleWidth) / 2,
        f.panelTop,
        (bandW - f.eagleWidth) / 2,
        f.panelBottom,
      ),
    ),
    background: oneLine
        ? top
        : PlateSection.rows(<PlatePart>[
            PlatePart(top, end: bandH),
            const PlatePart(PlateSection.plain),
          ]),
    slots: <PlateSlot>[for (final _Field fld in fields) slot(fld)],
    decals: <PlateDecal>[
      _disc(f.dotX * kx, f.dotY * ky, f.dotRadius),
      if (strip) _ring(f.ringX * kx, f.ringY * ky, f.ringRadius),
    ],
    restrictions: restrictions,
    borderWidthRatioOverride: f.border,
  );
}

/// The hologram: a flat disc centred at ([cx], [cy]).
PlateDecal _disc(double cx, double cy, double r) => PlateDecal(
  box: PlateBox(cx - r, cy - r, 2 * r, 2 * r),
  drawing: PlateDrawing(2 * r, 2 * r, <PlateShape>[
    PlateCircleShape(r, r, r, AlbaniaColors.hologram),
  ]),
);

/// The year-sticker ring in the sticker strip, a ~1.3-unit white line.
PlateDecal _ring(double cx, double cy, double r) => PlateDecal(
  box: PlateBox(cx - r, cy - r, 2 * r, 2 * r),
  drawing: PlateDrawing(2 * r, 2 * r, <PlateShape>[
    PlateRingShape(r, r, r - 0.65, 1.3, AlbaniaColors.white),
  ]),
);

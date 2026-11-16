import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'morocco_colors.dart';
import 'morocco_country.dart';

/// Where the ink sits, in plate units, measured off the Wikimedia artwork
/// (`orig_*.png`, alpha bounding box normalised to the canvas) except where
/// noted. One-line plates are 520x110 (the article gives the EU size for the
/// service plates; the others are drawn at the same aspect), two-line 300x150
/// and the motorcycle 220x150, each the size whose aspect matches its artwork.
///
/// Digits are under-height on purpose: `glyphStyle` sets 0.72 of the slot and a
/// bold digit is ~0.6 of that again, so the artwork's 60-70 unit digits would
/// need a slot taller than the plate. Slots are as tall as the plate allows
/// and pitched to the printed advance (`spacing`). Label glyph heights for
/// Arabic and the condensed Latin words are estimates fitted by eye to the
/// ink width; `platekit golden-check` refines them.
abstract final class _Layout {
  /// Advance of a bold digit as a fraction of the slot height
  /// (`0.72 * ~0.6`); a fixed field adds `spacing` when the printed pitch is
  /// wider.
  static const double advance = 0.6 * 0.72;

  static const double w = 520, h = 110;

  // Registration, 2026 series (Single_Row): dividers at 46.3, 317.7, 396;
  // the letter cell splits at y 54.7. Thickness 1.1.
  static const double stdDivider = 1.1, stdMaEnd = 46.5, stdCellEnd = 317.7;
  static const double stdLetterEnd = 396, stdLetterSplit = 54.7;
  static const double stdSerialCx = 182, stdSerialHeight = 106;
  static const double stdSeriesCx = 357, stdSeriesCy = 29, stdSeriesHeight = 52;
  static const double stdLatinCy = 84, stdLatinGlyph = 54, stdRegionCx = 458.8;
  static const double stdMaCx = 25.2, stdMaCy = 55.9, stdMaGlyph = 30;

  // Registration before the MA badge (Car_license_plate_of_Morocco_in_Spain,
  // a photograph, normalised): dividers 4.4 thick at 266 and 367.
  static const double oldDivider = 4.4, oldFirstEnd = 266, oldSecondEnd = 367;
  static const double oldCy = 52.7, oldHeight = 100, oldSerialCx = 138.5;
  static const double oldSeriesCx = 316.5, oldSeriesHeight = 70;
  static const double oldRegionCx = 449;

  // Service plates (police, auxiliary forces, government): white rim, black
  // block x 7..356 (one line) with white digits, red Arabic letters on white.
  static const double blockLeft = 7, blockRight = 356, blockTop = 7.3;
  static const double blockBottom = 102.7, lineCy = 54.7, lineHeight = 104;
  static const double linePitch = 45.6, lineSerialCx = 166.5;

  // Two-line service plates, 300x150: block y 75.5..141.7 (inset as on the
  // one-line plates), digits ink 28.2..265.8.
  static const double sqW = 300, sqH = 150, sqBlockTop = 75.5;
  static const double sqBlockBottom = 141.7, sqBlockLeft = 7;
  static const double sqBlockRight = 293, sqDigitsCx = 147, sqDigitsCy = 108.3;
  static const double sqDigitsHeight = 82, sqDigitsPitch = 39.6;

  // Civil protection digits are black on white and narrower (pitch 39,
  // ink 28.7..262.2 on one line; 41.9, ink 22.8..274.2 on two).
  static const double pcLineHeight = 90, pcLinePitch = 39, pcLineCx = 145.5;
  static const double pcSqHeight = 95, pcSqPitch = 41.9, pcSqCx = 148.5;
  static const double pcSqCy = 101.5;

  // Military: red flag block from 436.5 (Navy photo: 442), stretched flag
  // star, crest at the left, dash then ق م م.
  static const double milFlagStart = 436.5, milCy = 55.2, milPitch = 36.8;
  static const double milHeight = 85, milDigitsCx = 181.4, milDashLeft = 293;
  static const double milDashWidth = 29.8, milDashThickness = 8.8;
  static const double milLettersCx = 380.3, milLettersCy = 55.5;
  static const double milLettersGlyph = 100;
  static const PlateBox milCrest = PlateBox(9.2, 10.4, 56.9, 86.1);
  static const double starSize = 55;

  // Trailer, `1234 - 09`: ink 69.3..431.7, y 17.1..86.1.
  static const double trailerCy = 51.6, trailerHeight = 100;
  static const double trailerPitch = 45.2, trailerSerialCx = 159.75;
  static const double trailerRegionCx = 387.55, trailerDashLeft = 280.6;
  static const double trailerDashWidth = 29.8, trailerDashThickness = 8.8;
  // The dash was not measured here: its centre sits 6.7 below the digit
  // centre, as on the diplomatic plate.
  static const double trailerDashCy = trailerCy + 6.7;

  // Dealer W18 `12345 W 18` (digits ink 55.2..231.3, W 311.5..366.7, 18
  // 411.7..476.7) and temporary WW `134567 WW` (digits 28.7..258.9, WW
  // 346.1..461).
  static const double w18Cy = 55.5, w18Height = 83, w18Pitch = 35.2;
  static const double w18SerialCx = 143.25, w18Glyph = 75, w18WCx = 339.1;
  static const double w18NumberCx = 444.2, wwCy = 54.2, wwHeight = 89;
  static const double wwPitch = 38.4, wwSerialCx = 143.8, wwGlyph = 78;
  static const double wwLettersCx = 403.5;

  // Diplomatic and international cooperation: `CD | 123-45 | هـ د`.
  static const double dipCy = 52.7, dipHeight = 78, dipPitch = 33.6;
  static const double dipNumberCx = 204.2, dipCountryCx = 324;
  static const double dipDashLeft = 261.6, dipDashWidth = 27.1;
  static const double dipDashCy = 59.4, dipDashThickness = 8.8, dipRuleTop = 13;
  static const double dipRuleHeight = 79.4, dipRuleWidth = 6.5;
  static const double dipRule1 = 141.4, dipRule2 = 371.6, dipCodeCx = 78.5;
  static const double dipCodeCy = 31.4, dipCodeGlyph = 36, dipMarocCx = 80.2;
  static const double dipMarocCy = 76.8, dipMarocGlyph = 27, dipArabicCx = 433;
  static const double dipArabicCy = 28.8, dipArabicGlyph = 46;
  static const double dipWordCx = 439.3, dipWordCy = 76.2, dipWordGlyph = 50;
}

/// A two-row registration plate. Cells are split by thin dividers: the top
/// row holds the series (Arabic over Latin) and the region, the bottom row
/// the MA badge and the serial.
@immutable
class _TwoRow {
  const _TwoRow({
    required this.id,
    required this.width,
    required this.height,
    required this.rowSplit,
    required this.letterSplit,
    required this.cellSplit,
    required this.maSplit,
    required this.divider,
    required this.rim,
    required this.letterCx,
    required this.arabicCy,
    required this.latinCy,
    required this.regionCx,
    required this.regionCy,
    required this.regionHeight,
    required this.serialCx,
    required this.serialCy,
    required this.maCx,
    required this.maCy,
  });

  final String id;
  final double width, height;
  final double rowSplit, letterSplit, cellSplit, maSplit;
  final double divider, rim;
  final double letterCx, arabicCy, latinCy;
  final double regionCx, regionCy, regionHeight;
  final double serialCx, serialCy;
  final double maCx, maCy;

  static const double serialHeight = 70, arabicHeight = 34, latinGlyph = 45;
  static const double maGlyph = 24;

  /// 300x150, Double_Row artwork.
  static const _TwoRow car = _TwoRow(
    id: 'car2',
    width: 300,
    height: 150,
    rowSplit: 75,
    letterSplit: 37.5,
    cellSplit: 150,
    maSplit: 40.8,
    divider: 1.2,
    rim: 0.016,
    letterCx: 75.6,
    arabicCy: 18,
    latinCy: 56.7,
    regionCx: 225,
    regionCy: 38,
    regionHeight: 70,
    serialCx: 170.1,
    serialCy: 112.2,
    maCx: 21.9,
    maCy: 111.6,
  );

  /// 220x150, Motorcycle artwork.
  static const _TwoRow motorcycle = _TwoRow(
    id: 'moto',
    width: 220,
    height: 150,
    rowSplit: 71.2,
    letterSplit: 38.9,
    cellSplit: 109.7,
    maSplit: 29.7,
    divider: 1.3,
    rim: 0.015,
    letterCx: 55.4,
    arabicCy: 19,
    latinCy: 55.7,
    regionCx: 164,
    regionCy: 36,
    regionHeight: 66,
    serialCx: 124.4,
    serialCy: 110,
    maCx: 18,
    maCy: 112,
  );
}

/// An Arabic service marking on a service plate and where it sits on the
/// white part of the one-line and two-line plates.
@immutable
class _Service {
  const _Service({
    required this.id,
    required this.letters,
    required this.lineCx,
    required this.lineCy,
    required this.lineGlyph,
    required this.sqCx,
    required this.sqGlyph,
    this.block = true,
  });

  final String id, letters;
  final double lineCx, lineCy, lineGlyph;
  final double sqCx, sqGlyph;

  /// White digits on a black block; false for civil protection (black on
  /// white).
  final bool block;

  static const double sqCy = 37.2;

  /// ش, Police. Ink 418..484, 15..85 (one line); 100.8..156.6 (two).
  static const _Service police = _Service(
    id: 'police',
    letters: 'ش',
    lineCx: 451,
    lineCy: 50,
    lineGlyph: 110,
    sqCx: 128.7,
    sqGlyph: 85,
  );

  /// ق س, Auxiliary Forces.
  static const _Service auxiliary = _Service(
    id: 'auxiliary',
    letters: 'ق‌س',
    lineCx: 431,
    lineCy: 53,
    lineGlyph: 100,
    sqCx: 139,
    sqGlyph: 85,
  );

  /// ج, local government vehicles. The state-owned variants (M, المغرب) are
  /// not in the artwork.
  static const _Service government = _Service(
    id: 'government',
    letters: 'ج',
    lineCx: 437,
    lineCy: 54,
    lineGlyph: 100,
    sqCx: 139,
    sqGlyph: 85,
  );

  /// و م, Civil Protection: black digits on white.
  static const _Service protection = _Service(
    id: 'protection',
    letters: 'و‌م',
    lineCx: 433.5,
    lineCy: 55.5,
    lineGlyph: 100,
    sqCx: 140.7,
    sqGlyph: 85,
    block: false,
  );
}

/// The code and Arabic initials of a diplomatic-style plate.
@immutable
class _Mission {
  const _Mission({required this.id, required this.latin, required this.arabic});

  final String id, latin, arabic;

  /// Corps Diplomatique, `CD` / هـ د.
  static const _Mission diplomatic = _Mission(
    id: 'diplomatic',
    latin: 'CD',
    arabic: 'هـ‌د',
  );

  /// Coopération Internationale, `CI` / ت د. Withdrawn in 2021.
  static const _Mission cooperation = _Mission(
    id: 'cooperation',
    latin: 'CI',
    arabic: 'ت‌د',
  );
}

/// The Latin equivalent of the series letter, printed under the Arabic one.
/// The slot stores the Latin letter, so it is the group's own value.
String? _latinSeries(String Function(String key) group) => group('series');

/// The star of the flag, as the military plates print it over a red block: a
/// 280x280 space with the pentagram centred on (140, 140).
const PlateDrawing _star = PlateDrawing(280, 280, <PlateShape>[
  PlatePolygonShape(<Offset>[
    Offset(131.0, 8.5),
    Offset(210.0, 251.7),
    Offset(223.6, 247.3),
    Offset(144.6, 4.1),
  ], MoroccoColors.flagGreen),
  PlatePolygonShape(<Offset>[
    Offset(224.6, 241.1),
    Offset(17.7, 90.8),
    Offset(9.3, 102.4),
    Offset(216.2, 252.6),
  ], MoroccoColors.flagGreen),
  PlatePolygonShape(<Offset>[
    Offset(12.2, 107.9),
    Offset(267.8, 107.9),
    Offset(267.8, 93.6),
    Offset(12.2, 93.6),
  ], MoroccoColors.flagGreen),
  PlatePolygonShape(<Offset>[
    Offset(262.3, 90.8),
    Offset(55.4, 241.1),
    Offset(63.8, 252.6),
    Offset(270.7, 102.4),
  ], MoroccoColors.flagGreen),
  PlatePolygonShape(<Offset>[
    Offset(70.0, 251.7),
    Offset(149.0, 8.5),
    Offset(135.4, 4.1),
    Offset(56.4, 247.3),
  ], MoroccoColors.flagGreen),
]);

/// Plates of Morocco. Every current category in the article has one spec; the
/// ones that differ only in numbers, colours or wording share a builder.
///
/// * [standard]: `NNNNN | A | NN` with the MA badge (2026 series, one line);
///   [legacy] is the same without the badge; [car2] and [motorcycle] are the
///   two-row forms of the 2026 series.
/// * [government], [police], [auxiliary], [civilProtection]: six digits and a
///   service marking, in a one-line and a two-line ([...Rows]) form.
/// * [trailer]: `NNNN - NN`, white on red.
/// * [dealer] (`NNNNN W 18`) and [temporary] (`NNNNNN WW`).
/// * [diplomatic] and [cooperation]: `CD`/`CI`, `NNN-NN`, yellow.
/// * [army] and [navy]: black or blue with the flag at the right.
///
/// Text groups: `serial` throughout; `series` and `region` on registration
/// plates, `region` on the trailer, `country` on the yellow plates.
///
/// Not implemented: the navy's crest (no usable artwork, the photograph is a
/// few pixels), the state-owned service markers M and المغرب, the screw
/// holes, and the pre-2000 series. The article's size note says registration
/// plates have no specified size, so the sizes above are the artwork's aspect.
abstract final class MoroccoPlates {
  static final PlateSpec standard = _standard(), legacy = _legacy();
  static final PlateSpec car2 = _twoRow(_TwoRow.car);
  static final PlateSpec motorcycle = _twoRow(_TwoRow.motorcycle);

  static final PlateSpec government = _service(_Service.government);
  static final PlateSpec governmentRows = _serviceRows(_Service.government);
  static final PlateSpec police = _service(_Service.police);
  static final PlateSpec policeRows = _serviceRows(_Service.police);
  static final PlateSpec auxiliary = _service(_Service.auxiliary);
  static final PlateSpec auxiliaryRows = _serviceRows(_Service.auxiliary);
  static final PlateSpec civilProtection = _service(_Service.protection);
  static final PlateSpec civilProtectionRows = _serviceRows(
    _Service.protection,
  );

  static final PlateSpec trailer = _trailer(), dealer = _dealer();
  static final PlateSpec temporary = _temporary();
  static final PlateSpec diplomatic = _mission(_Mission.diplomatic);
  static final PlateSpec cooperation = _mission(_Mission.cooperation);

  static final PlateSpec army = _military(
    id: 'army',
    count: 6,
    pitch: _Layout.milPitch,
    height: _Layout.milHeight,
    digitsCx: _Layout.milDigitsCx,
    dashLeft: _Layout.milDashLeft,
    lettersCx: _Layout.milLettersCx,
    lettersCy: _Layout.milLettersCy,
    flagStart: _Layout.milFlagStart,
    starCx: 470.4,
    starCy: 47.9,
    crest: true,
  );

  /// Navy photograph (flat, normalised): digits ink 96.5..263.8 and y
  /// 18.5..96, dash 278.5..308.8, letters 326.8..429.8, flag from 442.
  static final PlateSpec navy = _military(
    id: 'navy',
    count: 4,
    pitch: 41.8,
    height: 96,
    digitsCx: 180.2,
    dashLeft: 278.5,
    lettersCx: 378.3,
    lettersCy: 57,
    flagStart: 442,
    starCx: 478.5,
    starCy: 49,
    crest: false,
  );

  static PlateSlot _digits({
    required double cx,
    required double cy,
    required double height,
    required int count,
    int? minLength,
    double? pitch,
    Color? color,
  }) {
    final double advance = _Layout.advance * height, step = pitch ?? advance;
    final double width = count * step;
    return PlateSlot(
      alphabet: MoroccoAlphabets.digits,
      box: PlateBox.centered(cx, cy, width, height),
      length: count,
      minLength: minLength,
      spacing: minLength == null && pitch != null
          ? (step - advance).clamp(0, double.infinity).toDouble()
          : 0,
      color: color,
    );
  }

  static PlateSlot _series({
    required double cx,
    required double cy,
    required double height,
  }) => PlateSlot(
    alphabet: MoroccoAlphabets.series,
    box: PlateBox(cx - 30, cy - height / 2, 60, height),
  );

  /// A label centred on ([cx], [cy]); the box is as wide as the canvas allows
  /// so the line does not spill when it is longer than the ink.
  static PlateLabel _label(
    String text, {
    required double cx,
    required double cy,
    required double glyph,
    required double canvasWidth,
    required double canvasHeight,
    double width = 120,
    Color? color,
    PlateLabelResolver? resolve,
  }) {
    final double halfW = <double>[
      width / 2,
      cx,
      canvasWidth - cx,
    ].reduce((a, b) => a < b ? a : b);
    final double halfH = cy < canvasHeight - cy ? cy : canvasHeight - cy;
    return PlateLabel(
      text: text,
      box: PlateBox(cx - halfW, cy - halfH, 2 * halfW, 2 * halfH),
      glyphHeight: glyph,
      color: color,
      resolve: resolve,
    );
  }

  static PlateRule _rule(double left, double cy, double width, double thick) =>
      PlateRule(box: PlateBox(left, cy - thick / 2, width, thick));

  static PlateSpec _spec(
    String id, {
    required double width,
    required double height,
    required List<PlateSlot> slots,
    required List<PlateTextGroup> groups,
    PlateSection background = PlateSection.plain,
    List<PlateBand> bands = const <PlateBand>[],
    List<PlateRule> rules = const <PlateRule>[],
    List<PlateLabel> labels = const <PlateLabel>[],
    List<PlateDecal> decals = const <PlateDecal>[],
    double? rim,
  }) => PlateSpec(
    id: 'ma.$id',
    country: MoroccoCountry.morocco,
    canvasWidth: width,
    canvasHeight: height,
    borderWidthRatioOverride: rim,
    noPanel: true,
    panel: PlatePanel(box: PlateBox(0, 0, 0, height)),
    background: background,
    slots: slots,
    bands: bands,
    rules: rules,
    labels: labels,
    decals: decals,
    textGroups: groups,
  );

  static const List<PlateTextGroup> _registrationGroups = <PlateTextGroup>[
    PlateTextGroup(<int>[0], key: 'serial'),
    PlateTextGroup(<int>[1], key: 'series'),
    PlateTextGroup(<int>[2], key: 'region'),
  ];

  static PlateSpec _standard() => _spec(
    'standard',
    width: _Layout.w,
    height: _Layout.h,
    rim: null,
    background: const PlateSection.columns(<PlatePart>[
      PlatePart(
        PlateSection.plain,
        end: _Layout.stdMaEnd,
        divider: _Layout.stdDivider,
      ),
      PlatePart(
        PlateSection.plain,
        end: _Layout.stdCellEnd,
        divider: _Layout.stdDivider,
      ),
      PlatePart(
        PlateSection.columns(<PlatePart>[
          PlatePart(
            PlateSection.rows(<PlatePart>[
              PlatePart(
                PlateSection.plain,
                end: _Layout.stdLetterSplit,
                divider: _Layout.stdDivider,
              ),
              PlatePart(PlateSection.plain),
            ]),
            end: _Layout.stdLetterEnd,
            divider: _Layout.stdDivider,
          ),
          PlatePart(PlateSection.plain),
        ]),
      ),
    ]),
    slots: <PlateSlot>[
      _digits(
        cx: _Layout.stdSerialCx,
        cy: _Layout.h / 2,
        height: _Layout.stdSerialHeight,
        count: 5,
        minLength: 1,
      ),
      _series(
        cx: _Layout.stdSeriesCx,
        cy: _Layout.stdSeriesCy,
        height: _Layout.stdSeriesHeight,
      ),
      _digits(
        cx: _Layout.stdRegionCx,
        cy: _Layout.h / 2,
        height: _Layout.stdSerialHeight,
        count: 2,
        minLength: 1,
      ),
    ],
    groups: _registrationGroups,
    labels: <PlateLabel>[
      _label(
        'MA',
        cx: _Layout.stdMaCx,
        cy: _Layout.stdMaCy,
        glyph: _Layout.stdMaGlyph,
        canvasWidth: _Layout.w,
        canvasHeight: _Layout.h,
        width: 44,
      ),
      _label(
        '',
        cx: _Layout.stdSeriesCx,
        cy: _Layout.stdLatinCy,
        glyph: _Layout.stdLatinGlyph,
        canvasWidth: _Layout.w,
        canvasHeight: _Layout.h,
        width: 70,
        resolve: _latinSeries,
      ),
    ],
  );

  static PlateSpec _legacy() => _spec(
    'legacy',
    width: _Layout.w,
    height: _Layout.h,
    background: const PlateSection.columns(<PlatePart>[
      PlatePart(
        PlateSection.plain,
        end: _Layout.oldFirstEnd,
        divider: _Layout.oldDivider,
      ),
      PlatePart(
        PlateSection.plain,
        end: _Layout.oldSecondEnd,
        divider: _Layout.oldDivider,
      ),
      PlatePart(PlateSection.plain),
    ]),
    slots: <PlateSlot>[
      _digits(
        cx: _Layout.oldSerialCx,
        cy: _Layout.oldCy,
        height: _Layout.oldHeight,
        count: 5,
        minLength: 1,
      ),
      _series(
        cx: _Layout.oldSeriesCx,
        cy: _Layout.oldCy,
        height: _Layout.oldSeriesHeight,
      ),
      _digits(
        cx: _Layout.oldRegionCx,
        cy: _Layout.oldCy,
        height: _Layout.oldHeight,
        count: 2,
        minLength: 1,
      ),
    ],
    groups: _registrationGroups,
  );

  static PlateSpec _twoRow(_TwoRow t) => _spec(
    t.id,
    width: t.width,
    height: t.height,
    rim: t.rim,
    background: PlateSection.rows(<PlatePart>[
      PlatePart(
        PlateSection.columns(<PlatePart>[
          PlatePart(
            PlateSection.rows(<PlatePart>[
              PlatePart(
                PlateSection.plain,
                end: t.letterSplit,
                divider: t.divider,
              ),
              const PlatePart(PlateSection.plain),
            ]),
            end: t.cellSplit,
            divider: t.divider,
          ),
          const PlatePart(PlateSection.plain),
        ]),
        end: t.rowSplit,
        divider: t.divider,
      ),
      PlatePart(
        PlateSection.columns(<PlatePart>[
          PlatePart(PlateSection.plain, end: t.maSplit, divider: t.divider),
          const PlatePart(PlateSection.plain),
        ]),
      ),
    ]),
    slots: <PlateSlot>[
      _digits(
        cx: t.serialCx,
        cy: t.serialCy,
        height: _TwoRow.serialHeight,
        count: 5,
        minLength: 1,
      ),
      _series(cx: t.letterCx, cy: t.arabicCy, height: _TwoRow.arabicHeight),
      _digits(
        cx: t.regionCx,
        cy: t.regionCy,
        height: t.regionHeight,
        count: 2,
        minLength: 1,
      ),
    ],
    groups: _registrationGroups,
    labels: <PlateLabel>[
      _label(
        'MA',
        cx: t.maCx,
        cy: t.maCy,
        glyph: _TwoRow.maGlyph,
        canvasWidth: t.width,
        canvasHeight: t.height,
        width: 36,
      ),
      _label(
        '',
        cx: t.letterCx,
        cy: t.latinCy,
        glyph: _TwoRow.latinGlyph,
        canvasWidth: t.width,
        canvasHeight: t.height,
        width: 60,
        resolve: _latinSeries,
      ),
    ],
  );

  static PlateSpec _service(_Service s) => _spec(
    s.id,
    width: _Layout.w,
    height: _Layout.h,
    rim: 2.1 / _Layout.h,
    slots: <PlateSlot>[
      s.block
          ? _digits(
              cx: _Layout.lineSerialCx,
              cy: _Layout.lineCy,
              height: _Layout.lineHeight,
              count: 6,
              pitch: _Layout.linePitch,
              color: MoroccoColors.white,
            )
          : _digits(
              cx: _Layout.pcLineCx,
              cy: _Layout.lineCy,
              height: _Layout.pcLineHeight,
              count: 6,
              pitch: _Layout.pcLinePitch,
            ),
    ],
    groups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'serial'),
    ],
    bands: <PlateBand>[
      if (s.block)
        const PlateBand(
          box: PlateBox.fromLTRB(
            _Layout.blockLeft,
            _Layout.blockTop,
            _Layout.blockRight,
            _Layout.blockBottom,
          ),
          color: MoroccoColors.black,
        ),
    ],
    labels: <PlateLabel>[
      _label(
        s.letters,
        cx: s.lineCx,
        cy: s.lineCy,
        glyph: s.lineGlyph,
        canvasWidth: _Layout.w,
        canvasHeight: _Layout.h,
        width: 130,
        color: MoroccoColors.red,
      ),
    ],
  );

  static PlateSpec _serviceRows(_Service s) => _spec(
    '${s.id}.rows',
    width: _Layout.sqW,
    height: _Layout.sqH,
    rim: 2.1 / _Layout.sqH,
    slots: <PlateSlot>[
      s.block
          ? _digits(
              cx: _Layout.sqDigitsCx,
              cy: _Layout.sqDigitsCy,
              height: _Layout.sqDigitsHeight,
              count: 6,
              pitch: _Layout.sqDigitsPitch,
              color: MoroccoColors.white,
            )
          : _digits(
              cx: _Layout.pcSqCx,
              cy: _Layout.pcSqCy,
              height: _Layout.pcSqHeight,
              count: 6,
              pitch: _Layout.pcSqPitch,
            ),
    ],
    groups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'serial'),
    ],
    bands: <PlateBand>[
      if (s.block)
        const PlateBand(
          box: PlateBox.fromLTRB(
            _Layout.sqBlockLeft,
            _Layout.sqBlockTop,
            _Layout.sqBlockRight,
            _Layout.sqBlockBottom,
          ),
          color: MoroccoColors.black,
        ),
    ],
    labels: <PlateLabel>[
      _label(
        s.letters,
        cx: s.sqCx,
        cy: _Service.sqCy,
        glyph: s.sqGlyph,
        canvasWidth: _Layout.sqW,
        canvasHeight: _Layout.sqH,
        width: 130,
        color: MoroccoColors.red,
      ),
    ],
  );

  static PlateSpec _trailer() => _spec(
    'trailer',
    width: _Layout.w,
    height: _Layout.h,
    slots: <PlateSlot>[
      _digits(
        cx: _Layout.trailerSerialCx,
        cy: _Layout.trailerCy,
        height: _Layout.trailerHeight,
        count: 4,
        pitch: _Layout.trailerPitch,
      ),
      _digits(
        cx: _Layout.trailerRegionCx,
        cy: _Layout.trailerCy,
        height: _Layout.trailerHeight,
        count: 2,
        pitch: _Layout.trailerPitch,
      ),
    ],
    groups: PlateTextGroup.perSlot(<String>['serial', 'region']),
    rules: <PlateRule>[
      _rule(
        _Layout.trailerDashLeft,
        _Layout.trailerDashCy,
        _Layout.trailerDashWidth,
        _Layout.trailerDashThickness,
      ),
    ],
  );

  static PlateSpec _dealer() => _spec(
    'dealer',
    width: _Layout.w,
    height: _Layout.h,
    slots: <PlateSlot>[
      _digits(
        cx: _Layout.w18SerialCx,
        cy: _Layout.w18Cy,
        height: _Layout.w18Height,
        count: 5,
        pitch: _Layout.w18Pitch,
      ),
    ],
    groups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'serial'),
    ],
    labels: <PlateLabel>[
      _label(
        'W',
        cx: _Layout.w18WCx,
        cy: _Layout.w18Cy,
        glyph: _Layout.w18Glyph,
        canvasWidth: _Layout.w,
        canvasHeight: _Layout.h,
        width: 80,
      ),
      _label(
        '18',
        cx: _Layout.w18NumberCx,
        cy: _Layout.w18Cy,
        glyph: _Layout.w18Glyph,
        canvasWidth: _Layout.w,
        canvasHeight: _Layout.h,
        width: 90,
      ),
    ],
  );

  /// The WW artwork shows six digits; the article's format string for it is
  /// cut off, so the picture decides.
  static PlateSpec _temporary() => _spec(
    'temporary',
    width: _Layout.w,
    height: _Layout.h,
    rim: 0.03,
    slots: <PlateSlot>[
      _digits(
        cx: _Layout.wwSerialCx,
        cy: _Layout.wwCy,
        height: _Layout.wwHeight,
        count: 6,
        pitch: _Layout.wwPitch,
      ),
    ],
    groups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'serial'),
    ],
    labels: <PlateLabel>[
      _label(
        'WW',
        cx: _Layout.wwLettersCx,
        cy: _Layout.wwCy,
        glyph: _Layout.wwGlyph,
        canvasWidth: _Layout.w,
        canvasHeight: _Layout.h,
        width: 140,
      ),
    ],
  );

  static PlateSpec _mission(_Mission m) => _spec(
    m.id,
    width: _Layout.w,
    height: _Layout.h,
    slots: <PlateSlot>[
      _digits(
        cx: _Layout.dipNumberCx,
        cy: _Layout.dipCy,
        height: _Layout.dipHeight,
        count: 3,
        pitch: _Layout.dipPitch,
      ),
      _digits(
        cx: _Layout.dipCountryCx,
        cy: _Layout.dipCy,
        height: _Layout.dipHeight,
        count: 2,
        pitch: _Layout.dipPitch,
      ),
    ],
    groups: PlateTextGroup.perSlot(<String>['serial', 'country']),
    // The two vertical rules float: they stop short of the rim.
    rules: <PlateRule>[
      const PlateRule(
        box: PlateBox(
          _Layout.dipRule1,
          _Layout.dipRuleTop,
          _Layout.dipRuleWidth,
          _Layout.dipRuleHeight,
        ),
      ),
      const PlateRule(
        box: PlateBox(
          _Layout.dipRule2,
          _Layout.dipRuleTop,
          _Layout.dipRuleWidth,
          _Layout.dipRuleHeight,
        ),
      ),
      _rule(
        _Layout.dipDashLeft,
        _Layout.dipDashCy,
        _Layout.dipDashWidth,
        _Layout.dipDashThickness,
      ),
    ],
    labels: <PlateLabel>[
      _label(
        m.latin,
        cx: _Layout.dipCodeCx,
        cy: _Layout.dipCodeCy,
        glyph: _Layout.dipCodeGlyph,
        canvasWidth: _Layout.w,
        canvasHeight: _Layout.h,
        width: 100,
      ),
      _label(
        'MAROC',
        cx: _Layout.dipMarocCx,
        cy: _Layout.dipMarocCy,
        glyph: _Layout.dipMarocGlyph,
        canvasWidth: _Layout.w,
        canvasHeight: _Layout.h,
        width: 100,
      ),
      _label(
        m.arabic,
        cx: _Layout.dipArabicCx,
        cy: _Layout.dipArabicCy,
        glyph: _Layout.dipArabicGlyph,
        canvasWidth: _Layout.w,
        canvasHeight: _Layout.h,
        width: 100,
      ),
      _label(
        'المغرب',
        cx: _Layout.dipWordCx,
        cy: _Layout.dipWordCy,
        glyph: _Layout.dipWordGlyph,
        canvasWidth: _Layout.w,
        canvasHeight: _Layout.h,
        width: 100,
      ),
    ],
  );

  static PlateSpec _military({
    required String id,
    required int count,
    required double pitch,
    required double height,
    required double digitsCx,
    required double dashLeft,
    required double lettersCx,
    required double lettersCy,
    required double flagStart,
    required double starCx,
    required double starCy,
    required bool crest,
  }) {
    const double half = _Layout.starSize / 2;
    return _spec(
      id,
      width: _Layout.w,
      height: _Layout.h,
      background: PlateSection.columns(<PlatePart>[
        PlatePart(PlateSection.plain, end: flagStart),
        const PlatePart(
          PlateSection.fill(PlateFill.color(MoroccoColors.flagRed)),
        ),
      ]),
      slots: <PlateSlot>[
        _digits(
          cx: digitsCx,
          cy: _Layout.milCy,
          height: height,
          count: count,
          pitch: pitch,
        ),
      ],
      groups: const <PlateTextGroup>[
        PlateTextGroup(<int>[0], key: 'serial'),
      ],
      rules: <PlateRule>[
        _rule(
          dashLeft,
          _Layout.milCy,
          _Layout.milDashWidth,
          _Layout.milDashThickness,
        ),
      ],
      labels: <PlateLabel>[
        _label(
          'ق‌م‌م',
          cx: lettersCx,
          cy: lettersCy,
          glyph: _Layout.milLettersGlyph,
          canvasWidth: _Layout.w,
          canvasHeight: _Layout.h,
          width: 130,
        ),
      ],
      decals: <PlateDecal>[
        PlateDecal(
          drawing: _star,
          box: PlateBox(
            starCx - half,
            starCy - _Layout.starSize * 140 / 280,
            _Layout.starSize,
            _Layout.starSize,
          ),
        ),
        // Rasterised from the plate artwork
        // File:Plaque d'immatriculation des véhicules de l'Armée royale du
        // Maroc.png on Wikimedia Commons; no vector of this insignia was
        // found.
        if (crest)
          const PlateDecal(
            image: AssetImage(
              'assets/countries/morocco/icons/army_insignia.png',
              package: 'license_plate',
            ),
            box: _Layout.milCrest,
          ),
      ],
    );
  }
}

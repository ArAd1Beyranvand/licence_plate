import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'costa_rica_colors.dart';
import 'costa_rica_country.dart';

/// Where the ink sits on a 2013-series plate, in plate units.
///
/// **Canvas 520 × 257, not the infobox's 520 × 110.** Every picture on the
/// page is 2.0 : 1 (the offline stage fitted them at 2.025) and the prose gives
/// the North American 6 × 12 in, 152 × 300 mm. The infobox figure is a
/// copy-paste of Algeria's. Coordinates are those of the flattened references
/// (`.plateref/cr/flat_*.png`, 2080 × 1028 px, 4 px per unit): their frame
/// starts at x 2.5 where ours starts at 0, so everything sits ~2.5 units
/// further in than the printed artwork.
///
/// The consular, diplomatic, mission, official and historical plates are
/// measured off the small originals (330 px wide, scaled to 520, frame
/// offset removed) because their flats are corrupt; those figures are good to
/// about ±3.
///
/// **Fields, not cells.** Each printed run is one `PlateSlot`; its box spans
/// the whole run, laid out at the printed digit pitch (~60.5 — the plate's
/// face has fixed-width digits, so `1` is a bar in a full cell). Only the two
/// stacked digits of a protocol plate are separate slots, because they are
/// drawn one above the other.
///
/// **Glyph size.** Ink is ~0.55 of the glyph height asked for, so
/// `glyph = ink / 0.55`.
abstract final class _Layout {
  static const double width = 520, height = 257;

  /// The hologram strip: modal 939393 from the frame to x 25.2..26.8.
  static const double hologramEnd = 26;

  /// The side strip of bus, taxi, commercial, truck and motorcycle plates:
  /// yellow to ~106, then a 2.4-wide rule centred at 108.0 (AB bus), 109.4
  /// (commercial), 107.0 (SJB), 109.0 (TSJ). 108.5 is their mean.
  static const double stripEnd = 108.5, stripRule = 2.4;

  /// "COSTA RICA": ink rows 17.8..37 (19.3 tall, 156.7 wide, centred 247.2).
  static const double nameCx = 247.2, nameCy = 27.8, nameGlyph = 35;

  /// "CENTROAMÉRICA": ink rows 219.8..239 including the accent, whose ~2.3
  /// units are estimated away; centred 246.8.
  static const double sloganCx = 246.8, sloganCy = 229.8, sloganGlyph = 32;

  /// Flag: ink x 453.8..499, y 18.2..44.2 on every plate.
  static const PlateBox flag = PlateBox(454, 18, 45, 27);

  /// Pitch of the plate's digit face: centres of `2 3 9` at 341.5/401.7/463.5,
  /// `4 5 7 6 1 1` at 152/214/278/337/398/459, `1 2 3 4` at 194/255/315/376.
  static const double pitch = 60.5;

  // Private / electric: letters, dash, digits on one row.
  /// DCF-239: ink y 84.25..171.5 (87.25 → 158), centred 127.9.
  static const double privateCy = 127.9, privateGlyph = 158;
  // Letters ink 44.5..266.8; dash 276.2..305.2; digits 316..489.
  static const double privateLettersCx = 155.65, privateLettersWidth = 228;
  static const double privateDashCx = 290.7, privateDigitsCx = 402.5;

  /// The electric plate's bold condensed digits are 118.75 tall (y 77.5..196.25
  /// → a 216 glyph), which would run through both captions. 168 is what fits
  /// between them (~78% of reference). Ink: letters 39.8..246.2, dash
  /// 260..303.2, digits 315.5..496.8 (pitch 63.5).
  static const double electricCy = 134, electricGlyph = 168;
  static const double electricLettersCx = 143, electricLettersWidth = 210;
  static const double electricDashCx = 281.6, electricDigitsCx = 406.2;
  static const double electricPitch = 63.5;

  /// Hyphen box; the glyph is the row's own so the dash scales with it.
  static const double dashWidth = 30;

  // Disabled driver.
  /// The blue square: x 40..167, y 66.75..191.25, modal 0000A4. The corner
  /// radius is read off the picture (~12).
  static const PlateBox accessSquare = PlateBox(40, 66.75, 127, 124.5);
  static const double accessRadius = 12;

  /// The white figure inside it measures 99.5 × 101.25 on the plate; the
  /// Commons International Symbol of Access is narrower (0.85 : 1), so it is
  /// fitted by height and centred on (104, 129.1).
  static const PlateBox accessFigure = PlateBox(61.1, 78.5, 85.8, 101.25);

  /// `D-` ink 190.2..306.5; `699` ink 317.8..490.2 (pitch 60.9).
  static const double disabledPrefixCx = 248.35, disabledDigitsCx = 404;

  // Strip plates: prefix letters stacked in the strip, digits to its right.
  /// Letter column centred x 68.2; each letter ink 41 (→ 75); rows pitch 57.6
  /// (AB 76.2/134, SJB 47.8/105.8/162.5); the stack is centred on y 125.5.
  static const double stripLettersCx = 68.2, stripLettersCy = 125.5;
  static const double stripLettersGlyph = 75, stripLettersPitch = 57.6;

  /// Digits ink y 81.5..169.5 (88 → 160), centred 125.5. Six digits start at
  /// x ~122 (`4` of 457611, `1` of 561937, `2` of 225846); four sit centred
  /// at 285 (`1234` cell centres 194..376).
  static const double stripDigitsCy = 125.5, stripDigitsGlyph = 160;
  static const double stripSixLeft = 122, stripFourCx = 285;

  // Protocol plates (diplomatic, mission, power executive).
  /// Two stacked letters centred x 72.1 (54.8..88, 52..88.5, 60.2..89), ink
  /// rows 76.5..172.2 (each 41 → 74), centred 124.4: pitch 54.7.
  static const double protocolLettersCx = 72.1, protocolCy = 124.5;
  static const double protocolStackGlyph = 74, protocolStackPitch = 54.7;

  /// The two stacked digits, centred x 130.4, at the letters' rows.
  static const double protocolCodeCx = 130.4, protocolCodeWidth = 40;

  /// The dot: ink x 185..192.8 / 187.2..195.5, y 125.1..133.2.
  static const PlateBox protocolDot = PlateBox(186.2, 125.1, 8.2, 8);

  /// Digits ink y 82.2..167.8 (85.6 → 155), centred 125; cells from x 230.5
  /// (`427` centres 259.2/318/379.6, `4122` 263/322.9/382.7/442.6).
  static const double protocolDigitsCy = 125, protocolDigitsGlyph = 155;
  static const double protocolDigitsLeft = 230.5, protocolPitch = 60;

  // Consular, official, historical: one row of fields.
  /// Digits ink y 83.8..169 (consular), 80.8..167.5 (official),
  /// 80..165.8 (historical): ~86 → 156.
  static const double plainGlyph = 156, consularCy = 126.4, officialCy = 124.2;
  static const double historicCy = 122.9;

  /// CC: x 55.5..88.8 (centre 72.15), ink y 77..174.2, pitch 56.2.
  static const double consularLettersCx = 72.15, consularLettersCy = 125.6;
  static const double consularStackPitch = 56.2;

  /// VH: x 53.5..87.2 (centre 70.35), ink y 75.5..170.5, pitch 54.
  static const double historicLettersCx = 70.35, historicLettersCy = 123;
  static const double historicStackPitch = 54;
}

/// A stack of upright letters, one per line, centred on ([cx], [cy]).
PlateLabel _stack(
  String letters, {
  required double cx,
  required double cy,
  required double glyph,
  required double pitch,
}) => PlateLabel(
  text: letters.split('').join('\n'),
  box: PlateBox(cx - 30, cy - 87.5, 60, 175),
  glyphHeight: glyph,
  lineHeight: pitch / glyph,
);

PlateLabel _dash(double cx, double cy, double glyph) => PlateLabel(
  text: '-',
  box: PlateBox.centered(cx, cy, _Layout.dashWidth, glyph),
  glyphHeight: glyph,
);

/// [count] cells of [pitch] starting at [left], as one field. [length] is
/// [count] unless the field takes more digits than the box has cells, in which
/// case the longer run scales down to fit.
PlateSlot _digits({
  required double left,
  required double cy,
  required double glyph,
  required double pitch,
  required int count,
  int? length,
  int? minLength,
}) => PlateSlot(
  alphabet: CostaRicaAlphabets.digits,
  box: PlateBox(left, cy - glyph / 2, count * pitch, glyph),
  length: length ?? count,
  minLength: minLength,
);

/// The field of [count] cells centred on [cx].
PlateSlot _digitsAround({
  required double cx,
  required double cy,
  required double glyph,
  required double pitch,
  required int count,
  int? length,
  int? minLength,
}) => _digits(
  left: cx - count * pitch / 2,
  cy: cy,
  glyph: glyph,
  pitch: pitch,
  count: count,
  length: length,
  minLength: minLength,
);

const PlateSection _hologramFace = PlateSection.columns(<PlatePart>[
  PlatePart(
    PlateSection.fill(PlateFill.color(CostaRicaColors.hologram)),
    end: _Layout.hologramEnd,
  ),
  PlatePart(PlateSection.plain),
]);

const PlateSection _stripFace = PlateSection.columns(<PlatePart>[
  PlatePart(
    PlateSection.fill(PlateFill.color(CostaRicaColors.hologram)),
    end: _Layout.hologramEnd,
  ),
  PlatePart(
    PlateSection.fill(PlateFill.color(CostaRicaColors.stripYellow)),
    end: _Layout.stripEnd,
    divider: _Layout.stripRule,
  ),
  PlatePart(PlateSection.plain),
]);

/// What every plate shares: the hologram strip, the two captions and the flag.
/// The rest is the number's layout.
PlateSpec _plate({
  required String id,
  required List<PlateSlot> slots,
  required List<PlateTextGroup> textGroups,
  PlateSection background = _hologramFace,
  List<PlateLabel> labels = const <PlateLabel>[],
  List<PlateRule> rules = const <PlateRule>[],
  List<PlateBand> bands = const <PlateBand>[],
  List<PlateDecal> decals = const <PlateDecal>[],
}) => PlateSpec(
  id: 'cr.$id',
  country: CostaRicaCountry.costaRica,
  canvasWidth: _Layout.width,
  canvasHeight: _Layout.height,
  noPanel: true,
  panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
  background: background,
  bands: bands,
  slots: slots,
  rules: rules,
  labels: <PlateLabel>[
    PlateLabel(
      text: 'COSTA RICA',
      box: PlateBox(
        _Layout.nameCx - 130,
        _Layout.nameCy - _Layout.nameGlyph / 2,
        260,
        _Layout.nameGlyph,
      ),
      glyphHeight: _Layout.nameGlyph,
    ),
    PlateLabel(
      text: 'CENTROAMÉRICA',
      box: PlateBox(
        _Layout.sloganCx - 130,
        _Layout.sloganCy - _Layout.sloganGlyph / 2,
        260,
        _Layout.sloganGlyph,
      ),
      glyphHeight: _Layout.sloganGlyph,
    ),
    ...labels,
  ],
  decals: <PlateDecal>[
    const PlateDecal(drawing: CostaRicaCountry.flagDrawing, box: _Layout.flag),
    ...decals,
  ],
  textGroups: textGroups,
);

const List<PlateTextGroup> _numberOnly = <PlateTextGroup>[
  PlateTextGroup(<int>[0], key: 'number'),
];

/// Costa Rica's 2013-series plates.
///
/// Designs, and what the categories share:
///
/// * **Letters and digits** — [private] and [electric]: three letters, a dash,
///   three digits (`ABC-123`). They differ in colours and the box the row has
///   to fit.
/// * **Disabled driver** — [disabled]: the access pictogram, then `D-` and three
///   or four digits.
/// * **Strip** — [interprovincialBus], [cityBus], [taxi], [cityTaxi],
///   [commercial], [lightLoadTruck], [motorcycle]: the category's letters stacked
///   in a yellow side strip, one field of digits beside it. Four to five digits
///   on buses and taxis, six on the rest.
/// * **Protocol** — [diplomatic], [internationalMission], [powerExecutive]: two
///   stacked letters, two stacked digits, a dot, then three or four digits.
/// * **One row of fields** — [consular] (`C C 4-77`), [official] (`29-6944`),
///   [historical] (`VH 30`).
///
/// Not implemented: the 1961 plate (white on dark green, `SJ-10057`) on the
/// article's early-plates table. It is a historical series, not a current
/// category, and its photograph is of a worn real plate.
///
/// The article's serial formats (`1234 12345`, `D-123 D-1234`, `12 123 1234`)
/// are read as ranges, so those fields have a `minLength`. Every picture shows
/// the shorter form.
abstract final class CostaRicaPlates {
  /// `ABC-123`, blue on white.
  static final PlateSpec private = _lettersDash(
    id: 'private',
    lettersCx: _Layout.privateLettersCx,
    lettersWidth: _Layout.privateLettersWidth,
    dashCx: _Layout.privateDashCx,
    digitsCx: _Layout.privateDigitsCx,
    cy: _Layout.privateCy,
    glyph: _Layout.privateGlyph,
    pitch: _Layout.pitch,
  );

  /// `ABD-123`, blue on teal. First issued in 2019; hybrids are excluded. The
  /// two black pills beside the caption are on the artwork (x 75.5..131 and
  /// 388.5..444.5, y ~22.5..35); the reference's flag sits in a pale sticker
  /// zone that is not drawn.
  static final PlateSpec electric = _lettersDash(
    id: 'electric',
    lettersCx: _Layout.electricLettersCx,
    lettersWidth: _Layout.electricLettersWidth,
    dashCx: _Layout.electricDashCx,
    digitsCx: _Layout.electricDigitsCx,
    cy: _Layout.electricCy,
    glyph: _Layout.electricGlyph,
    pitch: _Layout.electricPitch,
    bands: const <PlateBand>[
      PlateBand(
        box: PlateBox(75.5, 22.5, 55.5, 11),
        color: CostaRicaColors.black,
        topCornerRadius: 5.5,
        bottomCornerRadius: 5.5,
      ),
      PlateBand(
        box: PlateBox(388.5, 23.5, 56, 11.5),
        color: CostaRicaColors.black,
        topCornerRadius: 5.75,
        bottomCornerRadius: 5.75,
      ),
    ],
  );

  /// `D-123`, `D-1234`: the pictogram, a fixed `D-`, three or four digits. A
  /// fourth digit does not fit at the printed pitch, so the run scales down
  /// to the three-digit box.
  static final PlateSpec disabled = _plate(
    id: 'disabled',
    bands: const <PlateBand>[
      PlateBand(
        box: _Layout.accessSquare,
        color: CostaRicaColors.accessBlue,
        topCornerRadius: _Layout.accessRadius,
        bottomCornerRadius: _Layout.accessRadius,
      ),
    ],
    decals: const <PlateDecal>[
      PlateDecal(
        image: AssetImage(
          'assets/countries/costa_rica/icons/access.png',
          package: 'license_plate',
        ),
        box: _Layout.accessFigure,
      ),
    ],
    labels: <PlateLabel>[
      PlateLabel(
        text: 'D-',
        box: PlateBox(
          _Layout.disabledPrefixCx - 65,
          _Layout.privateCy - _Layout.privateGlyph / 2,
          130,
          _Layout.privateGlyph,
        ),
        glyphHeight: _Layout.privateGlyph,
      ),
    ],
    slots: <PlateSlot>[
      _digitsAround(
        cx: _Layout.disabledDigitsCx,
        cy: _Layout.privateCy,
        glyph: _Layout.privateGlyph,
        pitch: 61,
        count: 3,
        length: 4,
        minLength: 3,
      ),
    ],
    textGroups: _numberOnly,
  );

  /// Interprovincial bus: `AB 1234`, black.
  static final PlateSpec interprovincialBus = _strip(
    'interprovincialBus',
    'AB',
  );

  /// City and interurban bus: `SJB 1234`, black.
  static final PlateSpec cityBus = _strip('cityBus', 'SJB');

  /// Taxi: `TA 1234`, black on red.
  static final PlateSpec taxi = _strip('taxi', 'TA');

  /// City and interurban taxi: `TSJ 1234`, red.
  static final PlateSpec cityTaxi = _strip('cityTaxi', 'TSJ');

  /// Commercial vehicle: `C 123456`, red.
  static final PlateSpec commercial = _strip('commercial', 'C', digits: 6);

  /// Commercial limited light-load truck: `CL 123456`, red.
  static final PlateSpec lightLoadTruck = _strip(
    'lightLoadTruck',
    'CL',
    digits: 6,
  );

  /// Motorcycle: `M 123456`, blue.
  static final PlateSpec motorcycle = _strip('motorcycle', 'M', digits: 6);

  /// Diplomatic corps: `CD`, a two-digit code, then three digits; black.
  static final PlateSpec diplomatic = _protocol('diplomatic', 'CD', 3);

  /// International mission: `MI`, a two-digit code, then three digits; black
  /// on yellow.
  static final PlateSpec internationalMission = _protocol(
    'internationalMission',
    'MI',
    3,
  );

  /// Power executive: `PE`, a two-digit code, then four digits; green.
  static final PlateSpec powerExecutive = _protocol('powerExecutive', 'PE', 4);

  /// Consular corps: `CC`, one digit, a dash, two digits; black.
  static final PlateSpec consular = _plate(
    id: 'consular',
    labels: <PlateLabel>[
      _stack(
        'CC',
        cx: _Layout.consularLettersCx,
        cy: _Layout.consularLettersCy,
        glyph: _Layout.protocolStackGlyph,
        pitch: _Layout.consularStackPitch,
      ),
      _dash(246.7, _Layout.consularCy, _Layout.plainGlyph),
    ],
    slots: <PlateSlot>[
      // `4`: cell centre 195.7; `77`: centres 298.4 and 358.8.
      _digits(
        left: 165.4,
        cy: _Layout.consularCy,
        glyph: _Layout.plainGlyph,
        pitch: _Layout.pitch,
        count: 1,
      ),
      _digits(
        left: 268.2,
        cy: _Layout.consularCy,
        glyph: _Layout.plainGlyph,
        pitch: _Layout.pitch,
        count: 2,
      ),
    ],
    textGroups: PlateTextGroup.perSlot(<String>['unit', 'number']),
  );

  /// Official vehicle: two digits, a dash, four; red.
  static final PlateSpec official = _plate(
    id: 'official',
    labels: <PlateLabel>[_dash(205.5, _Layout.officialCy, _Layout.plainGlyph)],
    slots: <PlateSlot>[
      // `29`: centres 95.5 and 155.6; `6944` from 225.8 at pitch 59.8.
      _digits(
        left: 65.4,
        cy: _Layout.officialCy,
        glyph: _Layout.plainGlyph,
        pitch: 60.1,
        count: 2,
      ),
      _digits(
        left: 225.8,
        cy: _Layout.officialCy,
        glyph: _Layout.plainGlyph,
        pitch: 59.8,
        count: 4,
      ),
    ],
    textGroups: PlateTextGroup.perSlot(<String>['unit', 'number']),
  );

  /// Historical vehicle: `VH`, two to four digits; black on yellow. `30`
  /// sits centred at x 248.
  static final PlateSpec historical = _plate(
    id: 'historical',
    labels: <PlateLabel>[
      _stack(
        'VH',
        cx: _Layout.historicLettersCx,
        cy: _Layout.historicLettersCy,
        glyph: _Layout.protocolStackGlyph,
        pitch: _Layout.historicStackPitch,
      ),
    ],
    slots: <PlateSlot>[
      _digitsAround(
        cx: 248,
        cy: _Layout.historicCy,
        glyph: _Layout.plainGlyph,
        pitch: 60,
        count: 4,
        minLength: 2,
      ),
    ],
    textGroups: _numberOnly,
  );

  static PlateSpec _lettersDash({
    required String id,
    required double lettersCx,
    required double lettersWidth,
    required double dashCx,
    required double digitsCx,
    required double cy,
    required double glyph,
    required double pitch,
    List<PlateBand> bands = const <PlateBand>[],
  }) => _plate(
    id: id,
    bands: bands,
    labels: <PlateLabel>[_dash(dashCx, cy, glyph)],
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: CostaRicaAlphabets.letters,
        box: PlateBox.centered(lettersCx, cy, lettersWidth, glyph),
        length: 3,
      ),
      _digitsAround(cx: digitsCx, cy: cy, glyph: glyph, pitch: pitch, count: 3),
    ],
    textGroups: PlateTextGroup.perSlot(<String>['letters', 'number']),
  );

  static PlateSpec _strip(String id, String prefix, {int digits = 4}) => _plate(
    id: id,
    background: _stripFace,
    labels: <PlateLabel>[
      _stack(
        prefix,
        cx: _Layout.stripLettersCx,
        cy: _Layout.stripLettersCy,
        glyph: _Layout.stripLettersGlyph,
        pitch: _Layout.stripLettersPitch,
      ),
    ],
    slots: <PlateSlot>[
      digits == 6
          ? _digits(
              left: _Layout.stripSixLeft,
              cy: _Layout.stripDigitsCy,
              glyph: _Layout.stripDigitsGlyph,
              pitch: 61.3,
              count: 6,
            )
          : _digitsAround(
              cx: _Layout.stripFourCx,
              cy: _Layout.stripDigitsCy,
              glyph: _Layout.stripDigitsGlyph,
              pitch: 61.3,
              count: 5,
              minLength: 4,
            ),
    ],
    textGroups: _numberOnly,
  );

  static PlateSpec _protocol(String id, String letters, int digits) => _plate(
    id: id,
    rules: const <PlateRule>[PlateRule(box: _Layout.protocolDot)],
    labels: <PlateLabel>[
      _stack(
        letters,
        cx: _Layout.protocolLettersCx,
        cy: _Layout.protocolCy,
        glyph: _Layout.protocolStackGlyph,
        pitch: _Layout.protocolStackPitch,
      ),
    ],
    slots: <PlateSlot>[
      for (final double dy in <double>[
        -_Layout.protocolStackPitch / 2,
        _Layout.protocolStackPitch / 2,
      ])
        PlateSlot(
          alphabet: CostaRicaAlphabets.digits,
          box: PlateBox(
            _Layout.protocolCodeCx - _Layout.protocolCodeWidth / 2,
            _Layout.protocolCy + dy - _Layout.protocolStackGlyph / 2,
            _Layout.protocolCodeWidth,
            _Layout.protocolStackGlyph,
          ),
        ),
      _digits(
        left: _Layout.protocolDigitsLeft,
        cy: _Layout.protocolDigitsCy,
        glyph: _Layout.protocolDigitsGlyph,
        pitch: _Layout.protocolPitch,
        count: digits,
      ),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0, 1], key: 'code'),
      PlateTextGroup(<int>[2], key: 'number'),
    ],
  );
}

import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'poland_country.dart';
import 'poland_missions.dart';

/// Measured on references flattened to 110 units high (4 px per unit): 520
/// wide for the long plates, and for the two reduced formats the width of the
/// original photograph at that height (the flattened sheet stretches them to
/// 520, so those were measured on the originals).
///
/// Ink runs (x, from colour masks; runs split on gaps over 7 units) behind the
/// boxes. The ink of a full-size plate is 78 units tall (y 16–94); a box would
/// need ~140 for that, so every field box is the full 110 and the ink lands at
/// about 77 % of reference.
/// - private (`WI 255RY`, `WA 6642E`): code 68–156 / 68–171, series 217–488;
///   a three-letter code (`DWR`, electric) runs 52–211 and its series
///   249–506, so the series moves right by ~30 with the code. One slot per
///   field cannot follow that: boxes are drawn for the three-letter code and a
///   two-letter code sits ~12 left of centre.
/// - professional `P35 01P07`: code 57–211 (pitch 55), series 248–508 (pitch 55)
/// - temporary `D6 5889`: code 64–171 (pitch 62), series 276–488 (pitch 57)
/// - test `S1 355 B`: code 63–165 (pitch 65), digits 230–384 (pitch 56),
///   `B` 425–480
/// - classic `SZ 08A`: code 65–190 (pitch 68), series 228–388 (pitch 57);
///   `CBR 7C`: code 61–248 (pitch 67), series 290–390
/// - custom `P0 KAZIK`: code 65–169 (pitch 58.5), series 211–492
/// - police `HPP E057`: code 64–250 (pitch 66.5), series 288–499 (pitch 55)
/// - border guard `HWA A105`: code 60–247 (pitch 67), series 292–506 (pitch 57)
/// - military `UA 03271`: code 68–189 (pitch 67.5), series 231–490 (pitch 56.5)
/// - diplomatic `W 005761`: `W` 27–80, digits 130–482 (pitch 64)
/// - reduced `C 009` (297 wide): `C` 53–98, digits 133–273 (pitch 49.5)
/// - motorcycle `CBY F55N` (140 wide): rows y 15–47 and 63–95, code 37–109
///   (pitch 27), series 14–127 (pitch 31)
///
/// The blue block is x 0–44.5 (frame to frame), full height; on the small
/// motorcycle plate it floats at x 6–33.5, y 10.5–45.5. The frame width and
/// corner radius are read off the reduced reference; the holograms, the
/// month-and-year seal on the temporary plate and the small print under the
/// border guard's number are not drawn.
abstract final class _Layout {
  static const double width = 520, height = 110;
  static const double reducedWidth = 297, motorcycleWidth = 140;

  static const _Panel panel = _Panel(0, 44.5, 0, height);
  static const _Panel reducedPanel = _Panel(0, 46, 0, height);
  static const _Panel motorcyclePanel = _Panel(5.9, 33.5, 10.5, 45.5);

  // Private and electric: three-letter box, five-character series.
  static const PlateBox carCode = PlateBox(51, 0, 161, height);
  static const PlateBox carSeries = PlateBox(246.5, 0, 262, height);

  static const PlateBox customCode = PlateBox(59.5, 0, 117, height);
  static const PlateBox customSeries = PlateBox(206.5, 0, 290, height);

  static const PlateBox professionalCode = PlateBox(52.8, 0, 166, height);
  static const PlateBox professionalSeries = PlateBox(242, 0, 274, height);

  static const PlateBox temporaryCode = PlateBox(56.5, 0, 124, height);
  static const PlateBox temporarySeries = PlateBox(267.6, 0, 227.2, height);

  static const PlateBox testCode = PlateBox(57.5, 0, 130, height);
  static const PlateBox testDigits = PlateBox(223.5, 0, 168, height);
  static const PlateBox testSuffix = PlateBox(425, 0, 55, height);

  // The vintage-car picture occupies x 400–500, so the series stops short.
  static const PlateBox classicCode = PlateBox(54, 0, 201, height);
  static const PlateBox classicSeries = PlateBox(234.5, 0, 171, height);

  static const PlateBox policeCode = PlateBox(56.75, 0, 199.5, height);
  static const PlateBox policeSeries = PlateBox(283.85, 0, 221.4, height);

  static const PlateBox guardCode = PlateBox(54.4, 0, 201.75, height);
  static const PlateBox guardSeries = PlateBox(285.4, 0, 228.8, height);

  static const PlateBox militaryCode = PlateBox(62.75, 0, 135, height);
  static const PlateBox militarySeries = PlateBox(224.75, 0, 282.5, height);

  static const PlateBox diplomaticVoivodeship = PlateBox(26, 0, 55, height);
  static const PlateBox diplomaticMission = PlateBox(119.5, 0, 192, height);
  static const PlateBox diplomaticSerial = PlateBox(312, 0, 192, height);

  static const PlateBox reducedCode = PlateBox(50, 0, 50, height);
  static const PlateBox reducedSeries = PlateBox(128.75, 0, 148.5, height);

  // Two rows of 58-high boxes: ink ~32 of the 58, as the references print.
  static const double rowHeight = 58;
  static const PlateBox motorcycleCode = PlateBox(32.5, 2, 81, rowHeight);
  static const PlateBox motorcycleSeries = PlateBox(8.5, 50, 124, rowHeight);

  /// Letter spacing that puts glyphs at [pitch] (the font advance is about
  /// 0.6 of its 0.72-of-height size).
  static double spacing(double pitch, [double glyph = height]) =>
      plateRunSpacing(pitch, glyph);
}

/// Every field is one slot; text groups are named per field.
///
/// - [private] (also electric, since 2020: theme `electric`) and [custom]: a
///   two- or three-letter county code and a series of four or five
///   characters (`WI 255RY`, `DWR 7545G`); a custom plate's code is a letter
///   and a digit and its series three to five characters in which B, D, I, O
///   and Z are allowed.
/// - [professional]: a letter and two digits, then a five-character series
///   with `P` in the middle (`P35 01P07`), green on white.
/// - [temporary]: a letter and a digit, then four characters, red on white.
/// - [test]: a letter and a digit, three digits and the letter `B`, red.
/// - [classic]: a two- or three-letter code and a two- or three-character
///   series on yellow.
/// - [motorcycle]: the code over a four-character series, on a small plate.
/// - [reduced]: a letter and three characters, on a plate the width of a US
///   one.
/// - [police], [borderGuard], [military]: read off one photograph each, so
///   only the field split and the flag block (not the EU stars) are known.
/// - [diplomatic]: `W`, a three-digit mission code and a three-digit serial,
///   white on dark blue with no blue block. Codes 049 and 095 are refused (see
///   [PolandMissions]). The article prints the two numbers as one run; they
///   are two fields here so the mission code can be refused.
///
/// Not implemented: the 1976–2000 and earlier series (superseded), the
/// windshield sticker (not a plate, no longer issued), the vintage-car picture
/// on classic plates (a complex emblem), and other temporary and export
/// formats the article does not picture.
abstract final class PolandPlates {
  static final PlateSpec private = _build(
    id: 'pl.private',
    slots: _car(),
    groups: _twoFields,
  );

  static final PlateSpec custom = _build(
    id: 'pl.custom',
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: PolandAlphabets.alphanumeric,
        box: _Layout.customCode,
        length: 2,
        spacing: _Layout.spacing(58.5),
      ),
      PlateSlot(
        alphabet: PolandAlphabets.alphanumeric,
        box: _Layout.customSeries,
        length: 5,
        minLength: 3,
      ),
    ],
    groups: _twoFields,
  );

  static final PlateSpec professional = _build(
    id: 'pl.professional',
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: PolandAlphabets.alphanumeric,
        box: _Layout.professionalCode,
        length: 3,
        spacing: _Layout.spacing(55.3),
      ),
      PlateSlot(
        alphabet: PolandAlphabets.alphanumeric,
        box: _Layout.professionalSeries,
        length: 5,
        spacing: _Layout.spacing(54.8),
      ),
    ],
    groups: _twoFields,
  );

  static final PlateSpec temporary = _build(
    id: 'pl.temporary',
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: PolandAlphabets.alphanumeric,
        box: _Layout.temporaryCode,
        length: 2,
        spacing: _Layout.spacing(62),
      ),
      PlateSlot(
        alphabet: PolandAlphabets.alphanumeric,
        box: _Layout.temporarySeries,
        length: 4,
        spacing: _Layout.spacing(56.8),
      ),
    ],
    groups: _twoFields,
  );

  static final PlateSpec test = _build(
    id: 'pl.test',
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: PolandAlphabets.alphanumeric,
        box: _Layout.testCode,
        length: 2,
        spacing: _Layout.spacing(65),
      ),
      PlateSlot(
        alphabet: PolandAlphabets.digits,
        box: _Layout.testDigits,
        length: 3,
        spacing: _Layout.spacing(56),
      ),
      PlateSlot(
        alphabet: PolandAlphabets.letters,
        box: _Layout.testSuffix,
        length: 1,
      ),
    ],
    groups: PlateTextGroup.perSlot(<String>['code', 'number', 'suffix']),
  );

  static final PlateSpec classic = _build(
    id: 'pl.classic',
    slots: const <PlateSlot>[
      PlateSlot(
        alphabet: PolandAlphabets.letters,
        box: _Layout.classicCode,
        length: 3,
        minLength: 2,
      ),
      PlateSlot(
        alphabet: PolandAlphabets.alphanumeric,
        box: _Layout.classicSeries,
        length: 3,
        minLength: 2,
      ),
    ],
    groups: _twoFields,
  );

  static final PlateSpec police = _build(
    id: 'pl.police',
    country: PolandCountry.polandFlag,
    slots: _fixed(_Layout.policeCode, 3, 66.5, _Layout.policeSeries, 4, 55.3),
    groups: _twoFields,
  );

  static final PlateSpec borderGuard = _build(
    id: 'pl.border_guard',
    country: PolandCountry.polandFlag,
    slots: _fixed(_Layout.guardCode, 3, 67.25, _Layout.guardSeries, 4, 57.2),
    groups: _twoFields,
  );

  static final PlateSpec military = _build(
    id: 'pl.military',
    country: PolandCountry.polandFlag,
    slots: _fixed(
      _Layout.militaryCode,
      2,
      67.5,
      _Layout.militarySeries,
      5,
      56.5,
    ),
    groups: _twoFields,
  );

  static final PlateSpec diplomatic = _build(
    id: 'pl.diplomatic',
    panel: null,
    slots: <PlateSlot>[
      const PlateSlot(
        alphabet: PolandAlphabets.letters,
        box: _Layout.diplomaticVoivodeship,
        length: 1,
      ),
      PlateSlot(
        alphabet: PolandAlphabets.digits,
        box: _Layout.diplomaticMission,
        length: 3,
        spacing: _Layout.spacing(64),
      ),
      PlateSlot(
        alphabet: PolandAlphabets.digits,
        box: _Layout.diplomaticSerial,
        length: 3,
        spacing: _Layout.spacing(64),
      ),
    ],
    groups: PlateTextGroup.perSlot(<String>[
      'voivodeship',
      'mission',
      'serial',
    ]),
    restrictions: const <PlateRestriction>[PolandMissions.restriction],
  );

  static final PlateSpec reduced = _build(
    id: 'pl.reduced',
    width: _Layout.reducedWidth,
    panel: _Layout.reducedPanel,
    slots: <PlateSlot>[
      const PlateSlot(
        alphabet: PolandAlphabets.letters,
        box: _Layout.reducedCode,
        length: 1,
      ),
      PlateSlot(
        alphabet: PolandAlphabets.alphanumeric,
        box: _Layout.reducedSeries,
        length: 3,
        spacing: _Layout.spacing(49.5),
      ),
    ],
    groups: _twoFields,
  );

  static final PlateSpec motorcycle = _build(
    id: 'pl.motorcycle',
    width: _Layout.motorcycleWidth,
    panel: _Layout.motorcyclePanel,
    slots: <PlateSlot>[
      const PlateSlot(
        alphabet: PolandAlphabets.letters,
        box: _Layout.motorcycleCode,
        length: 3,
        minLength: 2,
      ),
      PlateSlot(
        alphabet: PolandAlphabets.alphanumeric,
        box: _Layout.motorcycleSeries,
        length: 4,
        spacing: _Layout.spacing(31, _Layout.rowHeight),
      ),
    ],
    groups: _twoFields,
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    custom,
    professional,
    temporary,
    test,
    classic,
    motorcycle,
    reduced,
    police,
    borderGuard,
    military,
    diplomatic,
  ];

  static const List<PlateTextGroup> _twoFields = <PlateTextGroup>[
    PlateTextGroup(<int>[0], key: 'code'),
    PlateTextGroup(<int>[1], key: 'serial'),
  ];

  /// A county code of two or three letters and a series of four or five
  /// characters. Both are variable, so neither has a printed pitch to keep.
  static List<PlateSlot> _car() => const <PlateSlot>[
    PlateSlot(
      alphabet: PolandAlphabets.letters,
      box: _Layout.carCode,
      length: 3,
      minLength: 2,
    ),
    PlateSlot(
      alphabet: PolandAlphabets.alphanumeric,
      box: _Layout.carSeries,
      length: 5,
      minLength: 4,
    ),
  ];

  /// A letters field and a mixed field, each of a fixed length at a printed
  /// pitch.
  static List<PlateSlot> _fixed(
    PlateBox code,
    int codeLength,
    double codePitch,
    PlateBox series,
    int seriesLength,
    double seriesPitch,
  ) => <PlateSlot>[
    PlateSlot(
      alphabet: PolandAlphabets.letters,
      box: code,
      length: codeLength,
      spacing: _Layout.spacing(codePitch),
    ),
    PlateSlot(
      alphabet: PolandAlphabets.alphanumeric,
      box: series,
      length: seriesLength,
      spacing: _Layout.spacing(seriesPitch),
    ),
  ];

  static PlateSpec _build({
    required String id,
    required List<PlateSlot> slots,
    required List<PlateTextGroup> groups,
    PlateCountry country = PolandCountry.poland,
    double width = _Layout.width,
    _Panel? panel = _Layout.panel,
    List<PlateRestriction> restrictions = const <PlateRestriction>[],
  }) => PlateSpec(
    id: id,
    country: country,
    canvasWidth: width,
    canvasHeight: _Layout.height,
    panel: PlatePanel(box: panel?.inner ?? const PlateBox(0, 0, 0, 0)),
    noPanel: panel == null,
    background: panel == null ? PlateSection.plain : panel.background(),
    slots: slots,
    textGroups: groups,
    restrictions: restrictions,
  );
}

class _Panel {
  const _Panel(this.left, this.right, this.top, this.bottom);

  final double left, right, top, bottom;

  bool get _fullHeight => top <= 0 && bottom >= _Layout.height;

  /// The block the flag and `PL` are laid out in: inside the frame for a strip
  /// that runs to the plate's edge.
  PlateBox get inner => _fullHeight
      ? PlateBox(left + 4, 4, right - left - 4, _Layout.height - 8)
      : PlateBox.fromLTRB(left, top, right, bottom);

  /// A strip under the frame, or a block floating clear of the edge.
  PlateSection background() {
    const PlateSection panelFill = PlateSection.fill(PlateFill.panel);
    if (_fullHeight) {
      return PlateSection.columns(<PlatePart>[
        PlatePart(panelFill, end: right),
        const PlatePart(PlateSection.plain),
      ]);
    }
    return PlateSection.columns(<PlatePart>[
      PlatePart(PlateSection.plain, end: left),
      PlatePart(
        PlateSection.rows(<PlatePart>[
          PlatePart(PlateSection.plain, end: top),
          PlatePart(panelFill, end: bottom),
          const PlatePart(PlateSection.plain),
        ]),
        end: right,
      ),
      const PlatePart(PlateSection.plain),
    ]);
  }
}

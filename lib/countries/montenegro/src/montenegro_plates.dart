import 'dart:math';

import 'package:flutter/painting.dart' show AssetImage;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'montenegro_colors.dart';
import 'montenegro_country.dart';
import 'montenegro_regions.dart';

/// Where the ink sits, in plate units.
///
/// One-line plates are the 520×110 mm the article gives. The numbers are the
/// offline stage's column runs of the ink on the flattened photos: `AN`/`PL`/
/// `UL` for the regular plate, `Montenegro_diplomatic_license_plate__Norway_`
/// for the diplomatic one, `Temporary_license_plate_from_Montenegro` for the
/// temporary one. The blue band ends at 58 (diplomatic 52.5) under the frame;
/// `MNE` is white at its foot.
///
/// Ink is 7.5–102 tall on the regular plate, but ink is ~55% of the box, so
/// the 110 box gives about 60: roughly 64% of reference, the most the canvas
/// allows. Each field is one slot whose box spans the field's ink; a fixed
/// field is spaced to its printed pitch.
///
/// The crest is a red disc (a [PlateDrawing]) with the coat of arms on it.
/// The disc is x 177–218, y 18.5–68 on `AN`, read as a 44-unit circle centred
/// (197.5, 43); the tiny map and serial number printed under it are left out.
///
/// The two-row plates (agricultural, moped) have no article size; their
/// canvases follow the photos' aspect (1.85 and 1.33), and their rows are the
/// flat's rows (top ink 7.5–54.8, bottom 59.2–94 on the moped) scaled by the
/// canvas over 520×110. Those photos are skewed, so these boxes are read off
/// the sheet, not column-measured.
abstract final class _Layout {
  static const double width = 520, height = 110;
  static const double bandEnd = 58, dipBandEnd = 52.5;
  static const double sloTop = 70, sloHeight = 32, sloGlyph = 28;

  static const double crestCx = 197.5, crestCy = 43, crestRadius = 22;

  // Regular: municipality, series letters, number.
  static const (double, double) regionSpan = (68, 165);
  static const (double, double) lettersSpan = (230, 330);
  static const (double, double) serialSpan = (346, 499);

  // Diplomatic: country code (two digits, three for organisations), series
  // letter, number. The code box is shortened at the band; a two-digit code
  // sits a little left of the photo's 91.5–198.5.
  static const (double, double) codeSpan = (76, 199);
  static const (double, double) letterSpan = (240, 287.5);
  static const (double, double) dipSerialSpan = (328, 483.5);

  // Temporary: municipality, `R`/`P` and the year stacked, number.
  static const (double, double) tempRegionSpan = (68, 174);
  static const (double, double) tempSerialSpan = (332, 489);
  static const double tempCrestCx = 205, tempCrestCy = 54, tempCrestRadius = 22;
  static const double rpCx = 272, yearCx = 301;
  static const double stackTop = 8, stackStep = 50, stackHeight = 48;
  static const double stackWidth = 28;
}

/// A two-row plate's canvas and boxes.
class _Rows {
  const _Rows({
    required this.width,
    required this.height,
    required this.bandEnd,
    required this.rowEnd,
    required this.slo,
    required this.region,
    required this.crestCx,
    required this.crestCy,
    required this.crestRadius,
    required this.bottomTop,
    required this.bottomHeight,
    required this.topTop,
    required this.topHeight,
  });

  final double width, height;

  /// The band is the top row only: it ends at [bandEnd] and the row at [rowEnd].
  final double bandEnd, rowEnd;
  final PlateBox slo;
  final (double, double) region;
  final double crestCx, crestCy, crestRadius;
  final double topTop, topHeight, bottomTop, bottomHeight;

  static const _Rows agricultural = _Rows(
    width: 240,
    height: 130,
    bandEnd: 58,
    rowEnd: 68,
    slo: PlateBox(3, 40, 52, 26),
    region: (98, 152),
    crestCx: 186,
    crestCy: 34,
    crestRadius: 13,
    topTop: 4,
    topHeight: 64,
    bottomTop: 70,
    bottomHeight: 50,
  );

  static const _Rows moped = _Rows(
    width: 200,
    height: 150,
    bandEnd: 41,
    rowEnd: 80,
    slo: PlateBox(2, 46, 38, 28),
    region: (51, 117),
    crestCx: 155,
    crestCy: 45,
    crestRadius: 27,
    topTop: 5,
    topHeight: 72,
    bottomTop: 81,
    bottomHeight: 66,
  );
}

const AssetImage _coat = AssetImage(
  // Commons: File:Coat of arms of Montenegro.svg, rasterised at 256 high.
  'assets/countries/montenegro/icons/coat_of_arms.png',
  package: 'license_plate',
);

/// The Montenegrin plates.
///
/// [regular] `PG [crest] AB 123` (municipality, two series letters, three
/// digits), [diplomatic] `53 A 002` (country code, series letter, number;
/// yellow for the `A`/`M`/`C` series, black via `MontenegroThemes.press` for
/// `P`/`E`), [temporary] `HN [crest] R/P 10 097` (`R` over `P` and the year
/// stacked), [agricultural] `PG / AA 02` on green, [moped] `HN / AB18`.
///
/// Not implemented: the police and military plates (the pictures were
/// unticked in the offline stage), the oldtimer plate (black on brown, no
/// picture), the oval `CMD`/`CD` extras, and the pre-2008 Yugoslav plate. The
/// three-digit diplomatic codes of international organisations are accepted
/// (`minLength: 2, length: 3`).
///
/// A field is one slot: the municipality, the series letters and the number
/// are three slots, not seven cells. The temporary plate's year stays two
/// slots because its digits are drawn one above the other.
abstract final class MontenegroPlates {
  static final PlateSpec regular = _oneLine(
    id: 'me.regular',
    bandEnd: _Layout.bandEnd,
    slots: <(String, List<PlateSlot>)>[
      (
        'region',
        <PlateSlot>[
          _field(MontenegroAlphabets.municipality, _Layout.regionSpan, 2),
        ],
      ),
      (
        'letters',
        <PlateSlot>[
          _field(MontenegroAlphabets.letters, _Layout.lettersSpan, 2),
        ],
      ),
      (
        'serial',
        <PlateSlot>[_field(MontenegroAlphabets.digits, _Layout.serialSpan, 3)],
      ),
    ],
    crest: (_Layout.crestCx, _Layout.crestCy, _Layout.crestRadius),
    region: true,
  );

  static final PlateSpec diplomatic = _oneLine(
    id: 'me.diplomatic',
    bandEnd: _Layout.dipBandEnd,
    slots: <(String, List<PlateSlot>)>[
      (
        'code',
        <PlateSlot>[
          _field(MontenegroAlphabets.digits, _Layout.codeSpan, 3, minLength: 2),
        ],
      ),
      (
        'letter',
        <PlateSlot>[
          _field(MontenegroAlphabets.diplomaticLetters, _Layout.letterSpan, 1),
        ],
      ),
      (
        'serial',
        <PlateSlot>[
          _field(MontenegroAlphabets.digits, _Layout.dipSerialSpan, 3),
        ],
      ),
    ],
  );

  static final PlateSpec temporary = _oneLine(
    id: 'me.temporary',
    bandEnd: _Layout.bandEnd,
    slots: <(String, List<PlateSlot>)>[
      (
        'region',
        <PlateSlot>[
          _field(MontenegroAlphabets.municipality, _Layout.tempRegionSpan, 2),
        ],
      ),
      ('year', _stackSlots(_Layout.yearCx)),
      (
        'serial',
        <PlateSlot>[
          _field(MontenegroAlphabets.digits, _Layout.tempSerialSpan, 3),
        ],
      ),
    ],
    crest: (_Layout.tempCrestCx, _Layout.tempCrestCy, _Layout.tempCrestRadius),
    region: true,
    stackedLabels: true,
  );

  static final PlateSpec agricultural = _twoRows(
    id: 'me.agricultural',
    rows: _Rows.agricultural,
    bottom: <(String, (double, double), PlateAlphabet, int)>[
      ('letters', (62, 125), MontenegroAlphabets.letters, 2),
      ('serial', (140, 203), MontenegroAlphabets.digits, 2),
    ],
  );

  static final PlateSpec moped = _twoRows(
    id: 'me.moped',
    rows: _Rows.moped,
    bottom: <(String, (double, double), PlateAlphabet, int)>[
      ('serial', (30, 171), MontenegroAlphabets.mixed, 4),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[
    regular,
    diplomatic,
    temporary,
    agricultural,
    moped,
  ];
}

/// A field's slot: the box spans [span] and a fixed run is spaced to the
/// printed pitch (the span less one glyph, over the gaps).
PlateSlot _field(
  PlateAlphabet alphabet,
  (double, double) span,
  int length, {
  int? minLength,
  double top = 0,
  double height = _Layout.height,
}) {
  final double glyph = 0.6 * 0.72 * height;
  final double pitch = length > 1
      ? (span.$2 - span.$1 - glyph) / (length - 1)
      : 0;
  return PlateSlot(
    alphabet: alphabet,
    box: PlateBox(span.$1, top, span.$2 - span.$1, height),
    length: length,
    minLength: minLength,
    spacing: minLength == null && length > 1 ? max(0, pitch - glyph) : 0,
  );
}

/// The temporary plate's year: two digits, one above the other. Drawn apart,
/// so two slots.
List<PlateSlot> _stackSlots(double cx) => <PlateSlot>[
  for (int i = 0; i < 2; i++)
    PlateSlot(
      alphabet: MontenegroAlphabets.digits,
      box: PlateBox(
        cx - _Layout.stackWidth / 2,
        _Layout.stackTop + i * _Layout.stackStep,
        _Layout.stackWidth,
        _Layout.stackHeight,
      ),
    ),
];

PlateBox _discBox(double cx, double cy, double r) =>
    PlateBox(cx - r, cy - r, 2 * r, 2 * r);

List<PlateDecal> _crest(double cx, double cy, double r) => <PlateDecal>[
  PlateDecal(
    drawing: PlateDrawing(2 * r, 2 * r, <PlateShape>[
      PlateCircleShape(r, r, r, MontenegroColors.crestDisc),
    ]),
    box: _discBox(cx, cy, r),
  ),
  // The coat is 222×256; it fills three quarters of the disc's height.
  PlateDecal(
    image: _coat,
    box: PlateBox(
      cx - 0.75 * r * 222 / 256,
      cy - 0.75 * r,
      1.5 * r * 222 / 256,
      1.5 * r,
    ),
  ),
];

PlateLabel _slo(PlateBox box, double glyph) => PlateLabel(
  text: 'MNE',
  box: box,
  glyphHeight: glyph,
  color: MontenegroColors.white,
);

PlateSpec _oneLine({
  required String id,
  required double bandEnd,
  required List<(String, List<PlateSlot>)> slots,
  (double, double, double)? crest,
  bool region = false,
  bool stackedLabels = false,
}) {
  final List<PlateSlot> all = <PlateSlot>[];
  final List<PlateTextGroup> groups = <PlateTextGroup>[];
  for (final (String key, List<PlateSlot> made) in slots) {
    final int start = all.length;
    all.addAll(made);
    groups.add(
      PlateTextGroup(<int>[
        for (int i = 0; i < made.length; i++) start + i,
      ], key: key),
    );
  }

  return PlateSpec(
    id: id,
    country: MontenegroCountry.montenegro,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    background: PlateSection.columns(<PlatePart>[
      PlatePart(PlateSection.fill(PlateFill.panel), end: bandEnd),
      const PlatePart(PlateSection.plain),
    ]),
    slots: all,
    labels: <PlateLabel>[
      _slo(
        PlateBox(4, _Layout.sloTop, bandEnd - 8, _Layout.sloHeight),
        _Layout.sloGlyph,
      ),
      if (stackedLabels)
        for (int i = 0; i < 2; i++)
          PlateLabel(
            text: i == 0 ? 'R' : 'P',
            box: PlateBox(
              _Layout.rpCx - _Layout.stackWidth / 2,
              _Layout.stackTop + i * _Layout.stackStep,
              _Layout.stackWidth,
              _Layout.stackHeight,
            ),
            glyphHeight: _Layout.stackHeight,
          ),
    ],
    decals: crest == null
        ? const <PlateDecal>[]
        : _crest(crest.$1, crest.$2, crest.$3),
    textGroups: groups,
    resolveRegion: region ? MontenegroRegions.captionOf : null,
  );
}

PlateSpec _twoRows({
  required String id,
  required _Rows rows,
  required List<(String, (double, double), PlateAlphabet, int)> bottom,
}) {
  final List<PlateSlot> slots = <PlateSlot>[
    _field(
      MontenegroAlphabets.municipality,
      rows.region,
      2,
      top: rows.topTop,
      height: rows.topHeight,
    ),
    for (final (_, (double, double) span, PlateAlphabet a, int n) in bottom)
      _field(a, span, n, top: rows.bottomTop, height: rows.bottomHeight),
  ];

  return PlateSpec(
    id: id,
    country: MontenegroCountry.montenegro,
    canvasWidth: rows.width,
    canvasHeight: rows.height,
    background: PlateSection.rows(<PlatePart>[
      PlatePart(
        PlateSection.columns(<PlatePart>[
          PlatePart(PlateSection.fill(PlateFill.panel), end: rows.bandEnd),
          const PlatePart(PlateSection.plain),
        ]),
        end: rows.rowEnd,
      ),
      const PlatePart(PlateSection.plain),
    ]),
    slots: slots,
    labels: <PlateLabel>[_slo(rows.slo, rows.slo.height - 4)],
    decals: _crest(rows.crestCx, rows.crestCy, rows.crestRadius),
    textGroups: <PlateTextGroup>[
      const PlateTextGroup(<int>[0], key: 'region'),
      for (int i = 0; i < bottom.length; i++)
        PlateTextGroup(<int>[1 + i], key: bottom[i].$1),
    ],
    resolveRegion: MontenegroRegions.captionOf,
  );
}

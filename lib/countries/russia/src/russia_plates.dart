import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'russia_colors.dart';
import 'russia_country.dart';
import 'russia_missions.dart';
import 'russia_regions.dart';

/// Ink positions in plate coordinates, measured off references flattened to
/// 520×110. A `centre` is the middle of a field's ink run, a `pitch` its
/// printed character pitch.
///
/// Reference ink is taller than the canvas allows, so main slots (106) and the
/// region slot (72) print at about 75% of reference. The reference prints a
/// three-digit region smaller than a two-digit one; one slot cannot, so both
/// use the two-digit size.
abstract final class _Layout {
  static const double width = 520, height = 110, slotTop = 2, slotHeight = 106;

  /// Divider between the main fields and the region field: x 395..400 on the
  /// military, police and EN artwork, thickness 1.7..5.
  static const double dividerEnd = 397, dividerThickness = 3;

  /// Region digits: ink y 10.8..68.5, x centre ~450 on every clean artwork.
  static const double regionCentre = 450, regionTop = 4, regionHeight = 72;
  static const double regionWidth = 108;

  /// `RUS`: ink y 73..96, 57 wide beside no flag (centre ~451), 405..462 beside
  /// one. The flag box is 465..501 × 77..101.
  static const double rusTop = 66.5, rusHeight = 36, rusGlyph = 42;
  static const double rusWidth = 62, rusCentreAlone = 451;
  static const double rusCentreBesideFlag = 434;
  static const PlateBox flag = PlateBox(465, 77, 36, 24);

  /// Transit: the region box is yellow from x 387 to the edge.
  static const double transitYellowStart = 387;

  /// Exported: a divider after the `Т` at x ~93; ESTIMATED (CHECK photo).
  static const double exportedDividerEnd = 93;

  /// Transit hologram sticker, x 13..39.5, y 6.5..22.5.
  static const PlateBox hologram = PlateBox(13, 6.5, 26.5, 16);

  // Motorcycle, 190×145: the flattened reference is a 1.32 aspect squeezed to
  // 520×110, so every x is ×190/520 and every y ×145/110 of the brief's rows.
  // CHECK photo: estimated, not read off clean artwork.
  static const double bikeWidth = 190, bikeHeight = 145, bikeRowHeight = 64;
  static const double bikeTopRow = 4, bikeBottomRow = 79.5;
  static const PlateBox bikeRus = PlateBox(97, 66, 41, 18);
  static const double bikeRusGlyph = 29;
  static const PlateBox bikeFlag = PlateBox(141, 66, 27, 18);
  static const PlateBox bikeDivider = PlateBox(98.5, 88, 3, 47);
  static const double bikeRegionCentre = 142.4, bikeRegionWidth = 84;
}

/// One field of the main row: a run printed and typed as a unit. [pitch] is the
/// printed distance between characters; the slot spans `length * pitch` about
/// [centre].
class _Run {
  const _Run(
    this.key,
    this.alphabet,
    this.centre,
    this.pitch, {
    this.length = 1,
    this.minLength,
    this.top = _Layout.slotTop,
    this.height = _Layout.slotHeight,
  });

  final String key;
  final PlateAlphabet alphabet;
  final double centre, pitch;
  final int length;
  final int? minLength;
  final double top, height;

  PlateSlot get slot => PlateSlot(
    alphabet: alphabet,
    box: PlateBox(centre - length * pitch / 2, top, length * pitch, height),
    length: length,
    minLength: minLength,
    spacing: length == 1 || minLength != null && minLength != length
        ? 0
        : plateRunSpacing(pitch, height),
  );
}

/// * [private] — `У 199 ХА 78`: a letter, three digits, two letters, then the
///   region with `RUS` and the flag. Black on white.
/// * [trailer] — `АН 7331 47`, the same face with two letters and four digits.
/// * [taxi] — `АО 365 78`, black on yellow, no flag.
/// * [military] — `0245 ОК 43`, white on black; the last field is a formation
///   code, not a region.
/// * [police] — `А 1234 78`, white on blue.
/// * [diplomatic] — `002 CD 1 78`, white on red: the mission code, the status
///   (`CD`, `D` or `T`), a number (one digit after `CD`, three after `D`/`T`)
///   and the region. Code 127 is refused ([RussiaMissions]).
/// * [transit] — `СМ 655 К 78` on paper with a yellow region box and hologram.
/// * [exported] — `Т АО 002 78`, the export transit plate.
/// * [motorcycle] — the 2019 190×145 plate: digits over `АА | 77`.
///
/// Every field is one slot; `minLength` carries the region's two or three
/// digits and the diplomatic number's one to three. Not implemented: the
/// pre-2019 motorcycle plate and the military trailer order (`LL NNNN`), whose
/// layouts the references do not give.
abstract final class RussiaPlates {
  static const PlateAlphabet _digits = RussiaAlphabets.digits;
  static const PlateAlphabet _letters = RussiaAlphabets.letters;

  static const PlateSection _oneDivider = PlateSection.columns(<PlatePart>[
    PlatePart(
      PlateSection.plain,
      end: _Layout.dividerEnd,
      divider: _Layout.dividerThickness,
    ),
    PlatePart(PlateSection.plain),
  ]);

  static const PlateBox _regionBox = PlateBox(
    _Layout.regionCentre - _Layout.regionWidth / 2,
    _Layout.regionTop,
    _Layout.regionWidth,
    _Layout.regionHeight,
  );

  static const PlateSlot _regionTwoOrThree = PlateSlot(
    alphabet: _digits,
    box: _regionBox,
    length: 3,
    minLength: 2,
  );

  static const PlateSlot _regionTwo = PlateSlot(
    alphabet: _digits,
    box: _regionBox,
    length: 2,
  );

  static PlateLabel _rus({required bool besideFlag}) => PlateLabel(
    text: 'RUS',
    box: PlateBox(
      (besideFlag ? _Layout.rusCentreBesideFlag : _Layout.rusCentreAlone) -
          _Layout.rusWidth / 2,
      _Layout.rusTop,
      _Layout.rusWidth,
      _Layout.rusHeight,
    ),
    glyphHeight: _Layout.rusGlyph,
  );

  static const PlateDecal _flag = PlateDecal(
    drawing: RussiaCountry.flagDrawing,
    box: _Layout.flag,
  );

  /// The one-row plate: [runs] on the left, the region field on the right.
  static PlateSpec _row({
    required String id,
    required List<_Run> runs,
    PlateSection background = _oneDivider,
    bool flag = false,
    PlateSlot region = _regionTwoOrThree,
    List<PlateLabel> labels = const <PlateLabel>[],
    List<PlateRule> rules = const <PlateRule>[],
    List<PlateBand> bands = const <PlateBand>[],
    List<PlateRestriction> restrictions = const <PlateRestriction>[],
    PlateLabelResolver? resolveRegion = RussiaRegions.captionOf,
  }) {
    final List<String> keys = <String>[
      for (final _Run r in runs) r.key,
      'region',
    ];
    return PlateSpec(
      id: id,
      country: RussiaCountry.russia,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      noPanel: true,
      panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
      background: background,
      slots: <PlateSlot>[for (final _Run r in runs) r.slot, region],
      bands: bands,
      rules: rules,
      labels: <PlateLabel>[
        _rus(besideFlag: flag),
        ...labels,
      ],
      decals: <PlateDecal>[if (flag) _flag],
      textGroups: <PlateTextGroup>[
        for (var i = 0; i < keys.length; i++)
          PlateTextGroup(<int>[i], key: keys[i], prefix: i == 0 ? '' : ' '),
      ],
      restrictions: restrictions,
      resolveRegion: resolveRegion,
    );
  }

  static final PlateSpec private = _row(
    id: 'ru.private',
    flag: true,
    runs: const <_Run>[
      _Run('series', _letters, 59.5, 54),
      _Run('number', _digits, 184.5, 54.3, length: 3),
      _Run('letters', _letters, 332, 54, length: 2),
    ],
  );

  static final PlateSpec trailer = _row(
    id: 'ru.trailer',
    flag: true,
    runs: const <_Run>[
      _Run('letters', _letters, 89.9, 54.3, length: 2),
      _Run('number', _digits, 268.5, 52.8, length: 4),
    ],
  );

  static final PlateSpec taxi = _row(
    id: 'ru.taxi',
    runs: const <_Run>[
      _Run('letters', _letters, 95.6, 58.9, length: 2),
      _Run('number', _digits, 279, 59, length: 3),
    ],
  );

  static final PlateSpec military = _row(
    id: 'ru.military',
    region: _regionTwo,
    resolveRegion: RussiaRegions.militaryCaptionOf,
    runs: const <_Run>[
      _Run('number', _digits, 145.6, 49.8, length: 4),
      _Run('letters', _letters, 323, 46, length: 2),
    ],
  );

  static final PlateSpec police = _row(
    id: 'ru.police',
    runs: const <_Run>[
      _Run('series', _letters, 77.8, 51.5),
      _Run('number', _digits, 248.5, 53.4, length: 4),
    ],
  );

  /// The status is picked whole (`CD`), so its slot is one position over a
  /// wide, shorter box: `CD` ink is ~30% shorter than the digits and sits on
  /// their baseline. A one-digit number centres in its box where the reference
  /// right-aligns it.
  static final PlateSpec diplomatic = _row(
    id: 'ru.diplomatic',
    resolveRegion: RussiaMissions.captionOf,
    restrictions: const <PlateRestriction>[RussiaMissions.restriction],
    runs: const <_Run>[
      _Run('code', _digits, 121.5, 50.5, length: 3),
      _Run(
        'status',
        RussiaAlphabets.diplomaticStatus,
        262,
        100,
        top: 19,
        height: 90,
      ),
      _Run('number', _digits, 327, 46, length: 3, minLength: 1),
    ],
  );

  /// Paper plate: the region box is yellow, with no divider line.
  static final PlateSpec transit = _row(
    id: 'ru.transit',
    flag: true,
    background: const PlateSection.columns(<PlatePart>[
      PlatePart(PlateSection.plain, end: _Layout.transitYellowStart),
      PlatePart(PlateSection.fill(PlateFill.color(RussiaColors.transitYellow))),
    ]),
    bands: const <PlateBand>[
      PlateBand(box: _Layout.hologram, color: RussiaColors.hologram),
    ],
    runs: const <_Run>[
      _Run('letters', _letters, 100, 47, length: 2),
      _Run('number', _digits, 230, 46.3, length: 3),
      _Run('series', _letters, 342.8, 40),
    ],
  );

  /// A fixed `Т`, two letters and three digits, with a divider after the `Т`
  /// and a dot at each end. The dots and the first divider are ESTIMATED from
  /// a CHECK photo.
  static final PlateSpec exported = _row(
    id: 'ru.exported',
    background: const PlateSection.columns(<PlatePart>[
      PlatePart(
        PlateSection.plain,
        end: _Layout.exportedDividerEnd,
        divider: _Layout.dividerThickness,
      ),
      PlatePart(
        PlateSection.plain,
        end: _Layout.dividerEnd,
        divider: _Layout.dividerThickness,
      ),
      PlatePart(PlateSection.plain),
    ]),
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'T',
        box: PlateBox(29.5, _Layout.slotTop, 57, _Layout.slotHeight),
        glyphHeight: _Layout.slotHeight,
      ),
    ],
    rules: const <PlateRule>[
      PlateRule(box: PlateBox(8.5, 46, 9, 9)),
      PlateRule(box: PlateBox(503.5, 46, 9, 9)),
    ],
    runs: const <_Run>[
      _Run('letters', _letters, 154.6, 55.9, length: 2),
      _Run('number', _digits, 305.5, 55.7, length: 3),
    ],
  );

  /// The 2019 motorcycle plate, 190×145: four digits over two letters and the
  /// region, with `RUS` and the flag in the gap at the right.
  static final PlateSpec motorcycle = PlateSpec(
    id: 'ru.motorcycle',
    country: RussiaCountry.russia,
    canvasWidth: _Layout.bikeWidth,
    canvasHeight: _Layout.bikeHeight,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.bikeHeight)),
    slots: <PlateSlot>[
      const _Run(
        'number',
        _digits,
        96.5,
        33,
        length: 4,
        top: _Layout.bikeTopRow,
        height: _Layout.bikeRowHeight,
      ).slot,
      const _Run(
        'letters',
        _letters,
        50.7,
        37.3,
        length: 2,
        top: _Layout.bikeBottomRow,
        height: _Layout.bikeRowHeight,
      ).slot,
      const PlateSlot(
        alphabet: _digits,
        box: PlateBox(
          _Layout.bikeRegionCentre - _Layout.bikeRegionWidth / 2,
          _Layout.bikeBottomRow,
          _Layout.bikeRegionWidth,
          _Layout.bikeRowHeight,
        ),
        length: 3,
        minLength: 2,
      ),
    ],
    rules: const <PlateRule>[PlateRule(box: _Layout.bikeDivider)],
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'RUS',
        box: _Layout.bikeRus,
        glyphHeight: _Layout.bikeRusGlyph,
      ),
    ],
    decals: const <PlateDecal>[
      PlateDecal(drawing: RussiaCountry.flagDrawing, box: _Layout.bikeFlag),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'number'),
      PlateTextGroup(<int>[1], key: 'letters', prefix: ' '),
      PlateTextGroup(<int>[2], key: 'region', prefix: ' '),
    ],
    resolveRegion: RussiaRegions.captionOf,
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    trailer,
    taxi,
    military,
    police,
    diplomatic,
    transit,
    exported,
    motorcycle,
  ];
}

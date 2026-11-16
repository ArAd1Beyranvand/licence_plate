import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'georgia_country_colors.dart';
import 'georgia_country_country.dart';
import 'georgia_country_missions.dart';

/// Plate-unit measurements, flattened from photos to 520×110 (4 px per unit).
/// Values marked "sheet" in `.plateref/ge/brief.md` are readings off a contact
/// sheet, not ink runs; the embassy layout is unmeasured (borrowed from the
/// private plate).
///
/// Ink is drawn under-height (photos show 95 of 110): `glyphStyle` sets 0.72
/// of the slot, so boxes are as tall as the plate allows.
abstract final class _Layout {
  static const double width = 520, height = 110, dashWidth = 30;

  static const double privateStrip = 56, temporaryStrip = 64;
  static const double militaryStrip = 62;

  static const double squaredWidth = 330, squaredHeight = 205;
  static const double squaredBlockX = 57, squaredBlockY = 62;

  static const double motoWidth = 240, motoHeight = 135, motoBlock = 62;

  static const double exportPinkStart = 269, exportPinkEnd = 382;
  static const PlateBox exportYearWindow = PlateBox(281, 12, 90, 38);
  static const PlateBox exportStickerWindow = PlateBox(281, 64, 90, 38);

  static const PlateBox transitBar = PlateBox(46, 90, 451, 12.5);
  static const PlateBox transitCaption = PlateBox(330, 90, 167, 12.5);
  static const PlateBox transitFlag = PlateBox(14, 8, 38, 58);
}

/// One field: [length] cells over [width] from [left]. A fixed field gets the
/// printed pitch as `spacing`; a variable one ([minLength]) leaves it 0.
class _Field {
  const _Field(
    this.key,
    this.alphabet,
    this.left,
    this.width,
    this.length, {
    this.minLength,
    this.top = 0,
    this.height = _Layout.height,
  });

  final String key;
  final PlateAlphabet alphabet;
  final double left, width;
  final int length;
  final int? minLength;
  final double top, height;

  PlateSlot get slot => PlateSlot(
    alphabet: alphabet,
    box: PlateBox(left, top, width, height),
    length: length,
    minLength: minLength,
    spacing: length > 1 && minLength == null
        ? plateRunSpacing(width / length, height)
        : 0,
    group: key,
  );
}

const PlateAlphabet _digits = GeorgiaCountryAlphabets.digits;
const PlateAlphabet _letters = GeorgiaCountryAlphabets.letters;

/// The Georgian plates, one builder per design.
///
/// [private] and [trailer] share a design, differing in suffix length.
/// Fields are keyed `prefix`, `serial`, `suffix` (and `year`, `text`,
/// `mission`, `kind` where present).
///
/// Not built: historic Soviet-style and `AAA-123` plates, the military police
/// plate, the paper export plate, and the agricultural plate.
abstract final class GeorgiaCountryPlates {
  static final PlateSpec private = _euro(id: 'ge.private', suffixLength: 2);

  static final PlateSpec trailer = _euro(id: 'ge.trailer', suffixLength: 1);

  static PlateSpec _euro({required String id, required int suffixLength}) {
    return _spec(
      id: id,
      country: GeorgiaCountryCountry.georgia_country,
      background: _strip(_Layout.privateStrip),
      panel: const PlateBox(0, 0, _Layout.privateStrip, _Layout.height),
      fields: <_Field>[
        const _Field('prefix', _letters, 64.8, 94, 2),
        _Field('serial', _digits, 190.8, 141, 3),
        _Field('suffix', _letters, 363.8, 47.0 * suffixLength, suffixLength),
      ],
      dashes: const <double>[174.8, 347.8],
    );
  }

  static final PlateSpec temporary = _spec(
    id: 'ge.temporary',
    country: GeorgiaCountryCountry.georgia_country,
    background: _strip(_Layout.temporaryStrip),
    panel: const PlateBox(0, 0, _Layout.temporaryStrip, _Layout.height),
    fields: const <_Field>[
      _Field('prefix', _letters, 118, 104, 2),
      _Field('serial', _digits, 249, 178, 4),
    ],
    dashes: const <double>[235],
  );

  /// Any run of up to seven letters and digits after the blue strip.
  static final PlateSpec vanity = _spec(
    id: 'ge.vanity',
    country: GeorgiaCountryCountry.georgia_country,
    background: _strip(_Layout.privateStrip),
    panel: const PlateBox(0, 0, _Layout.privateStrip, _Layout.height),
    fields: const <_Field>[
      _Field(
        'text',
        GeorgiaCountryAlphabets.alphanumeric,
        66,
        424,
        7,
        minLength: 1,
      ),
    ],
  );

  static final PlateSpec squared = _spec(
    id: 'ge.squared',
    country: GeorgiaCountryCountry.georgia_country,
    width: _Layout.squaredWidth,
    height: _Layout.squaredHeight,
    background: _corner(_Layout.squaredBlockX, _Layout.squaredBlockY),
    panel: const PlateBox(0, 0, _Layout.squaredBlockX, _Layout.squaredBlockY),
    fields: const <_Field>[
      _Field('prefix', _letters, 104, 100, 2, top: 4, height: 100),
      _Field('serial', _digits, 9, 144, 3, top: 104, height: 100),
      _Field('suffix', _letters, 193, 105, 2, top: 104, height: 100),
    ],
    dashes: const <double>[218],
    dashTop: 4,
    dashHeight: 100,
    secondDashes: const <double>[171],
    secondDashTop: 104,
  );

  static final PlateSpec motorcycle = _spec(
    id: 'ge.motorcycle',
    country: GeorgiaCountryCountry.georgia_country,
    width: _Layout.motoWidth,
    height: _Layout.motoHeight,
    background: _corner(_Layout.motoBlock, _Layout.motoBlock),
    panel: const PlateBox(0, 0, _Layout.motoBlock, _Layout.motoBlock),
    fields: const <_Field>[
      _Field('prefix', _letters, 72, 150, 2, top: 4, height: 62),
      _Field('serial', _digits, 18, 204, 4, top: 70, height: 62),
    ],
  );

  static final PlateSpec export = _spec(
    id: 'ge.export',
    country: GeorgiaCountryCountry.plain,
    background: PlateSection.columns(<PlatePart>[
      const PlatePart(PlateSection.plain, end: _Layout.exportPinkStart),
      const PlatePart(
        PlateSection.fill(PlateFill.color(GeorgiaCountryColors.exportPink)),
        end: _Layout.exportPinkEnd,
      ),
      const PlatePart(PlateSection.plain),
    ]),
    fields: const <_Field>[
      _Field('serial', _digits, 27.5, 202, 4),
      _Field('year', _digits, 283, 86, 2, top: 12, height: 38),
      _Field('suffix', _letters, 390, 107, 2),
    ],
    bands: const <PlateBand>[
      PlateBand(
        box: _Layout.exportYearWindow,
        color: GeorgiaCountryColors.white,
      ),
      PlateBand(
        box: _Layout.exportStickerWindow,
        color: GeorgiaCountryColors.white,
      ),
    ],
  );

  static final PlateSpec transit = _spec(
    id: 'ge.transit',
    country: GeorgiaCountryCountry.transit,
    panel: _Layout.transitFlag,
    fields: const <_Field>[
      _Field('serial', _digits, 83.5, 236.5, 4, top: 2, height: 86),
      _Field('suffix', _letters, 367.5, 126.7, 2, top: 2, height: 86),
    ],
    bands: const <PlateBand>[
      PlateBand(
        box: _Layout.transitBar,
        color: GeorgiaCountryColors.transitRed,
      ),
    ],
    extraLabels: const <PlateLabel>[
      PlateLabel(
        text: 'TRANSIT',
        box: _Layout.transitCaption,
        glyphHeight: 12,
        color: GeorgiaCountryColors.white,
      ),
    ],
  );

  /// European Union Monitoring Mission: `EUMM`, a dot, three digits.
  static final PlateSpec mission = _spec(
    id: 'ge.mission',
    country: GeorgiaCountryCountry.plain,
    fields: const <_Field>[
      _Field('prefix', _letters, 34, 284, 4),
      _Field('serial', _digits, 347, 152, 3),
    ],
    extraLabels: const <PlateLabel>[
      PlateLabel(
        text: '·',
        box: PlateBox(318, 0, 26, _Layout.height),
        glyphHeight: _Layout.height,
      ),
    ],
  );

  static final PlateSpec military = _spec(
    id: 'ge.military',
    country: GeorgiaCountryCountry.military,
    background: _strip(_Layout.militaryStrip),
    fields: const <_Field>[
      _Field('prefix', _letters, 97, 150, 2),
      _Field('serial', _digits, 306, 168, 3),
    ],
    extraLabels: const <PlateLabel>[
      PlateLabel(
        text: 'G',
        box: PlateBox(8, 4, 46, 50),
        glyphHeight: 46,
        color: GeorgiaCountryColors.militaryInk,
      ),
      PlateLabel(
        text: 'A',
        box: PlateBox(8, 56, 46, 50),
        glyphHeight: 46,
        color: GeorgiaCountryColors.militaryInk,
      ),
    ],
  );

  /// `004 CMD 001`: three-digit mission code (004 is refused), `CMD`, `D` or
  /// `AS`, then a three-digit serial. Unmeasured; see [_Layout].
  static final PlateSpec diplomatic = _spec(
    id: 'ge.diplomatic',
    country: GeorgiaCountryCountry.plain,
    fields: const <_Field>[
      _Field('mission', _digits, 30, 138, 3),
      _Field('kind', _letters, 190, 140, 3, minLength: 1),
      _Field('serial', _digits, 350, 138, 3),
    ],
    restrictions: const <PlateRestriction>[GeorgiaCountryMissions.restriction],
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    trailer,
    temporary,
    vanity,
    squared,
    motorcycle,
    export,
    transit,
    mission,
    military,
    diplomatic,
  ];

  /// A side strip to the plate edge in the panel colour.
  static PlateSection _strip(double end) => PlateSection.columns(<PlatePart>[
    PlatePart(const PlateSection.fill(PlateFill.panel), end: end),
    const PlatePart(PlateSection.plain),
  ]);

  /// A panel-coloured block in the top-left corner, touching both edges.
  static PlateSection _corner(double x, double y) =>
      PlateSection.rows(<PlatePart>[
        PlatePart(
          PlateSection.columns(<PlatePart>[
            PlatePart(const PlateSection.fill(PlateFill.panel), end: x),
            const PlatePart(PlateSection.plain),
          ]),
          end: y,
        ),
        const PlatePart(PlateSection.plain),
      ]);

  static PlateLabel _dash(double cx, double top, double height) => PlateLabel(
    text: '-',
    box: PlateBox(cx - _Layout.dashWidth / 2, top, _Layout.dashWidth, height),
    glyphHeight: height,
  );

  static PlateSpec _spec({
    required String id,
    required PlateCountry country,
    required List<_Field> fields,
    PlateSection background = PlateSection.plain,
    PlateBox? panel,
    double width = _Layout.width,
    double height = _Layout.height,
    List<double> dashes = const <double>[],
    double dashTop = 0,
    double? dashHeight,
    List<double> secondDashes = const <double>[],
    double secondDashTop = 0,
    List<PlateBand> bands = const <PlateBand>[],
    List<PlateLabel> extraLabels = const <PlateLabel>[],
    List<PlateRestriction> restrictions = const <PlateRestriction>[],
  }) {
    return PlateSpec(
      id: id,
      country: country,
      canvasWidth: width,
      canvasHeight: height,
      noPanel: panel == null,
      panel: PlatePanel(
        box: panel ?? PlateBox(0, 0, 0, height),
        padding: panel == null ? null : const EdgeInsets.all(5),
      ),
      background: background,
      slots: <PlateSlot>[for (final _Field f in fields) f.slot],
      bands: bands,
      labels: <PlateLabel>[
        for (final double cx in dashes)
          _dash(cx, dashTop, dashHeight ?? height),
        for (final double cx in secondDashes)
          _dash(cx, secondDashTop, dashHeight ?? height),
        ...extraLabels,
      ],
      restrictions: restrictions,
    );
  }
}

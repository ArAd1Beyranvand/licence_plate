import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'ukraine_colors.dart';
import 'ukraine_country.dart';
import 'ukraine_missions.dart';

/// Where the ink sits, in plate units. The one-line references are flattened
/// to the 520×110 mm the article gives (4 px per unit); every span below is an
/// ink-run measurement of those flats (`.plateref/ua/brief.md`).
///
/// One line (field spans): letters 57–157, digits 184–354, letters 387–487;
/// band to x 47 on every banded plate (flat 2000 px: 180). 2015 band: dark
/// blue, flag x 10–42 y 24–47, `UA` below; 2004 band: the flag itself, cyan
/// over yellow split at y 55, the arms above, black `UA`.
///
/// **Under-height ink, accepted.** The references print ink 70–78 tall; a box
/// that tall would need ~130 on a 110 plate (`glyphStyle` paints ink at ~0.55
/// of the box), so every one-line box is the full 106 and the ink lands near
/// 60. `plate_core` is unchanged.
///
/// Two-line and three-line plates are laid out at the aspect of the original
/// photographs (2.0 and 1.26), so their flat x is scaled by width/520 and y by
/// height/110; they are estimates, not regulation.
///
/// Not drawn: the 2026 olive diplomatic design, pre-2004 plates, oblast flags
/// and stickers.
abstract final class _Layout {
  static const double width = 520, height = 110, rowTop = 2, rowHeight = 106;
  static const double bandEnd = 47;

  static const PlateBox uaCaption = PlateBox(2, 62, 44, 40);
  static const double uaGlyph = 30;
  static const PlateBox flag = PlateBox(9, 22, 34, 23);
  static const PlateBox arms = PlateBox(9, 8, 29, 40);
}

const PlateAlphabet _digits = UkraineAlphabets.digits;
const PlateAlphabet _letters = UkraineAlphabets.letters;
const PlateAlphabet _mixed = UkraineAlphabets.mixed;
const PlateAlphabet _free = UkraineAlphabets.personalised;

/// One field: a run of [length] cells over the span [left]..[right].
class _Field {
  const _Field(
    this.key,
    this.alphabet,
    this.left,
    this.right,
    this.length, {
    this.minLength,
    this.top = _Layout.rowTop,
    this.height = _Layout.rowHeight,
  });

  final String key;
  final PlateAlphabet alphabet;
  final double left, right;
  final int length;
  final int? minLength;
  final double top, height;
}

enum _Band {
  none,

  /// 2015: dark blue, flag, white `UA`.
  modern,

  /// 2004: cyan over yellow, the arms, black `UA`.
  legacy,

  /// Police: dark blue, the arms above a two-digit region code.
  police,
}

/// Ukraine's plates, one builder over fields and a band.
///
/// - [private], [transport], [temporary] and [personalised] are the one-line
///   body; the `Legacy` variants carry the 2004 band.
/// - [police] has a star and the region code on the band.
/// - [military] and [volunteers] have no band.
/// - [diplomatic], [diplomatic1997] and [companies] are unbanded one-liners
///   whose `mission` field is the register the restriction guards.
/// - [nonStandard] and [motorcycle] stack two and three rows.
abstract final class UkrainePlates {
  static final PlateSpec private = _spec(
    id: 'ua.private',
    band: _Band.modern,
    fields: _body,
  );

  static final PlateSpec privateLegacy = _spec(
    id: 'ua.private_legacy',
    band: _Band.legacy,
    fields: _body,
  );

  static final PlateSpec transport = _spec(
    id: 'ua.transport',
    band: _Band.modern,
    fields: _body,
  );

  static final PlateSpec transportLegacy = _spec(
    id: 'ua.transport_legacy',
    band: _Band.legacy,
    fields: _body,
  );

  /// Individualised: up to five letters or digits, Cyrillic or Latin.
  static final PlateSpec personalised = _spec(
    id: 'ua.personalised',
    band: _Band.legacy,
    fields: const <_Field>[_Field('series', _free, 93, 413, 5, minLength: 1)],
  );

  /// `T1 CP5140`: a two-character prefix and six mixed characters.
  static final PlateSpec temporary = _spec(
    id: 'ua.temporary',
    band: _Band.modern,
    fields: _temporaryFields,
  );

  static final PlateSpec temporaryLegacy = _spec(
    id: 'ua.temporary_legacy',
    band: _Band.legacy,
    fields: _temporaryFields,
  );

  /// `16 1564`: region code on the band, four digits, the star between.
  static final PlateSpec police = _spec(
    id: 'ua.police',
    band: _Band.police,
    fields: _policeFields,
    decals: _policeStar,
  );

  static final PlateSpec policeLegacy = _spec(
    id: 'ua.police_legacy',
    band: _Band.police,
    fields: _policeFields,
    decals: _policeStar,
  );

  /// `00 04 E6`.
  static final PlateSpec military = _spec(
    id: 'ua.military',
    fields: const <_Field>[
      _Field('unit', _digits, 38, 128, 2),
      _Field('serial', _digits, 167, 261, 2),
      _Field('series', _mixed, 380, 481, 2),
    ],
  );

  /// `KB 0004`.
  static final PlateSpec volunteers = _spec(
    id: 'ua.volunteers',
    fields: const <_Field>[
      _Field('unit', _letters, 60, 172, 2),
      _Field('series', _digits, 276, 489, 4),
    ],
  );

  /// `D 036 036`: prefix, mission code, serial.
  static final PlateSpec diplomatic = _spec(
    id: 'ua.diplomatic',
    fields: const <_Field>[
      _Field('prefix', _free, 92, 143, 1),
      _Field('mission', _digits, 195, 325, 3),
      _Field('series', _digits, 354, 484, 3),
    ],
    restrictions: const <PlateRestriction>[UkraineMissions.restriction],
  );

  /// `005 DP 0041`, white on red.
  static final PlateSpec diplomatic1997 = _spec(
    id: 'ua.diplomatic_1997',
    fields: const <_Field>[
      _Field('mission', _digits, 21, 195, 3),
      _Field('prefix', _free, 215, 345, 2),
      _Field('series', _digits, 345, 499, 4),
    ],
    restrictions: const <PlateRestriction>[UkraineMissions.restriction],
  );

  /// `004 F 40915`: foreign companies and media.
  static final PlateSpec companies = _spec(
    id: 'ua.companies',
    fields: const <_Field>[
      _Field('mission', _digits, 21, 105, 3),
      _Field('prefix', _free, 112, 166, 1),
      _Field('series', _digits, 225, 474, 5),
    ],
  );

  /// `AK KA 8608`, 220×110: the series letters over the digits.
  static final PlateSpec nonStandard = _spec(
    id: 'ua.non_standard',
    band: _Band.modern,
    width: 220,
    height: 110,
    bandEnd: 35,
    fields: _nonStandardFields,
  );

  static final PlateSpec nonStandardLegacy = _spec(
    id: 'ua.non_standard_legacy',
    band: _Band.legacy,
    width: 220,
    height: 110,
    bandEnd: 35,
    fields: _nonStandardFields,
  );

  /// `AK 2015 CE`, 220×174: three rows.
  static final PlateSpec motorcycle = _spec(
    id: 'ua.motorcycle',
    band: _Band.modern,
    width: 220,
    height: 174,
    bandEnd: 20,
    fields: _motorcycleFields,
  );

  static final PlateSpec motorcycleLegacy = _spec(
    id: 'ua.motorcycle_legacy',
    band: _Band.legacy,
    width: 220,
    height: 174,
    bandEnd: 20,
    fields: _motorcycleFields,
  );

  /// `02 35 A3`, 220×174: two rows on black.
  static final PlateSpec militaryMotorcycle = _spec(
    id: 'ua.military_motorcycle',
    width: 220,
    height: 174,
    fields: const <_Field>[
      _Field('unit', _digits, 32, 100, 2, top: 17, height: 61),
      _Field('serial', _digits, 119, 187, 2, top: 17, height: 61),
      _Field('series', _mixed, 63, 148, 2, top: 97, height: 60),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    privateLegacy,
    transport,
    transportLegacy,
    personalised,
    temporary,
    temporaryLegacy,
    police,
    policeLegacy,
    military,
    volunteers,
    diplomatic,
    diplomatic1997,
    companies,
    nonStandard,
    nonStandardLegacy,
    motorcycle,
    motorcycleLegacy,
    militaryMotorcycle,
  ];

  static const List<_Field> _body = <_Field>[
    _Field('prefix', _letters, 57, 157, 2),
    _Field('serial', _digits, 184, 354, 4),
    _Field('series', _letters, 387, 487, 2),
  ];

  static const List<_Field> _temporaryFields = <_Field>[
    _Field('prefix', _mixed, 57, 137, 2),
    _Field('series', _mixed, 155, 468, 6),
  ];

  static const List<_Field> _policeFields = <_Field>[
    _Field('region', _digits, 7, 44, 2, top: 58, height: 46),
    _Field('series', _digits, 230, 429, 4),
  ];

  static const List<PlateDecal> _policeStar = <PlateDecal>[
    PlateDecal(
      image: AssetImage(
        'assets/countries/russia/ukraine/icons/police_star.png',
        package: 'license_plate',
      ),
      box: PlateBox(118, 17, 86, 80),
    ),
  ];

  static const List<_Field> _nonStandardFields = <_Field>[
    _Field('prefix', _letters, 46, 98, 2, top: 3, height: 47),
    _Field('mark', _letters, 143, 196, 2, top: 3, height: 47),
    _Field('series', _digits, 60, 181, 4, top: 56, height: 52),
  ];

  static const List<_Field> _motorcycleFields = <_Field>[
    _Field('prefix', _letters, 90, 155, 2, top: 15, height: 40),
    _Field('serial', _digits, 68, 183, 4, top: 67, height: 40),
    _Field('series', _letters, 90, 152, 2, top: 118, height: 40),
  ];

  static PlateSlot _slot(_Field f) {
    final double pitch = (f.right - f.left) / f.length;
    return PlateSlot(
      alphabet: f.alphabet,
      box: PlateBox(f.left, f.top, f.right - f.left, f.height),
      length: f.length,
      minLength: f.minLength,
      spacing: plateRunSpacing(pitch, f.height),
      group: f.key,
    );
  }

  static PlateSection _background(_Band band, double end, double split) {
    switch (band) {
      case _Band.none:
        return PlateSection.plain;
      case _Band.modern || _Band.police:
        return PlateSection.columns(<PlatePart>[
          const PlatePart(
            PlateSection.fill(PlateFill.color(UkraineColors.bandBlue)),
            end: 0,
          ),
          const PlatePart(PlateSection.plain),
        ]);
      case _Band.legacy:
        return PlateSection.columns(<PlatePart>[
          PlatePart(
            PlateSection.rows(<PlatePart>[
              PlatePart(
                const PlateSection.fill(
                  PlateFill.color(UkraineColors.legacyBlue),
                ),
                end: split,
              ),
              const PlatePart(
                PlateSection.fill(PlateFill.color(UkraineColors.legacyYellow)),
              ),
            ]),
            end: end,
          ),
          const PlatePart(PlateSection.plain),
        ]);
    }
  }

  static PlateSpec _spec({
    required String id,
    required List<_Field> fields,
    _Band band = _Band.none,
    double width = _Layout.width,
    double height = _Layout.height,
    double bandEnd = _Layout.bandEnd,
    List<PlateDecal> decals = const <PlateDecal>[],
    List<PlateRestriction> restrictions = const <PlateRestriction>[],
  }) {
    final double s = width / _Layout.width, t = height / _Layout.height;
    PlateBox scaled(PlateBox b) =>
        PlateBox(b.left * s, b.top * t, b.width * s, b.height * t);
    final bool banded = band != _Band.none, legacy = band == _Band.legacy;
    final bool police = band == _Band.police;
    PlateSection background = _background(band, bandEnd, 55 * t);
    if (band == _Band.modern || police) {
      background = PlateSection.columns(<PlatePart>[
        PlatePart(
          const PlateSection.fill(PlateFill.color(UkraineColors.bandBlue)),
          end: bandEnd,
        ),
        const PlatePart(PlateSection.plain),
      ]);
    }
    return PlateSpec(
      id: id,
      country: UkraineCountry.ukraine,
      canvasWidth: width,
      canvasHeight: height,
      noPanel: true,
      panel: PlatePanel(box: PlateBox(0, 0, 0, height)),
      background: background,
      slots: <PlateSlot>[for (final _Field f in fields) _slot(f)],
      labels: <PlateLabel>[
        if (banded && !police)
          PlateLabel(
            text: 'UA',
            box: scaled(_Layout.uaCaption),
            glyphHeight: _Layout.uaGlyph * min(s, t) * 1.0,
            color: legacy ? UkraineColors.black : UkraineColors.white,
          ),
      ],
      decals: <PlateDecal>[
        if (band == _Band.modern)
          PlateDecal(
            drawing: UkraineCountry.ukraine.flag as PlateDrawing,
            box: scaled(_Layout.flag),
          ),
        if (legacy || police)
          PlateDecal(
            image: const AssetImage(
              'assets/countries/russia/ukraine/icons/lesser_coat_of_arms_of_ukraine.png',
              package: 'license_plate',
            ),
            box: scaled(_Layout.arms),
          ),
        ...decals,
      ],
      restrictions: restrictions,
    );
  }
}

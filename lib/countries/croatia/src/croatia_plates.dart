import 'package:flutter/widgets.dart' show AssetImage, EdgeInsets;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'croatia_colors.dart';
import 'croatia_country.dart';
import 'croatia_missions.dart';
import 'croatia_regions.dart';

/// Where the ink sits, in plate units. Every photo is flattened to the 520×110
/// mm the article gives (4 px per unit on the artwork).
///
/// Private plate (`Kroatisches_Kennzeichen`, read off the 2080×440 original):
/// euroband blue to x 49, stars ring centred at (25.5, 34.5) and 37 across, `HR`
/// ink y 74–95; `ZG` x 61–156; crest x 166–213, y 26–86 (the brief's zone
/// 166.5–212 × 26–86.5); `543` x 226–385; dash x 395–413; `AA` from x 421 to
/// the plate edge. Digits are 81 tall (y 14–95) on a 110 plate; a box that tall
/// would need ~147, so every box is the full canvas height and the ink lands
/// near 60, about 74% of reference. Pinstripes: red y 2.1–4.7 and blue
/// 5.7–7.8 at the top, red 102–104 and blue 106–108 at the bottom, running to
/// the plate's right edge from the band.
///
/// The other rows are read off the sheet at about ±5: army `HV 489-LV` (region
/// 40–152, crest 153–196.5, digits 202–350, dash centre 364, letters 388–480);
/// export `RH 599-AE` (region 61–152, crest 159.5–202, digits 217–365, letters
/// 409–499); oversize `ST 401-NR`; police `010 631`; diplomatic `023-A-002`
/// from the brief's measured fields (3@54–202, 1@246–288, 3@330–472).
abstract final class _Layout {
  static const double width = 520, height = 110, bandEnd = 49;

  static const double top = 0, box = 110;

  static const double starsLeft = 2.5, starsTop = 0;
  static const double starsWidth = 46, starsHeight = 70.4;
  static const double hrLeft = 4, hrTop = 65, hrWidth = 42, hrHeight = 40;
  static const double hrGlyph = 38;

  static const double dashWidth = 30;

  static const double stripeTopRedEnd = 4.5, stripeTopBlueEnd = 8;
  static const double stripeBottomRedEnd = 104, stripeBottomBlueEnd = 108;

  static const _Row current = _Row(
    region: _Span(61, 95),
    crest: PlateBox(166, 26, 47, 61),
    dashes: <double>[404],
    digits: _Span(226, 169),
    letters: _Span(421, 78),
  );

  /// Customized plate: the chosen word and a trailing number take the place of
  /// digits and letters; their spans are estimated from the sheet.
  static const _Span word = _Span(226, 194);
  static const double wordDash = 436;
  static const _Span suffix = _Span(452, 48);

  static const _Row army = _Row(
    region: _Span(40, 112),
    crest: PlateBox(153, 28, 43.5, 57.8),
    dashes: <double>[364],
    digits: _Span(202, 148),
    letters: _Span(388, 92),
  );

  static const _Row exportRow = _Row(
    region: _Span(61, 91),
    crest: PlateBox(159.5, 27, 42.5, 56.5),
    dashes: <double>[386],
    digits: _Span(217, 148),
    letters: _Span(409, 90),
  );

  static const _Row oversize = _Row(
    region: _Span(68, 104),
    crest: PlateBox(181, 30, 34, 45),
    dashes: <double>[406],
    digits: _Span(235, 161),
    letters: _Span(417, 85),
  );

  static const _Span policeFirst = _Span(68, 154);
  static const PlateBox policeCrest = PlateBox(236, 26, 42, 56);
  static const _Span policeSecond = _Span(292, 146);

  static const _Span dipMission = _Span(54, 148);
  static const _Span dipClass = _Span(246, 42);
  static const _Span dipSerial = _Span(330, 142);
  static const List<double> dipDashes = <double>[224, 309];
}

class _Span {
  const _Span(this.left, this.width);

  final double left, width;
}

/// A registration plate's geometry: city code, crest, digits, dash, letters.
class _Row {
  const _Row({
    required this.region,
    required this.crest,
    required this.dashes,
    required this.digits,
    required this.letters,
  });

  final _Span region;
  final PlateBox crest;
  final List<double> dashes;
  final _Span digits, letters;
}

class _Field {
  const _Field(
    this.key,
    this.alphabet,
    this.span, {
    required this.length,
    int? minLength,
  }) : minLength = minLength ?? length;

  final String key;
  final PlateAlphabet alphabet;
  final _Span span;
  final int length, minLength;
}

/// The Croatian plates. Every field, a run printed and typed as a unit, is one
/// slot: the city code, the digits (three or four), the letters (one or two).
///
/// [private] is the current `ZG 543-AA` with the EU band and edge pinstripes;
/// [customized] swaps digits and letters for a chosen word and a trailing
/// number; [classic] is the pre-2016 `KA 881-EB` without the band, also the yellow
/// military plate (theme only); [exportPlate] the teal plate with orange ink
/// (foreign residents, international organizations, temporary registrations);
/// [oversize] the red-ink plate for oversized vehicles; [police] the blue
/// `010 631`; [diplomatic] the cyan `023-A-002`, whose mission `071` (Israel)
/// is refused.
///
/// The crest is the coat of arms of Croatia, a decal: it is too complex to
/// draw (https://commons.wikimedia.org/wiki/File:Coat_of_arms_of_Croatia.svg).
/// The article's three-or-four-digit field is squeezed as one run when it holds
/// four, its box is sized for three.
///
/// Not implemented: the police motorcycle plate (a near-square two-row plate,
/// photographed obliquely, with no usable measurement), customized words of
/// six to seven letters (the word-with-number form is the one drawn), and the
/// date stickers.
abstract final class CroatiaPlates {
  static const AssetImage _crest = AssetImage(
    'assets/countries/croatia/icons/coat_of_arms.png',
    package: 'license_plate',
  );

  static final PlateSpec private = _registration(
    'hr.private',
    _Layout.current,
    band: true,
  );

  static final PlateSpec classic = _registration('hr.classic', _Layout.army);

  static final PlateSpec exportPlate = _registration(
    'hr.export',
    _Layout.exportRow,
  );

  static final PlateSpec oversize = _registration(
    'hr.oversize',
    _Layout.oversize,
  );

  static final PlateSpec customized = _spec(
    id: 'hr.customized',
    band: true,
    fields: const <_Field>[
      _Field(
        'region',
        CroatiaAlphabets.regionLetters,
        _Span(61, 95),
        length: 2,
      ),
      _Field(
        'word',
        CroatiaAlphabets.custom,
        _Layout.word,
        length: 5,
        minLength: 4,
      ),
      _Field(
        'suffix',
        CroatiaAlphabets.digits,
        _Layout.suffix,
        length: 2,
        minLength: 1,
      ),
    ],
    dashes: const <double>[_Layout.wordDash],
    crest: _Layout.current.crest,
    resolveRegion: CroatiaRegions.captionOf,
  );

  static final PlateSpec police = _spec(
    id: 'hr.police',
    fields: const <_Field>[
      _Field('first', CroatiaAlphabets.digits, _Layout.policeFirst, length: 3),
      _Field(
        'second',
        CroatiaAlphabets.digits,
        _Layout.policeSecond,
        length: 3,
      ),
    ],
    dashes: const <double>[],
    crest: _Layout.policeCrest,
  );

  static final PlateSpec diplomatic = _spec(
    id: 'hr.diplomatic',
    fields: const <_Field>[
      _Field('mission', CroatiaAlphabets.digits, _Layout.dipMission, length: 3),
      _Field('class', CroatiaAlphabets.letters, _Layout.dipClass, length: 1),
      _Field('serial', CroatiaAlphabets.digits, _Layout.dipSerial, length: 3),
    ],
    dashes: _Layout.dipDashes,
    restrictions: const <PlateRestriction>[CroatiaMissions.restriction],
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    customized,
    classic,
    exportPlate,
    oversize,
    police,
    diplomatic,
  ];

  static PlateSpec _registration(String id, _Row row, {bool band = false}) =>
      _spec(
        id: id,
        band: band,
        fields: <_Field>[
          _Field(
            'region',
            CroatiaAlphabets.regionLetters,
            row.region,
            length: 2,
          ),
          _Field(
            'number',
            CroatiaAlphabets.digits,
            row.digits,
            length: 4,
            minLength: 3,
          ),
          _Field(
            'letters',
            CroatiaAlphabets.letters,
            row.letters,
            length: 2,
            minLength: 1,
          ),
        ],
        dashes: row.dashes,
        crest: row.crest,
        resolveRegion: CroatiaRegions.captionOf,
      );

  /// The slot for [field]. A fixed multi-character field sits at the pitch its
  /// box implies; a variable one keeps the font's advance.
  static PlateSlot _slot(_Field field) {
    final bool fixed = field.length == field.minLength && field.length > 1;
    return PlateSlot(
      alphabet: field.alphabet,
      box: PlateBox(
        field.span.left,
        _Layout.top,
        field.span.width,
        _Layout.box,
      ),
      length: field.length,
      minLength: field.minLength,
      spacing: fixed
          ? plateRunSpacing(field.span.width / field.length, _Layout.box)
          : 0,
      group: field.key,
    );
  }

  static const PlateSection _stripes = PlateSection.rows(<PlatePart>[
    PlatePart(PlateSection.plain, end: 2),
    PlatePart(
      PlateSection.fill(PlateFill.color(CroatiaColors.stripeRed)),
      end: _Layout.stripeTopRedEnd,
    ),
    PlatePart(PlateSection.plain, end: 6),
    PlatePart(
      PlateSection.fill(PlateFill.color(CroatiaColors.stripeBlue)),
      end: _Layout.stripeTopBlueEnd,
    ),
    PlatePart(PlateSection.plain, end: 102),
    PlatePart(
      PlateSection.fill(PlateFill.color(CroatiaColors.stripeRed)),
      end: _Layout.stripeBottomRedEnd,
    ),
    PlatePart(PlateSection.plain, end: 106),
    PlatePart(
      PlateSection.fill(PlateFill.color(CroatiaColors.stripeBlue)),
      end: _Layout.stripeBottomBlueEnd,
    ),
    PlatePart(PlateSection.plain),
  ]);

  static PlateSpec _spec({
    required String id,
    required List<_Field> fields,
    required List<double> dashes,
    PlateBox? crest,
    bool band = false,
    List<PlateRestriction> restrictions = const <PlateRestriction>[],
    PlateLabelResolver? resolveRegion,
  }) {
    return PlateSpec(
      id: id,
      country: CroatiaCountry.croatia,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      panel: band
          ? const PlatePanel(
              box: PlateBox(
                _Layout.starsLeft,
                _Layout.starsTop,
                _Layout.starsWidth,
                _Layout.starsHeight,
              ),
              padding: EdgeInsets.zero,
            )
          : const PlatePanel(box: PlateBox(0, 0, 0, 0)),
      noPanel: !band,
      background: band
          ? const PlateSection.columns(<PlatePart>[
              PlatePart(
                PlateSection.fill(PlateFill.panel),
                end: _Layout.bandEnd,
              ),
              PlatePart(_stripes),
            ])
          : PlateSection.plain,
      slots: <PlateSlot>[for (final _Field f in fields) _slot(f)],
      labels: <PlateLabel>[
        if (band)
          const PlateLabel(
            text: 'HR',
            box: PlateBox(
              _Layout.hrLeft,
              _Layout.hrTop,
              _Layout.hrWidth,
              _Layout.hrHeight,
            ),
            glyphHeight: _Layout.hrGlyph,
            color: CroatiaColors.white,
          ),
        for (final double cx in dashes)
          PlateLabel(
            text: '-',
            box: PlateBox(
              cx - _Layout.dashWidth / 2,
              _Layout.top,
              _Layout.dashWidth,
              _Layout.box,
            ),
            glyphHeight: _Layout.box,
          ),
      ],
      decals: <PlateDecal>[
        if (crest != null) PlateDecal(image: _crest, box: crest),
      ],
      restrictions: restrictions,
      resolveRegion: resolveRegion,
    );
  }
}

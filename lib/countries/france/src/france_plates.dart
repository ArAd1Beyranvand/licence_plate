import 'package:flutter/widgets.dart' show AssetImage, EdgeInsets;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'france_colors.dart';
import 'france_country.dart';
import 'france_missions.dart';

/// One field, typed and printed as a unit: up to [length] characters (at least
/// [minLength]) centred on [cx], [pitch] apart, in a box [top]..[top]+[height].
class _Field {
  const _Field(
    this.key,
    this.alphabet,
    this.cx,
    this.pitch,
    this.top,
    this.height, {
    this.length = 1,
    int? minLength,
    this.white = false,
  }) : minLength = minLength ?? length;

  final String key;
  final PlateAlphabet alphabet;
  final double cx, pitch, top, height;
  final int length, minLength;

  /// Printed in white whatever the theme, for a field on the blue band.
  final bool white;
}

/// A printed hyphen between two fields, centred on ([cx], [cy]).
class _Dash {
  const _Dash(this.cx, this.cy);
  final double cx, cy;
}

/// The regional logo block of the right band, as offsets in a white box.
class _Logo {
  const _Logo(this.left, this.top, this.width);
  final double left, top, width;
  double get scale => width / 36.4;
}

class _Design {
  const _Design({
    required this.id,
    required this.width,
    required this.height,
    required this.fields,
    this.dashes = const <_Dash>[],
    this.dashGlyph = 54,
    this.leftEnd,
    this.rightStart,
    this.rowEnd,
    this.bandCx = 26.75,
    this.logo,
    this.restrictions = const <PlateRestriction>[],
  });

  final String id;
  final double width, height, dashGlyph;
  final List<_Field> fields;
  final List<_Dash> dashes;

  /// Right edge of the left (EU) band and left edge of the right (département)
  /// band; null when the plate has no such band.
  final double? leftEnd, rightStart;

  /// Bottom of the bands on a two-line plate; null when they run full height.
  final double? rowEnd;
  final double bandCx;
  final _Logo? logo;
  final List<PlateRestriction> restrictions;
}

/// Where the ink sits, in plate units.
///
/// One-line plates (520×110, the documented size). The vector artwork
/// `License_plate_of_France_AA-229-DB` has no left band, so the bands come from
/// the photographs `French_provisional_license_plate_2009` and
/// `French_license_plates_historic_2009`, which agree on the characters:
/// letters at pitch 47.3 centred 107.4, digits at 47.5 centred 262, letters at
/// 45.3 centred 413; hyphens centred 172.5 and 349.3 (16 wide, 8 thick in the
/// photo, 25 wide in the vector). Blue bands end at 52 and start at 470 (vector
/// right band 471.2–520; photo 6.2–54.5 and 465.5–513.8 inside a 6 frame).
/// Ink y 14–95.5 in the vector (81.5 tall, centre 54.75).
///
/// Ink is about 55% of a box and a box cannot leave the canvas, so the
/// 81.5 tall ink would need a 148 box on a 110 plate: the box is 110 and the ink
/// ~60 (74% of reference).
///
/// Right band (vector): white logo box x 475.8–512.2, y 10–48.9; the Île-de-France
/// mark is a star (≈ x 481–510, y 12–41) over its wordmark (y 43–48); the white
/// département code is 32 tall, centred (498.5, 82.8) — a box of 50 gives ~27
/// of ink (84%), the band being 49 wide. Three-digit overseas codes (971–976)
/// do not fit and are not modelled; the code is 2 characters.
///
/// Two-line plate: the artwork is 330×198, aspect 1.667; the canvas is 340×204
/// to keep it. Read as fractions of that artwork: bands x 0–0.17 and 0.835–1,
/// down to y 0.56; top row `AA` centred 0.4835, ink y 0.106–0.475; bottom row
/// ink y 0.586–0.949, digits centred 0.318 at pitch 0.1455, letters centred
/// 0.7607 at 0.146. Good to a few units only (a 330 px image).
///
/// Dated plates (transit, temporary): the date is two stacked two-digit fields
/// at x 467.2–499.5, ink y 16.5–40.3 and 66.5–89.3 (23.5 tall) on the transit
/// photo; the temporary photo agrees on position, its ink is smaller (15 tall).
/// Neither has a right band; the left band is the same as the standard plate.
///
/// Diplomatic plate (photo, CHECK fit): `168` x 57–191, `CD` x 239–334, `66`
/// x 382–477, ink y 14.2–77 (63 tall, centre 45.6); a 91 box is the largest
/// that keeps that centre. The photo's face ends near y 91, so the 110-tall
/// canvas is the documented size, not what the photo shows.
///
/// Not drawn: the cartouche of a 520×120 plate, and every pre-2009 FNI plate
/// (`1 A 75` format), the police, military, RATP, German NATO, FFECSA, free-zone
/// and overseas-territory plates; these are old or regional series.
abstract final class _Layout {
  static const List<_Field> _main = <_Field>[
    _Field('prefix', FranceAlphabets.letters, 107.4, 47.3, 0, 110, length: 2),
    _Field('number', FranceAlphabets.digits, 262, 47.5, 0, 110, length: 3),
    _Field('suffix', FranceAlphabets.letters, 413, 45.3, 0, 110, length: 2),
  ];

  static const List<_Dash> _dashes = <_Dash>[
    _Dash(172.5, 54.8),
    _Dash(349.3, 54.8),
  ];

  static const _Design private = _Design(
    id: 'fr.private',
    width: 520,
    height: 110,
    leftEnd: 52,
    rightStart: 470,
    fields: <_Field>[
      ..._main,
      _Field(
        'department',
        FranceAlphabets.department,
        498.5,
        21.5,
        57.8,
        50,
        length: 2,
        white: true,
      ),
    ],
    dashes: _dashes,
    logo: _Logo(475.8, 10, 36.4),
  );

  static const _Design collection = _Design(
    id: 'fr.collection',
    width: 520,
    height: 110,
    fields: _main,
    dashes: _dashes,
  );

  static const List<_Field> _date = <_Field>[
    _Field('month', FranceAlphabets.digits, 483.4, 17.5, 6.9, 43, length: 2),
    _Field('year', FranceAlphabets.digits, 483.4, 17.5, 56.4, 43, length: 2),
  ];

  static const _Design transit = _Design(
    id: 'fr.transit',
    width: 520,
    height: 110,
    leftEnd: 52,
    fields: <_Field>[..._main, ..._date],
    dashes: _dashes,
  );

  static const _Design temporary = _Design(
    id: 'fr.temporary',
    width: 520,
    height: 110,
    leftEnd: 52,
    fields: <_Field>[..._main, ..._date],
    dashes: _dashes,
  );

  static const _Design twoLine = _Design(
    id: 'fr.twoline',
    width: 340,
    height: 204,
    leftEnd: 58,
    rightStart: 284,
    rowEnd: 114,
    bandCx: 29,
    dashGlyph: 66,
    fields: <_Field>[
      _Field('prefix', FranceAlphabets.letters, 164.4, 47, 4, 110, length: 2),
      _Field('number', FranceAlphabets.digits, 108.1, 49.5, 110, 94, length: 3),
      _Field(
        'suffix',
        FranceAlphabets.letters,
        258.6,
        49.6,
        110,
        94,
        length: 2,
      ),
      _Field(
        'department',
        FranceAlphabets.department,
        311,
        20,
        57.5,
        47,
        length: 2,
        white: true,
      ),
    ],
    dashes: <_Dash>[_Dash(222.5, 59), _Dash(193.6, 156.6)],
    logo: _Logo(295, 11, 32),
  );

  static const _Design diplomatic = _Design(
    id: 'fr.diplomatic',
    width: 520,
    height: 110,
    fields: <_Field>[
      _Field(
        'embassy',
        FranceAlphabets.digits,
        124,
        47.8,
        0,
        91,
        length: 3,
        minLength: 1,
      ),
      _Field(
        'status',
        FranceAlphabets.status,
        286.5,
        47.8,
        0,
        91,
        length: 3,
        minLength: 1,
      ),
      _Field(
        'series',
        FranceAlphabets.digits,
        429.5,
        47.8,
        0,
        91,
        length: 3,
        minLength: 1,
      ),
    ],
    restrictions: <PlateRestriction>[FranceMissions.restriction],
  );

  /// The stars' panel block, and the `F` under it (photo: cap 21.5, y 65.5–87).
  static const double panelWidth = 46, panelHeight = 70.4;
  static const double fTop = 65.5, fHeight = 22, fGlyph = 39, fWidth = 20;

  /// The logo block at scale 1: a white box 36.4×39 holding the star (29 square,
  /// offset 5.2, 2) over the wordmark (32×5, offset 5.2, 33).
  static const double logoHeight = 39;
  static const double starOffsetX = 5.2, starOffsetY = 2, starSize = 29;
  static const double nameOffsetY = 33, nameWidth = 32, nameHeight = 5;
}

/// Groups `prefix`, `number` and `suffix`, then `department` or `month` and
/// `year` where the plate prints them; the diplomatic plate has `embassy`,
/// `status` and `series`. The EU band, département band and their logos are
/// painted by the background, bands and decals.
///
/// [private] is `AA-000-AA` with a département on the right (a provisional `WW`
/// plate is the same design); [twoLine] stacks the prefix over the number and
/// suffix; [collection] is white on black with no bands; [transit] and
/// [temporary] print a month and year where the département would be.
abstract final class FrancePlates {
  static final PlateSpec private = _spec(_Layout.private);
  static final PlateSpec twoLine = _spec(_Layout.twoLine);
  static final PlateSpec collection = _spec(_Layout.collection);
  static final PlateSpec transit = _spec(_Layout.transit);
  static final PlateSpec temporary = _spec(_Layout.temporary);
  static final PlateSpec diplomatic = _spec(_Layout.diplomatic);

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    twoLine,
    collection,
    transit,
    temporary,
    diplomatic,
  ];

  static PlateSpec _spec(_Design d) {
    final double? left = d.leftEnd, right = d.rightStart;
    final PlateSection bands = PlateSection.columns(<PlatePart>[
      if (left != null)
        PlatePart(PlateSection.fill(PlateFill.panel), end: left),
      if (right != null) ...<PlatePart>[
        PlatePart(PlateSection.plain, end: right),
        const PlatePart(PlateSection.fill(PlateFill.panel)),
      ] else
        const PlatePart(PlateSection.plain),
    ]);
    final PlateSection background = left == null && right == null
        ? PlateSection.plain
        : d.rowEnd == null
        ? bands
        : PlateSection.rows(<PlatePart>[
            PlatePart(bands, end: d.rowEnd),
            const PlatePart(PlateSection.plain),
          ]);

    final List<PlateSlot> slots = <PlateSlot>[];
    for (final _Field f in d.fields) {
      slots.add(
        PlateSlot(
          alphabet: f.alphabet,
          box: PlateBox(
            f.cx - f.length * f.pitch / 2,
            f.top,
            f.length * f.pitch,
            f.height,
          ),
          length: f.length,
          minLength: f.minLength,
          spacing: f.length == 1 || f.minLength != f.length
              ? 0
              : plateRunSpacing(f.pitch, f.height),
          color: f.white ? FranceColors.white : null,
          group: f.key,
        ),
      );
    }

    final _Logo? logo = d.logo;
    final double s = logo?.scale ?? 1;
    return PlateSpec(
      id: d.id,
      country: FranceCountry.france,
      canvasWidth: d.width,
      canvasHeight: d.height,
      noPanel: left == null,
      panel: left == null
          ? PlatePanel(box: PlateBox(0, 0, d.width, d.height))
          : PlatePanel(
              box: PlateBox(
                d.bandCx - _Layout.panelWidth / 2,
                0,
                _Layout.panelWidth,
                _Layout.panelHeight,
              ),
              padding: EdgeInsets.zero,
            ),
      background: background,
      bands: <PlateBand>[
        if (logo != null)
          PlateBand(
            box: PlateBox(
              logo.left,
              logo.top,
              logo.width,
              _Layout.logoHeight * s,
            ),
            color: FranceColors.white,
          ),
      ],
      decals: <PlateDecal>[
        if (logo != null) ...<PlateDecal>[
          // Île-de-France mark, split from
          // https://commons.wikimedia.org/wiki/File:Région_Île-de-France_(logo_2005).svg
          // It is the logo of the sample plate (département 95), one decal for
          // that value rather than every region's.
          PlateDecal(
            image: const AssetImage(
              'assets/countries/france/icons/ile_de_france_star.png',
              package: 'license_plate',
            ),
            box: PlateBox(
              logo.left + _Layout.starOffsetX * s,
              logo.top + _Layout.starOffsetY * s,
              _Layout.starSize * s,
              _Layout.starSize * s,
            ),
          ),
          PlateDecal(
            image: const AssetImage(
              'assets/countries/france/icons/ile_de_france_name.png',
              package: 'license_plate',
            ),
            box: PlateBox(
              logo.left + _Layout.starOffsetX * s,
              logo.top + _Layout.nameOffsetY * s,
              _Layout.nameWidth * s,
              _Layout.nameHeight * s,
            ),
          ),
        ],
      ],
      slots: slots,
      labels: <PlateLabel>[
        if (left != null)
          PlateLabel(
            text: 'F',
            box: PlateBox(
              d.bandCx - _Layout.fWidth / 2,
              _Layout.fTop,
              _Layout.fWidth,
              _Layout.fHeight,
            ),
            glyphHeight: _Layout.fGlyph,
            color: FranceColors.white,
          ),
        for (final _Dash dash in d.dashes)
          PlateLabel(
            text: '-',
            box: PlateBox(
              dash.cx - 15,
              dash.cy - d.dashGlyph / 2,
              30,
              d.dashGlyph,
            ),
            glyphHeight: d.dashGlyph,
          ),
      ],
      restrictions: d.restrictions,
    );
  }
}

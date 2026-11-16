import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'slovakia_colors.dart';
import 'slovakia_country.dart';

/// Plate-unit geometry, measured off photos flattened to 520×110 (4 px per
/// unit). Ink is about 80 tall on a 110 plate, but a box that tall would need
/// ~145, so every box is the full canvas height and the ink lands near 60. The
/// band is 46 wide (the flats end it between 44 and 47).
abstract final class _Layout {
  static const double width = 520, height = 110, bandEnd = 46;

  static const double box = 110, top = 0;

  static const double starsLeft = 1, starsTop = 6.3;
  static const double starsWidth = 45, starsHeight = 68.8;
  static const double skLeft = 4, skTop = 70, skWidth = 40;
  static const double skHeight = 30, skGlyph = 30;

  static const double dashWidth = 30;

  static const PlateBox crest = PlateBox(178, 29, 38, 50);

  // Two-line plates: no published size; these photos are 1.3–1.6:1, so flat
  // coordinates are scaled by 0.654 in x and 1.818 in y and every value below
  // is an estimate.
  static const double tlWidth = 340, tlHeight = 200;
  static const double row1Top = 5, row2Top = 97, rowBox = 100;
  static const PlateBox badge = PlateBox(7, 6, 53, 88);
  static const PlateBox badgeFlag = PlateBox(8, 8, 51, 58);
  static const PlateBox tlCrest = PlateBox(259, 30, 38, 50);
  static const PlateBox dealerCrest = PlateBox(20, 14, 28, 37);
  static const PlateBox dealerSk = PlateBox(17, 56, 34, 24);
  static const PlateBox legacyCrest = PlateBox(13, 18, 32, 36);
  static const PlateBox legacySk = PlateBox(11, 58, 36, 22);
}

/// One field: [count] cells at [pitch] from [firstCentre]; fewer than [count]
/// but at least [minCount] counts as complete.
class _Field {
  const _Field(
    this.key,
    this.alphabet,
    this.firstCentre,
    this.pitch,
    this.count, {
    this.minCount,
  }) : top = _Layout.top,
       height = _Layout.box;

  const _Field.row1(
    this.key,
    this.alphabet,
    this.firstCentre,
    this.pitch,
    this.count,
  ) : minCount = null,
      top = _Layout.row1Top,
      height = _Layout.rowBox;

  const _Field.row2(
    this.key,
    this.alphabet,
    this.firstCentre,
    this.pitch,
    this.count,
  ) : minCount = null,
      top = _Layout.row2Top,
      height = _Layout.rowBox;

  final String key;
  final PlateAlphabet alphabet;
  final double firstCentre, pitch;
  final int count;
  final int? minCount;
  final double top, height;
}

const PlateAlphabet _digits = SlovakiaAlphabets.digits;
const PlateAlphabet _letters = SlovakiaAlphabets.letters;
const PlateAlphabet _any = SlovakiaAlphabets.personalised;

/// The two-line plates and the personalised plate are estimated, not
/// measured. The Nitra district sticker and Bratislava's arms are not drawn.
abstract final class SlovakiaPlates {
  static final PlateSpec private = _spec(
    id: 'sk.private',
    band: true,
    fields: const <_Field>[
      _Field('a', _letters, 98, 56, 2),
      _Field('b', _digits, 245, 54.5, 3),
      _Field('c', _letters, 418, 55, 2),
    ],
    crest: _Layout.crest,
  );

  static final PlateSpec privateDash = _spec(
    id: 'sk.privateDash',
    band: true,
    fields: const <_Field>[
      _Field('a', _letters, 86, 57.5, 2),
      _Field('b', _digits, 247, 58, 3),
      _Field('c', _letters, 423, 58, 2),
    ],
    dashCx: 195,
  );

  static final PlateSpec military = _spec(
    id: 'sk.military',
    band: true,
    fields: const <_Field>[
      _Field('a', _digits, 82, 59, 2),
      _Field('b', _digits, 245, 60, 5),
    ],
    crest: _Layout.crest,
  );

  static final PlateSpec diplomatic = _spec(
    id: 'sk.diplomatic',
    band: true,
    country: SlovakiaCountry.diplomatic,
    fields: const <_Field>[
      _Field('a', _letters, 90, 57, 2),
      _Field('b', _digits, 248, 57.5, 5),
    ],
    crest: _Layout.crest,
  );

  static final PlateSpec legacy = _spec(
    id: 'sk.legacy',
    fields: const <_Field>[
      _Field('a', _letters, 82, 58, 2),
      _Field('b', _digits, 217, 57, 3),
      _Field('c', _letters, 394, 58, 2),
    ],
    dashCx: 168,
    legacyMarks: true,
  );

  static final PlateSpec officials = _spec(
    id: 'sk.officials',
    fields: const <_Field>[
      _Field('a', _letters, 84, 58, 2),
      _Field('b', _letters, 248, 58, 1),
      _Field('c', _digits, 366, 58, 3),
    ],
    dashCx: 196,
    legacyMarks: true,
  );

  /// Takes the private plate's geometry; the photo was never measured.
  static final PlateSpec personalised = _spec(
    id: 'sk.personalised',
    band: true,
    fields: const <_Field>[
      _Field('a', _letters, 98, 56, 2),
      _Field('b', _any, 252, 56, 5, minCount: 1),
    ],
    crest: _Layout.crest,
  );

  static final PlateSpec temporary = _twoLine(
    id: 'sk.temporary',
    row1: const _Field.row1('a', _letters, 180, 39, 2),
    row2: const <_Field>[
      _Field.row2('b', _letters, 57, 40, 1),
      _Field.row2('c', _digits, 190, 51, 3),
    ],
    badge: true,
    crest: _Layout.tlCrest,
  );

  static final PlateSpec dealer = _twoLine(
    id: 'sk.dealer',
    row1: const _Field.row1('a', _letters, 175, 39, 2),
    row2: const <_Field>[
      _Field.row2('b', _letters, 54, 40, 1),
      _Field.row2('c', _digits, 190, 52, 3),
    ],
    dealerMarks: true,
  );

  static final PlateSpec imported = _twoLine(
    id: 'sk.imported',
    row1: const _Field.row1('a', _letters, 177, 39, 1),
    row2: const <_Field>[_Field.row2('b', _digits, 100, 49, 5)],
    badge: true,
    crest: _Layout.tlCrest,
  );

  static PlateSpec _twoLine({
    required String id,
    required _Field row1,
    required List<_Field> row2,
    bool badge = false,
    bool dealerMarks = false,
    PlateBox? crest,
  }) {
    return _spec(
      id: id,
      fields: <_Field>[row1, ...row2],
      badge: badge,
      dealerMarks: dealerMarks,
      crest: crest,
      width: _Layout.tlWidth,
      height: _Layout.tlHeight,
    );
  }

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    privateDash,
    military,
    diplomatic,
    legacy,
    officials,
    personalised,
    temporary,
    dealer,
    imported,
  ];

  static PlateSlot _slot(_Field f) {
    return PlateSlot(
      alphabet: f.alphabet,
      box: PlateBox(
        f.firstCentre - f.pitch / 2,
        f.top,
        f.count * f.pitch,
        f.height,
      ),
      length: f.count,
      minLength: f.minCount,
      spacing: f.count > 1 ? plateRunSpacing(f.pitch, f.height) : 0,
      group: f.key,
    );
  }

  static PlateSpec _spec({
    required String id,
    required List<_Field> fields,
    bool band = false,
    bool badge = false,
    bool dealerMarks = false,
    bool legacyMarks = false,
    double width = _Layout.width,
    double height = _Layout.height,
    PlateCountry country = SlovakiaCountry.slovakia,
    PlateBox? crest,
    double? dashCx,
  }) {
    return PlateSpec(
      id: id,
      country: country,
      canvasWidth: width,
      canvasHeight: height,
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
          : badge
          ? const PlatePanel(box: _Layout.badgeFlag, padding: EdgeInsets.zero)
          : const PlatePanel(box: PlateBox(0, 0, 0, 0)),
      noPanel: !band && !badge,
      bands: <PlateBand>[
        if (badge)
          const PlateBand(box: _Layout.badge, color: SlovakiaColors.euroBlue),
      ],
      background: band
          ? const PlateSection.columns(<PlatePart>[
              PlatePart(
                PlateSection.fill(PlateFill.panel),
                end: _Layout.bandEnd,
              ),
              PlatePart(PlateSection.plain),
            ])
          : PlateSection.plain,
      slots: <PlateSlot>[for (final _Field f in fields) _slot(f)],
      labels: <PlateLabel>[
        if (badge)
          const PlateLabel(
            text: 'SK',
            box: PlateBox(9, 66, 49, 26),
            glyphHeight: 26,
            color: SlovakiaColors.white,
          ),
        if (dealerMarks)
          const PlateLabel(text: 'SK', box: _Layout.dealerSk, glyphHeight: 22),
        if (band)
          const PlateLabel(
            text: 'SK',
            box: PlateBox(
              _Layout.skLeft,
              _Layout.skTop,
              _Layout.skWidth,
              _Layout.skHeight,
            ),
            glyphHeight: _Layout.skGlyph,
            color: SlovakiaColors.white,
          ),
        if (legacyMarks)
          const PlateLabel(text: 'SK', box: _Layout.legacySk, glyphHeight: 22),
        if (dashCx != null)
          PlateLabel(
            text: '-',
            box: PlateBox(
              dashCx - _Layout.dashWidth / 2,
              _Layout.top,
              _Layout.dashWidth,
              _Layout.box,
            ),
            glyphHeight: _Layout.box,
          ),
      ],
      decals: <PlateDecal>[
        // Coat of arms of Slovakia: assets/icons/coat_of_arms_of_slovakia.svg,
        // rasterised to the .png; a crest, so a decal rather than painted.
        if (crest != null || legacyMarks || dealerMarks)
          PlateDecal(
            image: const AssetImage(
              'assets/countries/slovakia/icons/coat_of_arms_of_slovakia.png',
              package: 'license_plate',
            ),
            box:
                crest ??
                (dealerMarks ? _Layout.dealerCrest : _Layout.legacyCrest),
          ),
      ],
    );
  }
}

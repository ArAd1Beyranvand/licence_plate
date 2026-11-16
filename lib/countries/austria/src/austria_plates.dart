import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'austria_colors.dart';
import 'austria_country.dart';
import 'austria_missions.dart';

/// Where the ink sits, in plate units. Every photo is flattened to the
/// 520×120 mm the article gives (4 px per unit); positions are ink-run
/// measurements of those flats, read off `S 578 IL` unless noted.
///
/// - Triband: red lines at y 8–10.5, 12.5–14.5 and 108–111, 113.5–115.5.
/// - Euroband: x 12.5–57, y 15–108 between the triband lines.
/// - `S 578 IL`: S 109–146, crest 175–217 (y 26–96 with its name), digits
///   244–355, IL 391–449; letters are 68 tall.
/// - `W 26285 T`: five digits at a 50 pitch; the district letter starts at 72.
///
/// Ink is about 68 tall on a 120 plate, so every box is the full canvas height
/// and the ink lands near 66, ~97% of reference. The crest follows the
/// district letters on the real plate (one letter or two); here it stays where
/// the `S` plate has it, and each field is centred on its box.
///
/// Estimated rather than measured: the temporary plate (partial, tilted
/// photo; the strip colour is the trailer red), the moped plate (a shield on
/// a 220×240 canvas read off the 250×304 photo) and the export plate's
/// round validity sticker, which is not drawn.
abstract final class _Layout {
  static const double width = 520, height = 120, box = 120;

  static const double stripeTop1 = 8, stripeTop2 = 12.5;
  static const double stripeBottom1 = 108, stripeBottom2 = 113.5;
  static const double stripeThickness = 2.5;

  static const double bandLeft = 12.5, bandEnd = 57, bandWidth = 44.5;
  static const double bandTop = 15, bandBottom = 108, starsHeight = 68;
  static const double aTop = 63, aHeight = 38;

  static const double crestTop = 24, crestHeight = 62;
  static const double nameTop = 87, nameHeight = 11, nameGlyph = 11;

  static const double dashWidth = 30;

  static const double mopedWidth = 220, mopedHeight = 240;
}

const PlateAlphabet _digits = AustriaAlphabets.digits;
const PlateAlphabet _letters = AustriaAlphabets.letters;

/// One field: a run printed and typed as a unit, one slot.
class _Field {
  const _Field(
    this.key,
    this.alphabet,
    this.left,
    this.width,
    this.length, {
    this.minLength,
    this.top = 0,
    this.height = _Layout.box,
  });

  final String key;
  final PlateAlphabet alphabet;
  final double left, width;
  final int length;
  final int? minLength;
  final double top, height;
}

/// A crest decal: the vector in `assets/icons`, rasterised, with its printed
/// name beneath. Aspect is the raster's width over height.
class _Crest {
  const _Crest(this.asset, this.aspect, this.name);

  final String asset;
  final double aspect;
  final String? name;

  PlateBox boxAt(double centre) {
    final double w = _Layout.crestHeight * aspect;
    return PlateBox(centre - w / 2, _Layout.crestTop, w, _Layout.crestHeight);
  }
}

// Coat of arms of Salzburg: assets/icons/coat_of_arms_of_salzburg.svg, from
// https://commons.wikimedia.org/wiki/File:Salzburg_Wappen.svg
const _Crest _salzburg = _Crest(
  'coat_of_arms_of_salzburg.png',
  139 / 256,
  'SALZBURG',
);

// Coat of arms of Vorarlberg: assets/icons/coat_of_arms_of_vorarlberg.svg, from
// https://commons.wikimedia.org/wiki/File:Vorarlberg_CoA.svg
const _Crest _vorarlberg = _Crest(
  'coat_of_arms_of_vorarlberg.png',
  187 / 256,
  'VORARLBERG',
);

// Federal eagle: assets/icons/coat_of_arms_of_austria.svg, from
// https://commons.wikimedia.org/wiki/File:Coat_of_arms_of_Austria.svg
const _Crest _federal = _Crest('coat_of_arms_of_austria.png', 242 / 256, null);

// Fire brigade badge: assets/icons/fire_brigade_badge.png, cropped from
// https://commons.wikimedia.org/wiki/File:FW-Abzeichen.jpg (a photograph, so
// a raster decal rather than a drawing).
const _Crest _fire = _Crest('fire_brigade_badge.png', 202 / 256, 'FEUERWEHR');

/// The Austrian plates, one builder over a list of fields.
///
/// [private] is `S 578 IL` (district letters, the state's arms, digits,
/// letters) with the euroband and the red-white-red triband; [electric] and
/// [trailer] are the same body with Vorarlberg's arms (the trailer plate is
/// white on red with no triband); [personalised] `DO BUS 3` a block of
/// letters then digits; [federal] `A 1000` with the federal eagle and no
/// serial letters; [fire] `FW 200 B`; [diplomatic] `WD-15` with a dash and a
/// mission code; [export] and [temporary] drop the euroband; [moped] is the
/// two-line shield.
///
/// Not implemented: the 1990–2002 plate without the euroband, the 1954
/// occupation plate and the Cold-War Styrian plate (historic); the bus,
/// gendarmerie, army, police and finance plates print the federal plate's
/// layout and share [federal], their photographs were not measured. The
/// district's arms are one decal per plate, the one in the reference.
abstract final class AustriaPlates {
  static final PlateSpec private = _spec(
    id: 'at.private',
    band: true,
    stripes: true,
    fields: _regularFields,
    crest: _salzburg,
  );

  static final PlateSpec electric = _spec(
    id: 'at.electric',
    band: true,
    stripes: true,
    fields: _regularFields,
    crest: _vorarlberg,
  );

  static final PlateSpec trailer = _spec(
    id: 'at.trailer',
    band: true,
    fields: _regularFields,
    crest: _vorarlberg,
  );

  static final PlateSpec personalised = _spec(
    id: 'at.personalised',
    band: true,
    stripes: true,
    fields: const <_Field>[
      _Field('a', _letters, 72, 110, 2, minLength: 1),
      _Field('b', _letters, 214, 180, 5, minLength: 1),
      _Field('c', _digits, 392, 80, 3, minLength: 1),
    ],
    crest: _salzburg,
  );

  static final PlateSpec federal = _spec(
    id: 'at.federal',
    band: true,
    stripes: true,
    fields: const <_Field>[
      _Field('a', _letters, 72, 110, 2, minLength: 1),
      _Field('b', _digits, 214, 260, 5, minLength: 1),
    ],
    crest: _federal,
  );

  /// `FW 200 B`: the badge sits at 210–260 (zone measured on the photo).
  static final PlateSpec fire = _spec(
    id: 'at.fire',
    band: true,
    stripes: true,
    fields: const <_Field>[
      _Field('a', _letters, 92, 108, 2),
      _Field('b', _digits, 262, 140, 4, minLength: 1),
      _Field('c', _letters, 418, 60, 2, minLength: 1),
    ],
    crest: _fire,
    crestCentre: 235,
  );

  /// `WD-15`: no arms; the dash is centred between `WD` (152–259) and the
  /// mission code (332–414).
  static final PlateSpec diplomatic = _spec(
    id: 'at.diplomatic',
    band: true,
    stripes: true,
    fields: const <_Field>[
      _Field('a', _letters, 146, 124, 2),
      _Field('mission', _digits, 322, 102, 2, minLength: 1),
    ],
    dashCx: 295,
    restrictions: const <PlateRestriction>[AustriaMissions.restriction],
  );

  /// `B 10 VB`: no euroband; `gültig bis` / `valid until` at the right where
  /// the sticker sits (the sticker itself is not drawn).
  static final PlateSpec export = _spec(
    id: 'at.export',
    fields: const <_Field>[
      _Field('a', _letters, 46, 84, 2, minLength: 1),
      _Field('b', _digits, 166, 117, 3, minLength: 1),
      _Field('c', _letters, 290, 104, 2, minLength: 1),
    ],
    crest: _vorarlberg,
    crestCentre: 147,
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'gültig bis',
        box: PlateBox(405, 4, 105, 22),
        glyphHeight: 20,
      ),
      PlateLabel(
        text: 'valid until',
        box: PlateBox(405, 98, 105, 18),
        glyphHeight: 18,
      ),
    ],
  );

  /// `FK 19 YM` and the year of validity in a red strip at the right.
  static final PlateSpec temporary = _spec(
    id: 'at.temporary',
    fields: const <_Field>[
      _Field('a', _letters, 30, 124, 2, minLength: 1),
      _Field('b', _digits, 228, 100, 2, minLength: 1),
      _Field('c', _letters, 330, 112, 2, minLength: 1),
      _Field('d', _digits, 462, 56, 2, top: 30, height: 60),
    ],
    crest: _vorarlberg,
    crestCentre: 190,
    yearStrip: true,
  );

  /// `UU-3` over `XHW`: the shield is drawn as a rectangle with a white rim.
  static final PlateSpec moped = _spec(
    id: 'at.moped',
    width: _Layout.mopedWidth,
    height: _Layout.mopedHeight,
    fields: const <_Field>[
      _Field('a', _letters, 32, 86, 2, minLength: 1, top: 2, height: 115),
      _Field('b', _digits, 140, 54, 3, minLength: 1, top: 2, height: 115),
      _Field('c', _letters, 44, 140, 3, minLength: 1, top: 85.5, height: 115),
    ],
    dashCx: 133,
    dashHeight: 115,
    dashTop: 2,
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    electric,
    trailer,
    personalised,
    federal,
    fire,
    diplomatic,
    export,
    temporary,
    moped,
  ];

  static const List<_Field> _regularFields = <_Field>[
    _Field('a', _letters, 72, 110, 2, minLength: 1),
    _Field('b', _digits, 198, 190, 5, minLength: 1),
    _Field('c', _letters, 372, 96, 2, minLength: 1),
  ];

  /// The red-white-red triband top and bottom, with the euroband (if any)
  /// between the inner lines; or the band alone at the plate's full height.
  static PlateSection _background({
    required bool band,
    required bool stripes,
    required bool yearStrip,
  }) {
    const PlateFill red = PlateFill.color(AustriaColors.stripeRed);
    const PlateSection bandColumns = PlateSection.columns(<PlatePart>[
      PlatePart(PlateSection.plain, end: _Layout.bandLeft),
      PlatePart(PlateSection.fill(PlateFill.panel), end: _Layout.bandEnd),
      PlatePart(PlateSection.plain),
    ]);
    if (stripes) {
      return PlateSection.rows(<PlatePart>[
        const PlatePart(PlateSection.plain, end: _Layout.stripeTop1),
        PlatePart(
          const PlateSection.fill(red),
          end: _Layout.stripeTop1 + _Layout.stripeThickness,
        ),
        const PlatePart(PlateSection.plain, end: _Layout.stripeTop2),
        PlatePart(
          const PlateSection.fill(red),
          end: _Layout.stripeTop2 + _Layout.stripeThickness,
        ),
        PlatePart(
          band ? bandColumns : PlateSection.plain,
          end: _Layout.bandBottom,
        ),
        PlatePart(
          const PlateSection.fill(red),
          end: _Layout.stripeBottom1 + _Layout.stripeThickness,
        ),
        const PlatePart(PlateSection.plain, end: _Layout.stripeBottom2),
        PlatePart(
          const PlateSection.fill(red),
          end: _Layout.stripeBottom2 + _Layout.stripeThickness,
        ),
        const PlatePart(PlateSection.plain),
      ]);
    }
    if (yearStrip) {
      return const PlateSection.columns(<PlatePart>[
        PlatePart(PlateSection.plain, end: 460),
        PlatePart(
          PlateSection.fill(PlateFill.color(AustriaColors.trailerField)),
        ),
      ]);
    }
    return band ? bandColumns : PlateSection.plain;
  }

  static PlateSpec _spec({
    required String id,
    required List<_Field> fields,
    bool band = false,
    bool stripes = false,
    bool yearStrip = false,
    double width = _Layout.width,
    double height = _Layout.height,
    _Crest? crest,
    double crestCentre = 196,
    List<PlateLabel> labels = const <PlateLabel>[],
    List<PlateRestriction> restrictions = const <PlateRestriction>[],
    double? dashCx,
    double dashHeight = _Layout.box,
    double dashTop = 0,
  }) {
    // The euroband sits between the triband lines, or from the top when the
    // plate has none.
    final double bandTop = stripes ? _Layout.bandTop : 4;
    return PlateSpec(
      id: id,
      country: AustriaCountry.austria,
      canvasWidth: width,
      canvasHeight: height,
      panel: band
          ? PlatePanel(
              box: PlateBox(
                _Layout.bandLeft,
                bandTop,
                _Layout.bandWidth,
                _Layout.starsHeight,
              ),
              padding: EdgeInsets.zero,
            )
          : const PlatePanel(box: PlateBox(0, 0, 0, 0)),
      noPanel: !band,
      background: _background(
        band: band,
        stripes: stripes,
        yearStrip: yearStrip,
      ),
      slots: <PlateSlot>[
        for (final _Field f in fields)
          PlateSlot(
            alphabet: f.alphabet,
            box: PlateBox(f.left, f.top, f.width, f.height),
            length: f.length,
            minLength: f.minLength,
            group: f.key,
          ),
      ],
      labels: <PlateLabel>[
        if (band)
          PlateLabel(
            text: 'A',
            box: PlateBox(
              _Layout.bandLeft,
              bandTop + _Layout.aTop - _Layout.bandTop,
              _Layout.bandWidth,
              _Layout.aHeight,
            ),
            glyphHeight: _Layout.aHeight,
            color: AustriaColors.white,
          ),
        if (crest?.name case final String name)
          PlateLabel(
            text: name,
            box: PlateBox(
              crestCentre - 34,
              _Layout.nameTop,
              68,
              _Layout.nameHeight,
            ),
            glyphHeight: _Layout.nameGlyph,
          ),
        if (dashCx != null)
          PlateLabel(
            text: '-',
            box: PlateBox(
              dashCx - _Layout.dashWidth / 2,
              dashTop,
              _Layout.dashWidth,
              dashHeight,
            ),
            glyphHeight: dashHeight,
          ),
        ...labels,
      ],
      decals: <PlateDecal>[
        if (crest != null)
          PlateDecal(
            image: AssetImage(
              'assets/countries/austria/icons/${crest.asset}',
              package: 'license_plate',
            ),
            box: crest.boxAt(crestCentre),
          ),
      ],
      restrictions: restrictions,
    );
  }
}

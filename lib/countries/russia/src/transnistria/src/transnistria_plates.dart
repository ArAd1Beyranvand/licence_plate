import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'transnistria_country.dart';

/// Ink-run measurements of the article's artwork, each plate normalised to
/// its own canvas (`.plateref/pmr`). Vehicle plates are 520×112, the moped
/// 520×180 and the trailer 520×372 (aspect of the artwork).
///
/// Passenger and neutral: letters/digits at 99–154, 185–317, 352–488
/// (passenger) and 71–256, 290–449 (neutral), ink y 15–97. The flag is the
/// passenger's only decoration (x 15–68, y 16–43); the 2015 design has no
/// divider. State plates (interior, president, diplomatic) have a black
/// divider at x 62 with the flag left of it. Ink prints ~73% of the reference
/// height (the box is the full height, `glyphStyle` paints ~0.55 of it).
///
/// Estimated: the army plate (one low-resolution photograph), the diplomatic
/// field spans. Not drawn: the holographic stickers, the pre-2015 plates, the
/// 1992 military plates, the tractor and square plates.
abstract final class _Layout {
  static const double width = 520, height = 112, rowTop = 2, rowHeight = 108;
  static const double dividerEnd = 62, dividerThickness = 3;

  static const PlateBox flag = PlateBox(15, 16.5, 53, 27);
  static const PlateBox armyFlag = PlateBox(19, 22, 42, 21);
  static const PlateBox stateFlag = PlateBox(14, 17, 39, 28);
  static const PlateBox arms = PlateBox(351, 9, 104, 92);

  static const double mopedHeight = 180, trailerHeight = 372;
  static const PlateBox trailerFlag = PlateBox(23, 29, 64, 47);
}

const PlateAlphabet _digits = TransnistriaAlphabets.digits;
const PlateAlphabet _letters = TransnistriaAlphabets.letters;

class _Field {
  const _Field(
    this.key,
    this.alphabet,
    this.left,
    this.right,
    this.length, {
    this.top = _Layout.rowTop,
    this.height = _Layout.rowHeight,
  });

  final String key;
  final PlateAlphabet alphabet;
  final double left, right;
  final int length;
  final double top, height;
}

/// * [passenger] — `T 001 AA`: region letter, three digits, two letters.
/// * [neutral] — `ZJA 043`: three letters and three digits, no flag.
/// * [army] — `381 BY`: three digits and two letters, black divider.
/// * [interior], [president], [diplomatic] — state plates with a divider;
///   the president's carries the coat of arms.
/// * [moped] — `H364` on 520×180; [trailer] — `AC` over `C 001` on 520×372.
abstract final class TransnistriaPlates {
  static final PlateSpec passenger = _spec(
    id: 'pmr.passenger',
    flag: _Layout.flag,
    fields: const <_Field>[
      _Field('region', _letters, 99.1, 154, 1),
      _Field('serial', _digits, 185.1, 317.4, 3),
      _Field('series', _letters, 351.6, 488.1, 2),
    ],
  );

  static final PlateSpec neutral = _spec(
    id: 'pmr.neutral',
    fields: const <_Field>[
      _Field('series', _letters, 71, 255.8, 3),
      _Field('serial', _digits, 290.3, 449, 3),
    ],
  );

  static final PlateSpec army = _spec(
    id: 'pmr.army',
    flag: _Layout.armyFlag,
    divider: true,
    fields: const <_Field>[
      _Field('serial', _digits, 179.6, 322, 3),
      _Field('series', _letters, 362, 479, 2),
    ],
  );

  static final PlateSpec interior = _spec(
    id: 'pmr.interior',
    flag: _Layout.stateFlag,
    stateFlag: true,
    divider: true,
    fields: const <_Field>[
      _Field('series', _letters, 138.5, 273.7, 2),
      _Field('serial', _digits, 302.2, 440.7, 3),
    ],
  );

  static final PlateSpec president = _spec(
    id: 'pmr.president',
    flag: _Layout.stateFlag,
    stateFlag: true,
    divider: true,
    decals: const <PlateDecal>[
      PlateDecal(
        image: AssetImage(
          'assets/countries/russia/transnistria/icons/transnistria_coat_of_arms.png',
          package: 'license_plate',
        ),
        box: _Layout.arms,
      ),
    ],
    fields: const <_Field>[_Field('serial', _digits, 151.5, 289.9, 3)],
  );

  static final PlateSpec diplomatic = _spec(
    id: 'pmr.diplomatic',
    flag: _Layout.stateFlag,
    stateFlag: true,
    divider: true,
    fields: const <_Field>[
      _Field('status', _letters, 81, 199, 2),
      _Field('serial', _digits, 231, 354, 3),
      _Field('mission', _digits, 396, 484, 2),
    ],
  );

  static final PlateSpec moped = _spec(
    id: 'pmr.moped',
    height: _Layout.mopedHeight,
    fields: const <_Field>[
      _Field('region', _letters, 78.7, 174.4, 1, top: 6, height: 168),
      _Field('serial', _digits, 195.7, 463.6, 3, top: 6, height: 168),
    ],
  );

  static final PlateSpec trailer = _spec(
    id: 'pmr.trailer',
    height: _Layout.trailerHeight,
    flag: _Layout.trailerFlag,
    fields: const <_Field>[
      _Field('prefix', _letters, 159, 376, 2, top: 20, height: 168),
      _Field('region', _letters, 69.9, 163.1, 1, top: 196, height: 168),
      _Field('serial', _digits, 220.3, 445.9, 3, top: 196, height: 168),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[
    passenger,
    neutral,
    army,
    interior,
    president,
    diplomatic,
    moped,
    trailer,
  ];

  static PlateSlot _slot(_Field f) {
    final double pitch = (f.right - f.left) / f.length;
    return PlateSlot(
      alphabet: f.alphabet,
      box: PlateBox(f.left, f.top, f.right - f.left, f.height),
      length: f.length,
      spacing: f.length == 1 ? 0 : plateRunSpacing(pitch, f.height),
      group: f.key,
    );
  }

  static PlateSpec _spec({
    required String id,
    required List<_Field> fields,
    double height = _Layout.height,
    PlateBox? flag,
    bool stateFlag = false,
    bool divider = false,
    List<PlateDecal> decals = const <PlateDecal>[],
  }) {
    return PlateSpec(
      id: id,
      country: TransnistriaCountry.transnistria,
      canvasWidth: _Layout.width,
      canvasHeight: height,
      noPanel: true,
      panel: PlatePanel(box: PlateBox(0, 0, 0, height)),
      background: divider
          ? const PlateSection.columns(<PlatePart>[
              PlatePart(
                PlateSection.plain,
                end: _Layout.dividerEnd,
                divider: _Layout.dividerThickness,
              ),
              PlatePart(PlateSection.plain),
            ])
          : PlateSection.plain,
      slots: <PlateSlot>[for (final _Field f in fields) _slot(f)],
      decals: <PlateDecal>[
        if (flag != null)
          PlateDecal(
            drawing: stateFlag
                ? TransnistriaCountry.stateFlagDrawing
                : TransnistriaCountry.flagDrawing,
            box: flag,
          ),
        ...decals,
      ],
    );
  }
}

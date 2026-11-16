import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'hungary_colors.dart';
import 'hungary_country.dart';

/// Where the ink sits, in plate units. Every photo is flattened to the
/// 520×110 the article gives (4 px per unit); positions are ink-run
/// measurements of those flats, or readings off the contact sheet where the
/// photo is too blurred for a run (marked "sheet").
///
/// Fields (centre of the first cell, pitch):
/// - 2022 `AA BP-022` (measured): AA 103.5/57.7, BP 263/49.6, dash 352,
///   digits 392.5/46.9; arms x 200.5–228, y 30.5–78.5; band 0–63 in
///   `0046B8`, frame 5 units wide. Ink is 72 tall on the flat, but a box that
///   tall would need ~130, so every box is the full 110 and the ink lands near
///   60, about 83% of reference.
/// - diplomatic `DT 04-56` (sheet, ink runs for `56`): DT 95/71, `04` 225/53,
///   dash 326, `56` 382.7/72.
/// - staff `CK 06-29` (sheet): same layout as diplomatic, which it matches to
///   about 8%; blue strip 0–38.
/// - export `Z-07458 17` (ink runs): flag x 24–65.5, y 15.5–52.5, divider 83,
///   Z 128, dash 178, digits 225/54, year at 482–506.
/// - trial `P-04017 16` (ink runs): flag x 14–45, y 10.5–43, divider 58,
///   P 96, dash 137, digits 180/61.7, year 466–504.
/// - agricultural `M010311` (sheet): flag and divider as trial, M 101,
///   six digits from 135 at pitch 58. The article lists two fields; the
///   picture shows six digits, and the picture wins.
/// - slow `YEW 557` (sheet, 340×184): the photo is 1.85:1, so flat x is scaled
///   by 0.654 and y by 1.673; flag x 31–80, y 33–84, divider 98, `YEW` from
///   111 at 64, `557` from 142 at 47.7.
///
/// Not built, and why: the pre-1990 plate and the foreign-resident plate are
/// no longer issued; the US-size plates (diplomatic corps, dealer), the
/// sporting plate and the moped plate are photographed too blurred or too
/// obliquely (aspect 0.81–2.08, CHECK-fitted) to give a layout that is
/// better than a guess.
abstract final class _Layout {
  static const double width = 520, height = 110, box = 110;

  static const double dashWidth = 30, dividerWidth = 3.5;

  static const double euroBandEnd = 63;
  static const PlateBox euroPanel = PlateBox(8, 6.3, 46, 68.8);
  static const PlateBox euroH = PlateBox(8, 66, 46, 34);

  // Hungary's arms: assets/icons/coat_of_arms_of_hungary.svg, from
  // https://commons.wikimedia.org/wiki/File:Coat_of_arms_of_Hungary.svg,
  // rasterised to the .png; a crest, so a decal rather than painted.
  static const PlateBox crest = PlateBox(200.5, 30.5, 27.5, 48);

  static const double diplomaticStripEnd = 38;
  static const PlateBox staffPanel = PlateBox(3, 6, 32, 49);
  static const PlateBox staffH = PlateBox(3, 58, 32, 40);
  static const PlateBox diplomaticPanel = PlateBox(6, 6, 36, 55);
  static const PlateBox diplomaticH = PlateBox(6, 60, 36, 38);

  static const double slowWidth = 340, slowHeight = 184;
  static const double slowRowTop1 = 4, slowRowTop2 = 92, slowRowBox = 88;
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
    this.top = 0,
    this.height = _Layout.box,
  });

  final String key;
  final PlateAlphabet alphabet;
  final double firstCentre, pitch;
  final int count;
  final double top, height;
}

/// A strip of the older style: the tricolour and `H` left of a full-height
/// divider.
class _Strip {
  const _Strip(this.flag, this.h, this.dividerX);

  final PlateBox flag, h;
  final double dividerX;
}

const PlateAlphabet _digits = HungaryAlphabets.digits;
const PlateAlphabet _letters = HungaryAlphabets.letters;

const _Strip _trialStrip = _Strip(
  PlateBox(14, 10.5, 31, 32.5),
  PlateBox(12, 46, 36, 56),
  58,
);
const _Strip _exportStrip = _Strip(
  PlateBox(24, 15.5, 41.5, 37),
  PlateBox(22, 50, 45, 52),
  83,
);

/// The Hungarian plates, one builder per design.
///
/// [private] is the 2022 plate `AA BP-022`: the EU band, two letters, the
/// arms, two letters, a dash, three digits. [diplomatic] (`DT 04-56`) and
/// [staff] (`CK 06-29`) share one body, two letters and two pairs of digits.
/// [agricultural] `M010311`, [export] `Z-07458 17` and [trial] `P-04017 16`
/// are the older style with the tricolour strip and a divider; export and
/// trial are one builder, the year a small second field. [slowVehicle] is the
/// two-row `YEW` over `557`.
abstract final class HungaryPlates {
  static final PlateSpec private = _spec(
    id: 'hu.private',
    country: HungaryCountry.hungary,
    panel: _Layout.euroPanel,
    h: _Layout.euroH,
    hColor: HungaryColors.white,
    stripEnd: _Layout.euroBandEnd,
    fields: const <_Field>[
      _Field('a', _letters, 103.5, 57.7, 2),
      _Field('b', _letters, 263, 49.6, 2),
      _Field('c', _digits, 392.5, 46.9, 3),
    ],
    dashCx: 352.4,
    crest: true,
  );

  static final PlateSpec diplomatic = _spec(
    id: 'hu.diplomatic',
    country: HungaryCountry.diplomatic,
    panel: _Layout.diplomaticPanel,
    h: _Layout.diplomaticH,
    fields: _pairs,
    dashCx: 326,
  );

  static final PlateSpec staff = _spec(
    id: 'hu.staff',
    country: HungaryCountry.staff,
    panel: _Layout.staffPanel,
    h: _Layout.staffH,
    hColor: HungaryColors.white,
    stripEnd: _Layout.diplomaticStripEnd,
    fields: _pairs,
    dashCx: 326,
  );

  static const List<_Field> _pairs = <_Field>[
    _Field('a', _letters, 95, 71, 2),
    _Field('b', _digits, 225, 53, 2),
    _Field('c', _digits, 382.7, 72, 2),
  ];

  static final PlateSpec agricultural = _spec(
    id: 'hu.agricultural',
    country: HungaryCountry.tricolour,
    panel: _trialStrip.flag,
    h: _trialStrip.h,
    dividerX: _trialStrip.dividerX,
    fields: const <_Field>[
      _Field('a', _letters, 101, 62, 1),
      _Field('b', _digits, 164, 58, 6),
    ],
  );

  static final PlateSpec export = _yearPlate(
    id: 'hu.export',
    strip: _exportStrip,
    letterCx: 128,
    dashCx: 178,
    digitsCx: 225,
    digitsPitch: 54,
    yearLeft: 482,
    yearPitch: 12,
  );

  static final PlateSpec trial = _yearPlate(
    id: 'hu.trial',
    strip: _trialStrip,
    letterCx: 96,
    dashCx: 137,
    digitsCx: 180,
    digitsPitch: 61.7,
    yearLeft: 466,
    yearPitch: 19,
  );

  static PlateSpec _yearPlate({
    required String id,
    required _Strip strip,
    required double letterCx,
    required double dashCx,
    required double digitsCx,
    required double digitsPitch,
    required double yearLeft,
    required double yearPitch,
  }) {
    return _spec(
      id: id,
      country: HungaryCountry.tricolour,
      panel: strip.flag,
      h: strip.h,
      dividerX: strip.dividerX,
      fields: <_Field>[
        _Field('a', _letters, letterCx, 62, 1),
        _Field('b', _digits, digitsCx, digitsPitch, 5),
        _Field(
          'c',
          _digits,
          yearLeft + yearPitch / 2,
          yearPitch,
          2,
          top: 33,
          height: 44,
        ),
      ],
      dashCx: dashCx,
    );
  }

  /// `YEW` over `557`, the tricolour and `H` left of a divider, in red.
  static final PlateSpec slowVehicle = _spec(
    id: 'hu.slow',
    country: HungaryCountry.tricolour,
    panel: const PlateBox(31, 33, 49, 51),
    h: const PlateBox(31, 84, 49, 76),
    dividerX: 98,
    width: _Layout.slowWidth,
    height: _Layout.slowHeight,
    fields: const <_Field>[
      _Field(
        'a',
        _letters,
        143,
        64,
        3,
        top: _Layout.slowRowTop1,
        height: _Layout.slowRowBox,
      ),
      _Field(
        'b',
        _digits,
        166,
        47.7,
        3,
        top: _Layout.slowRowTop2,
        height: _Layout.slowRowBox,
      ),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    diplomatic,
    staff,
    agricultural,
    export,
    trial,
    slowVehicle,
  ];

  /// The field as one slot: its box spans the cells at their pitch.
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
      spacing: f.count > 1 ? plateRunSpacing(f.pitch, f.height) : 0,
      group: f.key,
    );
  }

  /// [stripEnd] paints a coloured side strip to the plate edge; [dividerX] a
  /// full-height rule; neither paints the plain face.
  static PlateSpec _spec({
    required String id,
    required PlateCountry country,
    required PlateBox panel,
    required PlateBox h,
    required List<_Field> fields,
    Color? hColor,
    double? stripEnd,
    double? dividerX,
    double? dashCx,
    bool crest = false,
    double width = _Layout.width,
    double height = _Layout.height,
  }) {
    return PlateSpec(
      id: id,
      country: country,
      canvasWidth: width,
      canvasHeight: height,
      panel: PlatePanel(box: panel, padding: EdgeInsets.zero),
      background: stripEnd != null
          ? PlateSection.columns(<PlatePart>[
              PlatePart(
                const PlateSection.fill(PlateFill.panel),
                end: stripEnd,
              ),
              const PlatePart(PlateSection.plain),
            ])
          : dividerX != null
          ? PlateSection.columns(<PlatePart>[
              PlatePart(
                PlateSection.plain,
                end: dividerX,
                divider: _Layout.dividerWidth,
              ),
              const PlatePart(PlateSection.plain),
            ])
          : PlateSection.plain,
      slots: <PlateSlot>[for (final _Field f in fields) _slot(f)],
      labels: <PlateLabel>[
        PlateLabel(text: 'H', box: h, glyphHeight: h.height, color: hColor),
        if (dashCx != null)
          PlateLabel(
            text: '-',
            box: PlateBox(
              dashCx - _Layout.dashWidth / 2,
              0,
              _Layout.dashWidth,
              _Layout.box,
            ),
            glyphHeight: _Layout.box,
          ),
      ],
      decals: <PlateDecal>[
        if (crest)
          const PlateDecal(
            image: AssetImage(
              'assets/countries/hungary/icons/coat_of_arms_of_hungary.png',
              package: 'license_plate',
            ),
            box: _Layout.crest,
          ),
      ],
    );
  }
}

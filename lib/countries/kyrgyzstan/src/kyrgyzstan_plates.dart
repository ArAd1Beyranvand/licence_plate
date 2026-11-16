import 'dart:math';

import 'package:flutter/widgets.dart' show AssetImage, EdgeInsets;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'kyrgyzstan_colors.dart';
import 'kyrgyzstan_country.dart';
import 'kyrgyzstan_regions.dart';

/// Where the ink sits, in plate units, measured off `.plateref/kg`.
///
/// The article gives 520 × 110 mm only; the square and motorcycle canvases
/// keep the artwork's aspect and the same ~4.2 frame.
///
/// A slot's ink is about 55% of its box height, so [_field] boxes each field
/// at ink / 0.55 centred on the measured ink, and shrinks it where it would
/// leave the canvas.
abstract final class _Layout {
  static const double width = 520, height = 110;

  // Dividers: x 128.7–132.9 on private, foreign; 148.2–151 on eco; 451.3–455.8
  // before the diplomatic date box, whose month/year rule is y 51–55.5.
  static const double dividerCx = 130.8, dividerThickness = 4.3;
  static const double ecoDividerCx = 149.6, ecoDividerThickness = 2.8;
  static const double ecoStripStart = 156.75, ecoStripEnd = 171.5;
  static const double dateDividerCx = 453.55, dateDividerThickness = 4.5;
  static const double dateRuleCy = 53.25, dateRuleThickness = 4.5;

  // Private and government (Plak_shakhsi-KG, Plak_dolati-KG). Region ink
  // 13.7–59.9, digits 17.4–91.1, letters 31.1–92.1.
  static const _Run region = _Run(47.3, 33.05, 13.7, 59.9);
  static const _Run digits = _Run(205.5, 52.7, 17.4, 91.1);
  static const _Run governmentDigits = _Run(212.75, 52.85, 17.4, 91.1);
  static const _Run letters = _Run(375.05, 44.85, 31.1, 92.1);
  static const _Run governmentLetters = _Run(386.25, 44.85, 31.1, 92.1);
  // The flag (red field x 18.7–64.1, y 71.6–98.4) and `KG` (ink x 72.6–107.3,
  // y 71.6–97.4, so cap height 25.8 and centre 84.5).
  static const PlateBox flag = PlateBox(18.7, 71.6, 45.4, 26.8);
  static const PlateBox kg = PlateBox(70, 61, 40, 47);
  static const double kgGlyph = 47;

  // Eco (Green-Eco-License-Plate-Kyrgyzstan-2024).
  static const _Run ecoRegion = _Run(62.35, 33.75, 17.2, 62.2);
  static const _Run ecoDigits = _Run(208.1, 52.6, 22.2, 94.2);
  static const _Run ecoLetters = _Run(370.1, 44.8, 34.8, 93.8);
  static const PlateBox ecoFlag = PlateBox(34.2, 71.5, 41.3, 23.3);
  static const PlateBox ecoKg = PlateBox(80.8, 61.25, 40, 41);
  static const double ecoKgGlyph = 41;

  // President (Plak_President-KG): flag block at the left, `01` and `KG` ink
  // x 358.2–441.5, y 30.8–91.5 (a 61 cap height, so the full-height glyph).
  static const PlateBox presidentFlag = PlateBox(8.5, 10, 154.7, 90.8);
  static const _Run presidentRegion = _Run(254.1, 53.8, 19.8, 92.5);
  static const PlateBox presidentKg = PlateBox(359.85, 12.8, 80, 97.2);
  static const double presidentKgGlyph = 111;

  // Foreign (Plak_mohajer/resane/varedat/sherkat_khareji-KG): the four
  // photographs agree to within 4 units; these are the means. No flag.
  static const _Run foreignRegion = _Run(52.9, 34.2, 12.5, 58.8);
  static const _Run foreignDigits = _Run(201.4, 52.3, 16.2, 89.2);
  static const _Run foreignLetter = _Run(432.1, 39.2, 29, 89.25);
  static const PlateBox foreignKg = PlateBox(47.25, 61.6, 40, 46);
  static const double foreignKgGlyph = 46;

  // White-on-colour series (Plak_diplomatic-KG and the ONU/eftekhari/safir
  // flats): glyph ink 17.3–90 (in each run below), month 13–43.5 and year 64.8–95.2 in the date box.
  static const _Run diplomaticClass = _Run(68.6, 46.8, 17.3, 90);
  static const _Run diplomaticMission = _Run(154, 53.2, 17.3, 90);
  static const _Run diplomaticNumber = _Run(288.9, 52.7, 17.3, 90);
  static const _Run honoraryClass = _Run(80.75, 53.65, 17.3, 90);
  static const _Run honoraryNumber = _Run(234.5, 52.2, 17.3, 90);
  static const _Run missionClass = _Run(103.4, 53.2, 16.8, 89.5);
  static const _Run missionNumber = _Run(310.5, 52.6, 16.8, 89.5);
  static const _Run month = _Run(473.8, 22.1, 13, 43.75);
  static const _Run year = _Run(473.8, 22.1, 64.8, 95.2);

  // Square two-row plate (Plak_shakhsi2-KG / Plak_dolati2-KG), 320 × 160.
  static const double squareWidth = 320, squareHeight = 160;
  static const double squareDividerCx = 110.8, squareDividerThickness = 4.2;
  static const _Run squareRegion = _Run(41.2, 33.5, 18.9, 66.8);
  static const _Run squareDigits = _Run(171.6, 42, 17.9, 79.5);
  static const _Run squareLetters = _Run(177.75, 36.1, 94.2, 145.3);
  static const _Run squareGovernmentLetters = _Run(198.35, 36.1, 94.2, 145.3);
  static const PlateBox squareFlag = PlateBox(33.5, 84.2, 43.8, 26.9);
  static const PlateBox squareKg = PlateBox(34.85, 112, 40, 47);

  // Motorcycle plate (Plak_motor-KG), 276 × 200: a second rule splits the
  // left cell at y 101–105.
  static const double motoWidth = 276, motoHeight = 200;
  static const double motoDividerCx = 114.1, motoDividerThickness = 4.2;
  static const double motoRuleCy = 103, motoRuleThickness = 4.2;
  static const _Run motoRegion = _Run(48.3, 34.5, 20.7, 69.1);
  static const _Run motoDigits = _Run(149.65, 43.25, 26.6, 88.8);
  static const _Run motoLetters = _Run(168.25, 37.7, 119.7, 171.3);
  static const PlateBox motoFlag = PlateBox(35, 118.1, 45.1, 27.1);
  static const PlateBox motoKg = PlateBox(37.05, 146.2, 40, 47.5);
}

final class _Run {
  const _Run(this.firstCx, this.pitch, this.inkTop, this.inkBottom);
  final double firstCx, pitch, inkTop, inkBottom;
}

final class _Register {
  const _Register(this.key, this.alphabet, this.run, this.count);

  const _Register.digits(String key, _Run run, int count)
    : this(key, KyrgyzstanAlphabets.digits, run, count);

  const _Register.letters(String key, _Run run, int count)
    : this(key, KyrgyzstanAlphabets.letters, run, count);

  final String key;
  final PlateAlphabet alphabet;
  final _Run run;
  final int count;
}

PlateSlot _field(_Register register, double canvasHeight) {
  final _Run run = register.run;
  final double centre = (run.inkTop + run.inkBottom) / 2;
  final double fit = 2 * min(centre, canvasHeight - centre);
  final double height = min((run.inkBottom - run.inkTop) / 0.55, fit);
  return plateRun(
    register.alphabet,
    register.count,
    left: run.firstCx - run.pitch / 2,
    top: centre - height / 2,
    pitch: run.pitch,
    height: height,
  );
}

PlateSection _split(double end, double thickness, [PlateSection? right]) =>
    PlateSection.columns(<PlatePart>[
      PlatePart(PlateSection.plain, end: end, divider: thickness),
      PlatePart(right ?? PlateSection.plain),
    ]);

const AssetImage _flagImage = AssetImage(
  // Commons: File:Flag_of_Kyrgyzstan.svg, red recoloured to the plates'
  // E8112D; assets/icons/kyrgyzstan_flag.svg is the vector.
  'assets/countries/kyrgyzstan/icons/kyrgyzstan_flag.png',
  package: 'license_plate',
);

PlateSpec _spec({
  required String id,
  required List<_Register> registers,
  double width = _Layout.width,
  double height = _Layout.height,
  PlateSection background = PlateSection.plain,
  List<PlateLabel> labels = const <PlateLabel>[],
  List<PlateBox> flags = const <PlateBox>[],
}) {
  return PlateSpec(
    id: id,
    country: KyrgyzstanCountry.kyrgyzstan,
    canvasWidth: width,
    canvasHeight: height,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, 0),
      padding: EdgeInsets.zero,
    ),
    noPanel: true,
    background: background,
    slots: <PlateSlot>[for (final r in registers) _field(r, height)],
    labels: labels,
    decals: <PlateDecal>[
      for (final PlateBox box in flags) PlateDecal(image: _flagImage, box: box),
    ],
    textGroups: <PlateTextGroup>[
      for (final (i, r) in registers.indexed)
        PlateTextGroup(<int>[i], key: r.key),
    ],
    resolveRegion: KyrgyzstanRegions.captionOf,
  );
}

PlateLabel _kg(PlateBox box, double glyph) =>
    PlateLabel(text: 'KG', box: box, glyphHeight: glyph);

/// The Kyrgyz plates since 2015, in the designs the article shows.
///
/// [government] ends in `PT` and sits two cells left of the private serial;
/// [eco] has a green strip after a thinner divider. [diplomatic], [honorary]
/// and [mission] take their red or blue from the theme.
///
/// Not implemented: the superseded 1980 and 1994 / 2009 plates. The blue and
/// red `CMD 001` flats sit 9 units apart; the red one (centred) is used.
abstract final class KyrgyzstanPlates {
  static final PlateSpec private = _spec(
    id: 'kg.private',
    background: _split(_Layout.dividerCx, _Layout.dividerThickness),
    registers: <_Register>[
      _Register.digits('region', _Layout.region, 2),
      _Register.digits('number', _Layout.digits, 3),
      _Register.letters('letters', _Layout.letters, 3),
    ],
    labels: <PlateLabel>[_kg(_Layout.kg, _Layout.kgGlyph)],
    flags: const <PlateBox>[_Layout.flag],
  );

  static final PlateSpec government = _spec(
    id: 'kg.government',
    background: _split(_Layout.dividerCx, _Layout.dividerThickness),
    registers: <_Register>[
      _Register.digits('region', _Layout.region, 2),
      _Register.digits('number', _Layout.governmentDigits, 3),
      _Register.letters('letters', _Layout.governmentLetters, 2),
    ],
    labels: <PlateLabel>[_kg(_Layout.kg, _Layout.kgGlyph)],
    flags: const <PlateBox>[_Layout.flag],
  );

  static final PlateSpec eco = _spec(
    id: 'kg.eco',
    background: PlateSection.columns(<PlatePart>[
      PlatePart(
        PlateSection.plain,
        end: _Layout.ecoDividerCx,
        divider: _Layout.ecoDividerThickness,
      ),
      PlatePart(PlateSection.plain, end: _Layout.ecoStripStart),
      PlatePart(
        PlateSection.fill(PlateFill.color(KyrgyzstanColors.ecoGreen)),
        end: _Layout.ecoStripEnd,
      ),
      PlatePart(PlateSection.plain),
    ]),
    registers: <_Register>[
      _Register.digits('region', _Layout.ecoRegion, 2),
      _Register.digits('number', _Layout.ecoDigits, 3),
      _Register.letters('letters', _Layout.ecoLetters, 3),
    ],
    labels: <PlateLabel>[_kg(_Layout.ecoKg, _Layout.ecoKgGlyph)],
    flags: const <PlateBox>[_Layout.ecoFlag],
  );

  static final PlateSpec president = _spec(
    id: 'kg.president',
    registers: <_Register>[
      _Register.digits('region', _Layout.presidentRegion, 2),
    ],
    labels: <PlateLabel>[_kg(_Layout.presidentKg, _Layout.presidentKgGlyph)],
    flags: const <PlateBox>[_Layout.presidentFlag],
  );

  static final PlateSpec foreign = _spec(
    id: 'kg.foreign',
    background: _split(_Layout.dividerCx, _Layout.dividerThickness),
    registers: <_Register>[
      _Register.digits('region', _Layout.foreignRegion, 2),
      _Register.digits('number', _Layout.foreignDigits, 4),
      _Register.letters('letters', _Layout.foreignLetter, 1),
    ],
    labels: <PlateLabel>[_kg(_Layout.foreignKg, _Layout.foreignKgGlyph)],
  );

  static final PlateSection _dated = _split(
    _Layout.dateDividerCx,
    _Layout.dateDividerThickness,
    PlateSection.rows(<PlatePart>[
      PlatePart(
        PlateSection.plain,
        end: _Layout.dateRuleCy,
        divider: _Layout.dateRuleThickness,
      ),
      PlatePart(PlateSection.plain),
    ]),
  );

  static List<_Register> _issued() => <_Register>[
    _Register.digits('month', _Layout.month, 2),
    _Register.digits('year', _Layout.year, 2),
  ];

  static final PlateSpec diplomatic = _spec(
    id: 'kg.diplomatic',
    background: _dated,
    registers: <_Register>[
      _Register.letters('class', _Layout.diplomaticClass, 1),
      _Register.digits('mission', _Layout.diplomaticMission, 2),
      _Register.digits('number', _Layout.diplomaticNumber, 3),
      ..._issued(),
    ],
  );

  static final PlateSpec honorary = _spec(
    id: 'kg.honorary',
    background: _dated,
    registers: <_Register>[
      _Register.letters('class', _Layout.honoraryClass, 2),
      _Register.digits('number', _Layout.honoraryNumber, 4),
      ..._issued(),
    ],
  );

  static final PlateSpec mission = _spec(
    id: 'kg.mission',
    registers: <_Register>[
      _Register.letters('class', _Layout.missionClass, 3),
      _Register.digits('number', _Layout.missionNumber, 3),
    ],
  );

  static PlateSpec _square(String id, _Run letters, int count) => _spec(
    id: id,
    width: _Layout.squareWidth,
    height: _Layout.squareHeight,
    background: _split(_Layout.squareDividerCx, _Layout.squareDividerThickness),
    registers: <_Register>[
      _Register.digits('region', _Layout.squareRegion, 2),
      _Register.digits('number', _Layout.squareDigits, 3),
      _Register.letters('letters', letters, count),
    ],
    labels: <PlateLabel>[_kg(_Layout.squareKg, _Layout.kgGlyph)],
    flags: const <PlateBox>[_Layout.squareFlag],
  );

  static final PlateSpec square = _square(
    'kg.square',
    _Layout.squareLetters,
    3,
  );

  static final PlateSpec squareGovernment = _square(
    'kg.square_government',
    _Layout.squareGovernmentLetters,
    2,
  );

  static final PlateSpec motorcycle = _spec(
    id: 'kg.motorcycle',
    width: _Layout.motoWidth,
    height: _Layout.motoHeight,
    background: PlateSection.columns(<PlatePart>[
      PlatePart(
        PlateSection.rows(<PlatePart>[
          PlatePart(
            PlateSection.plain,
            end: _Layout.motoRuleCy,
            divider: _Layout.motoRuleThickness,
          ),
          PlatePart(PlateSection.plain),
        ]),
        end: _Layout.motoDividerCx,
        divider: _Layout.motoDividerThickness,
      ),
      PlatePart(PlateSection.plain),
    ]),
    registers: <_Register>[
      _Register.digits('region', _Layout.motoRegion, 2),
      _Register.digits('number', _Layout.motoDigits, 3),
      _Register.letters('letters', _Layout.motoLetters, 2),
    ],
    labels: <PlateLabel>[_kg(_Layout.motoKg, _Layout.kgGlyph)],
    flags: const <PlateBox>[_Layout.motoFlag],
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    government,
    eco,
    president,
    foreign,
    diplomatic,
    honorary,
    mission,
    square,
    squareGovernment,
    motorcycle,
  ];
}

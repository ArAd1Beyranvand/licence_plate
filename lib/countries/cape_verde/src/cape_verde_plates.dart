import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'cape_verde_country.dart';
import 'cape_verde_regions.dart';
import 'cape_verde_themes.dart';

/// Ink placement in plate units. References are photographs flattened to
/// 520×110 (`flat_*`, aspect 4.7–4.85); every centre is the middle of an ink
/// run measured on the flat photo:
///
/// * regular `ST-65-BC`, ink y 17–97.2: S 90.7, T 147; 6 233.7, 5 285.7;
///   B 376.7, C 440.4; dots (x) 189 and 327.
/// * free font `ST-16-KD-G`, ink y 13–93.8: S 50.6, T 102.3; 1 182, 6 234;
///   K 314, D 366.7; G 460; dots 140, 274, 413 (the first sits in a gap whose
///   ink run is smeared, so it is the gap's visual centre).
/// * military `FA-06-86`, ink y 14.2–94.5: flag block x 7–56; F 56–114 and
///   A 127–194 (printed `FA`, a fixed label centred on 125); 0 258.8, 6 315.3;
///   8 405, 6 462; dots 212.6 and 364.
/// * diplomatic `CD-00-337`: read by eye off a perspective-skewed photo, so
///   every number is approximate: `CD` centred on 74; 0 191, 0 252; 3 346,
///   3 397, 7 448; dots 145.6 and 300.
///
/// Ink is ~55% of a slot box (`glyphStyle`: 0.72 of the box, a cap three
/// quarters of that), so the reference ink of ~80 would need a ~145 box on a
/// 110 canvas. The box is capped at [box] = 104, giving ink ~57, about 70% of
/// the reference.
abstract final class _Layout {
  static const double width = 520, height = 110, box = 104, diplomaticBox = 100;

  static const double regularCy = 57.1, freeCy = 53.4, militaryCy = 54.35;
  static const double diplomaticCy = 56;

  /// Separator dots are square middle dots: a centred label this wide.
  static const double dotWidth = 20;

  /// The flag block's far edge, under the frame (the reference flag is
  /// 51.5×30.4).
  static const double flagEnd = 56;
  static const PlatePanel flagPanel = PlatePanel(
    box: PlateBox(0, 0, flagEnd, height),
    padding: EdgeInsets.symmetric(horizontal: 4.5, vertical: 4),
  );

  /// The fixed `FA` on the military plate: ink x 56–194.
  static const PlateLabel fa = PlateLabel(
    text: 'FA',
    box: PlateBox(50, 0, 150, height),
    glyphHeight: box,
  );

  /// The fixed `CD` on the diplomatic plate: ink x 23–125.
  static const PlateLabel cd = PlateLabel(
    text: 'CD',
    box: PlateBox(14, 0, 120, height),
    glyphHeight: diplomaticBox,
  );
}

/// One register; [pitch] is between ink centres.
class _Run {
  const _Run(this.key, this.letters, this.firstCentre, this.pitch, this.count);

  final String key;
  final bool letters;
  final double firstCentre, pitch;
  final int count;
}

/// Cape Verde's current plates: one row of registers split by square dots.
///
/// * [regular]: `AB-12-CD`, `AB` the island code.
/// * [freeFont]: `ST-16-KD-G`, four registers in a thinner face (the Santiago
///   example).
/// * [military]: `FA-12-34` with the flag block at the left.
/// * [diplomatic]: `CD-12-345`, the first pair the represented country.
///
/// Not implemented: the president's `PR CV` plate, the Fogo free-font plate
/// and the pre-1990s `CVS`/`CVB` plates.
abstract final class CapeVerdePlates {
  static final PlateSpec regular = _build(
    id: 'cv.regular',
    cy: _Layout.regularCy,
    box: _Layout.box,
    runs: const <_Run>[
      _Run('series', true, 90.7, 56.3, 2),
      _Run('number', false, 233.7, 52, 2),
      _Run('letters', true, 376.7, 63.7, 2),
    ],
    dots: const <double>[189, 327],
    resolveRegion: CapeVerdeRegions.captionOf,
  );

  static final PlateSpec freeFont = _build(
    id: 'cv.freeFont',
    cy: _Layout.freeCy,
    box: _Layout.box,
    runs: const <_Run>[
      _Run('series', true, 50.6, 51.7, 2),
      _Run('number', false, 182, 52, 2),
      _Run('letters', true, 314, 52.7, 2),
      _Run('suffix', true, 460, 52, 1),
    ],
    dots: const <double>[140, 274, 413],
    resolveRegion: CapeVerdeRegions.captionOf,
  );

  static final PlateSpec military = _build(
    id: 'cv.military',
    cy: _Layout.militaryCy,
    box: _Layout.box,
    runs: const <_Run>[
      _Run('first', false, 258.8, 56.5, 2),
      _Run('second', false, 405, 57, 2),
    ],
    dots: const <double>[212.6, 364],
    labels: const <PlateLabel>[_Layout.fa],
    background: const PlateSection.columns(<PlatePart>[
      PlatePart(PlateSection.fill(PlateFill.panel), end: _Layout.flagEnd),
      PlatePart(PlateSection.plain),
    ]),
    panel: _Layout.flagPanel,
  );

  static final PlateSpec diplomatic = _build(
    id: 'cv.diplomatic',
    cy: _Layout.diplomaticCy,
    box: _Layout.diplomaticBox,
    runs: const <_Run>[
      _Run('country', false, 191, 61, 2),
      _Run('serial', false, 346, 51, 3),
    ],
    dots: const <double>[145.6, 300],
    labels: const <PlateLabel>[_Layout.cd],
  );

  static List<PlateSpec> get all => <PlateSpec>[
    regular,
    freeFont,
    military,
    diplomatic,
  ];

  static PlateTheme themeOf(PlateSpec spec) => switch (spec.id) {
    'cv.freeFont' => CapeVerdeThemes.freeFont,
    'cv.diplomatic' => CapeVerdeThemes.diplomatic,
    _ => CapeVerdeThemes.regular,
  };

  static PlateSpec _build({
    required String id,
    required double cy,
    required double box,
    required List<_Run> runs,
    required List<double> dots,
    List<PlateLabel> labels = const <PlateLabel>[],
    PlateSection background = PlateSection.plain,
    PlatePanel? panel,
    PlateLabelResolver? resolveRegion,
  }) {
    final slots = <PlateSlot>[];
    for (final run in runs) {
      slots.add(
        plateRun(
          run.letters ? CapeVerdeAlphabets.letters : CapeVerdeAlphabets.digits,
          run.count,
          left: run.firstCentre - run.pitch / 2,
          top: cy - box / 2,
          pitch: run.pitch,
          height: box,
          group: run.key,
        ),
      );
    }
    return PlateSpec(
      id: id,
      country: CapeVerdeCountry.cape_verde,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      panel: panel ?? const PlatePanel(box: PlateBox(0, 0, 0, 0)),
      noPanel: panel == null,
      background: background,
      slots: slots,
      labels: <PlateLabel>[
        ...labels,
        for (final dx in dots)
          PlateLabel(
            text: '·',
            box: PlateBox.centered(dx, cy, _Layout.dotWidth, box),
            glyphHeight: box,
          ),
      ],
      resolveRegion: resolveRegion,
    );
  }
}

import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'ivory_coast_colors.dart';
import 'ivory_coast_country.dart';
import 'ivory_coast_themes.dart';

/// Where the ink sits, in plate units, off the 520×110 mm references flattened
/// to that size (ink centres of each glyph run):
///
/// * private `1234AB56`, ink y 18.25–90.5: digits at 35.4, 91.4, 148.5, 203.4
///   (pitch 56); `AB` 262.6, 321.7; `56` 375.6, 429.
/// * temporary `123 IT 56`, ink y 17.5–92.75: digits 61.1, 120.2, 177.7;
///   `IT` 241–302.5; `56` 348.4, 404.2.
/// * diplomatic `123 CD 45`, ink y 19.75–93.75: digits 55, 114.2, 171.5;
///   `CD` 243.2, 302.7; `45` 370.9, 422.5.
/// * military `12345`, ink y 19.8–90.5: digits 217.9–444.6 (pitch 56.7); the
///   flag x 47.8–163.3, y 17.7–94.6.
/// * strip: private and temporary from x 470.5, diplomatic from 463.75 (first
///   column matching the strip colour). Emblem ring centre (492.5, 35.25),
///   outer radius 19.5, 2 wide; `CI` ink y 64.5–86.5, centre x 494.
///
/// Ink is ~55% of a slot box, so the reference ink of ~72 would need a box of
/// 130 on a 110-unit plate. The box is 104, which lands the ink near 57.
abstract final class _Layout {
  static const double width = 520, height = 110, box = 104;

  static const double emblemCx = 492.5, emblemCy = 35.25;

  /// The country outline inside the ring, traced from the private plate's
  /// white pixels (contour simplified to 31 vertices), in a 40×40 space
  /// centred on the ring.
  static const List<Offset> outline = <Offset>[
    Offset(10.8, 7.2),
    Offset(9.0, 9.2),
    Offset(10.2, 14.8),
    Offset(8.5, 15.5),
    Offset(9.0, 17.8),
    Offset(7.5, 19.8),
    Offset(8.2, 21.8),
    Offset(7.2, 23.2),
    Offset(7.5, 24.2),
    Offset(12.0, 27.2),
    Offset(10.8, 32.0),
    Offset(12.8, 32.5),
    Offset(20.2, 29.5),
    Offset(23.2, 30.0),
    Offset(26.2, 29.0),
    Offset(28.5, 30.0),
    Offset(29.8, 29.0),
    Offset(30.8, 29.8),
    Offset(31.0, 27.5),
    Offset(29.2, 23.2),
    Offset(31.0, 20.8),
    Offset(31.0, 18.0),
    Offset(32.8, 16.5),
    Offset(31.0, 10.8),
    Offset(28.5, 9.2),
    Offset(24.8, 10.5),
    Offset(23.0, 10.2),
    Offset(20.2, 7.5),
    Offset(17.0, 8.0),
    Offset(16.2, 6.5),
    Offset(14.0, 8.2),
  ];
}

/// One field: its alphabet, the centre of its ink, its pitch and length.
class _Run {
  const _Run(this.key, this.letters, this.centre, this.pitch, this.count);

  final String key;
  final bool letters;
  final double centre, pitch;
  final int count;
}

/// Ivory Coast's plates, all 520×110 mm; the civil ones have the strip and
/// emblem at the right.
///
/// * [private] — white on blue, `1234 AB 56`; the last two digits are the
///   region of origin.
/// * [temporary] — white on green, `123 IT 56`.
/// * [diplomatic] — black on orange over a white strip, `123 CD 45`.
/// * [military] — white on black: the flag and five digits, no frame.
///
/// The fields are fixed length as pictured (the article gives only the private
/// format). Not implemented: the green sticker line along the temporary
/// plate's bottom edge.
abstract final class IvoryCoastPlates {
  static final PlateSpec private = _civil(
    id: 'ci.private',
    stripFrom: 470.5,
    cy: 54.4,
    emblem: IvoryCoastColors.white,
    runs: const <_Run>[
      _Run('number', false, 119.9, 56, 4),
      _Run('series', true, 292.2, 59, 2),
      _Run('region', false, 402.3, 53.4, 2),
    ],
  );

  static final PlateSpec temporary = _civil(
    id: 'ci.temporary',
    stripFrom: 470.5,
    cy: 55.1,
    emblem: IvoryCoastColors.white,
    runs: const <_Run>[
      _Run('number', false, 120.2, 57.5, 3),
      _Run('series', true, 270, 46, 2),
      _Run('region', false, 376.3, 55.8, 2),
    ],
  );

  static final PlateSpec diplomatic = _civil(
    id: 'ci.diplomatic',
    stripFrom: 463.75,
    cy: 56.8,
    emblem: IvoryCoastColors.black,
    runs: const <_Run>[
      _Run('number', false, 114.2, 57.3, 3),
      _Run('series', true, 273, 59.5, 2),
      _Run('region', false, 396.7, 51.6, 2),
    ],
  );

  static final PlateSpec military = _build(
    id: 'ci.military',
    cy: 55.1,
    runs: const <_Run>[_Run('number', false, 333.4, 57, 5)],
    decals: const <PlateDecal>[
      PlateDecal(
        drawing: IvoryCoastCountry.flag,
        box: PlateBox(47.8, 17.7, 115.5, 76.9),
      ),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    diplomatic,
    temporary,
    military,
  ];

  /// The theme each spec is drawn in.
  static PlateTheme themeOf(PlateSpec spec) => switch (spec.id) {
    'ci.diplomatic' => IvoryCoastThemes.diplomatic,
    'ci.temporary' => IvoryCoastThemes.temporary,
    'ci.military' => IvoryCoastThemes.military,
    _ => IvoryCoastThemes.private,
  };

  /// A strip at the right in the theme's divider colour, run out under the
  /// frame, with the emblem and `CI` on it.
  static PlateSpec _civil({
    required String id,
    required double stripFrom,
    required double cy,
    required Color emblem,
    required List<_Run> runs,
  }) => _build(
    id: id,
    cy: cy,
    runs: runs,
    background: PlateSection.columns(<PlatePart>[
      PlatePart(PlateSection.plain, end: stripFrom),
      const PlatePart(PlateSection.fill(PlateFill.divider)),
    ]),
    labels: const <PlateLabel>[
      PlateLabel(text: 'CI', box: PlateBox(469, 55.5, 50, 40), glyphHeight: 40),
    ],
    decals: <PlateDecal>[
      PlateDecal(
        drawing: PlateDrawing(40, 40, <PlateShape>[
          PlateRingShape(20, 20, 18.5, 2, emblem),
          PlatePolygonShape(_Layout.outline, emblem),
        ]),
        box: PlateBox(_Layout.emblemCx - 20, _Layout.emblemCy - 20, 40, 40),
      ),
    ],
  );

  static PlateSpec _build({
    required String id,
    required double cy,
    required List<_Run> runs,
    PlateSection background = PlateSection.plain,
    List<PlateLabel> labels = const <PlateLabel>[],
    List<PlateDecal> decals = const <PlateDecal>[],
  }) {
    final slots = <PlateSlot>[];
    for (final run in runs) {
      slots.add(
        plateRun(
          run.letters
              ? IvoryCoastAlphabets.letters
              : IvoryCoastAlphabets.digits,
          run.count,
          centre: run.centre,
          top: cy - _Layout.box / 2,
          pitch: run.pitch,
          height: _Layout.box,
          group: run.key,
        ),
      );
    }
    return PlateSpec(
      id: id,
      country: IvoryCoastCountry.ivory_coast,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      background: background,
      slots: slots,
      labels: labels,
      decals: decals,
    );
  }
}

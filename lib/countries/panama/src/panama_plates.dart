import 'dart:ui';

import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'panama_colors.dart';
import 'panama_country.dart';

/// Where the ink sits, in plate units.
///
/// Every reference is a photograph flattened to 300×150 (the article's
/// 300 × 150 mm) by `tools/platekit` and projected onto each axis. The ink is
/// ~55% of a slot's box, so boxes are ink / 0.55, capped by the canvas.
///
/// Car (`2016_Panama_License_Plate`): blue band y 0–38; caption ink x 89.8–209.8,
/// y 11.5–31.5; six digits x 24.5–275.8, y 39.8–110.5 (70.7 tall, pitch ≈ 44);
/// year ink x 114.8–181.8, y 117.8–138.8. The 110-unit digit box gives ~60 of
/// ink, about 85% of the reference: a 128 box would leave no room for the rows
/// either side.
///
/// Motorcycle (`A_motorcycle_license_plate_of_Panama_seen_in_Liechtenstein`):
/// grey-green band y 0–35; caption ink x ~90–210, y ~15–32; `M` x 35.5–60.8,
/// y 41.2–94.5; diamond x 77.5–87.5, y 56.5–77; five digits x 104.2–264.8
/// (pitch ≈ 34); year ink x ~115–183, y ~100–118.
abstract final class _Layout {
  static const double width = 300, height = 150;

  static const double carBandEnd = 38, carCaptionCy = 21.5, carCaptionBox = 36;
  static const PlateBox carSerial = PlateBox(17.9, 20.2, 264, 110);
  static const double carYearCy = 128.3, carYearBox = 38;

  static const double motoBandEnd = 35;
  static const double motoCaptionCy = 23.5, motoCaptionBox = 34;
  static const PlateBox motoClass = PlateBox(16, 19.8, 64, 96);
  static const PlateBox motoSerial = PlateBox(99.6, 23.8, 170, 88);
  static const PlateBox motoDiamond = PlateBox(77.5, 56.5, 10, 20.5);
  static const double motoYearCy = 109, motoYearBox = 34;
}

/// Panama's current plates, one builder for the car design and one for the
/// motorcycle. Colour is the theme's: [car] with [PanamaThemes.car], [plain]
/// with [PanamaThemes.cream], [motorcycle] with [PanamaThemes.motorcycle].
///
/// The month sticker and the state emblem are not drawn. The `AB1234` format
/// issued from 2013 and the 1942–1993 series (caption above, slogan below)
/// are not implemented: the article's captions name no current plate for them
/// and no 2013+ reference was measured. Nothing Israel-specific exists.
abstract final class PanamaPlates {
  /// 2016: six digits under a blue band, year below.
  static final PlateSpec car = _car(
    'pa.car',
    year: '2016',
    band: PanamaColors.band,
  );

  /// 2007–2008: the same rows with no band, year below.
  static final PlateSpec plain = _car('pa.plain', year: '2008');

  /// 2018 motorcycle: `M`, a diamond, five digits.
  static final PlateSpec motorcycle = PlateSpec(
    id: 'pa.motorcycle',
    country: PanamaCountry.panama,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    background: _band(_Layout.motoBandEnd, PanamaColors.motoBand),
    slots: const <PlateSlot>[
      PlateSlot(
        alphabet: PanamaAlphabets.letters,
        box: _Layout.motoClass,
        group: 'class',
      ),
      PlateSlot(
        alphabet: PanamaAlphabets.digits,
        box: _Layout.motoSerial,
        length: 5,
        group: 'serial',
      ),
    ],
    labels: <PlateLabel>[
      _label('PANAMA', _Layout.motoCaptionCy, _Layout.motoCaptionBox),
      _label('2018', _Layout.motoYearCy, _Layout.motoYearBox),
    ],
    decals: const <PlateDecal>[
      PlateDecal(
        box: _Layout.motoDiamond,
        drawing: PlateDrawing(10, 20.5, <PlateShape>[
          PlatePolygonShape(<Offset>[
            Offset(5, 0),
            Offset(10, 10.25),
            Offset(5, 20.5),
            Offset(0, 10.25),
          ], PanamaColors.motoBlack),
        ]),
      ),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[car, plain, motorcycle];

  static PlateSection _band(double end, Color color) =>
      PlateSection.rows(<PlatePart>[
        PlatePart(PlateSection.fill(PlateFill.color(color)), end: end),
        const PlatePart(PlateSection.plain),
      ]);

  static PlateLabel _label(String text, double cy, double box) => PlateLabel(
    text: text,
    box: PlateBox(70, cy - box / 2, 160, box),
    glyphHeight: box,
  );

  static PlateSpec _car(String id, {required String year, Color? band}) =>
      PlateSpec(
        id: id,
        country: PanamaCountry.panama,
        canvasWidth: _Layout.width,
        canvasHeight: _Layout.height,
        background: band == null
            ? PlateSection.plain
            : _band(_Layout.carBandEnd, band),
        slots: const <PlateSlot>[
          PlateSlot(
            alphabet: PanamaAlphabets.digits,
            box: _Layout.carSerial,
            length: 6,
            group: 'serial',
          ),
        ],
        labels: <PlateLabel>[
          _label('PANAMA', _Layout.carCaptionCy, _Layout.carCaptionBox),
          _label(year, _Layout.carYearCy, _Layout.carYearBox),
        ],
      );
}

import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'uganda_colors.dart';
import 'uganda_country.dart';

/// Where the ink sits, in plate units. The article gives no size, so the
/// canvas is the photograph's flattened rectangle, 520x110 at 4 px per unit
/// (`.plateref/ug/flat_*`).
///
/// Measured ink: flag x 20.8–100.2 y 8–26; `UP` x 197.8–383.2 y 7.5–52.2
/// (cap height 44.7); `2938` x 122–408 y 58.5–101.2 (cap height 42.7).
///
/// Ink is only ~0.52 of a slot's height, so 44-tall ink would need an
/// 86-unit box. Row 1 is centred at y 29.9, which caps its box at 59.7 (ink
/// ~31, about 70% of reference); row 2 is centred at y 79.9, capped at 60.2.
/// The two boxes overlap by ~10 units, which is harmless as the ink does not.
abstract final class _Layout {
  static const double width = 520, height = 110;

  static const PlateBox flag = PlateBox(20.8, 8, 79.4, 18);

  static const double seriesTop = 0, seriesHeight = 59.7;
  static const double seriesLeft = 197.8, seriesWidth = 185.4;
  static const double seriesPitch = 92.7;

  // Four digits measured over 286 (pitch 71.5); the box is widened to the
  // five the article's `UP 00001` shows, centred on the same x (265).
  static const double numberTop = 49.8, numberHeight = 60.2, numberPitch = 71.5;
  static const double numberWidth = 5 * numberPitch;
  static const double numberLeft = 265 - numberWidth / 2;
}

/// [police] is `UP 2938`, the photographed police ambulance plate (groups
/// `series`, `number`). The prison service's `UU` series shares the design.
///
/// Not implemented: the digital `UG 01 00001` government series, which the
/// article lists in a table with no picture to measure, and the c. 1990
/// foreign-agency (`UZO`) plate, a historical series. The crane on the flag is
/// too small to see on the plate and is left out.
abstract final class UgandaPlates {
  static const PlateDrawing _flag = PlateDrawing(80, 18, <PlateShape>[
    PlateRectShape(0, 0, 80, 3, UgandaColors.flagBlack),
    PlateRectShape(0, 3, 80, 3, UgandaColors.flagYellow),
    PlateRectShape(0, 6, 80, 3, UgandaColors.flagRed),
    PlateRectShape(0, 9, 80, 3, UgandaColors.flagBlack),
    PlateRectShape(0, 12, 80, 3, UgandaColors.flagYellow),
    PlateRectShape(0, 15, 80, 3, UgandaColors.flagRed),
  ]);

  static final PlateSpec police = PlateSpec(
    id: 'ug.police',
    country: UgandaCountry.uganda,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    background: PlateSection.plain,
    decals: const <PlateDecal>[PlateDecal(drawing: _flag, box: _Layout.flag)],
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: UgandaAlphabets.letters,
        box: const PlateBox(
          _Layout.seriesLeft,
          _Layout.seriesTop,
          _Layout.seriesWidth,
          _Layout.seriesHeight,
        ),
        length: 2,
        spacing: _spacing(_Layout.seriesPitch, _Layout.seriesHeight),
        group: 'series',
      ),
      PlateSlot(
        alphabet: UgandaAlphabets.digits,
        box: const PlateBox(
          _Layout.numberLeft,
          _Layout.numberTop,
          _Layout.numberWidth,
          _Layout.numberHeight,
        ),
        length: 5,
        minLength: 4,
        spacing: _spacing(_Layout.numberPitch, _Layout.numberHeight),
        group: 'number',
      ),
    ],
  );

  static double _spacing(double pitch, double height) =>
      plateRunSpacing(pitch, height);
}

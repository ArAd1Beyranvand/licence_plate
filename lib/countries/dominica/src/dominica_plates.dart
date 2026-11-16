import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'dominica_country.dart';

/// Measured from the photo, whose aspect (3.22) wins over the 300×152 mm
/// stated size. Screw holes are not drawn.
///
/// Matching the photo's digit height would need a ~140 tall box, but a slot
/// must lie inside the canvas, so the box is the full 93 and the digits are
/// about 65% of the photo's height.
abstract final class _Layout {
  static const double width = 300, height = 93;
  static const double serialLeft = 59, serialWidth = 174.2, serialCount = 3;
}

/// Silver digits on black, three of them. Text group: `serial`.
///
/// The type letter and yellow rear plate described in prose are not shown in
/// the photo, so only the black digits-only plate exists.
abstract final class DominicaPlates {
  static final PlateSpec regular = PlateSpec(
    id: 'dm.regular',
    country: DominicaCountry.dominica,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    borderWidthRatioOverride: 0,
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: DominicaAlphabets.digits,
        box: const PlateBox(
          _Layout.serialLeft,
          0,
          _Layout.serialWidth,
          _Layout.height,
        ),
        length: 3,
        spacing: plateRunSpacing(
          _Layout.serialWidth / _Layout.serialCount,
          _Layout.height,
        ),
        group: 'serial',
      ),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[regular];
}

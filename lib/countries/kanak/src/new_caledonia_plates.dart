import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'new_caledonia_country.dart';

/// Measured off `NC_2019_license_plate.png` (2080×440 normalised to 520×110):
/// six digits x 32.5–355.2 (pitch ~54), the printed "NC" x 408.5–493; ink y
/// 18–98 (80 tall). Ink is ~55% of the box, so the box uses the full height
/// and the ink comes out ~74% of the reference.
abstract final class _Layout {
  static const double width = 520, height = 110, rowTop = 0, rowHeight = 110;
}

abstract final class NewCaledoniaPlates {
  static const double _pitch = (355.2 - 32.5) / 6;

  static final PlateSpec private = PlateSpec(
    id: 'nc.private',
    country: NewCaledoniaCountry.new_caledonia,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
    background: PlateSection.plain,
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: NewCaledoniaAlphabets.digits,
        box: const PlateBox(
          32.5,
          _Layout.rowTop,
          355.2 - 32.5,
          _Layout.rowHeight,
        ),
        length: 6,
        spacing: plateRunSpacing(_pitch, _Layout.rowHeight),
        group: 'number',
      ),
    ],
    labels: const <PlateLabel>[
      PlateLabel(text: 'NC', box: PlateBox(400, 0, 101, 110), glyphHeight: 80),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[private];
}

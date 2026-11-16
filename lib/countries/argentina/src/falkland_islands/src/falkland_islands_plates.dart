import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'falkland_islands_country.dart';

/// Measured off `Falkland_Island_vehicle_registration_plate_front_and_rear.png`
/// (2000 px wide, normalised to 520×111): ink x 92–419; "F" 92–146, digits
/// 158–350 (three), serial letter 364–419. Government plates replace the letter
/// with a fourth digit. Ink is ~55% of the box, so the box uses the full row.
abstract final class _Layout {
  static const double width = 520, height = 111, rowTop = 3, rowHeight = 105;
}

abstract final class FalklandIslandsPlates {
  static PlateSlot _slot(
    PlateAlphabet a,
    double left,
    double right,
    int length, {
    int? minLength,
  }) {
    final double pitch = (right - left) / length;
    return PlateSlot(
      alphabet: a,
      box: PlateBox(left, _Layout.rowTop, right - left, _Layout.rowHeight),
      length: length,
      minLength: minLength ?? length,
      spacing: length == 1 ? 0 : plateRunSpacing(pitch, _Layout.rowHeight),
    );
  }

  static PlateSpec _spec(String id, List<PlateSlot> slots, List<String> keys) =>
      PlateSpec(
        id: id,
        country: FalklandIslandsCountry.falkland_islands,
        canvasWidth: _Layout.width,
        canvasHeight: _Layout.height,
        noPanel: true,
        panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
        background: PlateSection.plain,
        slots: slots,
        textGroups: <PlateTextGroup>[
          for (var i = 0; i < keys.length; i++)
            PlateTextGroup(<int>[i], key: keys[i]),
        ],
      );

  static final PlateSpec private = _spec(
    'fk.private',
    <PlateSlot>[
      _slot(FalklandIslandsAlphabets.prefix, 92, 146, 1),
      _slot(FalklandIslandsAlphabets.digits, 158, 350, 3, minLength: 1),
      _slot(FalklandIslandsAlphabets.letters, 364, 419, 1),
    ],
    const <String>['prefix', 'digits', 'letter'],
  );

  static final PlateSpec government = _spec(
    'fk.government',
    <PlateSlot>[
      _slot(FalklandIslandsAlphabets.prefix, 92, 146, 1),
      _slot(FalklandIslandsAlphabets.digits, 158, 419, 4),
    ],
    const <String>['prefix', 'digits'],
  );

  static List<PlateSpec> get all => <PlateSpec>[private, government];
}

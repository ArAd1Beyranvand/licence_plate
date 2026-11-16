import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'mauritius_colors.dart';
import 'mauritius_country.dart';

/// Where the ink sits, in plate units.
///
/// The photo flattened to 520x105 (aspect 4.96 as measured; the article
/// gives no size). Ink y 7.5-101 (h 93), letters x 23.5-162.8 (pitch 70),
/// digits x 206-499 (pitch 73.25). That ink needs a ~170-unit box; the box
/// is capped at the 105-unit canvas, so ink lands at ~60% of the reference.
/// Badge "MAURITIUS": x 340-391, y 5-12.5.
abstract final class _Layout {
  static const double width = 520, height = 105, box = height;

  static const PlateBox letters = PlateBox(23, 0, 140, box);
  static const PlateBox digits = PlateBox(206, 0, 293, box);
  static const double letterPitch = 70, digitPitch = 73.25;

  static const PlateBox badge = PlateBox(340, 5, 51, 7.5);
  static const double badgeGlyph = 11;
}

PlateSlot _slot(
  PlateAlphabet alphabet,
  PlateBox box,
  int length,
  double pitch,
) => PlateSlot(
  alphabet: alphabet,
  box: box,
  length: length,
  spacing: plateRunSpacing(pitch, _Layout.box),
);

/// Mauritius's government plate: two letters and four digits (`GM 3345`),
/// raised silver on black. Groups `letters`, `serial`.
abstract final class MauritiusPlates {
  static final PlateSpec government = PlateSpec(
    id: 'mu.government',
    country: MauritiusCountry.mauritius,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    bands: const <PlateBand>[
      PlateBand(box: _Layout.badge, color: MauritiusColors.badge),
    ],
    slots: <PlateSlot>[
      _slot(
        MauritiusAlphabets.letters,
        _Layout.letters,
        2,
        _Layout.letterPitch,
      ),
      _slot(MauritiusAlphabets.digits, _Layout.digits, 4, _Layout.digitPitch),
    ],
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'MAURITIUS',
        box: _Layout.badge,
        glyphHeight: _Layout.badgeGlyph,
        color: MauritiusColors.badgeText,
      ),
    ],
    textGroups: PlateTextGroup.perSlot(<String>['letters', 'serial']),
  );

  static List<PlateSpec> get all => <PlateSpec>[government];
}

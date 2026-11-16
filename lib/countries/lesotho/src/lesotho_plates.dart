import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'lesotho_colors.dart';
import 'lesotho_country.dart';

/// Plate units, scaled from the 2080x440 reference photo to 520x131 (x by
/// 0.25, y by 0.3157). The reference ink would need a 160-unit box; the box is
/// capped at the canvas height (126), so ink lands at ~70% of the reference.
abstract final class _Layout {
  static const double width = 520, height = 131, box = 126;

  static const PlateBox letters = PlateBox(112, 0, 125, box);

  static const PlateBox digits = PlateBox(243, 0, 254, box);
  static const double digitPitch = 63.5;

  static const PlateBox sticker = PlateBox(9, 3, 103, 122);

  /// Drawn narrower than in the photo (68 vs 79) to keep the artwork's
  /// proportions.
  static const PlateBox hat = PlateBox(26, 11, 68, 81);
  static const PlateBox country = PlateBox(21, 100, 82, 16);
  static const PlateBox month = PlateBox(18, 24, 24, 16);
  static const PlateBox year = PlateBox(78, 24, 24, 16);
  static const double countryGlyph = 24, dateGlyph = 20;
}

/// The private plate (`A 1705`) with the mokorotlo validity sticker at the
/// left. Groups `letters`, `serial`.
///
/// Government, dealer, diplomatic and pre-1979 plates are absent: no reference
/// was measured.
abstract final class LesothoPlates {
  static final PlateSpec private = PlateSpec(
    id: 'ls.private',
    country: LesothoCountry.lesotho,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    bands: const <PlateBand>[
      PlateBand(
        box: _Layout.sticker,
        color: LesothoColors.sticker,
        topCornerRadius: 3,
        bottomCornerRadius: 3,
      ),
    ],
    slots: <PlateSlot>[
      const PlateSlot(
        alphabet: LesothoAlphabets.letters,
        box: _Layout.letters,
        length: 2,
        minLength: 1,
        group: 'letters',
      ),
      PlateSlot(
        alphabet: LesothoAlphabets.digits,
        box: _Layout.digits,
        length: 4,
        spacing: plateRunSpacing(_Layout.digitPitch, _Layout.box),
        group: 'serial',
      ),
    ],
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'LESOTHO',
        box: _Layout.country,
        glyphHeight: _Layout.countryGlyph,
        color: LesothoColors.blue,
      ),
      PlateLabel(
        text: '01',
        box: _Layout.month,
        glyphHeight: _Layout.dateGlyph,
        color: LesothoColors.blue,
      ),
      PlateLabel(
        text: '06',
        box: _Layout.year,
        glyphHeight: _Layout.dateGlyph,
        color: LesothoColors.blue,
      ),
    ],
    // Mokorotlo hat cropped from the national flag (rasterised from the SVG).
    decals: const <PlateDecal>[
      PlateDecal(
        image: AssetImage(
          'assets/countries/lesotho/icons/lesotho_mokorotlo.png',
          package: 'license_plate',
        ),
        box: _Layout.hat,
      ),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[private];
}

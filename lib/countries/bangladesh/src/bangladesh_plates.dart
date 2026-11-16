import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'bangladesh_country.dart';
import 'bangladesh_themes.dart';

/// Where the ink sits, in plate units, on the 300×152 mm car plate.
///
/// The only reference is one photograph that the offline flattening could not
/// square (it is cropped and skewed), so the positions are not pixel-measured:
/// the photograph gives two rows, the city and class on the upper (ink y
/// 10.5–45) and the series and number on the lower, large row (ink about y
/// 62–135), with a dash between the city and class and between series and
/// number. The x extents are laid out to fit six Bengali digits at an even
/// pitch and the widest city name; they are estimates, to be checked against
/// the goldens.
abstract final class _Layout {
  static const double width = 300, height = 152;

  static const double topCy = 36, topBox = 56, bottomCy = 102, bottomBox = 84;

  static const PlateBox city = PlateBox(14, 8, 196, 56);
  static const PlateBox classLetter = PlateBox(232, 8, 54, 56);
  static const double topDashCx = 220;

  /// Series then number on the lower row: two digits, a dash, four digits.
  static const double pitch = 42, seriesLeft = 14, numberLeft = 126;
  static const double bottomDashCx = 114;

  static const double markWidth = 20;
}

/// Bangladesh's car plate: Bengali city and class over a two-digit series and
/// a four-digit number (`ঢাকা মেট্রো-গ` / `১১-৯৯৯৯`). Groups `city`, `class`,
/// `series`, `number`.
///
/// Private, commercial and electric vehicles share it; only the theme differs
/// (black on white, black on green, white on green).
///
/// Not implemented: the diplomatic, army, air force, navy, police and city
/// corporation plates (the article shows their text but no picture to measure),
/// the other plate sizes, and the pre-2012 plates.
abstract final class BangladeshPlates {
  static final PlateSpec car = _car();

  static PlateSpec get private => car;
  static PlateSpec get commercial => car;
  static PlateSpec get electric => car;

  static List<PlateSpec> get all => <PlateSpec>[car];

  static PlateTheme themeOf(String category) => switch (category) {
    'commercial' => BangladeshThemes.commercial,
    'electric' => BangladeshThemes.electric,
    _ => BangladeshThemes.private,
  };

  static PlateLabel _dash(double cx, double cy, double box) => PlateLabel(
    text: '-',
    box: PlateBox.centered(cx, cy, _Layout.markWidth, box),
    glyphHeight: box,
  );

  static PlateSpec _car() {
    final double spacing = plateRunSpacing(_Layout.pitch, _Layout.bottomBox);
    return PlateSpec(
      id: 'bd.car',
      country: BangladeshCountry.bangladesh,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      slots: <PlateSlot>[
        const PlateSlot(
          alphabet: BangladeshAlphabets.city,
          box: _Layout.city,
          length: 1,
          group: 'city',
        ),
        const PlateSlot(
          alphabet: BangladeshAlphabets.vehicleClass,
          box: _Layout.classLetter,
          length: 1,
          group: 'class',
        ),
        PlateSlot(
          alphabet: BangladeshAlphabets.digits,
          box: PlateBox(
            _Layout.seriesLeft,
            _Layout.bottomCy - _Layout.bottomBox / 2,
            2 * _Layout.pitch,
            _Layout.bottomBox,
          ),
          length: 2,
          spacing: spacing,
          group: 'series',
        ),
        PlateSlot(
          alphabet: BangladeshAlphabets.digits,
          box: PlateBox(
            _Layout.numberLeft,
            _Layout.bottomCy - _Layout.bottomBox / 2,
            4 * _Layout.pitch,
            _Layout.bottomBox,
          ),
          length: 4,
          spacing: spacing,
          group: 'number',
        ),
      ],
      labels: <PlateLabel>[
        _dash(_Layout.topDashCx, _Layout.topCy, _Layout.topBox),
        _dash(_Layout.bottomDashCx, _Layout.bottomCy, _Layout.bottomBox),
      ],
    );
  }
}

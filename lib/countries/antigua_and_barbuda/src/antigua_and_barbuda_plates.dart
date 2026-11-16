import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'antigua_and_barbuda_colors.dart';
import 'antigua_and_barbuda_country.dart';

/// Where the ink sits on one design, in plate units (300x152 mm, the North
/// American size; the offline stage flattened every photo to it).
///
/// A slot's box height is its glyph height and the text is scaled down to the
/// box width, so a box is capped where its digits fit the measured span
/// (advance 0.6 * 0.72 * height). The printed digits are condensed, which the
/// engine cannot draw, so ink lands at 55-65% of the reference height.
class _Design {
  const _Design({
    required this.id,
    required this.letter,
    required this.digits,
    required this.digitCount,
    this.slogan,
    this.sloganGlyph = 0,
    this.sticker = false,
    this.caption = false,
  });

  final String id;
  final PlateBox letter, digits;
  final int digitCount;

  final PlateBox? slogan;
  final double sloganGlyph;
  final bool sticker, caption;
}

abstract final class _Layout {
  static const double width = 300, height = 152;

  /// Private, `Antigua_license_plate_graphic`: serial ink y 38.5-115, letter
  /// x 41-77, digits x 100-259 (read off the flat); slogan ink y 120.5-136,
  /// x 55-245 (h 15.5); caption ink y 10.5-30, `ANTIGUA` x 35-124,
  /// `BARBUDA` x 161-266; arms x 133.5-151 y 8.5-30.5.
  static const _Design private = _Design(
    id: 'ag.private',
    letter: PlateBox(36, 30, 46, 92),
    digits: PlateBox(100, 30, 159, 92),
    digitCount: 4,
    slogan: PlateBox(55, 120, 190, 16),
    sloganGlyph: 24,
    caption: true,
  );

  /// Government, the 2000s gold photo: serial ink y 42-112, letter x 55-85,
  /// three digits x 131-234; slogan ink y 125-140.5, x 63.5-229.5.
  static const _Design government = _Design(
    id: 'ag.government',
    letter: PlateBox(55, 37, 31, 79),
    digits: PlateBox(131, 37, 103, 79),
    digitCount: 3,
    slogan: PlateBox(63, 124, 167, 17),
    sloganGlyph: 20,
  );

  /// Taxi: ink y 10.5-131, letter x 28-65, digits x 102-274.5. The photo's
  /// fit is CHECK.
  static const _Design taxi = _Design(
    id: 'ag.taxi',
    letter: PlateBox(28, 21, 37, 100),
    digits: PlateBox(102, 21, 172, 100),
    digitCount: 4,
    sticker: true,
  );

  static const PlateBox arms = PlateBox(133.5, 8.5, 17.5, 22);
  static const PlateBox antigua = PlateBox(34, 8, 90, 24);
  static const PlateBox barbuda = PlateBox(161, 8, 105, 24);
  static const double captionGlyph = 30;

  static const PlateBox tab = PlateBox(67, 5.5, 25.5, 14);
  static const double tabGlyph = 8;
}

PlateSpec _plate(_Design d) {
  final PlateBox? slogan = d.slogan;
  return PlateSpec(
    id: d.id,
    country: AntiguaAndBarbudaCountry.antigua_and_barbuda,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    bands: <PlateBand>[
      if (d.sticker)
        const PlateBand(
          box: _Layout.tab,
          color: AntiguaAndBarbudaColors.sticker,
          topCornerRadius: 2,
          bottomCornerRadius: 2,
        ),
    ],
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: AntiguaAndBarbudaAlphabets.letters,
        box: d.letter,
        group: 'letter',
      ),
      PlateSlot(
        alphabet: AntiguaAndBarbudaAlphabets.digits,
        box: d.digits,
        length: d.digitCount,
        minLength: 1,
        spacing: plateRunSpacing(
          d.digits.width / d.digitCount,
          d.digits.height,
        ),
        group: 'serial',
      ),
    ],
    labels: <PlateLabel>[
      if (d.caption) ...const <PlateLabel>[
        PlateLabel(
          text: 'ANTIGUA',
          box: _Layout.antigua,
          glyphHeight: _Layout.captionGlyph,
        ),
        PlateLabel(
          text: 'BARBUDA',
          box: _Layout.barbuda,
          glyphHeight: _Layout.captionGlyph,
        ),
      ],
      if (slogan != null)
        PlateLabel(
          text: 'LAND OF SEA AND SUN',
          box: slogan,
          glyphHeight: d.sloganGlyph,
        ),
      if (d.sticker)
        const PlateLabel(
          text: 'ANTIGUA',
          box: _Layout.tab,
          glyphHeight: _Layout.tabGlyph,
          color: AntiguaAndBarbudaColors.cream,
        ),
    ],
    // Coat of arms, https://commons.wikimedia.org/wiki/File:Coat_of_arms_of_Antigua_and_Barbuda.svg
    // (`assets/icons/antigua_coat_of_arms.svg`), rasterised and greyed to the
    // single dark print of the graphic. A crest, so a decal.
    decals: <PlateDecal>[
      if (d.caption)
        const PlateDecal(
          image: AssetImage(
            'assets/countries/antigua_and_barbuda/icons/antigua_coat_of_arms.png',
            package: 'license_plate',
          ),
          box: _Layout.arms,
        ),
    ],
  );
}

/// A class letter and a number (`A 1234`); groups `letter`, `serial`.
abstract final class AntiguaAndBarbudaPlates {
  static final PlateSpec private = _plate(_Layout.private);

  static final PlateSpec government = _plate(_Layout.government);

  static final PlateSpec taxi = _plate(_Layout.taxi);

  static List<PlateSpec> get all => <PlateSpec>[private, government, taxi];
}

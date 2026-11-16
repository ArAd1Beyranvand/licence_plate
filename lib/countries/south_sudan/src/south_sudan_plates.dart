import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'south_sudan_country.dart';

/// Where the ink sits, in plate units.
///
/// The article gives no size and no image. Everything is off two
/// worldlicenseplates.com photographs (`AF_SSUD_GI` private, `AF_SSUD_OT`
/// taxi), each plate cropped 169×89 px and scaled ×2 to a 340×180 canvas.
/// The aspect (1.9) is the photographs'; the plate's physical size is unknown.
///
/// Private (px, plate origin at 3,2, then ×2): the flag x 8..42, y 8..31;
/// `SSD` ink y 8..38, x 66..136; digits ink y 50..80, x 15..85, pitch 25.5;
/// letters x 108..153. The taxi photo is the same design with the text block
/// ~10 px (20 units) further right.
///
/// **Under-height ink, accepted.** The reference ink is 60 units tall; that
/// would need a ~113-unit slot and two rows do not fit in 180. The slots are
/// 88 tall, so the ink lands near 47, about 78% of the photograph. The glyph
/// is then width-limited by the 51-unit pitch. `plate_core` is unchanged.
///
/// **Fields, not cells.** The digits are one slot and the letters another;
/// `spacing` brings the font's advance up to the measured pitch. `SSD` is
/// fixed text, a label.
abstract final class _Layout {
  static const double width = 340, height = 180;

  static const double flagLeft = 16, flagTop = 17;
  static const double flagWidth = 68, flagHeight = 34;

  static const double rowBox = 88, row1Top = 2, row2Top = 86;

  static const double sddLeft = 132, sddWidth = 140, sddGlyph = 88;

  static const double pitch = 51, digitsLeft = 24, lettersLeft = 212;

  static const double taxiShift = 20;
}

/// South Sudan's 2017 plates: `SSD` over three digits and one or two letters.
/// Groups `serial` (digits) and `letters`. Colour is the theme's: [private]
/// with [SouthSudanThemes.private], [taxi] with [SouthSudanThemes.taxi].
///
/// Not implemented: the 2005 series (CE/GOSS/SSWE regional and government
/// plates), the 2017 NGO plate (`NGO 17 / 19 RSS`), the 2020 government
/// motorcycle plate and the 2020 plate with a state roundel (`JB`, a rhino
/// crest with no vector available). The article names no Israel-specific
/// value.
abstract final class SouthSudanPlates {
  static final PlateSpec private = _spec('ss.private', 0);
  static final PlateSpec taxi = _spec('ss.taxi', _Layout.taxiShift);

  static List<PlateSpec> get all => <PlateSpec>[private, taxi];

  static PlateSpec _spec(String id, double shift) => PlateSpec(
    id: id,
    country: SouthSudanCountry.south_sudan,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    slots: <PlateSlot>[
      plateRun(
        SouthSudanAlphabets.digits,
        3,
        left: _Layout.digitsLeft + shift,
        top: _Layout.row2Top,
        pitch: _Layout.pitch,
        height: _Layout.rowBox,
        group: 'serial',
      ),
      plateRun(
        SouthSudanAlphabets.letters,
        2,
        left: _Layout.lettersLeft + shift,
        top: _Layout.row2Top,
        pitch: _Layout.pitch,
        height: _Layout.rowBox,
        minLength: 1,
        group: 'letters',
      ),
    ],
    labels: <PlateLabel>[
      PlateLabel(
        text: 'SSD',
        box: PlateBox(
          _Layout.sddLeft + shift,
          _Layout.row1Top,
          _Layout.sddWidth,
          _Layout.rowBox,
        ),
        glyphHeight: _Layout.sddGlyph,
      ),
    ],
    decals: const <PlateDecal>[
      PlateDecal(
        drawing: SouthSudanCountry.flagDrawing,
        box: PlateBox(
          _Layout.flagLeft,
          _Layout.flagTop,
          _Layout.flagWidth,
          _Layout.flagHeight,
        ),
      ),
    ],
  );
}

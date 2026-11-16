import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'tuvalu_country.dart';

/// Where the ink sits, in plate units.
///
/// `Tuvalu_license_plate_graphic` is a 500×180 drawing (the offline fit is
/// CHECK and its flattened sheet is a mis-crop, so the original was measured
/// instead), scaled by 0.744 to the article's 372×134 mm. Ink y 43–140 →
/// 32–104 (72 tall, cy 68.1). Glyph runs: `AO` x 48–178 → 35.7–132.4; `1792`
/// x 221–456 → 164–339.3. The `1` is a narrow glyph, so the digit cell starts
/// earlier, at 157.4 (one 48.7 pitch before the `7` at 277 → 206).
///
/// The picture's split (two letters, four digits) is what the infobox's
/// `AB1234` means. Ink of 72 would need a ~131-unit box on a 134-unit plate;
/// the box is capped at [box], so ink lands near 90% of the graphic's.
abstract final class _Layout {
  static const double width = 372, height = 134, box = 118, cy = 68.1;
  static const double lettersLeft = 35.7, lettersRight = 132.4;
  static const double digitsLeft = 157.4, digitsRight = 339.3;
}

/// Tuvalu's plate, white on black, `AB 1234` (groups `letters`, `serial`).
/// Pair [standard] with [TuvaluThemes.standard]. The article shows one design
/// and no older plates. It names no Israel-specific value.
abstract final class TuvaluPlates {
  static final PlateSpec standard = PlateSpec(
    id: 'tv.standard',
    country: TuvaluCountry.tuvalu,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    slots: <PlateSlot>[
      _field(
        TuvaluAlphabets.letters,
        _Layout.lettersLeft,
        _Layout.lettersRight,
        2,
      ),
      _field(
        TuvaluAlphabets.digits,
        _Layout.digitsLeft,
        _Layout.digitsRight,
        4,
      ),
    ],
    textGroups: PlateTextGroup.perSlot(<String>['letters', 'serial']),
  );

  static List<PlateSpec> get all => <PlateSpec>[standard];

  /// One field of [length] glyphs spanning [left]..[right]; the spacing brings
  /// the font's ~0.6 em advance up to the printed pitch.
  static PlateSlot _field(
    PlateAlphabet alphabet,
    double left,
    double right,
    int length,
  ) => plateRun(
    alphabet,
    length,
    left: left,
    top: _Layout.cy - _Layout.box / 2,
    pitch: (right - left) / length,
    height: _Layout.box,
  );
}

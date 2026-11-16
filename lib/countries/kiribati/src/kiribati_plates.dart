import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'kiribati_country.dart';

/// Where the ink sits, in plate units.
///
/// Standard (`Kiribati_license_plate_graphic`): flattened to the
/// 520×184 the photo's aspect (2.82) gives — the infobox's 520×110 contradicts
/// the picture, which wins. One row, ink y 43.5–147 (cy 95.25), x 36.2–476.8
/// over six glyphs, so a 73.4 pitch; the letters take the first three, the
/// digits the last three. Ink of 103 would need a ~188-unit box on a 184-unit
/// plate; the box is capped at [rowBox], so ink lands near 70% of the photo's.
///
/// Betio (`Kiribati_license_plate_Betio_graphic`): measured by hand (the
/// offline fit read the arms as the plate) off the original, 392×~126 scaled ×1.327 to 520×167: shield x 13–151, y 12–156;
/// `BTC` x 206–445 (ink y 19–77), `313` x 226–438 (ink y 88–149). Two rows of
/// ink ~58 tall need 105-unit boxes; they are capped at [betioBox], ink ~45.
abstract final class _Layout {
  static const double width = 520, height = 184, rowBox = 130, rowCy = 95.25;
  static const double lettersLeft = 36.2, split = 256.4, digitsRight = 476.8;

  static const double betioWidth = 520, betioHeight = 167;
  static const double betioBox = 80, betioTopCy = 48, betioBottomCy = 118;
  static const double betioLettersLeft = 206, betioLettersRight = 445;
  static const double betioDigitsLeft = 226, betioDigitsRight = 438;
  static const PlateBox arms = PlateBox(13, 12, 138, 144);
}

/// `ABC 123` (groups `letters`, `serial`). [standard] sets both fields on one
/// row inside a frame; [betio] stacks them beside the coat of arms. Pair them
/// with [KiribatiThemes.standard] and [KiribatiThemes.betio].
abstract final class KiribatiPlates {
  static final PlateSpec standard = _spec(
    'ki.standard',
    width: _Layout.width,
    height: _Layout.height,
    slots: <PlateSlot>[
      _field(
        KiribatiAlphabets.letters,
        _Layout.lettersLeft,
        _Layout.split,
        _Layout.rowCy,
        _Layout.rowBox,
      ),
      _field(
        KiribatiAlphabets.digits,
        _Layout.split,
        _Layout.digitsRight,
        _Layout.rowCy,
        _Layout.rowBox,
      ),
    ],
  );

  /// Coat of arms of Kiribati, shield only (the ribbon is not on the plate):
  /// https://commons.wikimedia.org/wiki/File:Coat_of_arms_of_Kiribati.svg
  /// (`assets/icons/kiribati_coat_of_arms.svg`, rasterised and cropped to the
  /// PNG). A crest cannot be drawn from shapes.
  static final PlateSpec betio = _spec(
    'ki.betio',
    width: _Layout.betioWidth,
    height: _Layout.betioHeight,
    slots: <PlateSlot>[
      _field(
        KiribatiAlphabets.letters,
        _Layout.betioLettersLeft,
        _Layout.betioLettersRight,
        _Layout.betioTopCy,
        _Layout.betioBox,
      ),
      _field(
        KiribatiAlphabets.digits,
        _Layout.betioDigitsLeft,
        _Layout.betioDigitsRight,
        _Layout.betioBottomCy,
        _Layout.betioBox,
      ),
    ],
    decals: const <PlateDecal>[
      PlateDecal(
        image: AssetImage(
          'assets/countries/kiribati/icons/kiribati_coat_of_arms.png',
          package: 'license_plate',
        ),
        box: _Layout.arms,
      ),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[standard, betio];

  /// One three-glyph field spanning [left]..[right]; the spacing brings the
  /// font's ~0.6 em advance up to the printed pitch.
  static PlateSlot _field(
    PlateAlphabet alphabet,
    double left,
    double right,
    double cy,
    double box,
  ) => plateRun(
    alphabet,
    3,
    left: left,
    top: cy - box / 2,
    pitch: (right - left) / 3,
    height: box,
  );

  static PlateSpec _spec(
    String id, {
    required double width,
    required double height,
    required List<PlateSlot> slots,
    List<PlateDecal> decals = const <PlateDecal>[],
  }) => PlateSpec(
    id: id,
    country: KiribatiCountry.kiribati,
    canvasWidth: width,
    canvasHeight: height,
    slots: slots,
    decals: decals,
    textGroups: PlateTextGroup.perSlot(<String>['letters', 'serial']),
  );
}

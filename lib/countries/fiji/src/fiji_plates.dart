import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'fiji_country.dart';

/// Where the ink sits, in plate units.
///
/// Cars: the documented 372×134 mm; the flattened photos are in the same
/// units. `Fiji_plate_2012` ink rows y 31–117.2 (cy 74.1); letters x
/// 59.2–150.8, digits x 188.2–330.2; "FIJI" caption ink y 9.2–25.2, centred on
/// the plate. The diamond sits mid-gap at x 169.5.
///
/// `E-0845` (older): ink y 31.8–115.8 (cy 73.8); the letter is x 87.2–129.2,
/// digits x 169.2–354.8. The coat-of-arms sticker at the left is not plate
/// print and is left out.
///
/// Motorcycle (184×95 mm): the photo is CHECK-fitted and shows three plates
/// stacked, so these are ESTIMATES read off the flattened sheet, not
/// projections: ink about 55% of the height, centred, margins about 20.
///
/// Ink is ~52% of a slot box, so the box is as tall as the canvas allows
/// (cy ± 59) and the ink lands near 72% of the 86-unit reference; the
/// references' narrow dies are also narrower than the theme's face, so wide
/// runs scale down to their box.
abstract final class _Layout {
  static const double width = 372, height = 134, carCy = 74.1, carBox = 118;
  static const double letterX = 59.2, letterW = 91.6;
  static const double digitX = 188.2, digitW = 142;
  static const double diamondCx = 169.5, diamondGlyph = 28;

  static const double captionCx = 186, captionCy = 17.2;
  static const double captionW = 100, captionH = 24, captionGlyph = 29;

  static const double legacyCy = 73.8, legacyLetterX = 87.2, legacyLetterW = 42;
  static const double legacyDigitX = 169.2, legacyDigitW = 185.6;
  static const double legacyDiamondCx = 149;

  static const double motoWidth = 184, motoHeight = 95;
  static const double motoBox = 90, motoCy = 47.5;
  static const double motoDigitX = 20, motoDigitW = 92;
  static const double motoLetterX = 116, motoLetterW = 48;
}

/// Fiji's current plates. Groups `letters`, `serial`.
///
/// [general] (two letters, three digits; [FijiThemes.general]) is also the
/// government plate with [FijiThemes.government]. [legacy] is
/// the older one-letter, four-digit plate (`E 0845`). [motorcycle] is digits
/// then a letter, centred, as issued from `001F`.
///
/// Not implemented: the diamond-separated motorcycle series (001–999E), the
/// coat-of-arms stickers, and the steel-base variants with smaller glyphs. The
/// page flag is an illustration, not plate content.
abstract final class FijiPlates {
  static final PlateSpec general = _car('fj.general');

  static final PlateSpec legacy = _spec(
    'fj.legacy',
    _Layout.width,
    _Layout.height,
    letters: _slot(
      FijiAlphabets.letters,
      _Layout.legacyLetterX,
      _Layout.legacyLetterW,
      _Layout.carBox,
      _Layout.legacyCy,
      1,
    ),
    serial: _slot(
      FijiAlphabets.digits,
      _Layout.legacyDigitX,
      _Layout.legacyDigitW,
      _Layout.carBox,
      _Layout.legacyCy,
      4,
    ),
    labels: <PlateLabel>[
      _caption,
      _diamond(_Layout.legacyDiamondCx, _Layout.legacyCy),
    ],
  );

  static final PlateSpec motorcycle = _spec(
    'fj.motorcycle',
    _Layout.motoWidth,
    _Layout.motoHeight,
    letters: _slot(
      FijiAlphabets.digits,
      _Layout.motoDigitX,
      _Layout.motoDigitW,
      _Layout.motoBox,
      _Layout.motoCy,
      3,
    ),
    serial: _slot(
      FijiAlphabets.letters,
      _Layout.motoLetterX,
      _Layout.motoLetterW,
      _Layout.motoBox,
      _Layout.motoCy,
      1,
    ),
  );

  static List<PlateSpec> get all => <PlateSpec>[general, legacy, motorcycle];

  static const PlateLabel _caption = PlateLabel(
    text: 'FIJI',
    box: PlateBox.centered(
      _Layout.captionCx,
      _Layout.captionCy,
      _Layout.captionW,
      _Layout.captionH,
    ),
    glyphHeight: _Layout.captionGlyph,
  );

  static PlateLabel _diamond(double cx, double cy) => PlateLabel(
    text: '◆',
    box: PlateBox(cx - 12, cy - 12, 24, 24),
    glyphHeight: _Layout.diamondGlyph,
  );

  static PlateSpec _car(String id) => _spec(
    id,
    _Layout.width,
    _Layout.height,
    letters: _slot(
      FijiAlphabets.letters,
      _Layout.letterX,
      _Layout.letterW,
      _Layout.carBox,
      _Layout.carCy,
      2,
    ),
    serial: _slot(
      FijiAlphabets.digits,
      _Layout.digitX,
      _Layout.digitW,
      _Layout.carBox,
      _Layout.carCy,
      3,
    ),
    labels: <PlateLabel>[_caption, _diamond(_Layout.diamondCx, _Layout.carCy)],
  );

  static PlateSlot _slot(
    PlateAlphabet alphabet,
    double x,
    double w,
    double box,
    double cy,
    int length,
  ) => PlateSlot(
    alphabet: alphabet,
    box: PlateBox(x, cy - box / 2, w, box),
    length: length,
  );

  static PlateSpec _spec(
    String id,
    double width,
    double height, {
    required PlateSlot letters,
    required PlateSlot serial,
    List<PlateLabel> labels = const <PlateLabel>[],
  }) => PlateSpec(
    id: id,
    country: FijiCountry.fiji,
    canvasWidth: width,
    canvasHeight: height,
    slots: <PlateSlot>[letters, serial],
    labels: labels,
    textGroups: PlateTextGroup.perSlot(<String>['letters', 'serial']),
  );
}

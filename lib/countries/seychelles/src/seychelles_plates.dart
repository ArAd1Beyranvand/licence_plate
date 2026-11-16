import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'seychelles_colors.dart';
import 'seychelles_country.dart';

/// Where the ink sits, in plate units. Measured on the 384x200 drawing,
/// no physical size in the article.
///
/// Until 2018 (plate 288x82, x 40-327 / y 1-82): ink y 17-64 (h 47), x 16-261
/// for the letter and five digits, ~41 per character. Since 2018 (plate
/// 360x91, x 21-381 / y 108-199): same ink height, y 21-68, x 15-254, plus a
/// yellow tag from x 278 to the edge holding two letters (ink y 15-37,
/// x 301-341) over four digits (ink y 44-66, x 287-350), both ~22 tall.
/// A 47-unit ink needs an ~85-unit box, which fits both plates.
abstract final class _Layout {
  static const double oldWidth = 288, oldHeight = 82, oldBox = 82;
  static const double newWidth = 360, newHeight = 91, newBox = 85;
  static const double tagStart = 278;

  static const PlateBox oldLetter = PlateBox(16, 0, 41, oldBox);
  static const PlateBox oldDigits = PlateBox(57, 0, 204, oldBox);
  static const PlateBox newLetter = PlateBox(15, 3, 41, newBox);
  static const PlateBox newDigits = PlateBox(56, 3, 198, newBox);

  static const PlateBox tagLetters = PlateBox(293, 11, 56, 30);
  static const PlateBox tagDigits = PlateBox(285, 40, 68, 30);
}

/// Seychelles's plates: a series letter and up to five digits (`S 11111`),
/// white on black. [standard] is the plate issued until 2018; [highVisibility]
/// is the plate since 2018, with a yellow tag at the right holding two
/// letters and four digits (`HV 1111`). Groups `letter`, `serial`, and on the
/// tag `tagLetters`, `tag`.
///
/// The article's format `A0000 AA/0000` gives four digits but its drawing
/// shows five, so the picture wins. The tag's meaning is not stated in the
/// article, so its fields are modelled from the picture alone.
abstract final class SeychellesPlates {
  static final PlateSpec standard = PlateSpec(
    id: 'sc.standard',
    country: SeychellesCountry.seychelles,
    canvasWidth: _Layout.oldWidth,
    canvasHeight: _Layout.oldHeight,
    slots: const <PlateSlot>[
      PlateSlot(
        alphabet: SeychellesAlphabets.letters,
        box: _Layout.oldLetter,
        group: 'letter',
      ),
      PlateSlot(
        alphabet: SeychellesAlphabets.digits,
        box: _Layout.oldDigits,
        length: 5,
        minLength: 1,
        group: 'serial',
      ),
    ],
  );

  static final PlateSpec highVisibility = PlateSpec(
    id: 'sc.high_visibility',
    country: SeychellesCountry.seychelles,
    canvasWidth: _Layout.newWidth,
    canvasHeight: _Layout.newHeight,
    // The tag is the plate's last column so the corner rounding clips it.
    background: const PlateSection.columns(<PlatePart>[
      PlatePart(PlateSection.plain, end: _Layout.tagStart),
      PlatePart(PlateSection.fill(PlateFill.color(SeychellesColors.yellow))),
    ]),
    slots: const <PlateSlot>[
      PlateSlot(
        alphabet: SeychellesAlphabets.letters,
        box: _Layout.newLetter,
        group: 'letter',
      ),
      PlateSlot(
        alphabet: SeychellesAlphabets.digits,
        box: _Layout.newDigits,
        length: 5,
        minLength: 1,
        group: 'serial',
      ),
      PlateSlot(
        alphabet: SeychellesAlphabets.letters,
        box: _Layout.tagLetters,
        length: 2,
        color: SeychellesColors.black,
        group: 'tagLetters',
      ),
      PlateSlot(
        alphabet: SeychellesAlphabets.digits,
        box: _Layout.tagDigits,
        length: 4,
        color: SeychellesColors.black,
        group: 'tag',
      ),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[standard, highVisibility];
}

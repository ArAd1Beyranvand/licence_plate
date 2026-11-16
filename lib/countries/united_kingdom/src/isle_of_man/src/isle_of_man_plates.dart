import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'isle_of_man_country.dart';

/// Plate units measured off the flattened references
/// (`Licenceplate_of_Isle_of_Man_2`, `NMN-835-H`), both 2000 px across for the
/// 520 mm the article gives (3.846 px per unit); height 111 mm.
///
/// Red strip: x 0..77 (white plate) / 82 (yellow, frame included) — 80.
/// `isle of man` script: ink x 229..361 / 248..350, y 5..19 — centred 297.
/// Characters, white plate: `NMN` ink x 108..239, dash 248..268, digits
/// 278..409, dash 422..440, last letter 452..490; ink y 25..100 (75 tall,
/// pitch ~47). The ink is 75 tall on a 111 canvas; a box that tall would need
/// ~136, so the box is capped at 104 and the ink lands near 75% of reference.
/// Dashes are 20 × 7.5 at y 62.
abstract final class _Layout {
  static const double width = 520, height = 111, bandEnd = 80;

  static const double rowTop = 6, rowHeight = 104, spacing = 2;

  static const double prefixLeft = 105, prefixWidth = 137;
  static const double serialLeft = 276, serialWidth = 135;
  static const double suffixLeft = 449, suffixWidth = 44;

  static const double dashWidth = 20, dashTop = 62, dashHeight = 7.5;
  static const double dashCx1 = 258, dashCx2 = 431;

  static const double scriptCx = 297, scriptWidth = 150;
  static const double scriptCy = 12, scriptBox = 20, scriptGlyph = 17;
}

/// `NMN-835-H`: initial letter + `MN`, one to three digits, one letter. Groups
/// `prefix`, `serial`, `suffix`. Not drawn: the history of older formats
/// (`MN 1234`, `MAN 123`, `123 BMN`) and the optional plain plate without the
/// flag strip.
abstract final class IsleOfManPlates {
  static PlateSpec _spec(String id) => PlateSpec(
    id: 'im.$id',
    country: IsleOfManCountry.isle_of_man,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: const PlatePanel(
      box: PlateBox(0, 0, _Layout.bandEnd, _Layout.height),
    ),
    background: const PlateSection.columns(<PlatePart>[
      PlatePart(PlateSection.fill(PlateFill.panel), end: _Layout.bandEnd),
      PlatePart(PlateSection.plain),
    ]),
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: IsleOfManAlphabets.letters,
        box: const PlateBox(
          _Layout.prefixLeft,
          _Layout.rowTop,
          _Layout.prefixWidth,
          _Layout.rowHeight,
        ),
        length: 3,
        spacing: _Layout.spacing,
        group: 'prefix',
      ),
      PlateSlot(
        alphabet: IsleOfManAlphabets.digits,
        box: const PlateBox(
          _Layout.serialLeft,
          _Layout.rowTop,
          _Layout.serialWidth,
          _Layout.rowHeight,
        ),
        length: 3,
        minLength: 1,
        spacing: _Layout.spacing,
        group: 'serial',
      ),
      const PlateSlot(
        alphabet: IsleOfManAlphabets.suffix,
        box: PlateBox(
          _Layout.suffixLeft,
          _Layout.rowTop,
          _Layout.suffixWidth,
          _Layout.rowHeight,
        ),
        group: 'suffix',
      ),
    ],
    rules: const <PlateRule>[
      PlateRule(
        box: PlateBox(
          _Layout.dashCx1 - _Layout.dashWidth / 2,
          _Layout.dashTop,
          _Layout.dashWidth,
          _Layout.dashHeight,
        ),
      ),
      PlateRule(
        box: PlateBox(
          _Layout.dashCx2 - _Layout.dashWidth / 2,
          _Layout.dashTop,
          _Layout.dashWidth,
          _Layout.dashHeight,
        ),
      ),
    ],
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'isle of man',
        box: PlateBox.centered(
          _Layout.scriptCx,
          _Layout.scriptCy,
          _Layout.scriptWidth,
          _Layout.scriptBox,
        ),
        glyphHeight: _Layout.scriptGlyph,
      ),
    ],
  );

  /// White front plate, black characters. Pairs with [IsleOfManThemes.front].
  static final PlateSpec front = _spec('front');

  /// Yellow rear plate. Pairs with [IsleOfManThemes.rear].
  static final PlateSpec rear = _spec('rear');

  /// White on black, for vehicles built before 1 February 1990. Pairs with
  /// [IsleOfManThemes.classic].
  static final PlateSpec classic = _spec('classic');

  static List<PlateSpec> get all => <PlateSpec>[front, rear, classic];
}

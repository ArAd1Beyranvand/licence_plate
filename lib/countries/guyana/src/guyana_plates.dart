import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'guyana_country.dart';

/// Where the ink sits, in plate coordinates.
///
/// `platekit` flattened every photo to 520×264 (the Presidential photo's true
/// 1.97). The article's infobox gives 520×110, and the two standard photos
/// are not 1.97: `____1` is 500×108 (4.63) and the Private Car photo 1.54. So
/// the standard plates' y values below are the flattened ones rescaled
/// (×110/264 and ×338/264, the two-row plate being 520 wide at 1.54); x is
/// unchanged.
///
/// * single line (`____1`): letters ink x 35.2..205.5, digits 250..485.2,
///   y 17.2..93.8 (a 76.6-tall ink row, centre 55.5).
/// * two row (Private Car): letters ink x 107..409.2, y 23.3..150.1; digits
///   x 111.2..398.2, y 176..305. Row centres 86.7 and 240.5.
/// * Presidential crown x 172.5..345, y 46.8..217.8; Prime Minister's arms
///   x 163.8..355, y 41..223.5.
///
/// **Under-height ink, accepted.** The ink rows are 77 and 127 tall. At
/// `glyphStyle`'s 0.72 a bold cap is ~0.525 of the slot, so they would need
/// 146 and 241 slots: more than the plate (110) and over half of it (338).
/// The slots are 108 and 170, giving ink ~57 and ~89 (74% and 70%).
/// `plate_core` is unchanged.
abstract final class _Layout {
  static const double lineWidth = 520, lineHeight = 110;
  static const double lineTop = 1.5, lineSlot = 108;
  static const PlateBox lineLetters = PlateBox(35.2, lineTop, 170.3, lineSlot);
  static const PlateBox lineDigits = PlateBox(250, lineTop, 235.2, lineSlot);

  static const double rowWidth = 520, rowHeight = 338, rowSlot = 170;
  static const PlateBox rowLetters = PlateBox(107, 1.7, 302.2, rowSlot);
  static const PlateBox rowDigits = PlateBox(111.2, 155.5, 287, rowSlot);

  static const double stateWidth = 520, stateHeight = 264;
  static const PlateBox crown = PlateBox(172.5, 46.8, 172.5, 171);
  static const PlateBox arms = PlateBox(163.8, 41, 191.2, 182.5);
}

/// Guyana's plate geometries. Every standard plate is white on black, a
/// `letters` series of two or three letters and a `number` of one to four
/// digits; each is one field, so one slot.
///
/// [singleLine] and [twoRow] are the two shapes of the standard plate;
/// [president] (a crown) and [primeMinister] (the coat of arms) carry no
/// characters. The crown and the arms are complex emblems, so they are
/// decals; they are keyed out of the flattened photographs because no clean
/// vector was found.
///
/// Not implemented: the article's special series (`DPL`, `DC`,
/// `DFB`, `CRG`, `GUY`) have no picture, so they are typed on the standard
/// plate and the validator accepts them.
abstract final class GuyanaPlates {
  static final List<PlateTextGroup> _groups = PlateTextGroup.perSlot(<String>[
    'letters',
    'number',
  ]);

  static PlateSlot _field(
    PlateAlphabet alphabet,
    PlateBox box,
    int length,
    int minLength,
  ) => PlateSlot(
    alphabet: alphabet,
    box: box,
    length: length,
    minLength: minLength,
  );

  static PlateSpec _standard(
    String id,
    double width,
    double height,
    PlateBox letters,
    PlateBox digits,
  ) => PlateSpec(
    id: id,
    country: GuyanaCountry.guyana,
    canvasWidth: width,
    canvasHeight: height,
    noPanel: true,
    panel: PlatePanel(box: PlateBox(0, 0, 0, height)),
    slots: <PlateSlot>[
      _field(GuyanaAlphabets.letters, letters, 3, 2),
      _field(GuyanaAlphabets.digits, digits, 4, 1),
    ],
    textGroups: _groups,
  );

  static PlateSpec _emblem(String id, PlateBox box, String asset) => PlateSpec(
    id: id,
    country: GuyanaCountry.guyana,
    canvasWidth: _Layout.stateWidth,
    canvasHeight: _Layout.stateHeight,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.stateHeight)),
    slots: const <PlateSlot>[],
    decals: <PlateDecal>[
      PlateDecal(
        image: AssetImage(asset, package: 'license_plate'),
        box: box,
      ),
    ],
  );

  /// `PSS 2345`, one row (`____1`).
  static final PlateSpec singleLine = _standard(
    'gy.singleLine',
    _Layout.lineWidth,
    _Layout.lineHeight,
    _Layout.lineLetters,
    _Layout.lineDigits,
  );

  /// `PCC` over `9140` (the Private Car photo).
  static final PlateSpec twoRow = _standard(
    'gy.twoRow',
    _Layout.rowWidth,
    _Layout.rowHeight,
    _Layout.rowLetters,
    _Layout.rowDigits,
  );

  /// The Presidential plate: a gold Cacique's crown, no characters.
  static final PlateSpec president = _emblem(
    'gy.president',
    _Layout.crown,
    'assets/countries/guyana/icons/guyana_crown.png',
  );

  /// The Prime Minister's plate: the coat of arms in gold, no characters.
  static final PlateSpec primeMinister = _emblem(
    'gy.primeMinister',
    _Layout.arms,
    'assets/countries/guyana/icons/guyana_coat_of_arms.png',
  );

  static List<PlateSpec> get all => <PlateSpec>[
    singleLine,
    twoRow,
    president,
    primeMinister,
  ];
}

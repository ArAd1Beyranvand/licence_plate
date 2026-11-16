import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'burundi_country.dart';

/// Where the ink sits, in plate units.
///
/// **Approximate.** The article has no plate pictures; the only references
/// are two front plates and one rear plate in Commons street photographs of
/// the Gitega taxi station (`File:Bus and taxi station in Gitega
/// (6908586229).jpg`), each 60–110 px wide and photographed at an angle, so
/// nothing was normalised or measured with `measure.py`. Positions are
/// fractions of the plate width read off the larger front plate (`B·6232·A`
/// and `A·0412·A` agree within 0.01) times 520: first letter 0.21–0.32,
/// digits 0.37–0.725, last letter 0.78–0.865; flag 0.03–0.15 wide and
/// 0.17–0.61 of the height; "BU" under it. The canvas is the article's
/// 520×110 mm.
///
/// The reference digit ink is ~0.65 of the plate height; the slot is capped
/// at 106 like the other 520×110 packages, which gives ~58 of ink.
abstract final class _Layout {
  static const double width = 520, height = 110, slotHeight = 106, cy = 55;

  static const double digitsLeft = 192, digitsWidth = 185;

  /// The flag at the left of the field, at its own 5:3 aspect (60×36).
  static const PlateBox flag = PlateBox(16, 19, 60, 36);
  static const PlateBox bu = PlateBox(16, 62, 60, 24);
  static const double buGlyph = 20;

  /// The dots between the three fields.
  static const PlateBox dot1 = PlateBox(175.5, 52.5, 5, 5);
  static const PlateBox dot2 = PlateBox(388.5, 52.5, 5, 5);
}

/// Burundi's current plates: `A 0412 A` in one row — a letter, four digits
/// and a letter, dotted — with the flag and "BU" at the left. The front plate
/// is black on white and the rear black on yellow; the shape is the same (the
/// rear's layout is assumed from the front, as no rear plate is legible), so
/// one spec serves both. Colour is the theme's.
///
/// Not implemented: any government, diplomatic, police or motorcycle series;
/// none is pictured or described.
abstract final class BurundiPlates {
  static final PlateSpec standard = _spec('bi.standard');

  static List<PlateSpec> get all => <PlateSpec>[standard];

  static PlateSlot _field(
    PlateAlphabet alphabet,
    double left,
    double width,
    int count,
  ) => PlateSlot(
    alphabet: alphabet,
    box: PlateBox(
      left,
      _Layout.cy - _Layout.slotHeight / 2,
      width,
      _Layout.slotHeight,
    ),
    length: count,
    spacing: count == 1
        ? 0
        : plateRunSpacing(width / count, _Layout.slotHeight),
  );

  static PlateSpec _spec(String id) => PlateSpec(
    id: id,
    country: BurundiCountry.burundi,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    slots: <PlateSlot>[
      _field(BurundiAlphabets.letters, 110, 55, 1),
      _field(
        BurundiAlphabets.digits,
        _Layout.digitsLeft,
        _Layout.digitsWidth,
        4,
      ),
      _field(BurundiAlphabets.letters, 406, 44, 1),
    ],
    rules: const <PlateRule>[
      PlateRule(box: _Layout.dot1),
      PlateRule(box: _Layout.dot2),
    ],
    labels: const <PlateLabel>[
      PlateLabel(text: 'BU', box: _Layout.bu, glyphHeight: _Layout.buGlyph),
    ],
    decals: const <PlateDecal>[
      PlateDecal(drawing: BurundiCountry.flag, box: _Layout.flag),
    ],
    textGroups: PlateTextGroup.perSlot(<String>['prefix', 'number', 'suffix']),
  );
}

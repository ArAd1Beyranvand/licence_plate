import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart' show LuxembourgAlphabets;
import 'package:license_plate/core/plate_core.dart';

import 'luxembourg_colors.dart';
import 'luxembourg_country.dart';

/// Where the ink sits, in millimetres.
///
/// Figures are read off the flattened references in `.plateref/lu`, each
/// normalised to the 520×110 mm the article gives (the military plate to the
/// 211×110 its photograph has, aspect 1.92).
///
/// * Standard (`QV 8043`, 2003 format): EU band x 0..57 (blue to the
///   frame); ink y 19.5..95; letters x 93.8..202 at pitch 61; digits
///   x 245.5..478 at pitch 62.
/// * Diplomatic (`CD 70-05`), CHECK photograph, scaled from the plate's
///   rectangle in the original (±3 mm): `CD` x 59..158, a seal 181..203 (not
///   modelled), `70` 229..293, hyphen 310..340, `05` 385..499.
/// * Military (`9015`): the national arms at the left (not modelled), four
///   digits to the right of them, ink y 16.8..98.2. The x-span of the digits
///   and the canvas width are estimated off a very small photograph.
///
/// **Under-height ink, accepted.** Ink is ~75 mm of a 110 mm plate;
/// `glyphStyle` makes a bold digit ~0.55 of its slot, so full height would
/// need slots beyond the canvas. Slots are 106 tall and `plate_core` is
/// unchanged.
///
/// Not implemented: the pre-2003 plates (one letter and four digits, two
/// letters and three digits, the large-EU-flag rear plate), the white-on-black
/// 1966-78 plates, the custom digit-only plates (the standard design), the
/// government, Chamber of Deputies and dealer series, the moped plate.
abstract final class _Layout {
  static const double width = 520, height = 110, bandEnd = 57, slotHeight = 106;
  static const double centre = 57, pitch = 61.5;

  static const double militaryWidth = 211;
}

/// A field: a run printed and typed as a unit, one slot.
PlateSlot _field(
  PlateAlphabet alphabet, {
  required double left,
  required int count,
  double pitch = _Layout.pitch,
  double centre = _Layout.centre,
}) => plateRun(
  alphabet,
  count,
  left: left,
  top: centre - _Layout.slotHeight / 2,
  pitch: pitch,
  height: _Layout.slotHeight,
);

abstract final class LuxembourgPlates {
  static const PlateAlphabet _digits = LuxembourgAlphabets.digits;
  static const PlateAlphabet _letters = LuxembourgAlphabets.letters;

  static const PlateSection _euroBand = PlateSection.columns(<PlatePart>[
    PlatePart(PlateSection.fill(PlateFill.panel), end: _Layout.bandEnd),
    PlatePart(PlateSection.plain),
  ]);

  static const PlatePanel _euroPanel = PlatePanel(
    box: PlateBox(5.5, 3, 46, 63),
    padding: EdgeInsets.zero,
  );

  static const PlateLabel _euroL = PlateLabel(
    text: 'L',
    box: PlateBox(0, 61, _Layout.bandEnd, 40),
    glyphHeight: 40,
    color: LuxembourgColors.white,
  );

  static PlateSpec _euro({
    required String id,
    required List<PlateSlot> slots,
    List<String> keys = const <String>[],
    List<PlateRule> rules = const <PlateRule>[],
    List<PlateLabel> labels = const <PlateLabel>[],
  }) => PlateSpec(
    id: id,
    country: LuxembourgCountry.luxembourg,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: _euroPanel,
    background: _euroBand,
    slots: slots,
    rules: rules,
    labels: <PlateLabel>[_euroL, ...labels],
    textGroups: PlateTextGroup.perSlot(keys),
  );

  /// `QV 8043`: two letters, four digits (leading zeros allowed).
  static final PlateSpec standard = _euro(
    id: 'lu.standard',
    keys: const <String>['letters', 'serial'],
    slots: <PlateSlot>[
      _field(_letters, left: 86.5, count: 2),
      _field(_digits, left: 238.8, count: 4, pitch: 62),
    ],
  );

  /// `CD 70-05`: the fixed `CD`, then two pairs of digits round a hyphen.
  /// The picture wins over the article's "CD plus two sets of two digits".
  static final PlateSpec diplomatic = _euro(
    id: 'lu.diplomatic',
    keys: const <String>['series', 'serial'],
    slots: <PlateSlot>[
      _field(_digits, left: 222, count: 2, pitch: 36),
      _field(_digits, left: 389, count: 2, pitch: 55),
    ],
    rules: const <PlateRule>[PlateRule(box: PlateBox(310, 52, 30, 9))],
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'CD',
        box: PlateBox(59, 2, 99, _Layout.slotHeight),
        glyphHeight: _Layout.slotHeight,
      ),
    ],
  );

  /// `9015`: white on black, no EU band; the national arms at the left are a
  /// complex emblem and are not drawn.
  static final PlateSpec military = PlateSpec(
    id: 'lu.military',
    country: LuxembourgCountry.luxembourg,
    canvasWidth: _Layout.militaryWidth,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
    slots: <PlateSlot>[
      _field(_digits, left: 52, count: 4, pitch: 39, centre: 57),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'serial'),
    ],
  );
}

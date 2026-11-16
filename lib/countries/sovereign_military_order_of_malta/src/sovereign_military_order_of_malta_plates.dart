import 'package:flutter/widgets.dart' show EdgeInsets, Offset;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'sovereign_military_order_of_malta_colors.dart';
import 'sovereign_military_order_of_malta_country.dart';

/// Where the ink sits, in plate units.
///
/// One reference: a photographed plate (`Sovereign_Military_Order_of_Malta_
/// license_plate.jpg`) flattened to the Italian 520×110 (the article gives no
/// size; the plate is an Italian-format one, as issued in Rome). Ink y
/// 18..84 on both runs (centre 51.4), so the slots are 103 tall from y 0.
/// Glyph ink is ~55% of its box and a box cannot leave the canvas, so ink is
/// ~57 against 65 measured (~87%).
///
/// `SMOM` ink x 43.3..246.3 (centres at pitch ~51); number `60` ink x
/// 390.3..479.0 (pitch ~47). Between them a small red shield, x 270.8..279.8,
/// y 47.3..55.8, the Order's arms (white cross on red) drawn in code.
///
/// Not drawn: the dealer's strip under the characters (`CONCESSIONARIA ROMA
/// AUTO`) and the screw holes — neither is plate content. The Wikipedia page
/// for the Order has no plate text; the number's range and any other series
/// are unknown.
abstract final class _Layout {
  static const double width = 520, height = 110, slotTop = 0, slotHeight = 103;

  static const double prefixLeft = 42, prefixPitch = 51.25, numberLeft = 387.6;
  static const double numberPitch = 47;

  static const PlateBox arms = PlateBox(270.8, 47.3, 9, 8.5);
}

/// Groups are `prefix` (`SMOM`) and `number` (two digits).
abstract final class SovereignMilitaryOrderOfMaltaPlates {
  static const PlateDrawing _arms = PlateDrawing(10, 10, <PlateShape>[
    PlatePolygonShape(<Offset>[
      Offset(0, 0),
      Offset(10, 0),
      Offset(10, 5),
      Offset(8, 8),
      Offset(5, 10),
      Offset(2, 8),
      Offset(0, 5),
    ], SovereignMilitaryOrderOfMaltaColors.red),
    PlateRectShape(4.1, 1.2, 1.8, 7, SovereignMilitaryOrderOfMaltaColors.white),
    PlateRectShape(
      1.6,
      3.3,
      6.8,
      1.8,
      SovereignMilitaryOrderOfMaltaColors.white,
    ),
  ]);

  static PlateSlot _field(
    PlateAlphabet alphabet,
    int count,
    double left,
    double pitch, {
    bool red = false,
  }) => plateRun(
    alphabet,
    count,
    left: left,
    top: _Layout.slotTop,
    pitch: pitch,
    height: _Layout.slotHeight,
    color: red ? SovereignMilitaryOrderOfMaltaColors.red : null,
  );

  static final PlateSpec standard = PlateSpec(
    id: 'smom.standard',
    country:
        SovereignMilitaryOrderOfMaltaCountry.sovereign_military_order_of_malta,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, 0),
      padding: EdgeInsets.zero,
    ),
    noPanel: true,
    slots: <PlateSlot>[
      _field(
        SovereignMilitaryOrderOfMaltaAlphabets.letters,
        4,
        _Layout.prefixLeft,
        _Layout.prefixPitch,
        red: true,
      ),
      _field(
        SovereignMilitaryOrderOfMaltaAlphabets.digits,
        2,
        _Layout.numberLeft,
        _Layout.numberPitch,
      ),
    ],
    decals: const <PlateDecal>[PlateDecal(drawing: _arms, box: _Layout.arms)],
    textGroups: PlateTextGroup.perSlot(<String>['prefix', 'number']),
  );

  static List<PlateSpec> get all => <PlateSpec>[standard];
}

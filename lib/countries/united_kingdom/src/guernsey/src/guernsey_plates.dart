import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'guernsey_country.dart';

/// Where the ink sits, in plate coordinates.
///
/// Guernsey (`GBG_white_front_plate`, `8982`; the yellow rear photo agrees):
/// the platekit sheet is flattened to 520×204 but the article gives 520×110,
/// and the millimetres win, so y is scaled by 110/204. Ink y 7.7..102, x 20.8..
/// 499, one run of up to five digits (the picture's "1 + 2" glyph split is
/// kerning, not two fields). Ink fills ~0.55 of its box, so the 106 box gives
/// ~58 of the ~94 the reference has.
///
/// Alderney (`License_plate_of_Alderney`, `AY` over `933`): photo aspect 1.29
/// gives 520×403, so the sheet's y is scaled by 403/204. `AY` ink y 32.6..180,
/// x 144.8..368.2 (centre 256.5); digits y 209..360, x 81.5..440.2 at a pitch
/// of 119.6, so four cells span 21.5..500. Boxes are 180 high, again ~0.55 ink.
abstract final class _Layout {
  static const double guernseyWidth = 520, guernseyHeight = 110, rowTop = 2;
  static const double rowHeight = 106, runLeft = 20.8, runRight = 499;

  static const double alderneyWidth = 520, alderneyHeight = 403;
  static const double alderneyRowHeight = 180, prefixTop = 16;
  static const double prefixCentre = 256.5, prefixBoxWidth = 440;
  static const double digitsTop = 195, digitsLeft = 21.5, digitsRight = 500;
}

abstract final class GuernseyPlates {
  /// Up to five digits, no letters. Registration 1 is the Bailiff's, and
  /// numbers starting 0 / 00 were released from 2012; neither is restricted.
  static PlateSpec _oneLine(String id) => PlateSpec(
    id: id,
    country: GuernseyCountry.guernsey,
    canvasWidth: _Layout.guernseyWidth,
    canvasHeight: _Layout.guernseyHeight,
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: GuernseyAlphabets.digits,
        box: const PlateBox(
          _Layout.runLeft,
          _Layout.rowTop,
          _Layout.runRight - _Layout.runLeft,
          _Layout.rowHeight,
        ),
        length: 5,
        minLength: 1,
        group: 'serial',
      ),
    ],
  );

  /// White front plate, black digits.
  static final PlateSpec front = _oneLine('gg.front');

  /// Yellow rear plate, same layout in black on yellow.
  static final PlateSpec rear = _oneLine('gg.rear');

  /// Alderney's yellow rear plate: `AY` over one to four digits.
  static final PlateSpec alderney = PlateSpec(
    id: 'gg.alderney',
    country: GuernseyCountry.alderney,
    canvasWidth: _Layout.alderneyWidth,
    canvasHeight: _Layout.alderneyHeight,
    labels: <PlateLabel>[
      PlateLabel(
        text: 'AY',
        box: PlateBox(
          _Layout.prefixCentre - _Layout.prefixBoxWidth / 2,
          _Layout.prefixTop,
          _Layout.prefixBoxWidth,
          _Layout.alderneyRowHeight,
        ),
        glyphHeight: _Layout.alderneyRowHeight * 0.72,
      ),
    ],
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: GuernseyAlphabets.digits,
        box: const PlateBox(
          _Layout.digitsLeft,
          _Layout.digitsTop,
          _Layout.digitsRight - _Layout.digitsLeft,
          _Layout.alderneyRowHeight,
        ),
        length: 4,
        minLength: 1,
      ),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'serial', prefix: 'AY'),
    ],
  );
}

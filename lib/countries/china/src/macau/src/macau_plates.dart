import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'macau_country.dart';

/// Measured off `Macaubuslicence.png` and `sheet_flat.png`, normalised to the
/// sizes below: row ink x 67–462 as "MA" · "12" · "34"; square stacks "MA" over
/// "12-34"; moped is "CM" over up to five digits; the mainland supplement is
/// 粤Z·F023澳 on 440×140. Ink is ~55% of the box, so boxes use the full row.
abstract final class _Layout {
  static const double rowWidth = 520, rowHeight = 110;
  static const double squareWidth = 340, squareHeight = 216;
  static const double mopedWidth = 340, mopedHeight = 214;
  static const double mainlandWidth = 440, mainlandHeight = 140;
}

abstract final class MacauPlates {
  static PlateSlot _slot(
    PlateAlphabet a,
    double left,
    double right,
    int length,
    double top,
    double h, {
    int? minLength,
  }) {
    final double pitch = (right - left) / length;
    return PlateSlot(
      alphabet: a,
      box: PlateBox(left, top, right - left, h),
      length: length,
      minLength: minLength ?? length,
      spacing: length == 1 ? 0 : plateRunSpacing(pitch, h),
    );
  }

  static PlateSpec _spec(
    String id,
    double w,
    double h,
    List<PlateSlot> slots,
    List<String> keys, {
    List<PlateLabel> labels = const <PlateLabel>[],
    List<PlateRule> rules = const <PlateRule>[],
  }) => PlateSpec(
    id: id,
    country: MacauCountry.macau,
    canvasWidth: w,
    canvasHeight: h,
    noPanel: true,
    panel: PlatePanel(box: PlateBox(0, 0, 0, h)),
    background: PlateSection.plain,
    slots: slots,
    labels: labels,
    rules: rules,
    textGroups: <PlateTextGroup>[
      for (var i = 0; i < keys.length; i++)
        PlateTextGroup(<int>[i], key: keys[i]),
    ],
  );

  static final PlateSpec row = _spec(
    'mo.row',
    _Layout.rowWidth,
    _Layout.rowHeight,
    <PlateSlot>[
      _slot(MacauAlphabets.letters, 60, 200, 2, 4, 102),
      _slot(MacauAlphabets.digits, 242, 340, 2, 4, 102),
      _slot(MacauAlphabets.digits, 382, 480, 2, 4, 102),
    ],
    const <String>['letters', 'pair1', 'digits'],
    rules: const <PlateRule>[
      PlateRule(box: PlateBox(207, 51, 28, 8)),
      PlateRule(box: PlateBox(347, 51, 28, 8)),
    ],
  );

  static final PlateSpec square = _spec(
    'mo.square',
    _Layout.squareWidth,
    _Layout.squareHeight,
    <PlateSlot>[
      _slot(MacauAlphabets.letters, 60, 280, 2, 10, 92),
      _slot(MacauAlphabets.digits, 30, 150, 2, 114, 92),
      _slot(MacauAlphabets.digits, 190, 310, 2, 114, 92),
    ],
    const <String>['letters', 'pair1', 'digits'],
    rules: const <PlateRule>[PlateRule(box: PlateBox(156, 156, 28, 8))],
  );

  static final PlateSpec moped = _spec(
    'mo.moped',
    _Layout.mopedWidth,
    _Layout.mopedHeight,
    <PlateSlot>[
      _slot(MacauAlphabets.digits, 30, 310, 5, 114, 92, minLength: 2),
    ],
    const <String>['digits'],
    labels: const <PlateLabel>[
      PlateLabel(text: 'CM', box: PlateBox(60, 10, 220, 92), glyphHeight: 120),
    ],
  );

  static final PlateSpec mainland = _spec(
    'mo.mainland',
    _Layout.mainlandWidth,
    _Layout.mainlandHeight,
    <PlateSlot>[_slot(MacauAlphabets.mainlandSerial, 150, 345, 4, 8, 124)],
    const <String>['digits'],
    labels: const <PlateLabel>[
      PlateLabel(text: '粤Z·', box: PlateBox(10, 8, 140, 124), glyphHeight: 100),
      PlateLabel(text: '澳', box: PlateBox(350, 8, 80, 124), glyphHeight: 100),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[row, square, moped, mainland];
}

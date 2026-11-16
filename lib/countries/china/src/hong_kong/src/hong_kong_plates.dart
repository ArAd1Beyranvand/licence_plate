import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'hong_kong_country.dart';

/// Measured off `Hong_Kong_number_plates_2009.png` (front plate, 2000 px wide)
/// normalised to 520×109: ink x 60–477, "NS" 60–206, digits 258–477, ink 73 tall.
/// The box uses the full height; ink comes out shorter (~55% rule). The
/// two-line and cross-border sizes are estimates from the BS AU 145a / GA 36
/// proportions.
abstract final class _Layout {
  static const double width = 520, height = 109, rowTop = 4, rowHeight = 101;

  static const double rearWidth = 290, rearHeight = 175;
  static const double crossWidth = 440, crossHeight = 140;
}

abstract final class HongKongPlates {
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
  }) => PlateSpec(
    id: id,
    country: HongKongCountry.hong_kong,
    canvasWidth: w,
    canvasHeight: h,
    noPanel: true,
    panel: PlatePanel(box: PlateBox(0, 0, 0, h)),
    background: PlateSection.plain,
    slots: slots,
    labels: labels,
    textGroups: <PlateTextGroup>[
      for (var i = 0; i < keys.length; i++)
        PlateTextGroup(<int>[i], key: keys[i]),
    ],
  );

  static final PlateSpec private = _spec(
    'hk.private',
    _Layout.width,
    _Layout.height,
    <PlateSlot>[
      _slot(
        HongKongAlphabets.letters,
        60,
        206,
        2,
        _Layout.rowTop,
        _Layout.rowHeight,
      ),
      _slot(
        HongKongAlphabets.digits,
        258,
        477,
        4,
        _Layout.rowTop,
        _Layout.rowHeight,
        minLength: 1,
      ),
    ],
    const <String>['letters', 'digits'],
  );

  static final PlateSpec rear = _spec(
    'hk.rear',
    _Layout.rearWidth,
    _Layout.rearHeight,
    <PlateSlot>[
      _slot(HongKongAlphabets.letters, 30, 260, 2, 8, 76),
      _slot(HongKongAlphabets.digits, 30, 260, 4, 92, 76, minLength: 1),
    ],
    const <String>['letters', 'digits'],
  );

  static final PlateSpec personalised = _spec(
    'hk.personalised',
    _Layout.width,
    _Layout.height,
    <PlateSlot>[
      _slot(
        HongKongAlphabets.mixed,
        40,
        480,
        8,
        _Layout.rowTop,
        _Layout.rowHeight,
        minLength: 1,
      ),
    ],
    const <String>['digits'],
  );

  static final PlateSpec crossBorder = _spec(
    'hk.cross_border',
    _Layout.crossWidth,
    _Layout.crossHeight,
    <PlateSlot>[_slot(HongKongAlphabets.mixed, 150, 345, 4, 8, 124)],
    const <String>['digits'],
    labels: const <PlateLabel>[
      PlateLabel(text: '粤Z·', box: PlateBox(10, 8, 140, 124), glyphHeight: 100),
      PlateLabel(text: '港', box: PlateBox(350, 8, 80, 124), glyphHeight: 100),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    rear,
    personalised,
    crossBorder,
  ];
}

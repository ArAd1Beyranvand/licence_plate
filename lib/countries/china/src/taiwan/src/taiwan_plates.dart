import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'taiwan_colors.dart';
import 'taiwan_country.dart';

/// Measured off the 2014 plate sheet, each plate normalised to 380×160:
/// ink rows y 36–128, letters x 11–159, separator dot x≈166, digits x 174–369.
/// Ink is ~55% of the box, so boxes use the full height available.
abstract final class _Layout {
  static const double width = 380, height = 160, rowTop = 8, rowHeight = 144;
  static const double bandTop = 35, bandBottom = 27;
  static const double electricRowTop = bandTop,
      electricRowHeight = height - bandTop - bandBottom;

  static const double legacyWidth = 320, legacyHeight = 150;

  static const double blockEnd = 78, blockGlyph = 100;
}

const PlateAlphabet _digits = TaiwanAlphabets.digits;
const PlateAlphabet _letters = TaiwanAlphabets.letters;

abstract final class TaiwanPlates {
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

  static PlateSpec _spec({
    required String id,
    required double width,
    required double height,
    required PlateSection background,
    required List<PlateSlot> slots,
    required List<String> keys,
    List<PlateLabel> labels = const <PlateLabel>[],
    List<PlateRule> rules = const <PlateRule>[],
  }) => PlateSpec(
    id: id,
    country: TaiwanCountry.taiwan,
    canvasWidth: width,
    canvasHeight: height,
    noPanel: true,
    panel: PlatePanel(box: PlateBox(0, 0, 0, height)),
    background: background,
    slots: slots,
    labels: labels,
    rules: rules,
    textGroups: <PlateTextGroup>[
      for (var i = 0; i < keys.length; i++)
        PlateTextGroup(<int>[i], key: keys[i]),
    ],
  );

  static final PlateSpec standard = _spec(
    id: 'tw.standard',
    width: _Layout.width,
    height: _Layout.height,
    background: PlateSection.plain,
    slots: <PlateSlot>[
      _slot(_letters, 11, 159, 3, _Layout.rowTop, _Layout.rowHeight),
      _slot(_digits, 174, 369, 4, _Layout.rowTop, _Layout.rowHeight),
    ],
    keys: const <String>['letters', 'digits'],
    rules: const <PlateRule>[PlateRule(box: PlateBox(162, 76, 8, 8))],
  );

  static final PlateSpec electric = _spec(
    id: 'tw.electric',
    width: _Layout.width,
    height: _Layout.height,
    background: const PlateSection.rows(<PlatePart>[
      PlatePart(
        PlateSection.fill(PlateFill.color(TaiwanColors.green)),
        end: _Layout.bandTop,
      ),
      PlatePart(PlateSection.plain, end: _Layout.height - _Layout.bandBottom),
      PlatePart(PlateSection.fill(PlateFill.color(TaiwanColors.green))),
    ]),
    slots: <PlateSlot>[
      _slot(
        _letters,
        11,
        159,
        3,
        _Layout.electricRowTop,
        _Layout.electricRowHeight,
      ),
      _slot(
        _digits,
        174,
        369,
        4,
        _Layout.electricRowTop,
        _Layout.electricRowHeight,
      ),
    ],
    keys: const <String>['letters', 'digits'],
    rules: const <PlateRule>[PlateRule(box: PlateBox(162, 76, 8, 8))],
    labels: const <PlateLabel>[
      PlateLabel(
        text: '電動車',
        box: PlateBox(100, 2, 180, 31),
        glyphHeight: 40,
        color: TaiwanColors.white,
      ),
    ],
  );

  static final PlateSpec legacy = _spec(
    id: 'tw.legacy',
    width: _Layout.legacyWidth,
    height: _Layout.legacyHeight,
    background: PlateSection.plain,
    slots: <PlateSlot>[
      _slot(TaiwanAlphabets.alphanumeric, 18, 110, 2, 8, 134),
      _slot(_digits, 136, 302, 4, 8, 134),
    ],
    keys: const <String>['letters', 'digits'],
    rules: const <PlateRule>[PlateRule(box: PlateBox(116, 72, 14, 6))],
  );

  static PlateSpec _protocol(
    String id,
    String glyph,
    Color block,
    Color glyphColor,
    int digits,
    double right,
  ) => _spec(
    id: id,
    width: _Layout.width,
    height: _Layout.height,
    background: PlateSection.columns(<PlatePart>[
      PlatePart(
        PlateSection.fill(PlateFill.color(block)),
        end: _Layout.blockEnd,
      ),
      const PlatePart(PlateSection.plain),
    ]),
    slots: <PlateSlot>[
      _slot(
        _digits,
        96,
        right,
        digits,
        _Layout.rowTop,
        _Layout.rowHeight,
        minLength: 2,
      ),
    ],
    keys: const <String>['digits'],
    labels: <PlateLabel>[
      PlateLabel(
        text: glyph,
        box: const PlateBox(4, 20, 70, 120),
        glyphHeight: _Layout.blockGlyph,
        color: glyphColor,
      ),
    ],
  );

  static final PlateSpec embassy = _protocol(
    'tw.embassy',
    '使',
    TaiwanColors.red,
    TaiwanColors.black,
    3,
    365,
  );
  static final PlateSpec foreignAffairs = _protocol(
    'tw.foreign_affairs',
    '外',
    TaiwanColors.yellow,
    TaiwanColors.black,
    4,
    365,
  );
  static final PlateSpec foreignAffairsHeavy = _protocol(
    'tw.foreign_affairs_heavy',
    '外',
    TaiwanColors.blue,
    TaiwanColors.white,
    4,
    365,
  );

  static List<PlateSpec> get all => <PlateSpec>[
    standard,
    electric,
    legacy,
    embassy,
    foreignAffairs,
    foreignAffairsHeavy,
  ];
}

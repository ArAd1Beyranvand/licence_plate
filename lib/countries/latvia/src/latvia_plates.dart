import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'latvia_country.dart';
import 'latvia_themes.dart';

/// Measured on references flattened to 520×110 (4 px per unit). Ink is about
/// 0.55 of a box, so the 67-unit ink would need a ~122 box, more than the
/// canvas; every field box is the full 110, landing the ink at ~87 % of
/// reference.
///
/// Ink extents (x, y) behind the boxes:
/// - private/taxi/electric: panel x 10–56, y 9–101; digits 285.5–489,
///   y 21.8–89.3; dash 226.5–247.3
/// - diplomatic (no panel, red field): `CD` 78–203.5, dash 226.5–247.3,
///   digits 285.3–489.5, y 20.3–90.3
/// - motorcycle (aspect 1.83, measured as fractions of the photo and scaled
///   to 220×120): panel x .02–.215, y .047–.957; `TC` x .4475–.7725 over
///   `7924` x .32–.915; rows y .095–.473 and .532–.898
abstract final class _Layout {
  static const double width = 520, height = 110;

  static const _Panel panel = _Panel(10, 56, 9, 101);

  static const PlateBox letters = PlateBox(75, 0, 132, height);
  static const PlateBox digits = PlateBox(285, 0, 205, height);
  static const PlateBox dash = PlateBox(212, 0, 50, height);

  /// Printed pitch is ~58 units against the font's 47.5 advance at this height.
  static const double letterSpacing = 10;

  static const double mWidth = 220, mHeight = 120;
  static const _Panel mPanel = _Panel(4.4, 47.3, 5.7, 114.9);
  static const PlateBox mLetters = PlateBox(88, 4, 92, 60);
  static const PlateBox mDigits = PlateBox(68, 56, 136, 60);
}

/// Text groups are `letters` and `number`. Each field is one slot: two
/// letters, then one to four digits (the picture shows four; the article says
/// one to four, so `minLength: 1`). The hyphen is a label.
///
/// Not implemented: the president's plate (unticked in the article), the
/// square and small-format plates and trailer plates (no measurable
/// reference), and the pre-2004 plates with the flag in the panel.
abstract final class LatviaPlates {
  /// Private, taxi (`TX`, `TQ`) and electric (`EX`): the letters pick the
  /// livery.
  static final PlateSpec private = _line(
    id: 'lv.private',
    resolveTheme: LatviaThemes.byLetters,
  );
  static final PlateSpec diplomatic = _line(id: 'lv.diplomatic', panel: false);
  static final PlateSpec motorcycle = _motorcycle();

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    diplomatic,
    motorcycle,
  ];

  static PlateSpec _line({
    required String id,
    bool panel = true,
    PlateThemeResolver? resolveTheme,
  }) => _build(
    id: id,
    resolveTheme: resolveTheme,
    width: _Layout.width,
    height: _Layout.height,
    panel: panel ? _Layout.panel : null,
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: LatviaAlphabets.letters,
        box: _Layout.letters,
        length: 2,
        spacing: _Layout.letterSpacing,
      ),
      PlateSlot(
        alphabet: LatviaAlphabets.digits,
        box: _Layout.digits,
        length: 4,
        minLength: 1,
      ),
    ],
    labels: const <PlateLabel>[
      PlateLabel(text: '-', box: _Layout.dash, glyphHeight: _Layout.height),
    ],
  );

  static PlateSpec _motorcycle() => _build(
    id: 'lv.motorcycle',
    width: _Layout.mWidth,
    height: _Layout.mHeight,
    panel: _Layout.mPanel,
    slots: const <PlateSlot>[
      PlateSlot(
        alphabet: LatviaAlphabets.letters,
        box: _Layout.mLetters,
        length: 2,
      ),
      PlateSlot(
        alphabet: LatviaAlphabets.digits,
        box: _Layout.mDigits,
        length: 4,
        minLength: 1,
      ),
    ],
    labels: const <PlateLabel>[],
  );

  static PlateSpec _build({
    required String id,
    required double width,
    required double height,
    required _Panel? panel,
    required List<PlateSlot> slots,
    required List<PlateLabel> labels,
    PlateThemeResolver? resolveTheme,
  }) => PlateSpec(
    id: id,
    country: LatviaCountry.latvia,
    canvasWidth: width,
    canvasHeight: height,
    panel: PlatePanel(box: panel?.box ?? const PlateBox(0, 0, 0, 0)),
    noPanel: panel == null,
    background: panel == null
        ? PlateSection.plain
        : PlateSection.columns(<PlatePart>[
            PlatePart(PlateSection.plain, end: panel.left),
            PlatePart(
              PlateSection.rows(<PlatePart>[
                PlatePart(PlateSection.plain, end: panel.top),
                PlatePart(
                  const PlateSection.fill(PlateFill.panel),
                  end: panel.bottom,
                ),
                const PlatePart(PlateSection.plain),
              ]),
              end: panel.right,
            ),
            const PlatePart(PlateSection.plain),
          ]),
    slots: slots,
    labels: labels,
    resolveTheme: resolveTheme,
    textGroups: PlateTextGroup.perSlot(<String>['letters', 'number']),
  );
}

class _Panel {
  const _Panel(this.left, this.right, this.top, this.bottom);

  final double left, right, top, bottom;

  PlateBox get box => PlateBox.fromLTRB(left, top, right, bottom);
}

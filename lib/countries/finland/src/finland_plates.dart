import 'package:flutter/widgets.dart' show AssetImage;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'finland_colors.dart';
import 'finland_country.dart';

/// Measured on references flattened to the 520×110 of a one-row plate; the
/// motorcycle plate is 164×200, rescaled from that frame.
///
/// Ink is about 0.55 of a box, so a box would need ~110 for the regular
/// plate's 61 — the canvas height. Where the ink centre sits above the middle
/// (export, diplomatic, Åland, motorcycle letters) the box cannot be centred
/// on it without leaving the canvas and is shortened, so those inks land at
/// roughly 75–90 % of reference.
abstract final class _Layout {
  static const double width = 520, height = 110;

  static const PlateBox panel = PlateBox(14.3, 13, 50.2, 85.8);
  static const double panelLeft = 14.3, panelRight = 64.5;
  static const double panelTop = 13, panelBottom = 98.8;

  // Regular.
  static const double regTop = 0, regHeight = 110;
  static const PlateBox regLetters = PlateBox(85, regTop, 196, regHeight);
  static const PlateBox regDash = PlateBox(301, 58, 19.8, 8);
  static const PlateBox regDigits = PlateBox(342, regTop, 144, regHeight);

  // Export.
  static const double expHeight = 95, expStampLeft = 449.5;
  static const PlateBox expLetter = PlateBox(90, 0, 48.5, expHeight);
  static const PlateBox expDash = PlateBox(148.8, 50, 14.7, 8);
  static const PlateBox expDigits = PlateBox(174, 0, 247.5, expHeight);
  static const PlateBox expMonth = PlateBox(455, 6, 60, 44);
  static const PlateBox expYear = PlateBox(455, 54, 60, 40);
  static const double expMonthGlyph = 56, expYearGlyph = 52;

  // Diplomatic.
  static const double dipHeight = 106;
  static const PlateBox dipCode = PlateBox(20, 0, 145, dipHeight);
  static const PlateBox dipDash = PlateBox(176, 48.3, 16.5, 9.5);
  static const PlateBox dipDigits = PlateBox(202, 0, 266, dipHeight);

  // Åland.
  static const double alandTop = 29, alandHeight = 81;
  static const PlateBox alandLetters = PlateBox(
    73.5,
    alandTop,
    164,
    alandHeight,
  );
  static const PlateBox alandDigits = PlateBox(
    300,
    alandTop,
    148.5,
    alandHeight,
  );
  static const PlateBox alandName = PlateBox(170, 8, 165.4, 31);
  static const double alandNameGlyph = 30;
  static const PlateBox alandCrest = PlateBox(133, 5.7, 20, 27.6);
  static const PlateBox alandFlag = PlateBox(348.2, 13.5, 40.8, 17.7);

  // Motorcycle.
  static const double motoWidth = 164, motoHeight = 200;
  static const double motoPanelLeft = 9, motoPanelRight = 53.5;
  static const double motoPanelTop = 10, motoPanelBottom = 92;
  static const PlateBox motoPanel = PlateBox(9, 10, 44.5, 82);
  static const PlateBox motoLetters = PlateBox(56, 0.2, 98, 105);
  static const PlateBox motoDigits = PlateBox(14, 84, 136, 116);
}

/// Text groups are `letters` and `number`; the diplomatic plate has `code` and
/// `number`. Each field is one slot, with the dash a painted rule between them.
///
/// [private] is two or three letters and one to three digits; [motorcycle]
/// stacks the same fields; [export] is one letter and up to four digits with a
/// red stamp zone; [aland] adds the `ÅLAND` caption row; [diplomatic] is `C`
/// or `CD` and up to five digits.
///
/// Not implemented: the pre-2001 plate, museum plates and classes with no
/// reference picture.
abstract final class FinlandPlates {
  static final PlateSpec private = _oneRow(
    id: 'fi.private',
    letters: _Layout.regLetters,
    lettersMin: 2,
    dash: _Layout.regDash,
    digits: _Layout.regDigits,
    digitsMax: 3,
    panel: true,
  );

  static final PlateSpec export = _oneRow(
    id: 'fi.export',
    letters: _Layout.expLetter,
    lettersMin: 1,
    lettersMax: 1,
    dash: _Layout.expDash,
    digits: _Layout.expDigits,
    digitsMax: 4,
    panel: true,
    stamp: true,
  );

  static final PlateSpec diplomatic = _oneRow(
    id: 'fi.diplomatic',
    letters: _Layout.dipCode,
    lettersMin: 1,
    lettersMax: 2,
    lettersAlphabet: FinlandAlphabets.diplomaticLetters,
    lettersKey: 'code',
    dash: _Layout.dipDash,
    digits: _Layout.dipDigits,
    digitsMax: 5,
    panel: false,
  );

  static final PlateSpec aland = PlateSpec(
    id: 'fi.aland',
    country: FinlandCountry.finland,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    slots: const <PlateSlot>[
      PlateSlot(
        alphabet: FinlandAlphabets.letters,
        box: _Layout.alandLetters,
        length: 3,
        minLength: 2,
        group: 'letters',
      ),
      PlateSlot(
        alphabet: FinlandAlphabets.digits,
        box: _Layout.alandDigits,
        length: 5,
        minLength: 1,
        group: 'number',
      ),
    ],
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'ÅLAND',
        box: _Layout.alandName,
        glyphHeight: _Layout.alandNameGlyph,
      ),
    ],
    decals: const <PlateDecal>[
      PlateDecal(
        image: AssetImage(
          'assets/countries/finland/icons/aland_coat_of_arms.png',
          package: 'license_plate',
        ),
        box: _Layout.alandCrest,
      ),
    ],
    // The flag drawn as boxes: a red cross on a yellow cross on blue.
    bands: _alandFlag(),
  );

  static final PlateSpec motorcycle = PlateSpec(
    id: 'fi.motorcycle',
    country: FinlandCountry.finland,
    canvasWidth: _Layout.motoWidth,
    canvasHeight: _Layout.motoHeight,
    panel: const PlatePanel(box: _Layout.motoPanel),
    background: const PlateSection.columns(<PlatePart>[
      PlatePart(PlateSection.plain, end: _Layout.motoPanelLeft),
      PlatePart(
        PlateSection.rows(<PlatePart>[
          PlatePart(PlateSection.plain, end: _Layout.motoPanelTop),
          PlatePart(
            PlateSection.fill(PlateFill.panel),
            end: _Layout.motoPanelBottom,
          ),
          PlatePart(PlateSection.plain),
        ]),
        end: _Layout.motoPanelRight,
      ),
      PlatePart(PlateSection.plain),
    ]),
    slots: const <PlateSlot>[
      PlateSlot(
        alphabet: FinlandAlphabets.letters,
        box: _Layout.motoLetters,
        length: 2,
        group: 'letters',
      ),
      PlateSlot(
        alphabet: FinlandAlphabets.digits,
        box: _Layout.motoDigits,
        length: 3,
        minLength: 1,
        group: 'number',
      ),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    motorcycle,
    export,
    aland,
    diplomatic,
  ];

  /// Letters field, painted dash, digits field. [panel] adds the EU panel;
  /// [stamp] the export plate's red zone with its month and year.
  static PlateSpec _oneRow({
    required String id,
    required PlateBox letters,
    required int lettersMin,
    int lettersMax = 3,
    PlateAlphabet lettersAlphabet = FinlandAlphabets.letters,
    String lettersKey = 'letters',
    required PlateBox dash,
    required PlateBox digits,
    required int digitsMax,
    required bool panel,
    bool stamp = false,
  }) => PlateSpec(
    id: id,
    country: FinlandCountry.finland,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: panel
        ? const PlatePanel(box: _Layout.panel)
        : const PlatePanel(box: PlateBox(0, 0, 0, 0)),
    noPanel: !panel,
    background: PlateSection.columns(<PlatePart>[
      if (panel) ...<PlatePart>[
        const PlatePart(PlateSection.plain, end: _Layout.panelLeft),
        const PlatePart(
          PlateSection.rows(<PlatePart>[
            PlatePart(PlateSection.plain, end: _Layout.panelTop),
            PlatePart(
              PlateSection.fill(PlateFill.panel),
              end: _Layout.panelBottom,
            ),
            PlatePart(PlateSection.plain),
          ]),
          end: _Layout.panelRight,
        ),
      ],
      if (stamp) ...<PlatePart>[
        const PlatePart(PlateSection.plain, end: _Layout.expStampLeft),
        const PlatePart(
          PlateSection.fill(PlateFill.color(FinlandColors.exportRed)),
        ),
      ] else
        const PlatePart(PlateSection.plain),
    ]),
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: lettersAlphabet,
        box: letters,
        length: lettersMax,
        minLength: lettersMin,
      ),
      PlateSlot(
        alphabet: FinlandAlphabets.digits,
        box: digits,
        length: digitsMax,
        minLength: 1,
      ),
    ],
    rules: <PlateRule>[PlateRule(box: dash)],
    labels: <PlateLabel>[
      if (stamp) ...const <PlateLabel>[
        PlateLabel(
          text: '2',
          box: _Layout.expMonth,
          glyphHeight: _Layout.expMonthGlyph,
          color: FinlandColors.exportStampInk,
        ),
        PlateLabel(
          text: '21',
          box: _Layout.expYear,
          glyphHeight: _Layout.expYearGlyph,
          color: FinlandColors.exportStampInk,
        ),
      ],
    ],
    textGroups: <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: lettersKey),
      const PlateTextGroup(<int>[1], key: 'number'),
    ],
  );

  /// The flag (52:34): a yellow cross 10 wide under a red cross 4 wide, the
  /// vertical bar at x 21 and the horizontal at y 17.
  static List<PlateBand> _alandFlag() {
    const PlateBox f = _Layout.alandFlag;
    const double sx = 40.8 / 52, sy = 17.7 / 34;
    PlateBox vertical(double w) =>
        PlateBox(f.left + 21 * sx - w * sx / 2, f.top, w * sx, f.height);
    PlateBox horizontal(double w) =>
        PlateBox(f.left, f.top + 17 * sy - w * sy / 2, f.width, w * sy);
    return <PlateBand>[
      PlateBand(box: f, color: FinlandColors.alandFlagBlue),
      PlateBand(box: vertical(10), color: FinlandColors.alandFlagYellow),
      PlateBand(box: horizontal(10), color: FinlandColors.alandFlagYellow),
      PlateBand(box: vertical(4), color: FinlandColors.alandFlagRed),
      PlateBand(box: horizontal(4), color: FinlandColors.alandFlagRed),
    ];
  }
}

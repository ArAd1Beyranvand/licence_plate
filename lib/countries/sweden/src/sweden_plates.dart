import 'package:flutter/widgets.dart' show EdgeInsets;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'sweden_colors.dart';
import 'sweden_country.dart';

/// Ink positions in plate units, measured from reference photos flattened to
/// the article's 520x110 (glyph centres are the middle of each ink run).
///
/// Per plate: the registration's EU band ends at 53 and its star ring is
/// placed at 0.935 of the shared asset; taxi has no band and drops the
/// retired `T`; dealer and diplomatic are evenly pitched runs; the temporary
/// plate stacks day over month at left, between two rules, with the year and
/// a mark at right; the military photo is a tight crop, so its field spans
/// the ink. The short plate is 300 wide (the photo was stretched, so x is
/// scaled back), with a band 40 wide and 58 tall, whose star ring starts at
/// y 0 and so sits 3 low.
///
/// An ink of 79 on a 110 plate would need a ~145 box, so full-size plates use
/// the whole canvas height and the ink lands near 74% of reference. The short
/// plate's reference ink is reachable with its 86 box.
abstract final class _Layout {
  static const double width = 520, height = 110, shortWidth = 300, bandEnd = 53;

  static const double box = 110, top = 0;

  static const double starsLeft = 8.5, starsTop = 3.4;
  static const double starsWidth = 43, starsHeight = 65.8;
  static const double sLeft = 10, sTop = 67, sWidth = 40, sHeight = 24;
  static const double sGlyph = 35;

  static const _Row registration = _Row(
    letterCx: 113.0,
    letterPitch: 62.7,
    digitCx: 323.8,
    digitPitch: 64.4,
  );
  static const _Row taxi = _Row(
    letterCx: 52.1,
    letterPitch: 68.5,
    digitCx: 257.6,
    digitPitch: 68.5,
  );
  static const _Row dealer = _Row(
    letterCx: 53.9,
    letterPitch: 68.7,
    digitCx: 331.9,
    digitPitch: 69.8,
  );

  static const double dipCx = 78, dipPitch = 70.1;

  // Temporary plate.
  static const double dateCx = 18.2, datePitch = 28.6, dateBox = 54;
  static const double dayTop = 1.6, monthTop = 53.6;
  static const double tempLetterCx = 101.1, tempLetterPitch = 58.7;
  static const double tempDigitCx = 288.7, tempDigitPitch = 59;
  static const double yearCx = 458.5, yearPitch = 16.5;
  static const double yearTop = 5.2, yearBox = 39, markCx = 481.7, markBox = 54;
  static const PlateBox ruleLeft = PlateBox(65, 11.7, 2.6, 85.8);
  static const PlateBox ruleRight = PlateBox(440.7, 11, 2.6, 85);

  // Military plate.
  static const double militaryLeft = 20.8, militaryWidth = 478.2;

  // Short plate.
  static const double shortBandEnd = 40, shortBandBottom = 58;
  static const double shortStarsLeft = 9.1, shortStarsTop = 0;
  static const double shortStarsWidth = 28.2, shortStarsHeight = 43.2;
  static const double shortSLeft = 7.4, shortSTop = 35.5;
  static const double shortSWidth = 30, shortSHeight = 24, shortSGlyph = 22;
  static const double shortBox = 86, shortBoxTop = 12;
  static const double shortCx = 76.6, shortPitch = 36.7;
}

/// Letters and digits of a three-letter registration row, each group evenly
/// pitched; the digits are the first two of the number, or all of it.
class _Row {
  const _Row({
    required this.letterCx,
    required this.letterPitch,
    required this.digitCx,
    required this.digitPitch,
  });

  final double letterCx, letterPitch, digitCx, digitPitch;
}

/// Groups: `letters`, `number` on a registration (the number is two digits
/// and a last character, one slot each); `code`, `number`, `status` on a
/// diplomatic plate; `day`, `month`, `letters`, `number`, `year`, `mark` on a
/// temporary one; `number` alone on a military one.
///
/// Mission code CA is refused through [israel] on the diplomatic spec, reason
/// `COUNTRY NOT FOUND`, in the controller, input machine, validator and
/// canvas.
///
/// Not implemented: the historical county-letter series, the square
/// motorcycle plate, personal plates, and the tax sticker.
abstract final class SwedenPlates {
  static const String notFound = 'COUNTRY NOT FOUND';

  static const PlateRestriction israel = PlateRestriction(
    group: 'code',
    values: <String>['CA'],
    reason: notFound,
  );

  static const List<PlateTextGroup> _registrationGroups = <PlateTextGroup>[
    PlateTextGroup(<int>[0], key: 'letters'),
    PlateTextGroup(<int>[1, 2], key: 'number'),
  ];

  static final PlateSpec private = _spec(
    id: 'se.private',
    band: true,
    slots: _registrationSlots(_Layout.registration),
    groups: _registrationGroups,
  );

  static final PlateSpec taxi = _spec(
    id: 'se.taxi',
    slots: _registrationSlots(_Layout.taxi),
    groups: _registrationGroups,
  );

  static final PlateSpec dealer = _spec(
    id: 'se.dealer',
    slots: <PlateSlot>[
      _run(
        SwedenAlphabets.letters,
        3,
        _Layout.dealer.letterCx,
        _Layout.dealer.letterPitch,
      ),
      _run(
        SwedenAlphabets.digits,
        3,
        _Layout.dealer.digitCx,
        _Layout.dealer.digitPitch,
      ),
    ],
    groups: PlateTextGroup.perSlot(<String>['letters', 'number']),
  );

  static final PlateSpec diplomatic = _spec(
    id: 'se.diplomatic',
    slots: <PlateSlot>[
      _run(SwedenAlphabets.missionLetters, 2, _Layout.dipCx, _Layout.dipPitch),
      _run(
        SwedenAlphabets.digits,
        3,
        _Layout.dipCx + 2 * _Layout.dipPitch,
        _Layout.dipPitch,
      ),
      _run(
        SwedenAlphabets.status,
        1,
        _Layout.dipCx + 5 * _Layout.dipPitch,
        _Layout.dipPitch,
      ),
    ],
    groups: PlateTextGroup.perSlot(<String>['code', 'number', 'status']),
    restrictions: const <PlateRestriction>[israel],
  );

  static final PlateSpec temporary = _spec(
    id: 'se.temporary',
    slots: <PlateSlot>[
      for (final double top in <double>[_Layout.dayTop, _Layout.monthTop])
        _run(
          SwedenAlphabets.digits,
          2,
          _Layout.dateCx,
          _Layout.datePitch,
          height: _Layout.dateBox,
          top: top,
        ),
      _run(
        SwedenAlphabets.letters,
        3,
        _Layout.tempLetterCx,
        _Layout.tempLetterPitch,
      ),
      _run(
        SwedenAlphabets.digits,
        3,
        _Layout.tempDigitCx,
        _Layout.tempDigitPitch,
      ),
      _run(
        SwedenAlphabets.digits,
        4,
        _Layout.yearCx,
        _Layout.yearPitch,
        height: _Layout.yearBox,
        top: _Layout.yearTop,
      ),
      _run(
        SwedenAlphabets.last,
        1,
        _Layout.markCx,
        _Layout.markBox,
        height: _Layout.markBox,
        top: _Layout.monthTop,
      ),
    ],
    groups: PlateTextGroup.perSlot(<String>[
      'day',
      'month',
      'letters',
      'number',
      'year',
      'mark',
    ]),
    rules: const <PlateRule>[
      PlateRule(box: _Layout.ruleLeft),
      PlateRule(box: _Layout.ruleRight),
    ],
  );

  static final PlateSpec military = _spec(
    id: 'se.military',
    slots: const <PlateSlot>[
      PlateSlot(
        alphabet: SwedenAlphabets.digits,
        box: PlateBox(
          _Layout.militaryLeft,
          _Layout.top,
          _Layout.militaryWidth,
          _Layout.box,
        ),
        length: 6,
        minLength: 4,
      ),
    ],
    groups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'number'),
    ],
  );

  static final PlateSpec american = PlateSpec(
    id: 'se.american',
    country: SwedenCountry.sweden,
    canvasWidth: _Layout.shortWidth,
    canvasHeight: _Layout.height,
    panel: const PlatePanel(
      box: PlateBox(
        _Layout.shortStarsLeft,
        _Layout.shortStarsTop,
        _Layout.shortStarsWidth,
        _Layout.shortStarsHeight,
      ),
      padding: EdgeInsets.zero,
    ),
    background: const PlateSection.columns(<PlatePart>[
      PlatePart(
        PlateSection.rows(<PlatePart>[
          PlatePart(
            PlateSection.fill(PlateFill.panel),
            end: _Layout.shortBandBottom,
          ),
          PlatePart(PlateSection.plain),
        ]),
        end: _Layout.shortBandEnd,
      ),
      PlatePart(PlateSection.plain),
    ]),
    slots: <PlateSlot>[
      _run(
        SwedenAlphabets.letters,
        3,
        _Layout.shortCx,
        _Layout.shortPitch,
        height: _Layout.shortBox,
        top: _Layout.shortBoxTop,
      ),
      _run(
        SwedenAlphabets.digits,
        2,
        _Layout.shortCx + 3 * _Layout.shortPitch,
        _Layout.shortPitch,
        height: _Layout.shortBox,
        top: _Layout.shortBoxTop,
      ),
      _run(
        SwedenAlphabets.last,
        1,
        _Layout.shortCx + 5 * _Layout.shortPitch,
        _Layout.shortPitch,
        height: _Layout.shortBox,
        top: _Layout.shortBoxTop,
      ),
    ],
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'S',
        box: PlateBox(
          _Layout.shortSLeft,
          _Layout.shortSTop,
          _Layout.shortSWidth,
          _Layout.shortSHeight,
        ),
        glyphHeight: _Layout.shortSGlyph,
        color: SwedenColors.euroInk,
      ),
    ],
    textGroups: _registrationGroups,
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    american,
    taxi,
    dealer,
    diplomatic,
    temporary,
    military,
  ];

  static List<PlateSlot> _registrationSlots(_Row row) => <PlateSlot>[
    _run(SwedenAlphabets.letters, 3, row.letterCx, row.letterPitch),
    _run(SwedenAlphabets.digits, 2, row.digitCx, row.digitPitch),
    _run(
      SwedenAlphabets.last,
      1,
      row.digitCx + 2 * row.digitPitch,
      row.digitPitch,
    ),
  ];

  /// One field of [count] characters at [pitch], the first centred [firstCx].
  static PlateSlot _run(
    PlateAlphabet alphabet,
    int count,
    double firstCx,
    double pitch, {
    double height = _Layout.box,
    double top = _Layout.top,
  }) => plateRun(
    alphabet,
    count,
    left: firstCx - pitch / 2,
    top: top,
    pitch: pitch,
    height: height,
  );

  static PlateSpec _spec({
    required String id,
    required List<PlateSlot> slots,
    required List<PlateTextGroup> groups,
    bool band = false,
    List<PlateRule> rules = const <PlateRule>[],
    List<PlateRestriction> restrictions = const <PlateRestriction>[],
  }) => PlateSpec(
    id: id,
    country: SwedenCountry.sweden,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: band
        ? const PlatePanel(
            box: PlateBox(
              _Layout.starsLeft,
              _Layout.starsTop,
              _Layout.starsWidth,
              _Layout.starsHeight,
            ),
            padding: EdgeInsets.zero,
          )
        : const PlatePanel(box: PlateBox(0, 0, 0, 0)),
    noPanel: !band,
    background: band
        ? const PlateSection.columns(<PlatePart>[
            PlatePart(PlateSection.fill(PlateFill.panel), end: _Layout.bandEnd),
            PlatePart(PlateSection.plain),
          ])
        : PlateSection.plain,
    slots: slots,
    rules: rules,
    labels: <PlateLabel>[
      if (band)
        const PlateLabel(
          text: 'S',
          box: PlateBox(
            _Layout.sLeft,
            _Layout.sTop,
            _Layout.sWidth,
            _Layout.sHeight,
          ),
          glyphHeight: _Layout.sGlyph,
          color: SwedenColors.euroInk,
        ),
    ],
    textGroups: groups,
    restrictions: restrictions,
  );
}

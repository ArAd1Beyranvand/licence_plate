import 'package:flutter/widgets.dart' show AssetImage;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'lithuania_colors.dart';
import 'lithuania_country.dart';
import 'lithuania_missions.dart';

/// Measured on references flattened to 520×110 (4 px per unit). Ink is about
/// 0.55 of a box, so a box would need ~150 for the 80-unit ink; every field
/// box is the full 110, which lands the ink at roughly 75 % of reference.
///
/// Field spans come from the ink runs of the flattened photographs (letters
/// found by colour mask, runs split on gaps over 6 units). Where a field has a
/// printed pitch the box is `count * pitch` centred on the ink and `spacing`
/// reproduces the pitch.
///
/// Ink extents (x) behind the boxes:
/// - private: letters 110.2–308.2 (pitch 71), digits 332.8–499.8 (pitch 61);
///   panel x ~5–47 (corner sheet, ±2); coat of arms x 58–93.5, y 33–76.5
/// - taxi: `T` 130–179.5, digits 188.8–467 (pitch 58.3)
/// - dealer: `P` 61.5–119, digits 137.8–448.2 (pitch 66)
/// - temporary: not measurable by mask (red frame merges with the ink), so the
///   spans are read off the photograph: digits ~133–345, letters ~345–449
/// - military: `LK` 115.5–241.2 (pitch 69), digits 257.5–421.8 (pitch 60),
///   letter 436–494; flag x 6.5–45.5, y 11 (drawn 5:3)
/// - agricultural: letter 124.2–190.2, digits 202.2–397.2, letter 411.2–476.5
/// - diplomatic: digits 88.2–192.2 (pitch 60), 237–279, 324.5–425.5+ (pitch 60)
abstract final class _Layout {
  static const double width = 520, height = 110;

  static const _Panel panel = _Panel(5, 47, 4.5, 105.5);

  static const PlateBox privateLetters = PlateBox(102.5, 0, 213, height);
  static const PlateBox privateDigits = PlateBox(324.5, 0, 183, height);
  static const PlateBox privateCrest = PlateBox(58, 33, 35.5, 43.5);

  static const PlateBox taxiLetter = PlateBox(122.7, 0, 60, height);
  static const PlateBox taxiDigits = PlateBox(183, 0, 291, height);

  static const PlateBox dealerLetter = PlateBox(60, 0, 60, height);
  static const PlateBox dealerDigits = PlateBox(127, 0, 330, height);

  static const PlateBox temporaryDigits = PlateBox(131, 0, 212, height);
  static const PlateBox temporaryLetters = PlateBox(345, 0, 106, height);

  static const PlateBox militaryCode = PlateBox(109.5, 0, 138, height);
  static const PlateBox militaryDigits = PlateBox(249, 0, 180, height);
  static const PlateBox militaryLetter = PlateBox(435, 0, 60, height);
  static const PlateBox militaryFlag = PlateBox(6.5, 11, 39, 23.4);

  // A variable-length number between two letters: the box holds the
  // three-digit run; a fourth digit scales the run down to fit.
  static const PlateBox farmPrefix = PlateBox(124, 0, 66, height);
  static const PlateBox farmDigits = PlateBox(196, 0, 207, height);
  static const PlateBox farmSuffix = PlateBox(411, 0, 65.5, height);

  static const PlateBox diplomaticMission = PlateBox(78, 0, 124, height);
  static const PlateBox diplomaticStatus = PlateBox(226.7, 0, 62, height);
  static const PlateBox diplomaticSerial = PlateBox(306.7, 0, 186, height);

  /// Letter spacing that puts glyphs at [pitch] (the font advance is about
  /// 0.6 of its 0.72-of-height size).
  static double spacing(double pitch) => plateRunSpacing(pitch, height);
}

/// Text groups are named per field; each field is one slot.
///
/// [private] is three letters and three digits (`ABC 123`) under the coat of
/// arms; [taxi] is `T` and five digits; [dealer] is `P` and five digits
/// (since 2018); [temporary] is four digits and one or two letters (one for
/// motorcycles); [military] is `LK`, three digits and a letter; [agricultural]
/// is a letter, three or four digits and a letter; [diplomatic] is a two-digit
/// mission, a status digit and a two-or-three digit serial, and refuses
/// code 41 (see [LithuaniaMissions]).
///
/// Not implemented: the 1993–2004 and 2004–2018 liveries (superseded), the
/// electric `E A1234`, trailer, motorcycle, moped and quadricycle formats and
/// sizes, vintage `H` plates, and the 300×150 and US-size plates; the
/// agricultural reference is a small plate and is drawn here on the long one.
abstract final class LithuaniaPlates {
  static final PlateSpec private = _build(
    id: 'lt.private',
    panel: _Layout.panel,
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: LithuaniaAlphabets.letters,
        box: _Layout.privateLetters,
        length: 3,
        spacing: _Layout.spacing(71),
      ),
      PlateSlot(
        alphabet: LithuaniaAlphabets.digits,
        box: _Layout.privateDigits,
        length: 3,
        spacing: _Layout.spacing(61),
      ),
    ],
    groups: PlateTextGroup.perSlot(<String>['letters', 'number']),
    // The coat of arms is a complex emblem, so a decal.
    // Source: https://commons.wikimedia.org/wiki/File:Coat_of_arms_of_Lithuania.svg
    decals: const <PlateDecal>[
      PlateDecal(
        image: AssetImage(
          'assets/countries/lithuania/icons/lithuania_coat_of_arms.png',
          package: 'license_plate',
        ),
        box: _Layout.privateCrest,
      ),
    ],
  );

  static final PlateSpec taxi = _prefixed(
    'lt.taxi',
    _Layout.taxiLetter,
    _Layout.taxiDigits,
    58.3,
  );

  static final PlateSpec dealer = _prefixed(
    'lt.dealer',
    _Layout.dealerLetter,
    _Layout.dealerDigits,
    66,
  );

  static final PlateSpec temporary = _build(
    id: 'lt.temporary',
    panel: _Layout.panel,
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: LithuaniaAlphabets.digits,
        box: _Layout.temporaryDigits,
        length: 4,
        spacing: _Layout.spacing(53),
      ),
      PlateSlot(
        alphabet: LithuaniaAlphabets.letters,
        box: _Layout.temporaryLetters,
        length: 2,
        minLength: 1,
      ),
    ],
    groups: PlateTextGroup.perSlot(<String>['number', 'letters']),
  );

  /// The flag is three stripes, so it is drawn rather than shipped.
  static final PlateSpec military = _build(
    id: 'lt.military',
    panel: null,
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: LithuaniaAlphabets.letters,
        box: _Layout.militaryCode,
        length: 2,
        spacing: _Layout.spacing(69),
      ),
      PlateSlot(
        alphabet: LithuaniaAlphabets.digits,
        box: _Layout.militaryDigits,
        length: 3,
        spacing: _Layout.spacing(60),
      ),
      PlateSlot(
        alphabet: LithuaniaAlphabets.letters,
        box: _Layout.militaryLetter,
        length: 1,
      ),
    ],
    groups: PlateTextGroup.perSlot(<String>['code', 'number', 'letters']),
    decals: const <PlateDecal>[
      PlateDecal(
        drawing: PlateDrawing(5, 3, <PlateShape>[
          PlateRectShape(0, 0, 5, 1, LithuaniaColors.flagYellow),
          PlateRectShape(0, 1, 5, 1, LithuaniaColors.flagGreen),
          PlateRectShape(0, 2, 5, 1, LithuaniaColors.flagRed),
        ]),
        box: _Layout.militaryFlag,
      ),
    ],
  );

  static final PlateSpec agricultural = _build(
    id: 'lt.agricultural',
    panel: _Layout.panel,
    slots: const <PlateSlot>[
      PlateSlot(
        alphabet: LithuaniaAlphabets.letters,
        box: _Layout.farmPrefix,
        length: 1,
      ),
      PlateSlot(
        alphabet: LithuaniaAlphabets.digits,
        box: _Layout.farmDigits,
        length: 4,
        minLength: 3,
      ),
      PlateSlot(
        alphabet: LithuaniaAlphabets.letters,
        box: _Layout.farmSuffix,
        length: 1,
      ),
    ],
    groups: PlateTextGroup.perSlot(<String>['prefix', 'number', 'suffix']),
  );

  static final PlateSpec diplomatic = _build(
    id: 'lt.diplomatic',
    panel: null,
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: LithuaniaAlphabets.digits,
        box: _Layout.diplomaticMission,
        length: 2,
        spacing: _Layout.spacing(62),
      ),
      PlateSlot(
        alphabet: LithuaniaAlphabets.digits,
        box: _Layout.diplomaticStatus,
        length: 1,
      ),
      PlateSlot(
        alphabet: LithuaniaAlphabets.digits,
        box: _Layout.diplomaticSerial,
        length: 3,
        minLength: 2,
      ),
    ],
    groups: PlateTextGroup.perSlot(<String>['mission', 'status', 'serial']),
    restrictions: const <PlateRestriction>[LithuaniaMissions.restriction],
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    taxi,
    dealer,
    temporary,
    military,
    agricultural,
    diplomatic,
  ];

  /// A constant letter and five digits (taxi `T`, dealer `P`).
  static PlateSpec _prefixed(
    String id,
    PlateBox letter,
    PlateBox digits,
    double pitch,
  ) => _build(
    id: id,
    panel: _Layout.panel,
    slots: <PlateSlot>[
      PlateSlot(alphabet: LithuaniaAlphabets.letters, box: letter, length: 1),
      PlateSlot(
        alphabet: LithuaniaAlphabets.digits,
        box: digits,
        length: 5,
        spacing: _Layout.spacing(pitch),
      ),
    ],
    groups: PlateTextGroup.perSlot(<String>['prefix', 'number']),
  );

  static PlateSpec _build({
    required String id,
    required _Panel? panel,
    required List<PlateSlot> slots,
    required List<PlateTextGroup> groups,
    List<PlateDecal> decals = const <PlateDecal>[],
    List<PlateRestriction> restrictions = const <PlateRestriction>[],
  }) => PlateSpec(
    id: id,
    country: LithuaniaCountry.lithuania,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
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
    decals: decals,
    textGroups: groups,
    restrictions: restrictions,
  );
}

class _Panel {
  const _Panel(this.left, this.right, this.top, this.bottom);

  final double left, right, top, bottom;

  PlateBox get box => PlateBox.fromLTRB(left, top, right, bottom);
}

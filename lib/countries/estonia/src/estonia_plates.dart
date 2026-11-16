import 'package:flutter/widgets.dart' show AssetImage;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'estonia_country.dart';

/// Measured on references flattened to 520×110 (4 px per unit). Ink is about
/// 0.55 of a box, so a box would need ~125 for the regular plate's 68.7 ink,
/// more than the canvas; every field box is the full 110, which lands the ink
/// at roughly 87 % of reference.
///
/// Ink extents (x, y) behind the boxes:
/// - regular: digits 92.2–236.8, letters 297.2–463.0, y 19.5–88.2;
///   panel x 10–56.5, y 8.75–100.75
/// - diplomatic: `CD` 88.8–215.8, digits 263.2–482.2, y 18.8–90.2;
///   panel x 6–56.5, y 7–103.25
/// - defence: digits 45.5–189.8, letters 290.8–471.0, y 16.8–90.8
/// - president: panel x 8.25–59, y 1–108; crest x 212–311, y 5–104
abstract final class _Layout {
  static const double width = 520, height = 110;

  static const _Panel regPanel = _Panel(10, 56.5, 8.75, 100.75);
  static const _Panel dipPanel = _Panel(6, 56.5, 7, 103.25);
  static const _Panel presPanel = _Panel(8.25, 59, 1, 108);

  static const PlateBox regDigits = PlateBox(90, 0, 149, height);
  static const PlateBox regLetters = PlateBox(295, 0, 170, height);

  // `CD`, `AT` or `CMD`: centred on the two-letter ink (centre 152.3).
  static const PlateBox dipLetters = PlateBox(72, 0, 160, height);
  static const PlateBox dipDigits = PlateBox(258, 0, 229, height);

  static const PlateBox defDigits = PlateBox(43, 0, 149, height);
  static const PlateBox defLetters = PlateBox(288, 0, 185, height);

  static const PlateBox presCrest = PlateBox(208.5, 5.2, 106, 98.8);
}

/// Text groups are `number` and `letters`; the diplomatic plate's letters are
/// `code`. Each field is one slot.
///
/// [private] is three digits and three letters (A1); [diplomatic] is `CD`/`AT`
/// or `CMD` and two to four digits (A4–A7); [defence] is three digits and a
/// `K`/`EK` letter group; [president] carries the coat of arms and no number.
///
/// Not implemented: the pre-2004 and Soviet-era plates (former), and the
/// special-order, reduced-size, transferable, classic, racing, moped, transit
/// and tractor classes, which have no reference picture.
abstract final class EstoniaPlates {
  static final PlateSpec private = _build(
    id: 'ee.private',
    country: EstoniaCountry.estonia,
    panel: _Layout.regPanel,
    slots: const <PlateSlot>[
      PlateSlot(
        alphabet: EstoniaAlphabets.digits,
        box: _Layout.regDigits,
        length: 3,
      ),
      PlateSlot(
        alphabet: EstoniaAlphabets.letters,
        box: _Layout.regLetters,
        length: 3,
      ),
    ],
    groups: PlateTextGroup.perSlot(<String>['number', 'letters']),
  );

  static final PlateSpec diplomatic = _build(
    id: 'ee.diplomatic',
    country: EstoniaCountry.diplomatic,
    panel: _Layout.dipPanel,
    slots: const <PlateSlot>[
      PlateSlot(
        alphabet: EstoniaAlphabets.letters,
        box: _Layout.dipLetters,
        length: 3,
        minLength: 2,
      ),
      PlateSlot(
        alphabet: EstoniaAlphabets.digits,
        box: _Layout.dipDigits,
        length: 4,
        minLength: 2,
      ),
    ],
    groups: PlateTextGroup.perSlot(<String>['code', 'number']),
  );

  static final PlateSpec defence = _build(
    id: 'ee.defence',
    country: EstoniaCountry.estonia,
    panel: null,
    slots: const <PlateSlot>[
      PlateSlot(
        alphabet: EstoniaAlphabets.digits,
        box: _Layout.defDigits,
        length: 3,
      ),
      PlateSlot(
        alphabet: EstoniaAlphabets.letters,
        box: _Layout.defLetters,
        length: 3,
        minLength: 2,
      ),
    ],
    groups: PlateTextGroup.perSlot(<String>['number', 'letters']),
  );

  /// The coat of arms is a complex emblem, so a decal.
  /// Source: https://commons.wikimedia.org/wiki/File:Coat_of_arms_of_Estonia.svg
  static final PlateSpec president = _build(
    id: 'ee.president',
    country: EstoniaCountry.estonia,
    panel: _Layout.presPanel,
    slots: const <PlateSlot>[],
    groups: const <PlateTextGroup>[],
    decals: const <PlateDecal>[
      PlateDecal(
        image: AssetImage(
          'assets/countries/estonia/icons/estonia_coat_of_arms.png',
          package: 'license_plate',
        ),
        box: _Layout.presCrest,
      ),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    diplomatic,
    defence,
    president,
  ];

  static PlateSpec _build({
    required String id,
    required PlateCountry country,
    required _Panel? panel,
    required List<PlateSlot> slots,
    required List<PlateTextGroup> groups,
    List<PlateDecal> decals = const <PlateDecal>[],
  }) => PlateSpec(
    id: id,
    country: country,
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
  );
}

class _Panel {
  const _Panel(this.left, this.right, this.top, this.bottom);

  final double left, right, top, bottom;

  PlateBox get box => PlateBox.fromLTRB(left, top, right, bottom);
}

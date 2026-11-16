import 'package:license_plate/core/plate_core.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';

import 'singapore_colors.dart';
import 'singapore_country.dart';

/// Where the ink sits on a Singaporean plate, in plate units.
///
/// Sizes: the article gives 520×110 mm (one line) and 325×160 mm (two lines,
/// "square"). Every number below was read off the offline stage's flattened
/// photos, which are normalised to 520×110; the two-line figures are those
/// scaled by 325/520 across and 160/110 down.
///
/// **One line** (`SNB 9538 E`, `GBF 307 K`, `YN 1219 K`, `XE 2017 D`, ...):
/// ink rows y 14.2..85.2 on the standard plate (71 tall). Fields, x:
///   prefix 20.8..200.2 · serial 219.8..446.5 (four digits) · check 464.2..499
/// The same split holds on the euro front (3: 27..198, 4: 219..418.5,
/// 1: 438.5..490.5), the off-peak and hazardous illustrations (26..196.2,
/// 263.5..494; 38.5..161.5 for a two-letter prefix) within a few units.
///
/// **Under-height ink, accepted.** 71 mm of ink would need a ~129 mm slot on
/// a 110 mm plate (`glyphStyle` sets 0.72 of the slot, a bold cap is ~0.75
/// of that). The slots are as tall as the plate allows (104), ~80% of the
/// reference ink. `plate_core` is unchanged.
///
/// **Variable fields.** The prefix is one to three letters ("S", "SH",
/// "SBA") and the number one to four digits (no leading zeros), so each is
/// one slot sized for the longest run with `minLength` 1; the text is
/// centred in it, where the real plate is left-aligned. The checksum is one
/// letter, absent on government and event plates; it is still part of
/// completion.
///
/// **Two lines** (motorcycles `F_`, engineering plant `W_`): rows' ink
/// y 17.5..81.5 and 89.5..148.4. Top: the prefix, x 68..250. Bottom: the
/// number 16.8..236 and the checksum 264..307. Slots 76 tall: rows 64 and 59
/// tall would need ~110 mm slots.
///
/// Not drawn: the car-club and dealer frames (`CARCLUB by TRIBECAR`,
/// `HYUNDAI`, `MOTORVIVA PTE LTD`) are the vehicle's, not the plate's; the
/// off-peak tamper seal and the registration stickers are not modelled.
abstract final class _Layout {
  static const double width = 520, height = 110, slotTop = 3, slotHeight = 104;

  static const double prefixLeft = 18, prefixWidth = 186, serialLeft = 216;
  static const double serialWidth = 234, checkLeft = 458, checkWidth = 44;

  static const double twoWidth = 325, twoHeight = 160, twoSlotHeight = 76;
  static const double twoRow1Top = 11.5, twoRow2Top = 81, twoPrefixLeft = 68;
  static const double twoPrefixWidth = 182, twoSerialLeft = 14;
  static const double twoSerialWidth = 226, twoCheckLeft = 258;
  static const double twoCheckWidth = 53;

  /// Classic plate: red above, yellow below, the boundary at y ≈ 60 of 110
  /// (the photo's left edge turns from red to yellow between 57 and 61.5).
  static const double classicSplit = 60;

  /// Restricted use: the red/green boundary runs from the top-left corner to
  /// the bottom-right (atan(110 / 520)), crossing the middle at y 55.
  static const double restrictedAngle = -0.2086, restrictedMid = 55;
}

/// Singapore's plate geometries. Every livery of a geometry shares its spec;
/// the colours are the theme's, except the two-tone classic and restricted
/// plates, whose halves are their own background.
///
/// Every spec has three fields (`prefix`, `serial`, `check`), one slot each.
///
/// Categories: private and commercial cars, taxis, buses, goods, emergency
/// and law-enforcement plates are `line` in `SingaporeThemes.private`, `front`
/// or `rear`; off-peak, hazardous cargo and Pulau Ubin are `line` in their
/// own themes; classic/vintage and restricted-use have their own backgrounds;
/// motorcycles and engineering plant are `twoLine`. Trailers (`TR_`) have no
/// reference and use `line`. The RD plate's photograph is too small to read a
/// livery from, and the euro-style 2000 scheme's rim is not measured.
abstract final class SingaporePlates {
  static final List<PlateTextGroup> _groups = PlateTextGroup.perSlot(<String>[
    'prefix',
    'serial',
    'check',
  ]);

  static PlateSlot _field(
    PlateAlphabet alphabet,
    double left,
    double top,
    double width,
    double height,
    int length, {
    int? minLength,
  }) => PlateSlot(
    alphabet: alphabet,
    box: PlateBox(left, top, width, height),
    length: length,
    minLength: minLength,
  );

  static PlateSpec _line(String id, {PlateSection? background}) => PlateSpec(
    id: id,
    country: SingaporeCountry.singapore,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
    background: background ?? PlateSection.plain,
    slots: <PlateSlot>[
      _field(
        SingaporeAlphabets.letters,
        _Layout.prefixLeft,
        _Layout.slotTop,
        _Layout.prefixWidth,
        _Layout.slotHeight,
        3,
        minLength: 1,
      ),
      _field(
        SingaporeAlphabets.digits,
        _Layout.serialLeft,
        _Layout.slotTop,
        _Layout.serialWidth,
        _Layout.slotHeight,
        4,
        minLength: 1,
      ),
      _field(
        SingaporeAlphabets.letters,
        _Layout.checkLeft,
        _Layout.slotTop,
        _Layout.checkWidth,
        _Layout.slotHeight,
        1,
      ),
    ],
    textGroups: _groups,
  );

  /// The one-line plate: `SNB 9538 E`.
  static final PlateSpec line = _line('sg.line');

  /// Classic and vintage vehicles: the field is red above and yellow below.
  static final PlateSpec classic = _line(
    'sg.classic',
    background: const PlateSection.rows(<PlatePart>[
      PlatePart(
        PlateSection.fill(PlateFill.color(SingaporeColors.classicRed)),
        end: _Layout.classicSplit,
      ),
      PlatePart(
        PlateSection.fill(PlateFill.color(SingaporeColors.classicYellow)),
      ),
    ]),
  );

  /// Restricted-use vehicles: red above, emerald green below, split on the
  /// diagonal.
  static final PlateSpec restricted = _line(
    'sg.restricted',
    background: const PlateSection.fill(
      PlateFill.stripes(
        <PlateFill>[
          PlateFill.color(SingaporeColors.restrictedRed),
          PlateFill.color(SingaporeColors.restrictedGreen),
        ],
        stops: <double>[_Layout.restrictedMid],
        angle: _Layout.restrictedAngle,
      ),
    ),
  );

  /// The squarish two-line plate: the prefix over the number and checksum.
  static final PlateSpec twoLine = PlateSpec(
    id: 'sg.twoLine',
    country: SingaporeCountry.singapore,
    canvasWidth: _Layout.twoWidth,
    canvasHeight: _Layout.twoHeight,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.twoHeight)),
    slots: <PlateSlot>[
      _field(
        SingaporeAlphabets.letters,
        _Layout.twoPrefixLeft,
        _Layout.twoRow1Top,
        _Layout.twoPrefixWidth,
        _Layout.twoSlotHeight,
        3,
        minLength: 1,
      ),
      _field(
        SingaporeAlphabets.digits,
        _Layout.twoSerialLeft,
        _Layout.twoRow2Top,
        _Layout.twoSerialWidth,
        _Layout.twoSlotHeight,
        4,
        minLength: 1,
      ),
      _field(
        SingaporeAlphabets.letters,
        _Layout.twoCheckLeft,
        _Layout.twoRow2Top,
        _Layout.twoCheckWidth,
        _Layout.twoSlotHeight,
        1,
      ),
    ],
    textGroups: _groups,
  );
}

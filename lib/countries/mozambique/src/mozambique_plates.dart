import 'package:flutter/widgets.dart' show AssetImage, EdgeInsets;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'mozambique_colors.dart';
import 'mozambique_country.dart';
import 'mozambique_regions.dart';

/// Where the ink sits, in plate units, measured from photos flattened to
/// 520 wide (239 high for the two-row plates, 145 for the one-row plate).
///
/// Every ink is 80-100 tall on a plate 145-239 high; at 0.55 ink per box a
/// box must be about 1.8 times the ink, which the canvas cannot hold near an
/// edge. Each box is the largest centred one that stays on the plate, so the
/// ink lands at 73-85% of the references'.
abstract final class _Layout {
  static const double width = 520;

  // 2011 plate.
  static const double modernHeight = 239;
  static const double modernRow1Top = 0.1, modernRow1Box = 117;
  static const double modernRow2Top = 102.6, modernRow2Box = 136;
  static const double gridFirst = 65, gridPitch = 83;
  static const double provinceFirst = 391, provincePitch = 79;
  static const PlateBox emblem = PlateBox(391.5, 7, 61, 66);
  static const double fadeMiddle = 95, fadeFoot = 175;

  // Pre-2011 two-row.
  static const double legacyRow1Top = 0, legacyRow1Box = 115.6;
  static const double legacyRow2Top = 77.9, legacyRow2Box = 154;
  static const double legacyLetterFirst = 172, legacyLetterPitch = 110;
  static const double legacyDigitPitch = 101;
  static const double legacyDash = 260, legacyDashWidth = 80;

  // Pre-2011 one-row.
  static const double rowHeight = 145, rowTop = 0.3, rowBox = 133;
  static const double rowLetterFirst = 67, rowLetterPitch = 50;
  static const double rowDigitPitch = 54;
  static const double rowDash1 = 214, rowDash2 = 354, rowDashWidth = 40;
}

/// The Mozambican plates.
///
/// [private] is the 2011 series, `ABC 123 MC`: groups `letters`, `number`,
/// `province`; the white-to-blue fade is painted into the background and the
/// national emblem is a decal (a crest with a ribbon, too detailed to draw).
/// [legacy] (`MLY 01-81`, groups `letters`, `first`, `second`) and
/// [legacyOneRow] (`MLW-17-30`, same groups) are the pre-2011 light-on-dark
/// plates, kept because they are still on the road.
///
/// Not implemented: the dealer line printed on some pre-2011 plates (it is
/// free text, `CAR CENTER MAPUTO` in the photo), and the 2011 plate's one-row
/// variant, for which the article gives no measured plate.
abstract final class MozambiquePlates {
  /// Emblem: https://commons.wikimedia.org/wiki/File:Emblem_of_Mozambique.svg
  static const AssetImage _emblem = AssetImage(
    'assets/countries/mozambique/icons/emblem_of_mozambique.png',
    package: 'license_plate',
  );

  static final PlateSpec private = _spec(
    id: 'mz.private',
    height: _Layout.modernHeight,
    background: const PlateSection.fill(
      PlateFill.stripes(
        <PlateFill>[
          PlateFill.field,
          PlateFill.color(MozambiqueColors.modernMiddle),
          PlateFill.color(MozambiqueColors.modernFoot),
        ],
        stops: <double>[_Layout.fadeMiddle, _Layout.fadeFoot],
      ),
    ),
    decals: const <PlateDecal>[PlateDecal(image: _emblem, box: _Layout.emblem)],
    slots: <PlateSlot>[
      _field(
        MozambiqueAlphabets.letters,
        3,
        _Layout.gridFirst,
        _Layout.gridPitch,
        _Layout.modernRow1Top,
        _Layout.modernRow1Box,
      ),
      _field(
        MozambiqueAlphabets.digits,
        3,
        _Layout.gridFirst,
        _Layout.gridPitch,
        _Layout.modernRow2Top,
        _Layout.modernRow2Box,
      ),
      _field(
        MozambiqueAlphabets.letters,
        2,
        _Layout.provinceFirst,
        _Layout.provincePitch,
        _Layout.modernRow2Top,
        _Layout.modernRow2Box,
      ),
    ],
    groups: PlateTextGroup.perSlot(<String>['letters', 'number', 'province']),
    resolveRegion: MozambiqueRegions.captionOf,
  );

  static final PlateSpec legacy = _spec(
    id: 'mz.legacy',
    height: _Layout.modernHeight,
    slots: <PlateSlot>[
      _field(
        MozambiqueAlphabets.letters,
        3,
        _Layout.legacyLetterFirst,
        _Layout.legacyLetterPitch,
        _Layout.legacyRow1Top,
        _Layout.legacyRow1Box,
      ),
      _field(
        MozambiqueAlphabets.digits,
        2,
        77,
        _Layout.legacyDigitPitch,
        _Layout.legacyRow2Top,
        _Layout.legacyRow2Box,
      ),
      _field(
        MozambiqueAlphabets.digits,
        2,
        367,
        _Layout.legacyDigitPitch,
        _Layout.legacyRow2Top,
        _Layout.legacyRow2Box,
      ),
    ],
    groups: _legacyGroups,
    labels: <PlateLabel>[
      _dash(
        _Layout.legacyDash,
        _Layout.legacyDashWidth,
        _Layout.legacyRow2Top,
        _Layout.legacyRow2Box,
      ),
    ],
  );

  static final PlateSpec legacyOneRow = _spec(
    id: 'mz.legacy.one_row',
    height: _Layout.rowHeight,
    slots: <PlateSlot>[
      _field(
        MozambiqueAlphabets.letters,
        3,
        _Layout.rowLetterFirst,
        _Layout.rowLetterPitch,
        _Layout.rowTop,
        _Layout.rowBox,
      ),
      _field(
        MozambiqueAlphabets.digits,
        2,
        256,
        _Layout.rowDigitPitch,
        _Layout.rowTop,
        _Layout.rowBox,
      ),
      _field(
        MozambiqueAlphabets.digits,
        2,
        399,
        _Layout.rowDigitPitch,
        _Layout.rowTop,
        _Layout.rowBox,
      ),
    ],
    groups: _legacyGroups,
    labels: <PlateLabel>[
      for (final double cx in <double>[_Layout.rowDash1, _Layout.rowDash2])
        _dash(cx, _Layout.rowDashWidth, _Layout.rowTop, _Layout.rowBox),
    ],
  );

  static const List<PlateTextGroup> _legacyGroups = <PlateTextGroup>[
    PlateTextGroup(<int>[0], key: 'letters'),
    PlateTextGroup(<int>[1], key: 'first'),
    PlateTextGroup(<int>[2], key: 'second'),
  ];

  static List<PlateSpec> get all => <PlateSpec>[private, legacy, legacyOneRow];

  /// One slot of [count] cells of [pitch], the first centred on [firstCx].
  static PlateSlot _field(
    PlateAlphabet alphabet,
    int count,
    double firstCx,
    double pitch,
    double top,
    double box,
  ) => plateRun(
    alphabet,
    count,
    left: firstCx - pitch / 2,
    top: top,
    pitch: pitch,
    height: box,
  );

  static PlateLabel _dash(double cx, double width, double top, double box) =>
      PlateLabel(
        text: '-',
        box: PlateBox(cx - width / 2, top, width, box),
        glyphHeight: box,
      );

  static PlateSpec _spec({
    required String id,
    required double height,
    required List<PlateSlot> slots,
    required List<PlateTextGroup> groups,
    PlateSection background = PlateSection.plain,
    List<PlateLabel> labels = const <PlateLabel>[],
    List<PlateDecal> decals = const <PlateDecal>[],
    PlateLabelResolver? resolveRegion,
  }) => PlateSpec(
    id: id,
    country: MozambiqueCountry.mozambique,
    canvasWidth: _Layout.width,
    canvasHeight: height,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, 0),
      padding: EdgeInsets.zero,
    ),
    noPanel: true,
    background: background,
    decals: decals,
    slots: slots,
    labels: labels,
    textGroups: groups,
    resolveRegion: resolveRegion,
  );
}

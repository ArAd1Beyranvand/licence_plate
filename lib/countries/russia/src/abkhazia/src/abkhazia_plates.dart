import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'abkhazia_colors.dart';
import 'abkhazia_country.dart';

/// Ink-run measurements of the references flattened to 520×110 mm
/// (`.plateref/ab/brief.md`): a divider at x 398, `ABH` and the flag to its
/// right. The diplomatic plate is a photograph of one car, so its spans are
/// approximate. Ink prints ~77% of the reference height (see the Ukraine
/// layout note: the box is the full 106 and `glyphStyle` paints ~0.55 of it).
abstract final class _Layout {
  static const double width = 520, height = 110, rowTop = 2, rowHeight = 106;
  static const double dividerEnd = 398, dividerThickness = 3;

  static const PlateBox flag = PlateBox(411, 49, 82, 51);
  static const PlateBox abh = PlateBox(405, 10, 96, 36);
  static const double abhGlyph = 55;

  static const PlateBox abhDiplomatic = PlateBox(405, 42, 96, 36);
  static const double abhDiplomaticGlyph = 40;
}

const PlateAlphabet _digits = AbkhaziaAlphabets.digits;
const PlateAlphabet _letters = AbkhaziaAlphabets.letters;

/// * [private] — `А377АБ`: a letter, three digits and two letters, then `ABH`
///   and the flag. Black on white.
/// * [diplomatic] — `002 CD 1`, silver on dark red with `ABH`. The status
///   letters and the number length are assumed from Russia: the one photo
///   shows only `CD`.
abstract final class AbkhaziaPlates {
  static const PlateSection _divided = PlateSection.columns(<PlatePart>[
    PlatePart(
      PlateSection.plain,
      end: _Layout.dividerEnd,
      divider: _Layout.dividerThickness,
    ),
    PlatePart(PlateSection.plain),
  ]);

  static PlateSlot _slot(
    PlateAlphabet alphabet,
    double left,
    double right,
    int length, {
    int? minLength,
    double top = _Layout.rowTop,
    double height = _Layout.rowHeight,
  }) {
    final double pitch = (right - left) / length;
    return PlateSlot(
      alphabet: alphabet,
      box: PlateBox(left, top, right - left, height),
      length: length,
      minLength: minLength,
      spacing: length == 1 || minLength != null && minLength != length
          ? 0
          : plateRunSpacing(pitch, height),
    );
  }

  static final PlateSpec private = PlateSpec(
    id: 'ab.private',
    country: AbkhaziaCountry.abkhazia,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
    background: _divided,
    slots: <PlateSlot>[
      _slot(_letters, 37.5, 84.2, 1),
      _slot(_digits, 101.8, 258.8, 3),
      _slot(_letters, 281.2, 379.2, 2),
    ],
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'ABH',
        box: _Layout.abh,
        glyphHeight: _Layout.abhGlyph,
        color: AbkhaziaColors.black,
      ),
    ],
    decals: const <PlateDecal>[
      PlateDecal(
        image: AssetImage(
          'assets/countries/russia/abkhazia/icons/abkhazia_flag.png',
          package: 'license_plate',
        ),
        box: _Layout.flag,
      ),
    ],
    textGroups: PlateTextGroup.perSlot(<String>['letter', 'number', 'series']),
  );

  static final PlateSpec diplomatic = PlateSpec(
    id: 'ab.diplomatic',
    country: AbkhaziaCountry.abkhazia,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
    background: _divided,
    slots: <PlateSlot>[
      _slot(_digits, 42.8, 198.2, 3),
      PlateSlot(
        alphabet: AbkhaziaAlphabets.diplomaticStatus,
        box: const PlateBox(211, 19, 99, 90),
        length: 2,
      ),
      _slot(_digits, 322, 392, 3, minLength: 1),
    ],
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'ABH',
        box: _Layout.abhDiplomatic,
        glyphHeight: _Layout.abhDiplomaticGlyph,
        color: AbkhaziaColors.diplomaticInk,
      ),
    ],
    textGroups: PlateTextGroup.perSlot(<String>['code', 'status', 'number']),
  );

  static List<PlateSpec> get all => <PlateSpec>[private, diplomatic];
}

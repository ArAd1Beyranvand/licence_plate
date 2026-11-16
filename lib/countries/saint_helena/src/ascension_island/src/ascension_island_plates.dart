import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'ascension_island_country.dart';

/// No Ascension photograph exists: the article gives one sentence ("similar to
/// Saint Helena but start with an 'A'"), so the layout is the UK-size 520×111
/// plate measured on the Falkland Islands artwork, ink x 92–419 with the prefix
/// letter at 92–146 and up to four digits after it. Ink is ~55% of the box, so
/// the box uses the full row.
abstract final class _Layout {
  static const double width = 520, height = 111, rowTop = 3, rowHeight = 105;
}

abstract final class AscensionIslandPlates {
  static PlateSlot _slot(
    PlateAlphabet a,
    double left,
    double right,
    int length, {
    int? minLength,
  }) {
    final double pitch = (right - left) / length;
    return PlateSlot(
      alphabet: a,
      box: PlateBox(left, _Layout.rowTop, right - left, _Layout.rowHeight),
      length: length,
      minLength: minLength ?? length,
      spacing: length == 1 ? 0 : plateRunSpacing(pitch, _Layout.rowHeight),
    );
  }

  static final PlateSpec standard = PlateSpec(
    id: 'ac.standard',
    country: AscensionIslandCountry.ascension_island,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
    background: PlateSection.plain,
    slots: <PlateSlot>[
      _slot(AscensionIslandAlphabets.prefix, 92, 146, 1),
      _slot(AscensionIslandAlphabets.digits, 158, 419, 4, minLength: 1),
    ],
    textGroups: PlateTextGroup.perSlot(<String>['prefix', 'digits']),
  );

  static List<PlateSpec> get all => <PlateSpec>[standard];
}

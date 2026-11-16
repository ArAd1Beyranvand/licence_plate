import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'south_ossetia_colors.dart';
import 'south_ossetia_country.dart';

/// Ink-run measurements of the article's artwork (2000 px = 520 mm,
/// `.plateref/so/brief.md`): a divider at x 133, the flag (33..122 × 16..60)
/// and `RSO` (ink 35..116 × 70..97) left of it, the serial right of it:
/// letter 138..191, digits 205..372, letters 383..492. Ink prints under the
/// reference height (box is the full 106, `glyphStyle` paints ~0.55 of it).
abstract final class _Layout {
  static const double width = 520, height = 110, rowTop = 2, rowHeight = 106;
  static const double dividerEnd = 133, dividerThickness = 3;

  static const PlateBox flag = PlateBox(33, 16, 89, 44);
  static const PlateBox rso = PlateBox(30, 62, 96, 42);
  static const double rsoGlyph = 49;
}

const PlateAlphabet _digits = SouthOssetiaAlphabets.digits;
const PlateAlphabet _letters = SouthOssetiaAlphabets.letters;

/// `А733АН`: a letter, three digits and two letters, with the flag and `RSO`
/// left of a divider. Black on white; no region code. Older plates
/// (four digits and `ЮОР`) are not drawn: no reference.
abstract final class SouthOssetiaPlates {
  static PlateSlot _slot(
    PlateAlphabet alphabet,
    double left,
    double right,
    int length,
  ) {
    final double pitch = (right - left) / length;
    return PlateSlot(
      alphabet: alphabet,
      box: PlateBox(left, _Layout.rowTop, right - left, _Layout.rowHeight),
      length: length,
      spacing: length == 1 ? 0 : plateRunSpacing(pitch, _Layout.rowHeight),
    );
  }

  static final PlateSpec standard = PlateSpec(
    id: 'so.standard',
    country: SouthOssetiaCountry.southOssetia,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
    background: const PlateSection.columns(<PlatePart>[
      PlatePart(
        PlateSection.plain,
        end: _Layout.dividerEnd,
        divider: _Layout.dividerThickness,
      ),
      PlatePart(PlateSection.plain),
    ]),
    slots: <PlateSlot>[
      _slot(_letters, 138.5, 190.8, 1),
      _slot(_digits, 205, 372, 3),
      _slot(_letters, 382.8, 492.2, 2),
    ],
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'RSO',
        box: _Layout.rso,
        glyphHeight: _Layout.rsoGlyph,
        color: SouthOssetiaColors.black,
      ),
    ],
    decals: const <PlateDecal>[
      PlateDecal(drawing: SouthOssetiaCountry.flagDrawing, box: _Layout.flag),
    ],
    textGroups: PlateTextGroup.perSlot(<String>['letter', 'number', 'series']),
  );

  static List<PlateSpec> get all => <PlateSpec>[standard];
}

import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'french_guiana_colors.dart';
import 'french_guiana_country.dart';

/// The layout is France's (`france_plate`), measured there off the vector
/// artwork on a 520×110 plate: letters pitch 47.3 centred 107.4, digits pitch
/// 47.5 centred 262, letters pitch 45.3 centred 413; hyphens centred 172.5 and
/// 349.3 (16 wide, 8 thick); blue bands 0–52 and 470–520. The article for French
/// Guiana pictures only the region block, so nothing else is measured here:
/// the département code is a 34-tall box of white digits (three do not fit a
/// 50-wide band at the French 32-tall size), and the logo is a simplified drawing at
/// the French logo box (475.8, 10, 36.4×39).
abstract final class _Layout {
  static const double width = 520, height = 110, leftEnd = 52, rightStart = 470;
  static const PlateBox logo = PlateBox(475.8, 10, 36.4, 39);
  static const PlateBox region = PlateBox(471, 62, 48, 34);
}

abstract final class FrenchGuianaPlates {
  static PlateSlot _field(
    PlateAlphabet a,
    double cx,
    double pitch,
    int length,
  ) => plateRun(
    a,
    length,
    centre: cx,
    top: 0,
    pitch: pitch,
    height: _Layout.height,
  );

  static final PlateSpec private = PlateSpec(
    id: 'gf.private',
    country: FrenchGuianaCountry.french_guiana,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
    background: const PlateSection.columns(<PlatePart>[
      PlatePart(
        PlateSection.fill(PlateFill.color(FrenchGuianaColors.band)),
        end: _Layout.leftEnd,
      ),
      PlatePart(PlateSection.plain, end: _Layout.rightStart),
      PlatePart(PlateSection.fill(PlateFill.color(FrenchGuianaColors.band))),
    ]),
    slots: <PlateSlot>[
      _field(FrenchGuianaAlphabets.letters, 107.4, 47.3, 2),
      _field(FrenchGuianaAlphabets.digits, 262, 47.5, 3),
      _field(FrenchGuianaAlphabets.letters, 413, 45.3, 2),
      PlateSlot(
        alphabet: FrenchGuianaAlphabets.digits,
        box: _Layout.region,
        color: FrenchGuianaColors.white,
        length: 3,
        spacing: 0,
      ),
    ],
    rules: const <PlateRule>[
      PlateRule(box: PlateBox(164.5, 51, 16, 8)),
      PlateRule(box: PlateBox(341.3, 51, 16, 8)),
    ],
    decals: const <PlateDecal>[
      PlateDecal(drawing: FrenchGuianaCountry.logo, box: _Layout.logo),
    ],
    textGroups: PlateTextGroup.perSlot(<String>[
      'prefix',
      'number',
      'suffix',
      'region',
    ]),
  );

  static List<PlateSpec> get all => <PlateSpec>[private];
}

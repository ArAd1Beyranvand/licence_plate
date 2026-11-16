import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'china_colors.dart';
import 'china_country.dart';
import 'china_missions.dart';

/// Where the ink sits on a Chinese plate, in millimetres.
///
/// **Scale.** The offline stage flattened every photo to 440×440, i.e. y is
/// stretched, so only x was used from it. x comes from the glyph runs of the
/// flattened photos (`GA36-2007_C.1.1`, `Hunan`, `GD-HK_Plate`, the
/// diplomatic photo and the Guangdong New Energy pair); y is the plate's
/// height, because the ink is centred on it.
///
/// **Standard plate, 440×140.** Seven cells of the GA 36 grid: pitch 56.5 (a
/// 45 mm character and 11.5 between). Province centre 40.0, letter 96.5, the
/// dot at 135.7 (the 34 mm gap the grid leaves), serial cells from centre
/// 174.3 to 400.3 (measured run 151.8..422.2, of which the first `1` or
/// `F` is narrower than its cell).
///
/// **New Energy plates, 480×140.** The Guangdong photo (700 px wide,
/// aspect 3.5) is a 480 mm plate, not the article's 440: pitch 52.3,
/// province centre 38.6, letter 90.9, serial six cells from centre 182.3
/// (measured run 160.6..467.5), the emblem centred at (134.7, 72.5). A large
/// plate's yellow end runs to x 134.7.
///
/// **Diplomatic plate, 440×140** (pre-2017 photo; the 2017 plate moves the
/// 使/领 to the end, which no reference shows): mark centre 42.2, mission
/// cells from centre 97.3 and serial cells from 291.4, pitch 56.5, the dot at
/// 249.6.
///
/// **Under-height ink, accepted.** The references' ink is 93–98 mm of 140.
/// `glyphStyle` sets 0.72 of the slot and a digit is ~0.73 of that, so 95 mm
/// would need a ~180 mm slot. The slots are as tall as the plate allows
/// (134), giving ~70 mm of ink (~73%). The test
/// font is far wider than a plate's condensed face, so goldens show runs
/// scaled down to fit; the pitch is satisfied by arithmetic
/// (`0.6 × 0.72 × 134 = 57.9 ≥ pitch`, spacing 0).
abstract final class _Layout {
  static const double height = 140, slotTop = 3, slotHeight = 134;

  // Standard and diplomatic: 440 wide.
  static const double width = 440, pitch = 56.5;
  static const double provinceLeft = 40.0 - pitch / 2;
  static const double letterLeft = 96.5 - pitch / 2;
  static const double standardSerialLeft = 174.3 - pitch / 2;
  static const double standardDotCentre = 135.7;

  static const double markLeft = 42.2 - pitch / 2;
  static const double missionLeft = 97.3 - pitch / 2;
  static const double diplomaticSerialLeft = 291.4 - pitch / 2;
  static const double diplomaticDotCentre = 249.6;

  // New Energy: 480 wide.
  static const double energyWidth = 480, energyPitch = 52.3;
  static const double energyProvinceLeft = 38.6 - energyPitch / 2;
  static const double energyLetterLeft = 90.9 - energyPitch / 2;
  static const double energySerialLeft = 182.3 - energyPitch / 2;
  static const double energyYellowEnd = 134.7, emblemSize = 27;
  static const double emblemCentreX = 134.7, emblemCentreY = 72.5;

  /// A label is not shrunk to its box: this prints a ~10 mm dot.
  static const double dotGlyph = 134, dotBoxWidth = 20;
}

/// The New Energy logo between the letter and the serial: an approximation,
/// a white disc in a green ring. The reference is ~25 px across, too small to
/// trace; its real artwork is a multi-colour arrow-in-circle.
const PlateDrawing _energyEmblem = PlateDrawing(100, 100, <PlateShape>[
  PlateCircleShape(50, 50, 50, Color(0xFF2E8B57)),
  PlateCircleShape(50, 50, 38, Color(0xFFF5FAFD)),
]);

/// China's plate geometries. A plate's colours are the theme's, so the
/// standard spec serves the blue, yellow (large, 学 coach) and black
/// (港/澳 cross-border) liveries alike.
///
/// Text groups: `province`, `city` and `serial` (standard and New Energy);
/// diplomatic has `mark`, `mission` and `serial`. The serial is one field of
/// five characters — the last may be a Hanzi suffix — or of six on a New
/// Energy plate.
///
/// Not implemented, with the reason: the 2019-series armed-police plate and
/// the 2002 edition (replaced), the paper interim plates (windscreen permits
/// on a watermarked pattern, not mounted plates), two-line motorcycle plates
/// (no reference image), and police/military plates (no reference image).
abstract final class ChinaPlates {
  static PlateSlot _slot(
    PlateAlphabet alphabet,
    double left,
    double width, {
    int length = 1,
    double pitch = 0,
    Color? color,
  }) => PlateSlot(
    alphabet: alphabet,
    box: PlateBox(left, _Layout.slotTop, width, _Layout.slotHeight),
    length: length,
    color: color,
    spacing: length == 1 ? 0 : plateRunSpacing(pitch, _Layout.slotHeight),
  );

  static PlateLabel _dot(double centre) => PlateLabel(
    text: '·',
    box: PlateBox(
      centre - _Layout.dotBoxWidth / 2,
      _Layout.slotTop,
      _Layout.dotBoxWidth,
      _Layout.slotHeight,
    ),
    glyphHeight: _Layout.dotGlyph,
  );

  static const List<PlateTextGroup> _regionGroups = <PlateTextGroup>[
    PlateTextGroup(<int>[0], key: 'province'),
    PlateTextGroup(<int>[1], key: 'city'),
    PlateTextGroup(<int>[2], key: 'serial'),
  ];

  static const PlatePanel _noPanel = PlatePanel(
    box: PlateBox(0, 0, 0, _Layout.height),
  );

  /// 京A·F0236: province, city letter, dot, a five-character serial.
  static final PlateSpec standard = PlateSpec(
    id: 'cn.standard',
    country: ChinaCountry.china,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: _noPanel,
    slots: <PlateSlot>[
      _slot(ChinaAlphabets.provinces, _Layout.provinceLeft, _Layout.pitch),
      _slot(ChinaAlphabets.cityLetters, _Layout.letterLeft, _Layout.pitch),
      _slot(
        ChinaAlphabets.serial,
        _Layout.standardSerialLeft,
        5 * _Layout.pitch,
        length: 5,
        pitch: _Layout.pitch,
      ),
    ],
    labels: <PlateLabel>[_dot(_Layout.standardDotCentre)],
    textGroups: _regionGroups,
  );

  static PlateSpec _newEnergy(String id, PlateSection background) => PlateSpec(
    id: id,
    country: ChinaCountry.china,
    canvasWidth: _Layout.energyWidth,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: _noPanel,
    background: background,
    slots: <PlateSlot>[
      _slot(
        ChinaAlphabets.provinces,
        _Layout.energyProvinceLeft,
        _Layout.energyPitch,
      ),
      _slot(
        ChinaAlphabets.cityLetters,
        _Layout.energyLetterLeft,
        _Layout.energyPitch,
      ),
      _slot(
        ChinaAlphabets.serial,
        _Layout.energySerialLeft,
        6 * _Layout.energyPitch,
        length: 6,
        pitch: _Layout.energyPitch,
      ),
    ],
    decals: const <PlateDecal>[
      PlateDecal(
        drawing: _energyEmblem,
        box: PlateBox.centered(
          _Layout.emblemCentreX,
          _Layout.emblemCentreY,
          _Layout.emblemSize,
          _Layout.emblemSize,
        ),
      ),
    ],
    textGroups: _regionGroups,
  );

  /// 粤B·D12345: the energy letter D/F leads a six-character serial.
  static final PlateSpec newEnergySmall = _newEnergy(
    'cn.energy.small',
    PlateSection.plain,
  );

  /// 粤B·12345D: the energy letter ends the serial, and the province end of
  /// the plate is yellow.
  static final PlateSpec newEnergyLarge = _newEnergy(
    'cn.energy.large',
    const PlateSection.columns(<PlatePart>[
      PlatePart(
        PlateSection.fill(PlateFill.divider),
        end: _Layout.energyYellowEnd,
      ),
      PlatePart(PlateSection.plain),
    ]),
  );

  /// 使 132·003, as photographed before 2017: red status mark, a three-digit
  /// mission code and a three-digit serial. Mission 157 is refused.
  static final PlateSpec diplomatic = PlateSpec(
    id: 'cn.diplomatic',
    country: ChinaCountry.china,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: _noPanel,
    slots: <PlateSlot>[
      _slot(
        ChinaAlphabets.diplomaticMark,
        _Layout.markLeft,
        _Layout.pitch,
        color: ChinaColors.diplomaticMark,
      ),
      _slot(
        ChinaAlphabets.digits,
        _Layout.missionLeft,
        3 * _Layout.pitch,
        length: 3,
        pitch: _Layout.pitch,
      ),
      _slot(
        ChinaAlphabets.digits,
        _Layout.diplomaticSerialLeft,
        3 * _Layout.pitch,
        length: 3,
        pitch: _Layout.pitch,
      ),
    ],
    labels: <PlateLabel>[_dot(_Layout.diplomaticDotCentre)],
    textGroups: PlateTextGroup.perSlot(<String>['mark', 'mission', 'serial']),
    restrictions: const <PlateRestriction>[ChinaMissions.restriction],
  );
}

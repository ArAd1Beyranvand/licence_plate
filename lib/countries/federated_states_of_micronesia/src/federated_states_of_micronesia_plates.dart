import 'dart:ui';

import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'federated_states_of_micronesia_colors.dart';
import 'federated_states_of_micronesia_country.dart';

/// Where the ink sits, in plate units.
///
/// The canvas is the 305×152 mm of the article's 12×6 in plate. Yap and
/// Pohnpei: the flattened references in `.plateref/fm` (608×292 px, scale
/// 0.5016 x, 0.5205 y), projected onto each axis. Kosrae: the clean 330×165
/// graphic, plate rectangle x 7–325, y 4–164 px, the same way (its photo fit
/// was rejected as CHECK, so only the graphic is used).
///
/// Pohnpei: PV x 20.6–38.1, y 37–112 (two stacked letters, ~32 tall each);
/// digits x 114.4–254.3, y 39–112; STATE OF POHNPEI x 58.2–243.3, y 126.5–135.3.
/// Yap: ISLAND OF STONE MONEY x 40–262.4, y 30.2–43.7; digits x 76–222.2,
/// y 46.8–110.9; YAP STATE x 89.8–210.7, y 115.6–128.1.
/// Kosrae: KOSRAE x 22.1–94, y 21.8–30.4; subtitle x 104.5–260.9; digits
/// x 104.5–262.8, y ~39–115; bottle x 36.4–61.4, y 48.4–98.8; bottom line
/// x 22.1–281 (y estimated).
///
/// Digit ink is 64–76 tall, but the font's advance is 0.6 × 0.72 × box height
/// and the field is scaled down whole when wider than its box, so the box is
/// sized so the advance fits the printed pitch (0.432 × box ≤ pitch). That puts
/// the digit ink near 60% of the reference. Caption heights are likewise
/// capped by their span, so lines come out narrower than printed.
abstract final class _Layout {
  static const double width = 305, height = 152;

  static const double pohnpeiDigitsLeft = 114.4, pohnpeiDigitsRight = 254.3;
  static const double pohnpeiDigitsCy = 75.5, pohnpeiDigitsBox = 80;
  static const double pvCy = 74.5, pvBox = 58, pvLineHeight = 1.05;
  static const double pohnpeiCaptionCx = 150.8, pohnpeiCaptionCy = 130.9;
  static const double pohnpeiCaptionSpan = 185, pohnpeiCaptionBox = 16;

  static const double yapDigitsLeft = 76, yapDigitsRight = 222.2;
  static const double yapDigitsCy = 78.85, yapDigitsBox = 84;
  static const double yapTopCx = 151.2, yapTopCy = 37, yapTopSpan = 222;
  static const double yapTopBox = 20, yapBottomCx = 150.3, yapBottomCy = 121.85;
  static const double yapBottomSpan = 121, yapBottomBox = 22;

  static const double kosraeDigitsLeft = 104.5, kosraeDigitsRight = 262.8;
  static const double kosraeDigitsCy = 77, kosraeDigitsBox = 90;
  static const double kosraeNameCx = 58, kosraeNameCy = 26.1;
  static const double kosraeNameSpan = 72, kosraeNameBox = 16;
  static const double kosraeSubCx = 182.7, kosraeSubCy = 26.5;
  static const double kosraeSubSpan = 156, kosraeSubBox = 12;
  static const double kosraeBottomCx = 151.5, kosraeBottomCy = 128.5;
  static const double kosraeBottomSpan = 259, kosraeBottomBox = 16;
  static const double bottleLeft = 36.4, bottleTop = 48.4;
  static const double bottleWidth = 25, bottleHeight = 50.4;
}

/// One plate per state: four digits (group `serial`) with the state's wording
/// as labels. Pair each with the theme of the same name.
///
/// Chuuk is not implemented: no reference picture exists to measure. Yap's paper registration sticker and the
/// hand-drawn stone-money disc beside its digits are not painted: the sticker
/// is not plate print and the disc is an illustration. The Kosrae bottle is a
/// simplified silhouette of the Sleeping Lady.
abstract final class FederatedStatesOfMicronesiaPlates {
  static final PlateSpec pohnpei = _spec(
    'fm.pohnpei',
    digits: _digits(
      _Layout.pohnpeiDigitsLeft,
      _Layout.pohnpeiDigitsRight,
      _Layout.pohnpeiDigitsCy,
      _Layout.pohnpeiDigitsBox,
    ),
    labels: <PlateLabel>[
      PlateLabel(
        text: 'P\nV',
        box: PlateBox(20.6, _Layout.pvCy - 38, 17.5, 76),
        glyphHeight: _Layout.pvBox,
        lineHeight: _Layout.pvLineHeight,
      ),
      _label(
        'STATE OF POHNPEI',
        _Layout.pohnpeiCaptionCx,
        _Layout.pohnpeiCaptionCy,
        _Layout.pohnpeiCaptionSpan,
        _Layout.pohnpeiCaptionBox,
      ),
    ],
  );

  static final PlateSpec yap = _spec(
    'fm.yap',
    digits: _digits(
      _Layout.yapDigitsLeft,
      _Layout.yapDigitsRight,
      _Layout.yapDigitsCy,
      _Layout.yapDigitsBox,
    ),
    labels: <PlateLabel>[
      _label(
        'ISLAND OF STONE MONEY',
        _Layout.yapTopCx,
        _Layout.yapTopCy,
        _Layout.yapTopSpan,
        _Layout.yapTopBox,
      ),
      _label(
        'YAP STATE',
        _Layout.yapBottomCx,
        _Layout.yapBottomCy,
        _Layout.yapBottomSpan,
        _Layout.yapBottomBox,
      ),
    ],
  );

  static final PlateSpec kosrae = _spec(
    'fm.kosrae',
    digits: _digits(
      _Layout.kosraeDigitsLeft,
      _Layout.kosraeDigitsRight,
      _Layout.kosraeDigitsCy,
      _Layout.kosraeDigitsBox,
    ),
    labels: <PlateLabel>[
      _label(
        'KOSRAE',
        _Layout.kosraeNameCx,
        _Layout.kosraeNameCy,
        _Layout.kosraeNameSpan,
        _Layout.kosraeNameBox,
      ),
      _label(
        'Island of the Sleeping Lady',
        _Layout.kosraeSubCx,
        _Layout.kosraeSubCy,
        _Layout.kosraeSubSpan,
        _Layout.kosraeSubBox,
      ),
      _label(
        'Federated States of Micronesia',
        _Layout.kosraeBottomCx,
        _Layout.kosraeBottomCy,
        _Layout.kosraeBottomSpan,
        _Layout.kosraeBottomBox,
      ),
    ],
    decals: const <PlateDecal>[
      PlateDecal(
        drawing: PlateDrawing(
          _Layout.bottleWidth,
          _Layout.bottleHeight,
          <PlateShape>[
            PlatePolygonShape(<Offset>[
              Offset(10.5, 0),
              Offset(14.5, 0),
              Offset(15, 10),
              Offset(18, 22),
              Offset(22, 34),
              Offset(25, 44),
              Offset(24, 50.4),
              Offset(1, 50.4),
              Offset(0, 44),
              Offset(3, 34),
              Offset(7, 22),
              Offset(10, 10),
            ], FederatedStatesOfMicronesiaColors.kosraeInk),
          ],
        ),
        box: PlateBox(
          _Layout.bottleLeft,
          _Layout.bottleTop,
          _Layout.bottleWidth,
          _Layout.bottleHeight,
        ),
      ),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[pohnpei, yap, kosrae];

  /// The four-digit field over ink [left]..[right]; its printed pitch is the
  /// span over four. [boxHeight] is capped so the font advance fits that pitch.
  static PlateSlot _digits(
    double left,
    double right,
    double cy,
    double boxHeight,
  ) {
    final double pitch = (right - left) / 4;
    return PlateSlot(
      alphabet: FederatedStatesOfMicronesiaAlphabets.digits,
      box: PlateBox(left, cy - boxHeight / 2, right - left, boxHeight),
      length: 4,
      spacing: plateRunSpacing(pitch, boxHeight),
    );
  }

  /// A caption centred on its ink span at [cx], [cy].
  static PlateLabel _label(
    String text,
    double cx,
    double cy,
    double span,
    double glyphHeight,
  ) => PlateLabel(
    text: text,
    box: PlateBox.centered(cx, cy, span, glyphHeight),
    glyphHeight: glyphHeight,
  );

  static PlateSpec _spec(
    String id, {
    required PlateSlot digits,
    required List<PlateLabel> labels,
    List<PlateDecal> decals = const <PlateDecal>[],
  }) => PlateSpec(
    id: id,
    country: FederatedStatesOfMicronesiaCountry.federated_states_of_micronesia,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    slots: <PlateSlot>[digits],
    labels: labels,
    decals: decals,
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'serial'),
    ],
  );
}

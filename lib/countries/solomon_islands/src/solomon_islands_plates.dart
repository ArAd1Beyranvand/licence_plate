import 'dart:ui';

import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'solomon_islands_colors.dart';
import 'solomon_islands_country.dart';

/// Where the ink sits, in plate units.
///
/// `SOLOMON_ISLANDS.5` is flattened to 152×50 (aspect 3.02, the photograph's;
/// the infobox's 152 × 305 mm is the same plate with the long side mistaken
/// for the height, and the lead's 372×134 mm is the Australian standard the
/// article says it follows, aspect 2.78 — the photograph wins).
///
/// Series `MA` ink y 3.5–36 (cy 19.75) x 7.5–53; digits `5021` x 64.5–139.8;
/// the diamond separator x ~56.5–60, y ~17.5–24.3 (read off the sheet, not
/// the projections). Caption `SOLOMON ISLANDS · THE HAPI ISLES` ink y 39–43.8
/// (cy 41.4) x 18.5–132.8.
///
/// 32.5 of ink would need a ~59-unit box on a 50-unit plate; the field box is
/// 39.5 (centred on the ink), so the characters land at ~67% of the printed
/// height. The caption is sized by height and set in the font's own width.
abstract final class _Layout {
  static const double width = 152, height = 50;

  static const double fieldCy = 19.75, fieldBox = 39.5;
  static const double seriesLeft = 7.5, seriesRight = 53;
  static const double serialLeft = 64.5, serialRight = 139.8;

  static const double diamondCx = 58.25, diamondCy = 20.9;
  static const double diamondHalfW = 2.2, diamondHalfH = 3.4;

  static const double captionCx = 75.65, captionCy = 41.4;
  static const double captionWidth = 116, captionBox = 8;
}

/// The private plate: `MA·5021`, a series of two letters and a four-digit
/// serial split by a diamond, over the caption `SOLOMON ISLANDS · THE HAPI
/// ISLES`. Text groups `series` and `serial`. The article names no
/// Israel-specific value, and no other category: only the 2014 plate exists.
abstract final class SolomonIslandsPlates {
  static final PlateSpec private = PlateSpec(
    id: 'sb.private',
    country: SolomonIslandsCountry.solomon_islands,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    slots: <PlateSlot>[
      _field(
        SolomonIslandsAlphabets.letters,
        _Layout.seriesLeft,
        _Layout.seriesRight,
        2,
      ),
      _field(
        SolomonIslandsAlphabets.digits,
        _Layout.serialLeft,
        _Layout.serialRight,
        4,
      ),
    ],
    decals: const <PlateDecal>[
      PlateDecal(
        drawing: PlateDrawing(
          _Layout.diamondHalfW * 2,
          _Layout.diamondHalfH * 2,
          <PlateShape>[
            PlatePolygonShape(<Offset>[
              Offset(0, _Layout.diamondHalfH),
              Offset(_Layout.diamondHalfW, 0),
              Offset(_Layout.diamondHalfW * 2, _Layout.diamondHalfH),
              Offset(_Layout.diamondHalfW, _Layout.diamondHalfH * 2),
            ], SolomonIslandsColors.ink),
          ],
        ),
        box: PlateBox(
          _Layout.diamondCx - _Layout.diamondHalfW,
          _Layout.diamondCy - _Layout.diamondHalfH,
          _Layout.diamondHalfW * 2,
          _Layout.diamondHalfH * 2,
        ),
      ),
    ],
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'SOLOMON ISLANDS · THE HAPI ISLES',
        box: PlateBox.centered(
          _Layout.captionCx,
          _Layout.captionCy,
          _Layout.captionWidth,
          _Layout.captionBox,
        ),
        glyphHeight: _Layout.captionBox,
      ),
    ],
    textGroups: PlateTextGroup.perSlot(<String>['series', 'serial']),
  );

  static List<PlateSpec> get all => <PlateSpec>[private];

  /// One field spanning ink [left]..[right]; its printed pitch is the span
  /// over [count].
  static PlateSlot _field(
    PlateAlphabet alphabet,
    double left,
    double right,
    int count,
  ) {
    final double pitch = (right - left) / count;
    return PlateSlot(
      alphabet: alphabet,
      box: PlateBox(
        left,
        _Layout.fieldCy - _Layout.fieldBox / 2,
        right - left,
        _Layout.fieldBox,
      ),
      length: count,
      spacing: plateRunSpacing(pitch, _Layout.fieldBox),
    );
  }
}

import 'dart:ui';

import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'nauru_colors.dart';
import 'nauru_country.dart';

/// Where the ink sits, in plate units.
///
/// All three references are photographs flattened to the Australian-standard
/// 372×134 mm the article cites, then projected onto each axis. Only
/// `NAuru_7827` fits confidently; the other two are CHECK-fitted.
///
/// Caption NAURU, ink y 9.2–28.2 (19 tall) x 74.2–303 on the 2015 plate;
/// 9.2–25.2 x 132.8–239.5 on the 1975 plate; 9.2–27 x 142.2–236.5 on the 1970
/// plate. The caption is a label centred on those spans.
///
/// 2015 (`Nauru_AAA-595`): letters y 36.5–121.2 (cy 78.85) x 26.2–160.5;
/// digits x 217.8–347.2.
/// 1975 (`NAuru_7827`): four digits y 31.2–118.8 (cy 75) x 80–296.5.
/// 1970 (`NAURU_1970s…`): digits y 28.5–119.2 (cy 73.85); one digit x 26–86.8,
/// three x 141.2–323.8 (the segmenter merged the last two, the sheet shows
/// `601`); diamond x 102.75–125.75, y 69.5–79.75.
///
/// A reference ink of 85–90 would need a ~165-unit box on a 134-unit plate, so
/// the digit boxes are capped at [fieldBox] and the ink lands near 60% of the
/// photo's. The caption is likewise sized by height, so NAURU is narrower than
/// printed: glyph advance is the font's, there is no wider face to ask for.
abstract final class _Layout {
  static const double width = 372, height = 134, fieldBox = 98, captionBox = 36;
  static const double captionCy = 18.7;

  static const double currentCaptionCx = 188.6, currentCy = 78.85;
  static const double lettersLeft = 26.2, lettersRight = 160.5;
  static const double digitsLeft = 217.8, digitsRight = 347.2;

  static const double legacyCaptionCx = 186.15, legacyCy = 75;
  static const double legacyLeft = 80, legacyRight = 296.5;

  static const double classicCaptionCx = 189.35, classicCy = 73.85;
  static const double classicDigitLeft = 26, classicDigitRight = 86.8;
  static const double classicSerialLeft = 141.2, classicSerialRight = 323.8;
  static const double diamondCx = 114.25, diamondCy = 74.6;
  static const double diamondHalfW = 11.5, diamondHalfH = 5.1;
}

/// Nauru's plates, each a caption row NAURU over one row of fields. Colour is
/// the theme's: pair [current] with [NauruThemes.current], [legacy] with
/// [NauruThemes.legacy] and [classic] with [NauruThemes.classic].
///
/// All three are implemented: the 2015 plate (`ABC 123`, groups `letters`,
/// `serial`), the 1975–2015 plate (`1234`, group `serial`) and the 1970–75
/// plate (`1-234`, groups `prefix`, `serial`). The article names no
/// Israel-specific value.
abstract final class NauruPlates {
  static final PlateSpec current = _spec(
    'nr.current',
    captionCx: _Layout.currentCaptionCx,
    slots: <PlateSlot>[
      _field(
        NauruAlphabets.letters,
        _Layout.lettersLeft,
        _Layout.lettersRight,
        _Layout.currentCy,
        3,
      ),
      _field(
        NauruAlphabets.digits,
        _Layout.digitsLeft,
        _Layout.digitsRight,
        _Layout.currentCy,
        3,
      ),
    ],
    groups: <String>['letters', 'serial'],
  );

  static final PlateSpec legacy = _spec(
    'nr.legacy',
    captionCx: _Layout.legacyCaptionCx,
    slots: <PlateSlot>[
      _field(
        NauruAlphabets.digits,
        _Layout.legacyLeft,
        _Layout.legacyRight,
        _Layout.legacyCy,
        4,
      ),
    ],
    groups: <String>['serial'],
  );

  static final PlateSpec classic = _spec(
    'nr.classic',
    captionCx: _Layout.classicCaptionCx,
    slots: <PlateSlot>[
      _field(
        NauruAlphabets.digits,
        _Layout.classicDigitLeft,
        _Layout.classicDigitRight,
        _Layout.classicCy,
        1,
      ),
      _field(
        NauruAlphabets.digits,
        _Layout.classicSerialLeft,
        _Layout.classicSerialRight,
        _Layout.classicCy,
        3,
      ),
    ],
    groups: <String>['prefix', 'serial'],
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
            ], NauruColors.classicInk),
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
  );

  static List<PlateSpec> get all => <PlateSpec>[current, legacy, classic];

  /// One field spanning ink [left]..[right]; its printed pitch is the span
  /// over [count].
  static PlateSlot _field(
    PlateAlphabet alphabet,
    double left,
    double right,
    double cy,
    int count,
  ) {
    final double pitch = (right - left) / count;
    return PlateSlot(
      alphabet: alphabet,
      box: PlateBox(
        left,
        cy - _Layout.fieldBox / 2,
        right - left,
        _Layout.fieldBox,
      ),
      length: count,
      spacing: count == 1 ? 0 : plateRunSpacing(pitch, _Layout.fieldBox),
    );
  }

  static PlateSpec _spec(
    String id, {
    required double captionCx,
    required List<PlateSlot> slots,
    required List<String> groups,
    List<PlateDecal> decals = const <PlateDecal>[],
  }) => PlateSpec(
    id: id,
    country: NauruCountry.nauru,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    slots: slots,
    decals: decals,
    labels: <PlateLabel>[
      PlateLabel(
        text: 'NAURU',
        box: PlateBox(
          captionCx - 60,
          _Layout.captionCy - _Layout.captionBox / 2,
          120,
          _Layout.captionBox,
        ),
        glyphHeight: _Layout.captionBox,
      ),
    ],
    textGroups: PlateTextGroup.perSlot(groups),
  );
}

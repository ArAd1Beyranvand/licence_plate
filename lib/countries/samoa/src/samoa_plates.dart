import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'samoa_colors.dart';
import 'samoa_country.dart';

/// Where the ink sits, in plate units. Each photo was flattened to the
/// 372×134 mm the article gives (Australian standard) and projected onto each
/// axis.
///
/// 2000 plate: "SAMOA" ink y 9.2–21, centred x 186; serial y 27–106.5
/// (cy 66.75, x 84.5–259.8); slogan y 109.5–123.8, x 112.8–258.8.
/// Late-1950s: digits y 16.5–116.2 (cy 66.35), x 110.2–260.5.
/// 1979: digit x 75.8–119, dot x 120–141, three digits x 144–296.5, all
/// y 40.5–115.2 (cy 77.85); the dot's x and the split are read off the sheet,
/// the brief's field spans for this photo are mis-grouped.
/// Government: "GOVT." x 38–160, digits x 183.9–326.5, both y 32–124.5
/// (cy 78.25); badge "WESTERN SAMOA" x 145–209, y 8–16.
///
/// Ink is about 55% of a box, so the 80–100 unit reference digits would need
/// boxes beyond the 134-unit canvas. Digit boxes are capped at 108–120 and the
/// ink lands near 75–85% of the photo's.
abstract final class _Layout {
  static const double width = 372, height = 134;

  static const double modernCy = 66.75, modernBox = 120;
  static const double modernCx = 172.2, modernSpan = 190;
  static const double captionCy = 15.1, captionGlyph = 21, captionCx = 186;
  static const double sloganCy = 116.6, sloganGlyph = 18, sloganCx = 185.8;

  static const double plainCy = 66.35, plainBox = 120;
  static const double plainCx = 185.35, plainSpan = 156;

  static const double dotCy = 77.85, dotBox = 110;
  static const double dotDigitCx = 97.4, dotDigitSpan = 52;
  static const double dotMarkCx = 130.5, dotGlyph = 40;
  static const double dotSerialCx = 220.25, dotSerialSpan = 153;

  static const double govCy = 78.25, govBox = 108;
  static const double govLabelCx = 99, govLabelSpan = 122, govLabelGlyph = 56;
  static const double govSerialCx = 255.2, govSerialSpan = 142.6;
  static const double badgeCx = 177, badgeCy = 12, badgeWidth = 64;
  static const double badgeHeight = 8.5, badgeGlyph = 7;
}

/// Samoa's plates. Groups `serial` (every plate), plus `mark` on the dotted
/// plate's leading digit. [modern] is the current 2000 design.
///
/// Only [modern] is current. [green], [dotted] and [government] are the late
/// 1950s, 1979 and 1979 government designs the article pictures. The plate
/// has no flag or emblem, so the flag in the article is not on the plates and
/// nothing is drawn for it. Pair [modern] with [SamoaThemes.modern], [plain]
/// with [SamoaThemes.green], [dotted] with [SamoaThemes.mint] and [government]
/// with [SamoaThemes.government]. The article names nothing Israel-specific.
abstract final class SamoaPlates {
  static final PlateSpec modern = _spec(
    'ws.modern',
    slots: <PlateSlot>[
      _field(
        _Layout.modernCx,
        _Layout.modernSpan,
        _Layout.modernCy,
        _Layout.modernBox,
        4,
        1,
        4,
      ),
    ],
    labels: <PlateLabel>[
      _label(
        'SAMOA',
        _Layout.captionCx,
        _Layout.captionCy,
        90,
        _Layout.captionGlyph,
        SamoaColors.red,
      ),
      _label(
        'Penina ole Pasefika',
        _Layout.sloganCx,
        _Layout.sloganCy,
        160,
        _Layout.sloganGlyph,
        SamoaColors.red,
      ),
    ],
  );

  static final PlateSpec plain = _spec(
    'ws.plain',
    slots: <PlateSlot>[
      _field(
        _Layout.plainCx,
        _Layout.plainSpan,
        _Layout.plainCy,
        _Layout.plainBox,
        3,
        1,
        3,
      ),
    ],
  );

  static final PlateSpec dotted = _spec(
    'ws.dotted',
    slots: <PlateSlot>[
      _field(
        _Layout.dotDigitCx,
        _Layout.dotDigitSpan,
        _Layout.dotCy,
        _Layout.dotBox,
        1,
        1,
        1,
      ),
      _field(
        _Layout.dotSerialCx,
        _Layout.dotSerialSpan,
        _Layout.dotCy,
        _Layout.dotBox,
        3,
        3,
        3,
      ),
    ],
    labels: <PlateLabel>[
      _label('•', _Layout.dotMarkCx, _Layout.dotCy, 24, _Layout.dotGlyph, null),
    ],
    groups: PlateTextGroup.perSlot(<String>['mark', 'serial']),
  );

  static final PlateSpec government = _spec(
    'ws.government',
    slots: <PlateSlot>[
      _field(
        _Layout.govSerialCx,
        _Layout.govSerialSpan,
        _Layout.govCy,
        _Layout.govBox,
        3,
        1,
        3,
      ),
    ],
    labels: <PlateLabel>[
      _label(
        'GOVT.',
        _Layout.govLabelCx,
        _Layout.govCy,
        _Layout.govLabelSpan,
        _Layout.govLabelGlyph,
        null,
      ),
      PlateLabel(
        text: 'WESTERN SAMOA',
        box: PlateBox.centered(
          _Layout.badgeCx,
          _Layout.badgeCy,
          _Layout.badgeWidth,
          _Layout.badgeHeight,
        ),
        glyphHeight: _Layout.badgeGlyph,
        color: SamoaColors.teal,
      ),
    ],
    // Floats clear of the plate edge; its colour is the ink's.
    bands: <PlateBand>[
      PlateBand(
        box: PlateBox.centered(
          _Layout.badgeCx,
          _Layout.badgeCy,
          _Layout.badgeWidth,
          _Layout.badgeHeight,
        ),
        color: SamoaColors.maroon,
      ),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[
    modern,
    plain,
    dotted,
    government,
  ];

  /// One field: [length] characters (down to [minLength]) in one slot whose
  /// box spans the whole run. [count] sets the printed pitch.
  static PlateSlot _field(
    double cx,
    double span,
    double cy,
    double box,
    int count,
    int minLength,
    int length,
  ) => PlateSlot(
    alphabet: SamoaAlphabets.digits,
    box: PlateBox.centered(cx, cy, span, box),
    length: length,
    minLength: minLength,
    spacing: plateRunSpacing(span / count, box),
  );

  static PlateLabel _label(
    String text,
    double cx,
    double cy,
    double width,
    double glyph,
    Color? color,
  ) => PlateLabel(
    text: text,
    box: PlateBox.centered(cx, cy, width, glyph),
    glyphHeight: glyph,
    color: color,
  );

  static PlateSpec _spec(
    String id, {
    required List<PlateSlot> slots,
    List<PlateLabel> labels = const <PlateLabel>[],
    List<PlateBand> bands = const <PlateBand>[],
    List<PlateTextGroup>? groups,
  }) => PlateSpec(
    id: id,
    country: SamoaCountry.samoa,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    slots: slots,
    labels: labels,
    bands: bands,
    textGroups:
        groups ??
        <PlateTextGroup>[
          PlateTextGroup(<int>[0], key: 'serial'),
        ],
  );
}

import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'jersey_country.dart';

/// Where the ink sits, in plate coordinates, measured off the platekit-
/// flattened references at the 520×111 mm the article gives.
///
/// `J` plus up to six digits is seven cells on a uniform pitch.
/// - Rear (`License_plate_of_Jersey_2`, `J98257`): ink y 7.8..103, six glyphs
///   at x 86..474.2 (pitch 64.7), so seven cells start at 23.8.
/// - Front (`..._GBJ`, `J181148`): ink y 14.8..94.5, x 125.8..461.8 (seven
///   cells of 48), strip to x 75 (arms x 17..57.5, y 27..74.5).
///
/// Ink fills ~0.55 of its box, so the boxes are the 105 the one-line UK
/// plates use and the ink comes out below reference, most on the front
/// (~58 against 80 high). The `J` is a label and the digits one centred slot,
/// so a short serial sits centred in the run rather than flush against the `J`.
abstract final class _Layout {
  static const double width = 520, height = 111, rowTop = 3, rowHeight = 105;
  static const int cells = 7;

  static const double rearLeft = 23.8, rearRight = 474.2, frontLeft = 125.8;
  static const double frontRight = 461.8;

  static const double stripEnd = 75;
  static const PlatePanel panel = PlatePanel(
    box: PlateBox(0, 0, stripEnd, height),
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
  );
  static const PlatePanel none = PlatePanel(box: PlateBox(0, 0, 0, 0));
}

abstract final class JerseyPlates {
  static PlateSpec _build({
    required String id,
    required PlateCountry country,
    required double left,
    required double right,
    bool strip = false,
  }) {
    const double glyph = _Layout.rowHeight * 0.72;
    final double pitch = (right - left) / _Layout.cells;
    return PlateSpec(
      id: id,
      country: country,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      panel: strip ? _Layout.panel : _Layout.none,
      noPanel: !strip,
      background: strip
          ? const PlateSection.columns(<PlatePart>[
              PlatePart(
                PlateSection.fill(PlateFill.panel),
                end: _Layout.stripEnd,
              ),
              PlatePart(PlateSection.plain),
            ])
          : PlateSection.plain,
      labels: <PlateLabel>[
        PlateLabel(
          text: 'J',
          box: PlateBox(left, _Layout.rowTop, pitch, _Layout.rowHeight),
          glyphHeight: glyph,
        ),
      ],
      slots: <PlateSlot>[
        PlateSlot(
          alphabet: JerseyAlphabets.digits,
          box: PlateBox(
            left + pitch,
            _Layout.rowTop,
            right - left - pitch,
            _Layout.rowHeight,
          ),
          length: 6,
          minLength: 1,
        ),
      ],
      textGroups: const <PlateTextGroup>[
        PlateTextGroup(<int>[0], key: 'serial', prefix: 'J'),
      ],
    );
  }

  /// `J123456`: `J` then one to six digits, black on yellow.
  static final PlateSpec rear = _build(
    id: 'je.rear',
    country: JerseyCountry.jersey,
    left: _Layout.rearLeft,
    right: _Layout.rearRight,
  );

  /// The front plate: silver, with the arms between `JERSEY` and `GBJ`. Hire
  /// cars' red `H` block, the L and P riders' plates and the `E` temporary
  /// prefix are not implemented.
  static final PlateSpec front = _build(
    id: 'je.front',
    country: JerseyCountry.front,
    left: _Layout.frontLeft,
    right: _Layout.frontRight,
    strip: true,
  );
}

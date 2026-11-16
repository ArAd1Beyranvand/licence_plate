import 'package:license_plate/core/plate_core.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';

import 'tristan_da_cunha_country.dart';

/// No Tristan da Cunha plate is pictured anywhere: the article says "T.D.C." or
/// "TDC" and up to three digits, white on black since 1969, with black on white
/// and black on yellow also seen. Size and layout are the UK 520×111 plate as
/// measured on the Falkland Islands artwork: the prefix takes x 60–200 and the
/// digits x 214–440. Ink is ~55% of the box, so the box uses the full row.
abstract final class _Layout {
  static const double width = 520, height = 111, rowTop = 3, rowHeight = 105;
  static const PlateBox prefix = PlateBox(60, rowTop, 140, rowHeight);
  static const double prefixGlyph = 105, digitsLeft = 214, digitsRight = 460;
}

abstract final class TristanDaCunhaPlates {
  static PlateSpec _spec(String id) {
    const int length = 3;
    const double pitch = (_Layout.digitsRight - _Layout.digitsLeft) / length;
    return PlateSpec(
      id: id,
      country: TristanDaCunhaCountry.tristan_da_cunha,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      noPanel: true,
      panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
      background: PlateSection.plain,
      slots: <PlateSlot>[
        PlateSlot(
          alphabet: TristanDaCunhaAlphabets.digits,
          box: const PlateBox(
            _Layout.digitsLeft,
            _Layout.rowTop,
            _Layout.digitsRight - _Layout.digitsLeft,
            _Layout.rowHeight,
          ),
          length: length,
          minLength: 1,
          spacing: plateRunSpacing(pitch, _Layout.rowHeight),
          group: 'digits',
        ),
      ],
      labels: const <PlateLabel>[
        PlateLabel(
          text: 'TDC',
          box: _Layout.prefix,
          glyphHeight: _Layout.prefixGlyph,
        ),
      ],
    );
  }

  /// Colours are the theme's; the three plates share this one design.
  static final PlateSpec standard = _spec('td.standard');

  static List<PlateSpec> get all => <PlateSpec>[standard];
}

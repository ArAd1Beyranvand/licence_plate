import 'package:flutter/widgets.dart' show AssetImage;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'canada_colors.dart';
import 'canada_country.dart';

/// Ink placement in plate coordinates; both references are normalised to
/// 300 × 150 (12 × 6 in).
///
/// Federal (`Canada_Federal_license_plate_78579`, 1.97 aspect):
/// * CANADA ink x 89.5–212.5, y 12.8–36.8 (24 tall);
/// * leaves x 14–35 and 265–286, y 14.3–37.5;
/// * serial ink x 25.8–276.8, y 47–121.5 (74.5 tall, centre y 84.4).
///
/// Permit (`2004_Ontario_license_plate_10_day_permit`, 2.0 aspect):
/// * caption line 1 ink x 44–255, y 2.7–12.8; line 2 x 18–284, y 14.2–24.8;
/// * serial ink y 30.8–109.5 (78.7 tall); the letter x 9–50, the six digits
///   x 52–258;
/// * ONTARIO ink x 117–186, y 118–128.
///
/// A bold cap is ~0.55 of a slot's height, so full-size glyphs would need
/// boxes the canvas cannot hold. The references' faces are condensed (cap
/// width ≈ 0.45 of height, DejaVu ≈ 0.7), so a run that fills its box is
/// scaled down as a whole. Serial boxes fit the measured x-span, so ink height
/// comes out short of the reference. Captions are sized by width to stay on
/// the plate.
///
/// Not drawn: the permit's per-permit barcode, expiry and VIN lines, the screw
/// holes, and the embossed panel behind the federal serial.
abstract final class _Layout {
  static const double width = 300, height = 150;

  // Federal.
  static const double fedSerialLeft = 22, fedSerialWidth = 258;
  static const double fedSerialTop = 28.4, fedSerialHeight = 112;
  static const double fedCaptionLeft = 80, fedCaptionWidth = 143;
  static const double fedCaptionTop = 3, fedCaptionHeight = 44;
  static const double fedCaptionGlyph = 40, leafTop = 14.3, leafWidth = 21;
  static const double leafHeight = 23.2, leafLeft = 14, leafRight = 265;

  // Permit.
  static const double permitLetterLeft = 9, permitLetterWidth = 43;
  static const double permitDigitsLeft = 50, permitDigitsWidth = 210;
  static const double permitSerialTop = 10, permitSerialHeight = 120;
  static const double permitGlyph = 16.5;
}

/// Canada's plates.
///
/// * [federal]: Department of National Defence vehicles and trailers, five
///   digits under CANADA and two maple leaves.
/// * [permit]: Ontario's 10-day temporary permit, a letter and six digits.
///
/// Provincial, vanity, dealer, diplomatic and mission plates are not
/// implemented; none has a measured reference.
abstract final class CanadaPlates {
  static const AssetImage _leaf = AssetImage(
    // Commons: File:Flag_of_Canada_(Pantone).svg, maple leaf only.
    'assets/countries/canada/icons/maple_leaf.png',
    package: 'license_plate',
  );

  /// Group `number`.
  static final PlateSpec federal = PlateSpec(
    id: 'ca.federal',
    country: CanadaCountry.canada,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: CanadaAlphabets.digits,
        box: const PlateBox(
          _Layout.fedSerialLeft,
          _Layout.fedSerialTop,
          _Layout.fedSerialWidth,
          _Layout.fedSerialHeight,
        ),
        length: 5,
        group: 'number',
      ),
    ],
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'CANADA',
        box: PlateBox(
          _Layout.fedCaptionLeft,
          _Layout.fedCaptionTop,
          _Layout.fedCaptionWidth,
          _Layout.fedCaptionHeight,
        ),
        glyphHeight: _Layout.fedCaptionGlyph,
        color: CanadaColors.federalGreen,
      ),
    ],
    decals: <PlateDecal>[
      for (final double left in <double>[_Layout.leafLeft, _Layout.leafRight])
        PlateDecal(
          image: _leaf,
          box: PlateBox(
            left,
            _Layout.leafTop,
            _Layout.leafWidth,
            _Layout.leafHeight,
          ),
        ),
    ],
  );

  /// Groups `letter`, `number`.
  static final PlateSpec permit = PlateSpec(
    id: 'ca.permit',
    country: CanadaCountry.canada,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: CanadaAlphabets.letters,
        box: const PlateBox(
          _Layout.permitLetterLeft,
          _Layout.permitSerialTop,
          _Layout.permitLetterWidth,
          _Layout.permitSerialHeight,
        ),
        group: 'letter',
      ),
      PlateSlot(
        alphabet: CanadaAlphabets.digits,
        box: const PlateBox(
          _Layout.permitDigitsLeft,
          _Layout.permitSerialTop,
          _Layout.permitDigitsWidth,
          _Layout.permitSerialHeight,
        ),
        length: 6,
        group: 'number',
      ),
    ],
    labels: const <PlateLabel>[
      PlateLabel(
        text: '10 DAY TEMPORARY PERMIT',
        box: PlateBox(44, 0, 211, 15.5),
        glyphHeight: _Layout.permitGlyph,
        color: CanadaColors.permitBlue,
      ),
      PlateLabel(
        text: 'PERMIS PROVISOIRE DE DIX JOURS',
        box: PlateBox(18, 12, 266, 15),
        glyphHeight: _Layout.permitGlyph - 0.5,
        color: CanadaColors.permitBlue,
      ),
      PlateLabel(
        text: 'ONTARIO',
        box: PlateBox(117, 115, 69, 16),
        glyphHeight: 17,
        color: CanadaColors.permitBlue,
      ),
    ],
  );
}

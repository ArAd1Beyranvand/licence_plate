import 'package:flutter/widgets.dart' show EdgeInsets;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'saint_lucia_country.dart';

/// Ink positions in plate units on the 300×152 blank (references flattened at
/// 1 px per unit). The passenger plate is measured: ink y 37.2–114.5. Taxi and
/// minibus carry the same row at y ~70 plus a caption. Their photos and the
/// dealer, government and MP ones are cropped or skewed, so they reuse the
/// passenger's spans.
///
/// A 140-tall box puts ~77 of ink on the plate (ink is ~55% of the box). The
/// real digits are condensed, so a four-digit run is wider than its box and is
/// scaled down as a whole: the engine's limit, not a measurement.
///
/// Not modelled: the government plate's dash between prefix and digits, and
/// older styles.
abstract final class _Layout {
  static const double width = 300, height = 152, boxHeight = 140;
  static const double rowCy = 75.9, captionRowCy = 70;
  static const double left = 24, right = 276, gap = 6;
  static const double captionCx = 150, captionCy = 132.8, captionHeight = 28;
  static const double captionGlyph = 28; // ink 15.5 / 0.55
  static const String caption = 'LCD 1 PASS';
}

PlateSpec _plate(
  String id, {
  required int letters,
  int? minLetters,
  required int digits,
  double lettersWidth = 72,
  bool caption = false,
}) {
  final double cy = caption ? _Layout.captionRowCy : _Layout.rowCy;
  final double top = cy - _Layout.boxHeight / 2;
  final double digitsLeft = _Layout.left + lettersWidth + _Layout.gap;
  return PlateSpec(
    id: id,
    country: SaintLuciaCountry.saint_lucia,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, 0),
      padding: EdgeInsets.zero,
    ),
    noPanel: true,
    background: PlateSection.plain,
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: SaintLuciaAlphabets.letters,
        box: PlateBox(_Layout.left, top, lettersWidth, _Layout.boxHeight),
        length: letters,
        minLength: minLetters ?? letters,
        group: 'letters',
      ),
      PlateSlot(
        alphabet: SaintLuciaAlphabets.digits,
        box: PlateBox(
          digitsLeft,
          top,
          _Layout.right - digitsLeft,
          _Layout.boxHeight,
        ),
        length: digits,
        minLength: 1,
        group: 'digits',
      ),
    ],
    labels: <PlateLabel>[
      if (caption)
        PlateLabel(
          text: _Layout.caption,
          box: PlateBox(
            _Layout.captionCx - 60,
            _Layout.captionCy - _Layout.captionHeight / 2,
            120,
            _Layout.captionHeight,
          ),
          glyphHeight: _Layout.captionGlyph,
        ),
    ],
  );
}

/// One layout, six categories differing in prefix length, digit count and
/// caption; the host pairs each with its `SaintLuciaThemes` entry.
abstract final class SaintLuciaPlates {
  /// `P 0000`, `PA 0000`; the first series is two letters, so one or two.
  static final PlateSpec private = _plate(
    'lc.private',
    letters: 2,
    minLetters: 1,
    digits: 4,
  );

  /// `TX 0000`.
  static final PlateSpec taxi = _plate(
    'lc.taxi',
    letters: 2,
    digits: 4,
    lettersWidth: 84,
    caption: true,
  );

  /// `M 0000`.
  static final PlateSpec minibus = _plate(
    'lc.minibus',
    letters: 1,
    digits: 4,
    caption: true,
  );

  /// `DM 000`.
  static final PlateSpec demonstration = _plate(
    'lc.demonstration',
    letters: 2,
    digits: 3,
  );

  /// `SLG 0000`.
  static final PlateSpec government = _plate(
    'lc.government',
    letters: 3,
    digits: 4,
    lettersWidth: 108,
  );

  /// `MP 00`; one or two digits.
  static final PlateSpec parliament = _plate(
    'lc.parliament',
    letters: 2,
    digits: 2,
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    taxi,
    minibus,
    demonstration,
    government,
    parliament,
  ];
}

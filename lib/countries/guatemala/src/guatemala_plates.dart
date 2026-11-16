import 'package:flutter/widgets.dart' show EdgeInsets;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'guatemala_colors.dart';
import 'guatemala_country.dart';

/// Plate-unit measurements: a 300×150 canvas (12×6 in) fitted to the flat
/// photograph of the 2021 plate.
///
/// Ink is about 55% of a box, so the 76-tall reference serial would need a 138
/// box that cannot fit under the band; the box is 100 high centred on the ink.
///
/// Not drawn: the coat of arms, screw slots and sticker. Only the 2021 series
/// is modelled. The class letter differs by vehicle and is typed, so there is
/// one spec.
abstract final class _Layout {
  static const double width = 300, height = 150;

  static const double bandEnd = 32, titleCx = 151, titleTop = 10;
  static const double titleHeight = 23, titleWidth = 180, titleGlyph = 34;

  static const double serialTop = 25.5, serialHeight = 100, classLeft = 13.6;
  static const double classWidth = 33.4, digitsLeft = 62, fieldWidth = 113;

  static const double captionCx = 150, captionTop = 126, captionHeight = 24;
  static const double captionWidth = 220, captionGlyph = 30;
}

/// The Guatemalan plate `P 123 ABC`: groups `class`, `digits` and `letters`.
/// Colour is a theme: see `GuatemalaThemes`.
abstract final class GuatemalaPlates {
  static final PlateSpec private = PlateSpec(
    id: 'gt.private',
    country: GuatemalaCountry.guatemala,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, _Layout.height),
      padding: EdgeInsets.zero,
    ),
    background: const PlateSection.rows(<PlatePart>[
      PlatePart(
        PlateSection.fill(PlateFill.color(GuatemalaColors.blue)),
        end: _Layout.bandEnd,
      ),
      PlatePart(PlateSection.plain),
    ]),
    slots: const <PlateSlot>[
      PlateSlot(
        alphabet: GuatemalaAlphabets.letters,
        box: PlateBox(
          _Layout.classLeft,
          _Layout.serialTop,
          _Layout.classWidth,
          _Layout.serialHeight,
        ),
        length: 1,
        group: 'class',
      ),
      PlateSlot(
        alphabet: GuatemalaAlphabets.digits,
        box: PlateBox(
          _Layout.digitsLeft,
          _Layout.serialTop,
          _Layout.fieldWidth,
          _Layout.serialHeight,
        ),
        length: 3,
        group: 'digits',
      ),
      PlateSlot(
        alphabet: GuatemalaAlphabets.letters,
        box: PlateBox(
          _Layout.digitsLeft + _Layout.fieldWidth,
          _Layout.serialTop,
          _Layout.fieldWidth,
          _Layout.serialHeight,
        ),
        length: 3,
        group: 'letters',
      ),
    ],
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'GUATEMALA',
        box: PlateBox(
          _Layout.titleCx - _Layout.titleWidth / 2,
          _Layout.titleTop,
          _Layout.titleWidth,
          _Layout.titleHeight,
        ),
        glyphHeight: _Layout.titleGlyph,
        color: GuatemalaColors.white,
      ),
      PlateLabel(
        text: 'CENTRO AMÉRICA',
        box: PlateBox(
          _Layout.captionCx - _Layout.captionWidth / 2,
          _Layout.captionTop,
          _Layout.captionWidth,
          _Layout.captionHeight,
        ),
        glyphHeight: _Layout.captionGlyph,
      ),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[private];
}

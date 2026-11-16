import 'package:flutter/widgets.dart' show EdgeInsets;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'saint_kitts_and_nevis_country.dart';

/// Ink positions in plate units on a 300×66 canvas (the photo at 4 px per
/// unit). The photo is a long, narrow plate, not the 300×152 size the article
/// states; the picture wins.
///
/// Each slot takes the full canvas height, so ink lands near 36, about 65% of
/// reference: the engine's limit, not a measurement. The caption box is
/// estimated.
///
/// The photo shows only `P`, but `P(A)` since 1997 gives a second letter, so
/// the letters run one to two. Digits run one to four.
abstract final class _Layout {
  static const double width = 300, height = 66;
  static const double lettersCx = 44.75, lettersWidth = 65.5;
  static const double digitsCx = 185.5, digitsWidth = 138;
  static const PlateBox caption = PlateBox(96, 0.5, 110, 8);
  static const double captionGlyph = 6;
}

PlateSpec _plate() => PlateSpec(
  id: 'kn.private',
  country: SaintKittsAndNevisCountry.saint_kitts_and_nevis,
  canvasWidth: _Layout.width,
  canvasHeight: _Layout.height,
  panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
  noPanel: true,
  background: PlateSection.plain,
  labels: const <PlateLabel>[
    // The bracketed middle of the printed caption is illegible at this
    // resolution, so only the readable words are drawn.
    PlateLabel(
      text: 'ST. CHRISTOPHER & NEVIS ST. KITTS',
      box: _Layout.caption,
      glyphHeight: _Layout.captionGlyph,
    ),
  ],
  slots: <PlateSlot>[
    PlateSlot(
      alphabet: SaintKittsAndNevisAlphabets.letters,
      box: PlateBox(
        _Layout.lettersCx - _Layout.lettersWidth / 2,
        0,
        _Layout.lettersWidth,
        _Layout.height,
      ),
      length: 2,
      minLength: 1,
      group: 'letters',
    ),
    PlateSlot(
      alphabet: SaintKittsAndNevisAlphabets.digits,
      box: PlateBox(
        _Layout.digitsCx - _Layout.digitsWidth / 2,
        0,
        _Layout.digitsWidth,
        _Layout.height,
      ),
      length: 4,
      minLength: 1,
      group: 'digits',
    ),
  ],
);

/// The one category: the regular plate, white on black.
abstract final class SaintKittsAndNevisPlates {
  static final PlateSpec private = _plate();

  static List<PlateSpec> get all => <PlateSpec>[private];
}

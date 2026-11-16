import 'package:flutter/widgets.dart' show AssetImage, Color;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'andorra_colors.dart';
import 'andorra_country.dart';

/// Where the ink sits, in plate units: the 340×120 mm the article gives. Both
/// photographs were flattened to it at 4 px per unit (`.plateref/ad/flat_*`)
/// and read off.
///
/// Measured ink, standard plate: crest x 27.5–93 y 11–82; `L` x 115.8–146
/// y 15.5–83; `3705` x 169–317; `AND` x 30.5–90 y 89–109 (cap height 20.5);
/// `PRINCIPAT D'ANDORRA` x 114.5–314 y 94–105 (cap height 11.25).
/// Temporary plate: red boxes x 6.25–75.75 y 7–80 and x 265–333.75 y 6.25–79.25;
/// `MT` x 19–73 y 16–68; `0137` x 96–244 y 15–80.5; `XI` x 282.5–304 y 15–39.5;
/// `12` x 285–312.5 y 51–75.5; `AND` and the caption as on the standard plate.
///
/// Ink is only ~0.51 of a slot's height, so the serial's 67 tall ink would
/// need a 130-unit box; its centre is at y ~49, which caps a box at the canvas
/// top at ~98, giving ink ~50 (about 74% of reference). The serial boxes are
/// also wider than the printed digits: the references use a condensed face
/// and a slot scales its run down to fit its box, so the box is sized for the
/// natural width of the run, centred on the measured one.
abstract final class _Layout {
  static const double width = 340, height = 120;

  // Standard serial.
  static const double serialTop = 0.5, serialHeight = 98.5;
  static const double letterLeft = 108, letterWidth = 46; // centre 131
  static const double digitsLeft = 162.6, digitsWidth = 160; // centre 242.6

  // Temporary serial (ink centre y 47.75).
  static const double tempSerialHeight = 95.5;
  static const double tempDigitsLeft = 92, tempDigitsWidth = 156; // centre 170

  // "AND" and the caption, shared by both designs (ink centres y 99 / 99.4).
  static const double andLeft = 30.5, andWidth = 59.5;
  static const double andTop = 79, andGlyph = 40;
  static const double captionLeft = 114.5, captionWidth = 199.5;
  static const double captionTop = 88.4, captionGlyph = 22;

  // Expiry boxes on the temporary plate.
  static const double monthLeft = 265, monthWidth = 56;
  static const double monthTop = 3.25, dateGlyph = 48;
  static const double yearLeft = 278.75, yearWidth = 40, yearTop = 39.25;

  /// Photo of the crest only, cropped from the flag; aspect 0.926, matching
  /// the measured 65.5×71 box.
  static const PlateBox crest = PlateBox(27.5, 11, 65.5, 71);
}

/// [standard] is `L 3705` with the coat of arms; [temporary] is `MT 0137` with
/// an expiry month and year in a second red box.
///
/// Not implemented: the 1989–2011 and 1970s series (history, not the current
/// system) and the dealer (`PROVA`), diplomatic and special-vehicle plates the
/// article describes only in prose, with no picture to measure. The faint
/// mountain pattern on the standard plate's face is not drawn.
abstract final class AndorraPlates {
  static final PlateSpec standard = PlateSpec(
    id: 'ad.standard',
    country: AndorraCountry.andorra,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: _Layout.crest),
    slots: <PlateSlot>[
      _slot(
        AndorraAlphabets.letters,
        _Layout.letterLeft,
        _Layout.letterWidth,
        _Layout.serialTop,
        _Layout.serialHeight,
        1,
      ),
      _slot(
        AndorraAlphabets.digits,
        _Layout.digitsLeft,
        _Layout.digitsWidth,
        _Layout.serialTop,
        _Layout.serialHeight,
        4,
      ),
    ],
    labels: _captions(AndorraColors.blue),
    decals: const <PlateDecal>[
      PlateDecal(
        // Commons: File:Flag_of_Andorra.svg (coat of arms, rasterised).
        image: AssetImage(
          'assets/countries/andorra/icons/andorra_coat_of_arms.png',
          package: 'license_plate',
        ),
        box: _Layout.crest,
      ),
    ],
    textGroups: PlateTextGroup.perSlot(<String>['letter', 'digits']),
  );

  static final PlateSpec temporary = PlateSpec(
    id: 'ad.temporary',
    country: AndorraCountry.andorra,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
    bands: const <PlateBand>[
      PlateBand(
        box: PlateBox(6.25, 7, 69.5, 73.25),
        color: AndorraColors.redBox,
      ),
      PlateBand(
        box: PlateBox(265, 6.25, 68.75, 73),
        color: AndorraColors.redBox,
      ),
    ],
    slots: <PlateSlot>[
      _slot(
        AndorraAlphabets.digits,
        _Layout.tempDigitsLeft,
        _Layout.tempDigitsWidth,
        0,
        _Layout.tempSerialHeight,
        4,
      ),
      _slot(
        AndorraAlphabets.romanMonth,
        _Layout.monthLeft,
        _Layout.monthWidth,
        _Layout.monthTop,
        _Layout.dateGlyph,
        4,
        minLength: 1,
      ),
      _slot(
        AndorraAlphabets.digits,
        _Layout.yearLeft,
        _Layout.yearWidth,
        _Layout.yearTop,
        _Layout.dateGlyph,
        2,
      ),
    ],
    labels: <PlateLabel>[
      // Ink is 52 tall and 54 wide in a condensed face; 56 keeps the word
      // inside the box at the font's width.
      const PlateLabel(
        text: 'MT',
        box: PlateBox(19, 16, 54, 52),
        glyphHeight: 56,
      ),
      ..._captions(AndorraColors.redText),
    ],
    textGroups: PlateTextGroup.perSlot(<String>['digits', 'month', 'year']),
  );

  static List<PlateSpec> get all => <PlateSpec>[standard, temporary];

  static PlateSlot _slot(
    PlateAlphabet alphabet,
    double left,
    double width,
    double top,
    double height,
    int length, {
    int? minLength,
  }) => PlateSlot(
    alphabet: alphabet,
    box: PlateBox(left, top, width, height),
    length: length,
    minLength: minLength,
  );

  static List<PlateLabel> _captions(Color color) => <PlateLabel>[
    PlateLabel(
      text: 'AND',
      box: PlateBox(
        _Layout.andLeft,
        _Layout.andTop,
        _Layout.andWidth,
        _Layout.andGlyph,
      ),
      glyphHeight: _Layout.andGlyph,
      color: color,
    ),
    PlateLabel(
      text: "PRINCIPAT D'ANDORRA",
      box: PlateBox(
        _Layout.captionLeft,
        _Layout.captionTop,
        _Layout.captionWidth,
        _Layout.captionGlyph,
      ),
      glyphHeight: _Layout.captionGlyph,
      color: color,
    ),
  ];
}

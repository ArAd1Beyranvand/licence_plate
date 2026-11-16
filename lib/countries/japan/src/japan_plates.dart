import 'package:flutter/widgets.dart' show Color;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'japan_colors.dart';
import 'japan_country.dart';

/// Where the ink sits, in plate units, read off the article's vector artwork and
/// the export and diplomatic photographs (`.plateref/jp`) scaled to 330 wide.
///
/// The article gives only 330×165 (cars). The two-wheeler artwork is 330×179
/// (aspect 1.84, the 230×125 mm plate); the export plate photographs at the same
/// aspect and shares it, and the diplomatic photograph is 330×142. Those sizes
/// are the artwork's aspect, not an article figure.
///
/// Ink is about 55% of a Latin glyph box and 65% of a kanji box, and a box must
/// stay inside the canvas, so low rows cannot be tall enough: the serial inks
/// come out at ~74% (car), ~79% (two-wheeler), ~74% (export) and ~88%
/// (diplomatic) of reference.
///
/// Car (330×165): top row ink y 14–56 (office pitch 49, or 35 for three
/// characters; class pitch 27), bottom row ink y 71–151 (kana x 21–57, serial
/// pairs x 75–172 and 211–307 at digit pitch 56, hyphen x 182–200), bolt holes
/// x 53–64 and 266–277, y 22–33.
///
/// Two-wheeler (330×179): top row ink y 19–63 (sticker x 19–62, office pitch 46,
/// kana x 266–303), bottom row ink y 78–161 (serial pairs x 27–144 and 190–307 at
/// pitch 67, hyphen x 158–177), bolt holes x 73–86 and 244–257, y 22–35.
///
/// Export (330×179): `STO` x 105–228 (pitch 43.5), `HA` x 266–310, serial digit
/// centres 50, 128, 204.5, 282, flag sticker x 18.5–53, y 20–43.
///
/// Diplomatic (330×142): ring x 10–68.5, y 47.8–105.6; digits y 38–118, centres
/// 90 to 291.6 (pitch 50.4).
abstract final class _Layout {
  static const double carWidth = 330, carHeight = 165;
  static const double bikeWidth = 330, bikeHeight = 179;
  static const double diplomaticWidth = 330, diplomaticHeight = 142;

  static const double carTopCentre = 35, carBottomCentre = 111;
  static const double kanjiBox = 65, classBox = 70, kanaBox = 62;
  static const double carSerialBox = 108, carSerialPitch = 56;

  static const double bikeTopCentre = 41, bikeBottomCentre = 119.5;
  static const double bikeKanjiBox = 68, bikeSerialBox = 119;
  static const double bikeSerialPitch = 67;
}

/// A slot on [width] centred at [cx], so its box centre is the ink centre.
/// A run of [length] cells at [pitch] gets the spacing that reaches it.
PlateSlot _slot(
  PlateAlphabet alphabet, {
  required double cx,
  required double centreY,
  required double width,
  required double height,
  int length = 1,
  int? minLength,
  double pitch = 0,
}) => PlateSlot(
  alphabet: alphabet,
  box: PlateBox.centered(cx, centreY, width, height),
  length: length,
  minLength: minLength,
  spacing: pitch == 0 ? 0 : plateRunSpacing(pitch, height),
);

/// A disc: a band whose corner radii are half its side.
PlateBand _disc(double left, double top, double diameter, Color color) =>
    PlateBand(
      box: PlateBox(left, top, diameter, diameter),
      color: color,
      topCornerRadius: diameter / 2,
      bottomCornerRadius: diameter / 2,
    );

/// [private], [commercial], [keiPrivate] and [keiCommercial] are one car plate
/// (office, class code, hiragana, two pairs of digits) differing in colour and
/// hiragana. [motorcycle] is the two-wheeler plate
/// over 250 cc. [diplomatic] is the blue plate with an encircled 外; [export]
/// is the Roman-letter plate for travel abroad.
///
/// The serial is two fields of two digits with a hyphen between; a leading zero
/// is the dot `・`. Real plates drop the hyphen when the first pair is all dots,
/// which is not modelled. The canvas is fixed, so a three- or four-character
/// office shrinks to its box.
///
/// Not implemented: municipal plates (no artwork, sizes vary), the illuminated
/// plate, Imperial and U.S. forces plates, regional artwork, the Matsuyama cloud
/// plate, the second diplomatic print, and pre-1964 offices and pre-2000 codes.
abstract final class JapanPlates {
  static final PlateSpec private = _car('jp.private', JapanAlphabets.kanaWhite);

  static final PlateSpec commercial = _car(
    'jp.commercial',
    JapanAlphabets.kanaGreen,
  );

  static final PlateSpec keiPrivate = _car(
    'jp.kei_private',
    JapanAlphabets.kanaAny,
  );

  static final PlateSpec keiCommercial = _car(
    'jp.kei_commercial',
    JapanAlphabets.kanaBlack,
  );

  static final PlateSpec motorcycle = _bike('jp.motorcycle');

  static final PlateSpec diplomatic = PlateSpec(
    id: 'jp.diplomatic',
    country: JapanCountry.japan,
    canvasWidth: _Layout.diplomaticWidth,
    canvasHeight: _Layout.diplomaticHeight,
    panel: _noPanel,
    noPanel: true,
    bands: <PlateBand>[
      _disc(10, 47.8, 58.4, JapanColors.diplomaticInk),
      _disc(15, 52.8, 48.4, JapanColors.diplomaticField),
    ],
    slots: <PlateSlot>[
      _slot(
        JapanAlphabets.digits,
        cx: 190.8,
        centreY: 78,
        width: 248,
        height: 128,
        length: 5,
        pitch: 50.4,
      ),
    ],
    labels: const <PlateLabel>[
      PlateLabel(
        text: '外',
        box: PlateBox(10, 47.8, 58.4, 58.4),
        glyphHeight: 40,
      ),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'serial'),
    ],
  );

  static final PlateSpec export = PlateSpec(
    id: 'jp.export',
    country: JapanCountry.japan,
    canvasWidth: _Layout.bikeWidth,
    canvasHeight: _Layout.bikeHeight,
    panel: _noPanel,
    noPanel: true,
    bands: <PlateBand>[
      const PlateBand(
        box: PlateBox(18.5, 20, 34.5, 23),
        color: JapanColors.flagWhite,
      ),
      _disc(29.7, 25, 12, JapanColors.flagRed),
    ],
    slots: <PlateSlot>[
      _slot(
        JapanAlphabets.letters,
        cx: 166,
        centreY: 43.5,
        width: 130,
        height: 78,
        length: 3,
        minLength: 2,
        pitch: 43.5,
      ),
      _slot(
        JapanAlphabets.letters,
        cx: 288,
        centreY: 43.5,
        width: 52,
        height: 78,
        length: 2,
        minLength: 1,
      ),
      _slot(
        JapanAlphabets.digits,
        cx: 166,
        centreY: 121.5,
        width: 300,
        height: 115,
        length: 4,
        pitch: 77.3,
      ),
    ],
    textGroups: PlateTextGroup.perSlot(<String>['office', 'kana', 'serial']),
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    commercial,
    keiPrivate,
    keiCommercial,
    motorcycle,
    diplomatic,
    export,
  ];

  static const PlatePanel _noPanel = PlatePanel(box: PlateBox(0, 0, 1, 1));

  /// Office, class code, hiragana, and the serial's two pairs; the hyphen is
  /// a rule between them.
  static PlateSpec _car(String id, PlateAlphabet kana) => PlateSpec(
    id: id,
    country: JapanCountry.japan,
    canvasWidth: _Layout.carWidth,
    canvasHeight: _Layout.carHeight,
    panel: _noPanel,
    noPanel: true,
    bands: <PlateBand>[
      _disc(52.5, 21.5, 12, JapanColors.white),
      _disc(265.5, 21.5, 12, JapanColors.white),
    ],
    rules: const <PlateRule>[PlateRule(box: PlateBox(182, 107, 18, 9))],
    slots: <PlateSlot>[
      _slot(
        JapanAlphabets.offices,
        cx: 124,
        centreY: _Layout.carTopCentre,
        width: 100,
        height: _Layout.kanjiBox,
      ),
      _slot(
        JapanAlphabets.classCode,
        cx: 218.5,
        centreY: _Layout.carTopCentre,
        width: 80,
        height: _Layout.classBox,
        length: 3,
        minLength: 2,
        pitch: 26.8,
      ),
      _slot(
        kana,
        cx: 37,
        centreY: _Layout.carBottomCentre,
        width: 44,
        height: _Layout.kanaBox,
      ),
      _slot(
        JapanAlphabets.serialHead,
        cx: 123,
        centreY: _Layout.carBottomCentre,
        width: 112,
        height: _Layout.carSerialBox,
        length: 2,
        pitch: _Layout.carSerialPitch,
      ),
      _slot(
        JapanAlphabets.digits,
        cx: 259,
        centreY: _Layout.carBottomCentre,
        width: 112,
        height: _Layout.carSerialBox,
        length: 2,
        pitch: _Layout.carSerialPitch,
      ),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'office'),
      PlateTextGroup(<int>[1], key: 'class'),
      PlateTextGroup(<int>[2], key: 'kana'),
      PlateTextGroup(<int>[3, 4], key: 'serial'),
    ],
  );

  /// Sticker, office and hiragana on the top row, the serial below. The
  /// colours come from the theme; the sticker is its own.
  static PlateSpec _bike(String id) => PlateSpec(
    id: id,
    country: JapanCountry.japan,
    canvasWidth: _Layout.bikeWidth,
    canvasHeight: _Layout.bikeHeight,
    panel: _noPanel,
    noPanel: true,
    bands: <PlateBand>[
      const PlateBand(
        box: PlateBox(19, 18, 43, 43),
        color: JapanColors.sticker,
      ),
      const PlateBand(
        box: PlateBox(29, 24, 22, 8),
        color: JapanColors.stickerInk,
        topCornerRadius: 4,
        bottomCornerRadius: 4,
      ),
      _disc(73, 22, 13, JapanColors.white),
      _disc(244, 22, 13, JapanColors.white),
    ],
    rules: const <PlateRule>[PlateRule(box: PlateBox(158, 115, 19, 10))],
    labels: const <PlateLabel>[
      PlateLabel(
        text: '20',
        box: PlateBox(29, 24, 22, 8),
        glyphHeight: 11,
        color: JapanColors.white,
      ),
      PlateLabel(
        text: '10',
        box: PlateBox(19, 33, 43, 19),
        glyphHeight: 27,
        color: JapanColors.stickerInk,
      ),
    ],
    slots: <PlateSlot>[
      _slot(
        JapanAlphabets.offices,
        cx: 166.5,
        centreY: _Layout.bikeTopCentre,
        width: 99,
        height: _Layout.bikeKanjiBox,
      ),
      _slot(
        JapanAlphabets.kanaAny,
        cx: 284,
        centreY: _Layout.bikeTopCentre,
        width: 44,
        height: _Layout.bikeKanjiBox,
      ),
      _slot(
        JapanAlphabets.serialHead,
        cx: 85,
        centreY: _Layout.bikeBottomCentre,
        width: 134,
        height: _Layout.bikeSerialBox,
        length: 2,
        pitch: _Layout.bikeSerialPitch,
      ),
      _slot(
        JapanAlphabets.digits,
        cx: 248.75,
        centreY: _Layout.bikeBottomCentre,
        width: 135,
        height: _Layout.bikeSerialBox,
        length: 2,
        pitch: _Layout.bikeSerialPitch,
      ),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'office'),
      PlateTextGroup(<int>[1], key: 'kana'),
      PlateTextGroup(<int>[2, 3], key: 'serial'),
    ],
  );
}

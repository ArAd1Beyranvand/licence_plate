import 'package:flutter/widgets.dart' show Color, EdgeInsets;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'cyprus_country.dart';

/// Where the ink sits, in plate units: the 520×110 mm the article gives. Each
/// reference was flattened to it by the offline stage; column runs were then
/// read off the flats (`Cyprus_license_plate_2013_sample`,
/// `2023_Cyprus_trailer_plate`, `Cyprus_Corps_Diplomatique_Netherlands_...`)
/// with a dark-pixel threshold inside y 20–90, clear of frame and band.
///
/// Ink is ~71 tall (y 20–91, centre 55.5). At 0.72 x ~0.75 a box that tall
/// would need ~129, so every box is 104 and the ink lands near 57 (~80% of
/// reference). The EU band is blue to x 52, full height (`zone 05689F x
/// 2.5–51.5`).
///
/// Standard plate (`2013_sample`, `KQL-343`): letters ink 74.5–244.2, digits
/// 314.2–482.8, pitch ~57. The date stickers between them (ink 270.8–285.2)
/// are not typed and are not drawn.
///
/// Trailer (`2023_Cyprus_trailer_plate`): `P` ink 81–128; sticker 141–168
/// (not drawn); five digits 183.2–440.5, pitch ~52.
///
/// Diplomatic (`..._Netherlands_ambassador`, `49 CD 1`): code ink 72.5–172.2,
/// class 213.5–352.8, serial `1` 396.8–420.8. The serial may run to three
/// digits, which the plate has no room for at this size, so its box is
/// 372–470 and a long serial is scaled down; one digit sits ~12 right of the
/// photo.
///
/// SBA (`SBAA-22_police`): `SBAA` ~29–257, dash 291–319, digits 344.5–470.2.
/// The first two were read off the sheet (the frame contaminates the
/// threshold) and are good to a few units.
///
/// Dealer (`Cyprus_license_plate_2001_dealer`, a 500×140 photo of a framed
/// plate, no band): `ΔΟΚΙΜΗ` 73–234, dealer number 244–328, dash 333–359,
/// serial 364–478, after stretching x by 1.04 to 520. Measured by eye on the
/// original, not by the pipeline. The Greek word is condensed on the plate; at
/// the width available it is drawn at 56 (ink ~56% of the photo's).
abstract final class _Layout {
  static const double width = 520, height = 110, boxHeight = 104, cy = 55.5;

  static const double bandEnd = 52, bandLeft = 3, bandWidth = 46;
  static const double cyTop = 55, cyHeight = 40;

  static const double privateLettersLeft = 72.5, privateLettersWidth = 174;
  static const double privateDigitsLeft = 312.2, privateDigitsWidth = 172;

  static const double trailerPCx = 104.5, trailerPWidth = 60;
  static const double trailerDigitsLeft = 181, trailerDigitsWidth = 262;

  static const double dipCodeLeft = 70.5, dipCodeWidth = 104;
  static const double dipClassLeft = 211.5, dipClassWidth = 143;
  static const double dipSerialLeft = 372, dipSerialWidth = 98;

  static const double sbaCx = 143, sbaWidth = 228;
  static const double sbaDashCx = 305, sbaDashWidth = 28;
  static const double sbaDigitsLeft = 342, sbaDigitsWidth = 130;

  static const double dealerHeight = 78, dealerCy = 51;
  static const double dealerWordCx = 153.5, dealerWordWidth = 175;
  static const double dealerWordGlyph = 56;
  static const double dealerNoLeft = 244, dealerNoWidth = 84;
  static const double dealerDashCx = 346, dealerDashWidth = 26;
  static const double dealerSerialLeft = 364, dealerSerialWidth = 114;
}

/// The Republic of Cyprus's plates (Northern Cyprus has its own package).
///
/// [standard] is `KQL 343`, three letters and three digits; pair it with
/// [CyprusThemes.front], [CyprusThemes.rear] (also taxi and commercial
/// trucks), [CyprusThemes.rental] or [CyprusThemes.historic]. [trailer] is `P`
/// and five digits, [diplomatic] `49 CD 1`, [sba] `SBAA 22` and [dealer]
/// `ΔΟΚΙΜΗ 20-125`.
///
/// Not implemented: the pre-2013 formats (`CT` trailers, visitor `V`, export
/// `E`, the old rental `Z` and taxi `T` prefixes, `DL` dealers), the public
/// service secondary plates (`ΦΔΧ`, `ΛΔΧ`) and UNFICYP plates, for which no
/// current reference was measured. The president's car carries no number.
/// The article names no Israel-specific value.
abstract final class CyprusPlates {
  static final PlateSpec standard = _spec(
    'cy.standard',
    band: true,
    slots: <PlateSlot>[
      _run(
        CyprusAlphabets.letters,
        _Layout.privateLettersLeft,
        _Layout.privateLettersWidth,
        length: 3,
        pitch: 58,
      ),
      _run(
        CyprusAlphabets.digits,
        _Layout.privateDigitsLeft,
        _Layout.privateDigitsWidth,
        length: 3,
        pitch: 57.5,
      ),
    ],
    keys: <String>['letters', 'digits'],
  );

  static final PlateSpec trailer = _spec(
    'cy.trailer',
    band: true,
    labels: <PlateLabel>[
      _label(
        'P',
        _Layout.trailerPCx,
        _Layout.trailerPWidth,
        _Layout.boxHeight,
        _Layout.cy,
      ),
    ],
    slots: <PlateSlot>[
      _run(
        CyprusAlphabets.digits,
        _Layout.trailerDigitsLeft,
        _Layout.trailerDigitsWidth,
        length: 5,
        pitch: _Layout.trailerDigitsWidth / 5,
      ),
    ],
    keys: <String>['digits'],
  );

  static final PlateSpec diplomatic = _spec(
    'cy.diplomatic',
    band: true,
    slots: <PlateSlot>[
      _run(
        CyprusAlphabets.digits,
        _Layout.dipCodeLeft,
        _Layout.dipCodeWidth,
        length: 2,
        pitch: _Layout.dipCodeWidth / 2,
      ),
      _run(
        CyprusAlphabets.letters,
        _Layout.dipClassLeft,
        _Layout.dipClassWidth,
        length: 2,
        pitch: _Layout.dipClassWidth / 2,
      ),
      // One to three digits: the ambassador's car is 1.
      _run(
        CyprusAlphabets.digits,
        _Layout.dipSerialLeft,
        _Layout.dipSerialWidth,
        length: 3,
        minLength: 1,
      ),
    ],
    keys: <String>['code', 'class', 'digits'],
  );

  static final PlateSpec sba = _spec(
    'cy.sba',
    band: false,
    labels: <PlateLabel>[
      _label(
        'SBAA',
        _Layout.sbaCx,
        _Layout.sbaWidth,
        _Layout.boxHeight,
        _Layout.cy,
      ),
      _label(
        '-',
        _Layout.sbaDashCx,
        _Layout.sbaDashWidth,
        _Layout.boxHeight,
        _Layout.cy,
      ),
    ],
    slots: <PlateSlot>[
      _run(
        CyprusAlphabets.digits,
        _Layout.sbaDigitsLeft,
        _Layout.sbaDigitsWidth,
        length: 2,
        pitch: _Layout.sbaDigitsWidth / 2,
      ),
    ],
    keys: <String>['digits'],
  );

  static final PlateSpec dealer = _spec(
    'cy.dealer',
    band: false,
    labels: <PlateLabel>[
      _label(
        'ΔΟΚΙΜΗ',
        _Layout.dealerWordCx,
        _Layout.dealerWordWidth,
        _Layout.dealerWordGlyph,
        _Layout.dealerCy,
      ),
      _label(
        '-',
        _Layout.dealerDashCx,
        _Layout.dealerDashWidth,
        _Layout.dealerHeight,
        _Layout.dealerCy,
      ),
    ],
    slots: <PlateSlot>[
      _run(
        CyprusAlphabets.digits,
        _Layout.dealerNoLeft,
        _Layout.dealerNoWidth,
        length: 2,
        minLength: 1,
        height: _Layout.dealerHeight,
        cy: _Layout.dealerCy,
      ),
      _run(
        CyprusAlphabets.digits,
        _Layout.dealerSerialLeft,
        _Layout.dealerSerialWidth,
        length: 3,
        minLength: 1,
        height: _Layout.dealerHeight,
        cy: _Layout.dealerCy,
      ),
    ],
    keys: <String>['dealer', 'digits'],
  );

  static List<PlateSpec> get all => <PlateSpec>[
    standard,
    trailer,
    diplomatic,
    sba,
    dealer,
  ];

  /// One field: [length] characters, at a fixed [pitch] when one is printed,
  /// else at the font's advance.
  static PlateSlot _run(
    PlateAlphabet alphabet,
    double left,
    double width, {
    required int length,
    int? minLength,
    double? pitch,
    double height = _Layout.boxHeight,
    double cy = _Layout.cy,
  }) => PlateSlot(
    alphabet: alphabet,
    box: PlateBox(left, cy - height / 2, width, height),
    length: length,
    minLength: minLength,
    spacing: pitch == null ? 0 : plateRunSpacing(pitch, height),
  );

  static PlateLabel _label(
    String text,
    double cx,
    double width,
    double glyph,
    double cy,
  ) => PlateLabel(
    text: text,
    box: PlateBox.centered(cx, cy, width, glyph),
    glyphHeight: glyph,
  );

  static PlateSpec _spec(
    String id, {
    required bool band,
    required List<PlateSlot> slots,
    required List<String> keys,
    List<PlateLabel> labels = const <PlateLabel>[],
  }) => PlateSpec(
    id: id,
    country: CyprusCountry.cyprus,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: band
        ? const PlatePanel(
            box: PlateBox(_Layout.bandLeft, 0, _Layout.bandWidth, 70.4),
            padding: EdgeInsets.zero,
          )
        : const PlatePanel(box: PlateBox(0, 0, 0, 0)),
    noPanel: !band,
    background: band
        ? PlateSection.columns(<PlatePart>[
            const PlatePart(
              PlateSection.fill(PlateFill.panel),
              end: _Layout.bandEnd,
            ),
            const PlatePart(PlateSection.plain),
          ])
        : PlateSection.plain,
    slots: slots,
    labels: <PlateLabel>[
      if (band)
        const PlateLabel(
          text: 'CY',
          box: PlateBox(
            _Layout.bandLeft,
            _Layout.cyTop,
            _Layout.bandWidth,
            _Layout.cyHeight,
          ),
          glyphHeight: _Layout.cyHeight,
          color: Color(0xFFFFFFFF),
        ),
      ...labels,
    ],
    textGroups: PlateTextGroup.perSlot(keys),
  );
}

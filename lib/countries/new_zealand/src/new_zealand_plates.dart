import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'new_zealand_colors.dart';
import 'new_zealand_country.dart';

/// Where the ink sits, in plate units (360 × 124 mm, the article's size).
///
/// Measured off flattened photos, already in plate units:
/// - standard (`..._AAA-000_SERIES_SHORT_DIES`): ink y 21.8–106.2 (cy 64),
///   letters x 19–182.8, digits x 204–345.5;
/// - old plate (`New_zealand_license_plate_gg`): ink y 9.5–115.2 (cy 62.35),
///   letters x 14.2–128.5, digits x 153.8–339.8;
/// - Europlate (`2006_Ferrari_F430`, CHECK-fitted, flattened to 1440×496 and
///   rescaled by 360/1440): left band to x 47.5, right band from x 310.5,
///   characters x 69.5–287 over y 10–104, "NZ" ink x 14–36 y 90–111.
///
/// The reference ink is up to 105 tall on a 124 plate, which would need a box
/// well past the canvas (ink is ~55% of the box). Boxes are capped near the
/// canvas height, so ink lands at ~60–80% of the photos'.
abstract final class _Layout {
  static const double width = 360, height = 124;

  static const double standardCy = 64, standardBox = 112;
  static const double lettersLeft = 19, lettersWidth = 163.8;
  static const double digitsLeft = 204, digitsWidth = 141.5;

  static const double legacyCy = 62.35, legacyBox = 120;
  static const double legacyLettersLeft = 14.2, legacyLettersWidth = 114.3;
  static const double legacyDigitsLeft = 153.8, legacyDigitsWidth = 186;

  static const double personalCy = 57, personalBox = 112;
  static const double personalLeft = 20, personalWidth = 320;

  static const double europlateLeft = 69.5, europlateWidth = 217.5;
  static const double bandLeftEnd = 47.5, bandRightStart = 310.5;
  static const double nzCx = 25, nzCy = 100.5, nzWidth = 44, nzGlyph = 38;
}

/// New Zealand's plates. Every field is one slot; colour is the theme's.
///
/// - [standard] — three letters then three digits, black on white
///   ([NewZealandThemes.standard]). Groups `letters`, `serial`.
/// - [legacy] — two letters then four digits, silver on black
///   ([NewZealandThemes.black]). Groups `letters`, `serial`. The article
///   captions its photo as the 1926 plate; the picture is the later black
///   plate, and the picture wins.
/// - [personalised] — one field of one to six letters or digits
///   ([NewZealandThemes.standard] or [NewZealandThemes.black]). Group `serial`.
/// - [europlate] — the same field between blue bands with "NZ"
///   ([NewZealandThemes.europlate]). Group `serial`. The Southern Cross stars
///   and silver fern printed on the bands are left out: a fern is no shape
///   the spec can draw.
///
/// Not implemented: the 1926–27 plate (historic), motorcycle, trailer and
/// dealer plates, for which no reference was measured. The article names no
/// Israel-specific value.
abstract final class NewZealandPlates {
  static final PlateSpec standard = _spec(
    'nz.standard',
    slots: <PlateSlot>[
      _field(
        NewZealandAlphabets.letters,
        _Layout.lettersLeft,
        _Layout.lettersWidth,
        3,
        _Layout.standardCy,
        _Layout.standardBox,
      ),
      _field(
        NewZealandAlphabets.digits,
        _Layout.digitsLeft,
        _Layout.digitsWidth,
        3,
        _Layout.standardCy,
        _Layout.standardBox,
      ),
    ],
    groups: const <String>['letters', 'serial'],
  );

  static final PlateSpec legacy = _spec(
    'nz.legacy',
    slots: <PlateSlot>[
      _field(
        NewZealandAlphabets.letters,
        _Layout.legacyLettersLeft,
        _Layout.legacyLettersWidth,
        2,
        _Layout.legacyCy,
        _Layout.legacyBox,
      ),
      _field(
        NewZealandAlphabets.digits,
        _Layout.legacyDigitsLeft,
        _Layout.legacyDigitsWidth,
        4,
        _Layout.legacyCy,
        _Layout.legacyBox,
      ),
    ],
    groups: const <String>['letters', 'serial'],
  );

  static final PlateSpec personalised = _spec(
    'nz.personalised',
    slots: <PlateSlot>[_personal(_Layout.personalLeft, _Layout.personalWidth)],
    groups: const <String>['serial'],
  );

  static final PlateSpec europlate = _spec(
    'nz.europlate',
    slots: <PlateSlot>[
      _personal(_Layout.europlateLeft, _Layout.europlateWidth),
    ],
    groups: const <String>['serial'],
    background: const PlateSection.columns(<PlatePart>[
      PlatePart(
        PlateSection.fill(PlateFill.color(NewZealandColors.blue)),
        end: _Layout.bandLeftEnd,
      ),
      PlatePart(PlateSection.plain, end: _Layout.bandRightStart),
      PlatePart(PlateSection.fill(PlateFill.color(NewZealandColors.blue))),
    ]),
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'NZ',
        box: PlateBox.centered(
          _Layout.nzCx,
          _Layout.nzCy,
          _Layout.nzWidth,
          _Layout.nzGlyph,
        ),
        glyphHeight: _Layout.nzGlyph,
        color: NewZealandColors.silver,
      ),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[
    standard,
    legacy,
    personalised,
    europlate,
  ];

  /// A fixed-length run at the font's own pitch: `spacing` fills the box.
  static PlateSlot _field(
    PlateAlphabet alphabet,
    double left,
    double width,
    int count,
    double cy,
    double box,
  ) => plateRun(
    alphabet,
    count,
    left: left,
    top: cy - box / 2,
    pitch: width / count,
    height: box,
  );

  /// One to six letters or digits; shorter runs sit in the middle.
  static PlateSlot _personal(double left, double width) => PlateSlot(
    alphabet: NewZealandAlphabets.alphanumeric,
    box: PlateBox(
      left,
      _Layout.personalCy - _Layout.personalBox / 2,
      width,
      _Layout.personalBox,
    ),
    length: 6,
    minLength: 1,
  );

  static PlateSpec _spec(
    String id, {
    required List<PlateSlot> slots,
    required List<String> groups,
    PlateSection background = PlateSection.plain,
    List<PlateLabel> labels = const <PlateLabel>[],
  }) => PlateSpec(
    id: id,
    country: NewZealandCountry.new_zealand,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    background: background,
    slots: slots,
    labels: labels,
    textGroups: PlateTextGroup.perSlot(groups),
  );
}

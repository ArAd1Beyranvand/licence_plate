import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'romania_colors.dart';
import 'romania_country.dart';

/// Ink positions in plate units (520×110, size A), measured from photographs
/// flattened to 520×186, so every x is measured and y is only a share of the
/// height. The standard design follows the 2024 Cluj plate; the others follow
/// their own flats.
///
/// Under-height ink is accepted: photographed ink is ~86% of the plate height,
/// but a slot's ink is ~55% of its box and a box cannot leave the canvas, so
/// every one-row slot is the full 110 and prints ~60 of ink. `RO` is set at 44
/// because the plate's condensed face cannot reach its measured height.
///
/// Not modelled: the 1992–2007 series, the 340×200 and 240×130 plates, the
/// long-term temporary plate, the army's ring-and-dash, the inspection label,
/// the hologram and the Timișoara crest.
abstract final class _Layout {
  static const double width = 520, height = 110;

  static const double bandEnd = 51, starsCx = 25.5, starsCy = 33.3;
  static const double starsRing = 16.6, starsStar = 3.36;
  static const double roTop = 52.2, roBox = 55, roGlyph = 44;

  // Standard.
  static const double countyLeft = 53, countyWidth = 115;
  static const double digitsLeft = 202, digitsWidth = 114;
  static const double lettersLeft = 331, lettersWidth = 169, lettersPitch = 56;

  // Temporary.
  static const double tempDigitsLeft = 184, tempDigitsWidth = 316;

  // Test.
  static const double testCountyLeft = 53, testCountyWidth = 107;
  static const double testDigitsLeft = 194.5, testDigitsWidth = 133;
  static const double probeLeft = 371, probeWidth = 128, probeGlyph = 70;

  // Diplomatic.
  static const double dipCodeLeft = 76, dipCodeWidth = 130;
  static const double dipNumberLeft = 227, dipNumberWidth = 149;
  static const double dipRankLeft = 386, dipRankWidth = 113;

  // Ministry of Interior.
  static const double maiLeft = 21, maiWidth = 156;
  static const double maiDigitsLeft = 215.5, maiDigitsWidth = 300;
  static const double maiPitch = 60;

  // Army.
  static const double armyLeft = 18.5, armyWidth = 60;
  static const double armyDigitsLeft = 160, armyDigitsWidth = 340;

  // Local administration: caption row y 0..41 (ink 7.7..33.7), digits row
  // y 38..110 (ink 55..94.6).
  static const double captionLeft = 164, captionWidth = 302, captionHeight = 41;
  static const double localDigitsLeft = 176, localDigitsWidth = 284;
  static const double localDigitsTop = 38, localDigitsHeight = 72;
  static const double localPitch = 56.8;
}

/// Romania's plates. The electric plate is [standard] with
/// `RomaniaThemes.electric`.
///
/// Text groups: [standard] `county`, `number` (two digits, three in
/// Bucharest) and `letters`; [temporary] and [test] `county` and `number`;
/// [diplomatic] `code` (`CD`, `TC` or `CO`), `mission` and `rank`;
/// [ministryOfInterior] and [army] `number`; [localAdministration] `place`
/// and `number`.
abstract final class RomaniaPlates {
  static final List<PlateTextGroup> _countyAndNumber = PlateTextGroup.perSlot(
    <String>['county', 'number'],
  );

  /// `CC 12 ABC` / `B 123 ABC`.
  static final PlateSpec standard = _spec(
    id: 'ro.standard',
    slots: <PlateSlot>[
      _county(),
      const PlateSlot(
        alphabet: RomaniaAlphabets.digits,
        box: PlateBox(
          _Layout.digitsLeft,
          0,
          _Layout.digitsWidth,
          _Layout.height,
        ),
        length: 3,
        minLength: 2,
      ),
      PlateSlot(
        alphabet: RomaniaAlphabets.letters,
        box: const PlateBox(
          _Layout.lettersLeft,
          0,
          _Layout.lettersWidth,
          _Layout.height,
        ),
        length: 3,
        spacing: _spacing(_Layout.lettersPitch, _Layout.height),
      ),
    ],
    groups: PlateTextGroup.perSlot(<String>['county', 'number', 'letters']),
  );

  /// `CC 012345`: red, the first digit zero and the second not.
  static final PlateSpec temporary = _spec(
    id: 'ro.temporary',
    slots: <PlateSlot>[
      _county(),
      const PlateSlot(
        alphabet: RomaniaAlphabets.digits,
        box: PlateBox(
          _Layout.tempDigitsLeft,
          0,
          _Layout.tempDigitsWidth,
          _Layout.height,
        ),
        length: 6,
        minLength: 3,
      ),
    ],
    groups: _countyAndNumber,
  );

  /// `CC 123 PROBE`.
  static final PlateSpec test = _spec(
    id: 'ro.test',
    slots: const <PlateSlot>[
      PlateSlot(
        alphabet: RomaniaAlphabets.letters,
        box: PlateBox(
          _Layout.testCountyLeft,
          0,
          _Layout.testCountyWidth,
          _Layout.height,
        ),
        length: 2,
        minLength: 1,
      ),
      PlateSlot(
        alphabet: RomaniaAlphabets.digits,
        box: PlateBox(
          _Layout.testDigitsLeft,
          0,
          _Layout.testDigitsWidth,
          _Layout.height,
        ),
        length: 3,
      ),
    ],
    groups: _countyAndNumber,
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'PROBE',
        box: PlateBox(_Layout.probeLeft, 0, _Layout.probeWidth, _Layout.height),
        glyphHeight: _Layout.probeGlyph,
      ),
    ],
  );

  /// `CD 205 113`: the mission digits name the country or organisation, the
  /// rank digits the owner. `TC` and `CO` use the same plate.
  static final PlateSpec diplomatic = _spec(
    id: 'ro.diplomatic',
    slots: const <PlateSlot>[
      PlateSlot(
        alphabet: RomaniaAlphabets.letters,
        box: PlateBox(
          _Layout.dipCodeLeft,
          0,
          _Layout.dipCodeWidth,
          _Layout.height,
        ),
        length: 2,
      ),
      PlateSlot(
        alphabet: RomaniaAlphabets.digits,
        box: PlateBox(
          _Layout.dipNumberLeft,
          0,
          _Layout.dipNumberWidth,
          _Layout.height,
        ),
        length: 3,
      ),
      PlateSlot(
        alphabet: RomaniaAlphabets.digits,
        box: PlateBox(
          _Layout.dipRankLeft,
          0,
          _Layout.dipRankWidth,
          _Layout.height,
        ),
        length: 3,
      ),
    ],
    groups: PlateTextGroup.perSlot(<String>['code', 'mission', 'rank']),
  );

  /// `MAI 12345`: no Euroband.
  static final PlateSpec ministryOfInterior = _plain(
    id: 'ro.mai',
    prefix: 'MAI',
    prefixBox: const PlateBox(
      _Layout.maiLeft,
      0,
      _Layout.maiWidth,
      _Layout.height,
    ),
    digits: PlateSlot(
      alphabet: RomaniaAlphabets.digits,
      box: const PlateBox(
        _Layout.maiDigitsLeft,
        0,
        _Layout.maiDigitsWidth,
        _Layout.height,
      ),
      length: 5,
      spacing: _spacing(_Layout.maiPitch, _Layout.height),
    ),
  );

  /// `A 12345`: three to seven digits. No Euroband.
  static final PlateSpec army = _plain(
    id: 'ro.army',
    prefix: 'A',
    prefixBox: const PlateBox(
      _Layout.armyLeft,
      0,
      _Layout.armyWidth,
      _Layout.height,
    ),
    digits: const PlateSlot(
      alphabet: RomaniaAlphabets.digits,
      box: PlateBox(
        _Layout.armyDigitsLeft,
        0,
        _Layout.armyDigitsWidth,
        _Layout.height,
      ),
      length: 7,
      minLength: 3,
    ),
  );

  /// A municipality over a five-digit number, on yellow. No Euroband.
  static final PlateSpec localAdministration = PlateSpec(
    id: 'ro.local',
    country: RomaniaCountry.romania,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
    slots: <PlateSlot>[
      const PlateSlot(
        alphabet: RomaniaAlphabets.placeName,
        box: PlateBox(
          _Layout.captionLeft,
          0,
          _Layout.captionWidth,
          _Layout.captionHeight,
        ),
        length: 16,
        minLength: 1,
        group: 'place',
      ),
      PlateSlot(
        alphabet: RomaniaAlphabets.digits,
        box: const PlateBox(
          _Layout.localDigitsLeft,
          _Layout.localDigitsTop,
          _Layout.localDigitsWidth,
          _Layout.localDigitsHeight,
        ),
        length: 5,
        spacing: _spacing(_Layout.localPitch, _Layout.localDigitsHeight),
        group: 'number',
      ),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[
    standard,
    temporary,
    test,
    diplomatic,
    ministryOfInterior,
    army,
    localAdministration,
  ];

  /// Gap that gives a digit or letter run the measured [pitch], given the
  /// advance of a glyph in a slot of [height].
  static double _spacing(double pitch, double height) =>
      plateRunSpacing(pitch, height);

  static PlateSlot _county() => const PlateSlot(
    alphabet: RomaniaAlphabets.letters,
    box: PlateBox(_Layout.countyLeft, 0, _Layout.countyWidth, _Layout.height),
    length: 2,
    minLength: 1,
  );

  /// The blue strip is the background, the stars a decal and `RO` a label.
  static PlateSpec _spec({
    required String id,
    required List<PlateSlot> slots,
    required List<PlateTextGroup> groups,
    List<PlateLabel> labels = const <PlateLabel>[],
  }) => PlateSpec(
    id: id,
    country: RomaniaCountry.romania,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
    background: const PlateSection.columns(<PlatePart>[
      PlatePart(PlateSection.fill(PlateFill.panel), end: _Layout.bandEnd),
      PlatePart(PlateSection.plain),
    ]),
    decals: const <PlateDecal>[
      PlateDecal(
        drawing: PlateDrawing(_Layout.bandEnd, 66.6, <PlateShape>[
          PlateStarRingShape(
            _Layout.starsCx,
            _Layout.starsCy,
            _Layout.starsRing,
            _Layout.starsStar,
            12,
            RomaniaColors.euroGold,
          ),
        ]),
        box: PlateBox(0, 0, _Layout.bandEnd, 66.6),
      ),
    ],
    slots: slots,
    labels: <PlateLabel>[
      const PlateLabel(
        text: 'RO',
        box: PlateBox(0, _Layout.roTop, _Layout.bandEnd, _Layout.roBox),
        glyphHeight: _Layout.roGlyph,
        color: RomaniaColors.white,
      ),
      ...labels,
    ],
    textGroups: groups,
  );

  /// No Euroband: a fixed [prefix] and a digit field.
  static PlateSpec _plain({
    required String id,
    required String prefix,
    required PlateBox prefixBox,
    required PlateSlot digits,
  }) => PlateSpec(
    id: id,
    country: RomaniaCountry.romania,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
    slots: <PlateSlot>[digits],
    labels: <PlateLabel>[
      PlateLabel(text: prefix, box: prefixBox, glyphHeight: _Layout.height),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'number'),
    ],
  );
}

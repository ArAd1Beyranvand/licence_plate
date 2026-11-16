import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'pakistan_colors.dart';
import 'pakistan_country.dart';

/// Where the ink sits on a Pakistani plate, in plate units.
///
/// **Canvas 520×287.** The infobox gives 12×6 in (2.0) but states no size
/// for the provincial designs, and all six artworks agree on aspect 1.81, so
/// the canvas is the artwork's (the article's 520×110 is a stale default of
/// the offline tool). Every number below is off the artwork flattened to
/// 520×287 by platekit, or — Azad Jammu & Kashmir and Sindh, whose flattening
/// failed — off the 500×277 originals mapped from the rim's outer edge.
///
/// **Ink is not slot height.** The 109-unit digits would need a ~210-unit
/// slot (`glyphStyle` sets 0.72 of the slot, a bold cap is ~0.73 of that),
/// and DejaVu Bold is far wider than the plates' condensed face, so a field
/// is width-limited anyway and scaled down as a whole. The main row's slot is
/// 130 tall, ~62% of reference ink; the plate_core engine is unchanged.
abstract final class _Layout {
  static const double width = 520, height = 287;

  /// Slot height for a main row whose reference ink is 109.
  static const double mainHeight = 130;

  /// A main row's top from its ink centre.
  static double mainTop(double centre) => centre - mainHeight / 2;

  // Captioned plates: title, `LL ● DDDD`, city.
  /// Balochistan ink rows y 24.3..58 (title), 94..203 (main), 228..261.8.
  static const double balochCentre = 148.5;

  /// Azad Jammu & Kashmir: 20.7..59.8, 88.1..196.8, ~230.5..262.
  static const double ajkCentre = 142.5;

  /// Sindh: 13..59.8 (arms), 82.6..192.4, 223.9..~258.
  static const double sindhCentre = 137.5;

  /// Letters 20.8..168.8 and digits 246..497 on Balochistan and Khyber
  /// Pakhtunkhwa; the emblem fills 186..236 between them.
  static const double lettersLeft = 20.8, lettersWidth = 148, digitsLeft = 246;
  static const double digitsWidth = 251;

  // Islamabad: strip 0..135.5, `LL ■ DDD` ink 59..168, caption 227..258.5.
  static const double ictStripEnd = 135.5, ictCentre = 113.5;

  // Punjab: strip 0..135.75, row 1 ink 33.75..124.75 (letters), row 2
  // 161.25..252.5 (digits); the year's ink 73.5..121.5.
  static const double punjabStripEnd = 135.75, punjabRow1Centre = 79.25;
  static const double punjabRow2Centre = 207, punjabRowHeight = 110;
  static const double punjabYearCentre = 97.5, punjabYearHeight = 92;
}

/// What is printed on one province's captioned plate: an optional title above
/// and a city below. Titles and cities are fixed text here; the real plates print the
/// issuing city, so a host wanting another city builds its own label.
class _Caption {
  const _Caption({
    this.title,
    this.titleCentre = Offset.zero,
    this.titleGlyph = 0,
    required this.city,
    required this.cityCentre,
  });

  final String? title;
  final Offset titleCentre;
  final double titleGlyph;
  final String city;
  final Offset cityCentre;
}

/// Pakistan's plate geometries. Each province has its own design; the plate's
/// colours are the theme's ([PakistanThemes.white], [PakistanThemes.sindh]).
///
/// Every field is one slot: `letters` (2–3), `digits` (3–4) and, on Punjab,
/// `year` (2). The article's federal liveries (government green, diplomatic
/// red, armed forces and police black, NGO blue) have no image and are not
/// modelled. The Azad Jammu & Kashmir chinar leaf and wave strip, Islamabad's
/// mosque photograph, Punjab's flower and Sindh's arms are not drawn.
abstract final class PakistanPlates {
  static final List<PlateTextGroup> _groups = PlateTextGroup.perSlot(<String>[
    'letters',
    'digits',
  ]);

  static PlateSlot _letters(
    double left,
    double width,
    double top,
    double height, {
    int count = 2,
  }) => PlateSlot(
    alphabet: PakistanAlphabets.letters,
    box: PlateBox(left, top, width, height),
    length: count,
  );

  static PlateSlot _digits(
    double left,
    double width,
    double top,
    double height, {
    required int count,
    int? minLength,
  }) => PlateSlot(
    alphabet: PakistanAlphabets.digits,
    box: PlateBox(left, top, width, height),
    length: count,
    minLength: minLength,
  );

  static PlateLabel _label(String text, Offset centre, double glyph) {
    const double h = 60, w = 440;
    return PlateLabel(
      text: text,
      box: PlateBox.centered(centre.dx, centre.dy, w, h),
      glyphHeight: glyph,
    );
  }

  static PlateRule _square(double left, double top, double size) =>
      PlateRule(box: PlateBox(left, top, size, size));

  static PlateSpec _captioned({
    required String id,
    required _Caption caption,
    required PlateSlot letters,
    required PlateSlot digits,
    PlateDecal? emblem,
    PlateRule? dot,
  }) => PlateSpec(
    id: id,
    country: PakistanCountry.pakistan,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
    slots: <PlateSlot>[letters, digits],
    labels: <PlateLabel>[
      if (caption.title case final String title)
        _label(title, caption.titleCentre, caption.titleGlyph),
      _label(caption.city, caption.cityCentre, 52),
    ],
    rules: <PlateRule>[?dot],
    decals: <PlateDecal>[?emblem],
    textGroups: _groups,
  );

  /// Balochistan: BALOCHISTAN above, `LL` arms `DDDD`, QUETTA below.
  /// Title ink 104.5..411.2 (centre 258) over y 24.3..58; city 172.2..344.5.
  static final PlateSpec balochistan = _captioned(
    id: 'pk.balochistan',
    caption: const _Caption(
      title: 'BALOCHISTAN',
      titleCentre: Offset(258, 41),
      titleGlyph: 52,
      city: 'QUETTA',
      cityCentre: Offset(258.4, 245),
    ),
    letters: _letters(
      _Layout.lettersLeft,
      _Layout.lettersWidth,
      _Layout.mainTop(_Layout.balochCentre),
      _Layout.mainHeight,
    ),
    digits: _digits(
      _Layout.digitsLeft,
      _Layout.digitsWidth,
      _Layout.mainTop(_Layout.balochCentre),
      _Layout.mainHeight,
      count: 4,
    ),
    // Commons: File:Coat of arms of Balochistan.svg; ink 185.8..236.5 ×
    // 134.3..178.8.
    emblem: const PlateDecal(
      image: AssetImage(
        'assets/countries/pakistan/icons/balochistan_arms.png',
        package: 'license_plate',
      ),
      box: PlateBox(185.75, 134.25, 50.75, 44.5),
    ),
  );

  /// Khyber Pakhtunkhwa: the same face with the province's arms; title ink
  /// 94.8..443.5 over y 36.75..63 (a longer title, so a smaller glyph).
  static final PlateSpec khyberPakhtunkhwa = _captioned(
    id: 'pk.khyberPakhtunkhwa',
    caption: const _Caption(
      title: 'KHYBER PAKHTUNKHWA',
      titleCentre: Offset(269, 50),
      titleGlyph: 38,
      city: 'PESHAWAR',
      cityCentre: Offset(269, 245),
    ),
    letters: _letters(
      _Layout.lettersLeft,
      _Layout.lettersWidth,
      _Layout.mainTop(_Layout.balochCentre),
      _Layout.mainHeight,
    ),
    digits: _digits(
      _Layout.digitsLeft,
      _Layout.digitsWidth,
      _Layout.mainTop(_Layout.balochCentre),
      _Layout.mainHeight,
      count: 4,
    ),
    // Commons: File:Coat of arms of Khyber Pakhtunkhwa.svg; ink 186.8..234.3
    // × 130..179.8.
    emblem: const PlateDecal(
      image: AssetImage(
        'assets/countries/pakistan/icons/khyber_pakhtunkhwa_arms.png',
        package: 'license_plate',
      ),
      box: PlateBox(186.75, 130, 47.5, 49.75),
    ),
  );

  /// Azad Jammu & Kashmir: AJ&K above, `LL ■ DDD`, the city below. Off the
  /// original, not a flattened photo (CHECK): letters 167.6..289.7, dot
  /// 311.4..326.5 × 141.3..156.5, digits 341.6..494, title 252..383.
  static final PlateSpec azadJammuKashmir = _captioned(
    id: 'pk.azadJammuKashmir',
    caption: const _Caption(
      title: 'AJ&K',
      titleCentre: Offset(317, 40),
      titleGlyph: 60,
      city: 'MIRPUR',
      cityCentre: Offset(320, 246),
    ),
    letters: _letters(
      167.6,
      122,
      _Layout.mainTop(_Layout.ajkCentre),
      _Layout.mainHeight,
    ),
    digits: _digits(
      341.6,
      152.4,
      _Layout.mainTop(_Layout.ajkCentre),
      _Layout.mainHeight,
      count: 3,
    ),
    dot: _square(311.4, 141.3, 15),
  );

  /// Islamabad: a dusk-blue strip to x 135.5, `LL ■ DDD` on its right, and
  /// ICT-ISLAMABAD below. The mosque photograph is not drawn.
  static final PlateSpec islamabad = PlateSpec(
    id: 'pk.islamabad',
    country: PakistanCountry.pakistan,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
    background: const PlateSection.columns(<PlatePart>[
      PlatePart(
        PlateSection.fill(PlateFill.color(PakistanColors.ictStrip)),
        end: _Layout.ictStripEnd,
      ),
      PlatePart(PlateSection.plain),
    ]),
    slots: <PlateSlot>[
      _letters(166.8, 117.2, _Layout.mainTop(_Layout.ictCentre), 130),
      _digits(332, 159.8, _Layout.mainTop(_Layout.ictCentre), 130, count: 3),
    ],
    labels: <PlateLabel>[
      _label('ICT - ISLAMABAD', const Offset(325.8, 243), 44),
    ],
    rules: <PlateRule>[_square(301, 109, 16)],
    textGroups: _groups,
  );

  /// Punjab: a green strip to x 135.75 with PUNJAB at its foot, `LLL - YY` over
  /// `DDDD`. The reference is a pre-2020 plate; newer ones have three digits
  /// and no year, so the digits are 3–4 and the year is not required to be
  /// absent. The flower is not drawn.
  static final PlateSpec punjab = PlateSpec(
    id: 'pk.punjab',
    country: PakistanCountry.pakistan,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
    background: const PlateSection.columns(<PlatePart>[
      PlatePart(
        PlateSection.fill(PlateFill.color(PakistanColors.punjabGreen)),
        end: _Layout.punjabStripEnd,
      ),
      PlatePart(PlateSection.plain),
    ]),
    slots: <PlateSlot>[
      _letters(
        176.8,
        187.2,
        _Layout.punjabRow1Centre - _Layout.punjabRowHeight / 2,
        _Layout.punjabRowHeight,
        count: 3,
      ),
      _digits(
        157.5,
        252.5,
        _Layout.punjabRow2Centre - _Layout.punjabRowHeight / 2,
        _Layout.punjabRowHeight,
        count: 4,
        minLength: 3,
      ),
      PlateSlot(
        alphabet: PakistanAlphabets.digits,
        box: PlateBox(
          440,
          _Layout.punjabYearCentre - _Layout.punjabYearHeight / 2,
          64,
          _Layout.punjabYearHeight,
        ),
        length: 2,
      ),
    ],
    labels: <PlateLabel>[
      PlateLabel(
        text: 'PUNJAB',
        box: PlateBox(21, 223, 100, 40),
        glyphHeight: 32,
      ),
    ],
    rules: <PlateRule>[PlateRule(box: PlateBox(392, 84.25, 31, 11.5))],
    textGroups: PlateTextGroup.perSlot(<String>['letters', 'digits', 'year']),
  );

  /// Sindh: yellow, `LLL ■ DDD` and SINDH below. Off the original (CHECK):
  /// letters 38.9..225.9, dot 258.4..273.5 × 135.9..151.1, digits
  /// 305..458.4, title ink 171..334. The arms above are not drawn.
  static final PlateSpec sindh = _captioned(
    id: 'pk.sindh',
    caption: const _Caption(city: 'SINDH', cityCentre: Offset(252.5, 241)),
    letters: _letters(
      38.9,
      187,
      _Layout.mainTop(_Layout.sindhCentre),
      _Layout.mainHeight,
      count: 3,
    ),
    digits: _digits(
      305,
      153.4,
      _Layout.mainTop(_Layout.sindhCentre),
      _Layout.mainHeight,
      count: 3,
    ),
    dot: _square(258.4, 135.9, 15),
  );
}

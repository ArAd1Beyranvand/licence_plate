import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'gambia_colors.dart';
import 'gambia_country.dart';
import 'gambia_regions.dart';

/// Where the ink sits on one design, in plate units.
///
/// Measured on references flattened to 520 wide and 298 tall, then rescaled in
/// y by `canvasHeight / 298`. Glyph size is the largest box that stays on the
/// canvas, the ink being ~0.55 of it, so ink is shorter than the references'.
class _Design {
  const _Design({
    required this.width,
    required this.height,
    required this.border,
    required this.flag,
    required this.gpf,
    required this.gpfGlyph,
    required this.region,
    required this.regionGlyph,
    required this.number,
    required this.numberPitch,
    required this.numberGlyph,
    required this.suffix,
    this.mc,
    this.mcGlyph = 0,
  });

  final double width, height;

  /// Frame width over [height]: measured 4.0, 8.2 and 5.6 units.
  final double border;

  /// The flag, which is drawn on the background (stripes 6:1:4:1:6).
  final PlateBox flag;

  /// "GPF", the issuer, under the flag.
  final PlateBox gpf;
  final double gpfGlyph;

  /// "MC" before the region on motorcycle plates.
  final PlateBox? mc;
  final double mcGlyph;

  /// The region field, sized for 3 letters; 2 letters sit in its middle.
  final PlateBox region;
  final double regionGlyph;

  /// The four digits, centred on the first/last digit centres, at [numberPitch].
  final PlateBox number;
  final double numberPitch, numberGlyph;

  final PlateBox suffix;
}

abstract final class _Layout {
  /// 520×110 mm. Ink y 19.6–96.0 (76 tall, centre 57.8); region x 75.8–222
  /// (3 letters) or 97–196.2 (2); digits x 232.8–426.2, centres 252.6, 303,
  /// 356, 404 (pitch 50.5); suffix x 442.2–500. Flag x 14.2–64.2 y 20.2–45.7;
  /// GPF x 17.5–63.8, ink ~19 tall at y 77–96. The plate is 110 tall, so the
  /// glyph box is capped at 104 (ink ~57, 75% of the reference's 76).
  static const _Design line = _Design(
    width: 520,
    height: 110,
    border: 0.036,
    flag: PlateBox(14.2, 20.2, 50, 25.5),
    gpf: PlateBox(14, 74, 53, 24),
    gpfGlyph: 34,
    region: PlateBox(75.8, 5.8, 146.2, 104),
    regionGlyph: 104,
    number: PlateBox(227.3, 5.8, 202, 104),
    numberPitch: 50.5,
    numberGlyph: 104,
    suffix: PlateBox(440, 5.8, 60, 104),
  );

  /// 270×200 mm → 520×385. Row 1 ink y 46.5–186.7 (centre 116.6), region x
  /// 154.5–426 (3 letters) or 183.5–363.5 (2); row 2 ink y 223.8–352.7
  /// (centre 288.3), digit centres 62.9, 155.7, 251.9, 344.5 (pitch 93.9),
  /// suffix x 406.5–499.8. Flag x 27.8–125.8 y 39.4–88; GPF x 33–124.8,
  /// ink y 147–187. Boxes are 210 and 190: ink ~115 and ~104 against the
  /// reference's 140 and 129 (~82%), the most the 385-unit canvas lets two
  /// rows have.
  static const _Design square = _Design(
    width: 520,
    height: 385,
    border: 0.021,
    flag: PlateBox(27.8, 39.4, 98, 48.6),
    gpf: PlateBox(25, 142, 108, 50),
    gpfGlyph: 72,
    region: PlateBox(154.5, 11.6, 271.5, 210),
    regionGlyph: 210,
    number: PlateBox(15.9, 193.3, 375.6, 190),
    numberPitch: 93.9,
    numberGlyph: 190,
    suffix: PlateBox(406.5, 193.3, 93.3, 190),
  );

  /// 240×130 mm → 520×282. Row 1 ink y 26.3–126 (centre 76.2), region x
  /// 296.8–477 (3 letters) or 328.2–447.8 (2); "MC" x 163.5–251.2, ink y
  /// 47–115; row 2 ink y 162.3–261.2 (centre 211.7), digit centres 69.2,
  /// 146.8, 227.7, 304 (pitch 78.3), suffix x 408.2–485.8. Flag x 49–131
  /// y 26.5–66.1; GPF centred (91, 94), ink ~38. Boxes are 140: ink ~77 of
  /// the reference's 99 (~78%), as the rows' centres leave little room.
  static const _Design motorcycle = _Design(
    width: 520,
    height: 282,
    border: 0.02,
    flag: PlateBox(49, 26.5, 82, 39.6),
    gpf: PlateBox(40, 70, 102, 48),
    gpfGlyph: 66,
    mc: PlateBox(158, 20, 98, 130),
    mcGlyph: 130,
    region: PlateBox(296.8, 6.2, 180.2, 140),
    regionGlyph: 140,
    number: PlateBox(30, 141.5, 313.2, 140),
    numberPitch: 78.3,
    numberGlyph: 140,
    suffix: PlateBox(404, 141.5, 86, 140),
  );
}

/// The plates from 2019 on. Colour is the theme's: pair [line] and [square]
/// with [GambiaThemes.private] or [GambiaThemes.commercial], and [motorcycle]
/// with the private one.
///
/// Three designs with the same fields: `region` (2 or 3 letters), `number`
/// (4 digits) and `suffix` (1 letter). Motorcycle plates add a printed "MC".
/// The flag is painted on the background, not an asset.
///
/// Not implemented: the pre-2019 series, rickshaw plates, the diplomatic
/// series and the inspection sticker.
abstract final class GambiaPlates {
  /// 520×110 mm, one row.
  static final PlateSpec line = _spec('gm.line', _Layout.line);

  /// 270×200 mm, region over number.
  static final PlateSpec square = _spec('gm.square', _Layout.square);

  /// 240×130 mm, "MC" and region over number.
  static final PlateSpec motorcycle = _spec(
    'gm.motorcycle',
    _Layout.motorcycle,
  );

  static List<PlateSpec> get all => <PlateSpec>[line, square, motorcycle];

  static PlateSpec _spec(String id, _Design d) {
    PlateSlot field(
      PlateAlphabet alphabet,
      PlateBox box,
      double glyph, {
      int length = 1,
      int? minLength,
      double pitch = 0,
    }) => PlateSlot(
      alphabet: alphabet,
      box: box,
      length: length,
      minLength: minLength,
      spacing: pitch == 0 ? 0 : plateRunSpacing(pitch, glyph),
    );
    return PlateSpec(
      id: id,
      country: GambiaCountry.gambia,
      canvasWidth: d.width,
      canvasHeight: d.height,
      borderWidthRatioOverride: d.border,
      background: _flagBackground(d),
      slots: <PlateSlot>[
        field(
          GambiaAlphabets.letters,
          d.region,
          d.regionGlyph,
          length: 3,
          minLength: 2,
        ),
        field(
          GambiaAlphabets.digits,
          d.number,
          d.numberGlyph,
          length: 4,
          pitch: d.numberPitch,
        ),
        field(GambiaAlphabets.letters, d.suffix, d.numberGlyph),
      ],
      labels: <PlateLabel>[
        PlateLabel(text: 'GPF', box: d.gpf, glyphHeight: d.gpfGlyph),
        if (d.mc case final PlateBox mc)
          PlateLabel(text: 'MC', box: mc, glyphHeight: d.mcGlyph),
      ],
      textGroups: PlateTextGroup.perSlot(<String>[
        'region',
        'number',
        'suffix',
      ]),
      resolveRegion: GambiaRegions.captionOf,
    );
  }

  /// The flag of the Gambia on the plain face: red 6, white 1, blue 4, white
  /// 1, green 6 (of 18) down the flag's height.
  static PlateSection _flagBackground(_Design d) {
    final PlateBox f = d.flag;
    final double u = f.height / 18;
    const PlateFill white = PlateFill.color(GambiaColors.white);
    return PlateSection.rows(<PlatePart>[
      PlatePart(PlateSection.plain, end: f.top),
      PlatePart(
        PlateSection.columns(<PlatePart>[
          PlatePart(PlateSection.plain, end: f.left),
          PlatePart(
            PlateSection.fill(
              PlateFill.stripes(
                const <PlateFill>[
                  PlateFill.color(GambiaColors.flagRed),
                  white,
                  PlateFill.color(GambiaColors.flagBlue),
                  white,
                  PlateFill.color(GambiaColors.flagGreen),
                ],
                stops: <double>[
                  f.top + 6 * u,
                  f.top + 7 * u,
                  f.top + 11 * u,
                  f.top + 12 * u,
                ],
              ),
            ),
            end: f.right,
          ),
          const PlatePart(PlateSection.plain),
        ]),
        end: f.bottom,
      ),
      const PlatePart(PlateSection.plain),
    ]);
  }
}

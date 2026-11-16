import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'czech_republic_colors.dart';
import 'czech_republic_country.dart';

/// Where the ink sits, in plate units. Every one-line photo is flattened to
/// the 520×110 the article gives (4 px per unit); positions are ink-run
/// measurements of those flats, read as a field's centre of the first cell
/// and its pitch.
///
/// - private `1A2 3456`: band x 5.5–47 inside the frame; `1A2` 58–208, pitch
///   50; `3456` 300–499 (ink 301.2–499), pitch 50. Two inspection stickers
///   between them are not drawn.
/// - private2001 `2H2 7149`: no band; `2H2` ink 70.8–209.5, `7149` 274–474.
/// - classic `ALA 40-11`: letters 49–196 (2 or 3 of them), `40` ink
///   267–357.5, dash about 378, `11` ink 399–476 (cells 413.6 and 461.7).
/// - military `022 61-25`: `022` ink 47–190.5, `61` 258.5–345, `25` 387.8–479.
/// - classic70s `AZ-17-32`: the 8 glyphs of the row run 59–469 with pitch
///   about 60; the dashes sit at about 190 and 340. Estimated from the row
///   spans, not a clean measure.
/// - export `A67 38E`: `A67` ink 69.5–206, `38E` 276.5–421. The expiry
///   calendar at the right is not drawn.
/// - diplomatic `017 CD 75` and veteran `V 7425`: read off the flats' sheet
///   (the brief fits both CHECK / partly merged runs), so approximate. The
///   veteran photo shows `V` and four digits, the article `NNV XXXX`: the
///   picture wins.
///
/// Ink is 95 tall on a 110 plate, but a box that tall would need about 170,
/// so every box is the full canvas height and the ink lands near 60, about
/// 63% of reference.
///
/// Two-line plates (US-size `4B0 / 9595`, motorcycle `3A / 6789`): the flats
/// of the brief are 520×110 squashed from a photo of aspect 2.05 and 1.23, so
/// the canvases are 340×165 and 250×200 and every flat coordinate is scaled
/// by 340/520 and 165/110 (250/520 and 200/110). Those are estimates off the
/// sheet.
///
/// Not drawn: the inspection and emission stickers, and the EU band's
/// separate Czech flag (the plates do not print one). Electric `EL1 06AC` and
/// the vector "Variation 1/2" are the private plate with other characters.
abstract final class _Layout {
  static const double width = 520, height = 110, bandEnd = 47;

  static const double top = 0, box = 110, dashWidth = 24;

  static const PlateBox stars = PlateBox(5.5, 6, 41.5, 63.5);
  static const PlateBox label = PlateBox(6, 70, 40, 30);
  static const double labelGlyph = 30;

  static const _Badge usBadge = _Badge(
    PlateBox(3, 4, 47, 86),
    PlateBox(5, 6, 43, 52),
    PlateBox(5, 58, 43, 30),
  );
  static const _Badge motoBadge = _Badge(
    PlateBox(3, 6, 52, 86),
    PlateBox(5, 8, 48, 50),
    PlateBox(5, 58, 48, 30),
  );
}

/// The blue block floating on a two-line plate: the band, the stars in it and
/// the `CZ` beneath them.
class _Badge {
  const _Badge(this.band, this.stars, this.label);
  final PlateBox band, stars, label;
}

/// One field: [count] cells at [pitch] from [firstCentre]; fewer than [count]
/// but at least [minCount] counts as complete.
class _Field {
  const _Field(
    this.key,
    this.alphabet,
    this.firstCentre,
    this.pitch,
    this.count, {
    this.minCount,
    this.top = _Layout.top,
    this.height = _Layout.box,
  });

  final String key;
  final PlateAlphabet alphabet;
  final double firstCentre, pitch;
  final int count;
  final int? minCount;
  final double top, height;
}

const PlateAlphabet _digits = CzechRepublicAlphabets.digits;
const PlateAlphabet _letters = CzechRepublicAlphabets.letters;
const PlateAlphabet _mixed = CzechRepublicAlphabets.alphanumeric;

/// The Czech plates, one builder over a list of fields.
///
/// [private] is the current plate `1A2 3456` (also electric `EL1 06AC` and
/// `1AA B174`); [private2001] the 2001–2004 plate without band; [classic] the
/// 1992–2001 `ALA 40-11` (yellow for commercial vehicles, in
/// `CzechRepublicThemes.commercial`); [military] `022 61-25`; [classic70s]
/// `AZ-17-32`; [export]; [diplomatic] `017 CD 75`; [veteran] `V 7425`;
/// [personalised] `DIC TATOR`; [usSize] and [motorcycle], the two-line plates.
///
/// The one-line plates of 1986–1992 (`AX 70-84`, yellow) are [classic]'s
/// layout on a yellow field and are not a separate spec. The vector "Variation
/// 1 – 2 Line Plate" (aspect 1.37) is [usSize]'s fields on another canvas and
/// is an illustration, not a plate of its own.
abstract final class CzechRepublicPlates {
  static final PlateSpec private = _spec(
    id: 'cz.private',
    band: true,
    fields: const <_Field>[
      _Field('a', _mixed, 83, 50, 3),
      _Field('b', _mixed, 325, 50, 4),
    ],
  );

  static final PlateSpec private2001 = _spec(
    id: 'cz.private2001',
    fields: const <_Field>[
      _Field('a', _mixed, 92, 47, 3),
      _Field('b', _digits, 299, 50, 4),
    ],
  );

  /// Two or three district letters (`RA`, `ALA`): the box is sized for three,
  /// so a run of two is centred in it, a little right of where it is printed.
  static final PlateSpec classic = _spec(
    id: 'cz.classic',
    fields: const <_Field>[
      _Field('a', _letters, 73.5, 49, 3, minCount: 2),
      _Field('b', _digits, 287, 50, 2),
      _Field('c', _digits, 438, 48, 2),
    ],
    dashes: const <double>[378],
  );

  static final PlateSpec military = _spec(
    id: 'cz.military',
    fields: const <_Field>[
      _Field('a', _digits, 68.7, 50, 3),
      _Field('b', _digits, 276.8, 50, 2),
      _Field('c', _digits, 408.5, 50, 2),
    ],
    dashes: const <double>[366],
  );

  static final PlateSpec classic70s = _spec(
    id: 'cz.classic70s',
    fields: const <_Field>[
      _Field('a', _letters, 80, 62, 2),
      _Field('b', _digits, 235, 59.5, 2),
      _Field('c', _digits, 383, 63, 2),
    ],
    dashes: const <double>[190, 340],
  );

  static final PlateSpec export = _spec(
    id: 'cz.export',
    fields: const <_Field>[
      _Field('a', _mixed, 89.7, 48, 3),
      _Field('b', _mixed, 296.9, 52, 3),
    ],
  );

  static final PlateSpec diplomatic = _spec(
    id: 'cz.diplomatic',
    band: true,
    fields: const <_Field>[
      _Field('a', _digits, 74, 48.7, 3),
      _Field('b', _letters, 261, 49, 2),
      _Field('c', _digits, 386, 60, 2),
    ],
  );

  static final PlateSpec veteran = _spec(
    id: 'cz.veteran',
    band: true,
    fields: const <_Field>[
      _Field('a', _letters, 90, 56, 1),
      _Field('b', _digits, 312, 53.5, 4),
    ],
  );

  /// `DIC TATOR`: the fields either side of the stickers, estimated from the
  /// photo (its band is cropped), not measured. Czech personalised plates
  /// take up to eight characters.
  static final PlateSpec personalised = _spec(
    id: 'cz.personalised',
    band: true,
    fields: const <_Field>[
      _Field('a', _mixed, 82, 60, 3, minCount: 1),
      _Field('b', _mixed, 286, 48, 5, minCount: 1),
    ],
  );

  /// `4B0 / 9595`. Rows are 90 tall, centred on ink rows at about y 45 and
  /// 120.
  static final PlateSpec usSize = _spec(
    id: 'cz.usSize',
    fields: const <_Field>[
      _Field('a', _mixed, 130.5, 39, 3, top: 1, height: 90),
      _Field('b', _mixed, 108.3, 40.5, 4, top: 75, height: 90),
    ],
    badge: _Layout.usBadge,
    width: 340,
    height: 165,
  );

  /// `3A / 6789`, the band in the top left and the stickers at the right.
  static final PlateSpec motorcycle = _spec(
    id: 'cz.motorcycle',
    fields: const <_Field>[
      _Field('a', _mixed, 87, 49, 2, top: 0, height: 100),
      _Field('b', _digits, 52, 47.5, 4, top: 100, height: 100),
    ],
    badge: _Layout.motoBadge,
    width: 250,
    height: 200,
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    private2001,
    classic,
    military,
    classic70s,
    export,
    diplomatic,
    veteran,
    personalised,
    usSize,
    motorcycle,
  ];

  /// The field as one slot: its box spans the cells at their pitch. A fixed
  /// run is spaced to the printed pitch; a variable one keeps the font's.
  static PlateSlot _slot(_Field f) {
    return PlateSlot(
      alphabet: f.alphabet,
      box: PlateBox(
        f.firstCentre - f.pitch / 2,
        f.top,
        f.count * f.pitch,
        f.height,
      ),
      length: f.count,
      minLength: f.minCount,
      spacing: f.count > 1 && f.minCount == null
          ? plateRunSpacing(f.pitch, f.height)
          : 0,
      group: f.key,
    );
  }

  static PlateSpec _spec({
    required String id,
    required List<_Field> fields,
    bool band = false,
    _Badge? badge,
    List<double> dashes = const <double>[],
    double width = _Layout.width,
    double height = _Layout.height,
  }) {
    final bool framed = band;
    return PlateSpec(
      id: id,
      country: CzechRepublicCountry.czech_republic,
      canvasWidth: width,
      canvasHeight: height,
      panel: band
          ? const PlatePanel(box: _Layout.stars, padding: EdgeInsets.zero)
          : badge != null
          ? PlatePanel(box: badge.stars, padding: EdgeInsets.zero)
          : const PlatePanel(box: PlateBox(0, 0, 0, 0)),
      noPanel: !band && badge == null,
      bands: <PlateBand>[
        if (badge != null)
          PlateBand(box: badge.band, color: CzechRepublicColors.euroBlue),
      ],
      background: framed
          ? const PlateSection.columns(<PlatePart>[
              PlatePart(
                PlateSection.fill(PlateFill.panel),
                end: _Layout.bandEnd,
              ),
              PlatePart(PlateSection.plain),
            ])
          : PlateSection.plain,
      slots: <PlateSlot>[for (final _Field f in fields) _slot(f)],
      labels: <PlateLabel>[
        if (band)
          const PlateLabel(
            text: 'CZ',
            box: _Layout.label,
            glyphHeight: _Layout.labelGlyph,
            color: CzechRepublicColors.white,
          ),
        if (badge != null)
          PlateLabel(
            text: 'CZ',
            box: badge.label,
            glyphHeight: 28,
            color: CzechRepublicColors.white,
          ),
        for (final double cx in dashes)
          PlateLabel(
            text: '-',
            box: PlateBox(
              cx - _Layout.dashWidth / 2,
              _Layout.top,
              _Layout.dashWidth,
              _Layout.box,
            ),
            glyphHeight: _Layout.box,
          ),
      ],
    );
  }
}

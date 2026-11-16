import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'moldova_colors.dart';
import 'moldova_country.dart';

/// Where the ink sits, in plate units. Every photo is flattened to the
/// 520×110 the article gives (4 px per unit); the spans below are ink runs of
/// those flats, to the left and right edge of each field.
///
/// The band ends at 67.25 (the flats read 67.25 on the state plates), the
/// flag sits at x 3.5–66, y 14–47.5 and the white `MD` under it ends at
/// y 96. The 2015 plate is framed and its band runs 7–71, so its flag is
/// shifted by 4.
///
/// Ink is 84 tall on a 110 plate, but a box that tall would need ~153, so
/// every box is the full canvas height and the ink lands near 60, about 72% of
/// reference. Digit runs are also scaled down as a whole where the font is wider
/// than the condensed plate face.
///
/// Not drawn: the 2015 plate's grey sticker disc, the pre-2015 plates
/// (`C AA 001`, issued until 2015; the slanted band with the arms) and the
/// presidential front plate (unticked in the brief). The expiry month/year
/// boxes of the red plates are estimates off the sheet.
abstract final class _Layout {
  static const double width = 520, height = 110, top = 0, box = 110;

  static const double bandEnd = 67.25, framedBandEnd = 71;
  static const PlateBox flag = PlateBox(3.5, 14, 62.5, 33.5);
  static const PlateBox framedFlag = PlateBox(7.5, 14, 62.5, 33.5);
  static const PlateBox md = PlateBox(3, 56, 62, 42);
  static const PlateBox framedMd = PlateBox(7, 56, 62, 42);
  static const double mdGlyph = 46;

  /// The stacked month (top) and year (bottom) of a red plate, x 437–468.
  static const double expiryLeft = 437, expiryWidth = 31, expiryHeight = 44;
  static const double monthTop = 3, yearTop = 61;
}

/// A field spanning [left]..[right] of [count] characters; [alphabet] is
/// digits or letters.
class _Field {
  const _Field(this.key, this.alphabet, this.left, this.right, this.count);

  final String key;
  final PlateAlphabet alphabet;
  final double left, right;
  final int count;
}

const PlateAlphabet _digits = MoldovaAlphabets.digits;
const PlateAlphabet _letters = MoldovaAlphabets.letters;

/// The Moldovan plates, one builder over a list of fields.
///
/// Every plate is a run of letters and digits on the band. The private plate
/// is `ABC 012`; Government, Parliament and the ministries share `RMG 123`
/// (the three flats differ by under 6 units); the Ministry of Internal
/// Affairs `MAI 1234`, the armed forces `FA 1234`, the presidential rear plate
/// `RM 0001` and the State Protection Service `SP 123` are the same shape with
/// other lengths. The red plates carry a letter, digits and (except for
/// permanent residents) an expiry month and year; the blue diplomatic plate
/// `CD 123 AB` covers the consular and technical-staff plates too, which
/// differ only in their codes.
abstract final class MoldovaPlates {
  static final PlateSpec private = _spec(
    id: 'md.private',
    framed: true,
    fields: const <_Field>[
      _Field('letters', _letters, 87, 249, 3),
      _Field('digits', _digits, 323, 477, 3),
    ],
  );

  static final PlateSpec state = _spec(
    id: 'md.state',
    fields: const <_Field>[
      _Field('letters', _letters, 85, 247, 3),
      _Field('digits', _digits, 299, 455, 3),
    ],
  );

  static final PlateSpec interior = _spec(
    id: 'md.interior',
    fields: const <_Field>[
      _Field('letters', _letters, 80, 236, 3),
      _Field('digits', _digits, 288, 501, 4),
    ],
  );

  static final PlateSpec armedForces = _spec(
    id: 'md.armedForces',
    fields: const <_Field>[
      _Field('letters', _letters, 87, 195, 2),
      _Field('digits', _digits, 247, 460, 4),
    ],
  );

  static final PlateSpec president = _spec(
    id: 'md.president',
    fields: const <_Field>[
      _Field('letters', _letters, 92, 195, 2),
      _Field('digits', _digits, 288, 491, 4),
    ],
  );

  static final PlateSpec protection = _spec(
    id: 'md.protection',
    fields: const <_Field>[
      _Field('letters', _letters, 113, 216, 2),
      _Field('digits', _digits, 311, 466, 3),
    ],
  );

  /// `H 1234 03 21`: foreign entities and temporary import, red, with the
  /// month and year of expiry.
  static final PlateSpec foreign = _spec(
    id: 'md.foreign',
    expiry: true,
    fields: const <_Field>[
      _Field('letters', _letters, 87, 134, 1),
      _Field('digits', _digits, 186, 400, 4),
    ],
  );

  /// `T 123A 03 21`: vehicles exported for good, red; a trailing letter.
  static final PlateSpec exported = _spec(
    id: 'md.exported',
    expiry: true,
    fields: const <_Field>[
      _Field('letters', _letters, 87, 133, 1),
      _Field('digits', _digits, 186, 336, 3),
      _Field('suffix', _letters, 345, 396, 1),
    ],
  );

  /// `H 1234`: foreign residents, red, no expiry.
  static final PlateSpec resident = _spec(
    id: 'md.resident',
    fields: const <_Field>[
      _Field('letters', _letters, 87, 132, 1),
      _Field('digits', _digits, 184, 390, 4),
    ],
  );

  /// `CD 123 AB`: diplomatic, consular and technical staff, blue.
  static final PlateSpec diplomatic = _spec(
    id: 'md.diplomatic',
    fields: const <_Field>[
      _Field('letters', _letters, 78, 186, 2),
      _Field('digits', _digits, 196, 355, 3),
      _Field('suffix', _letters, 363, 478, 2),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    state,
    interior,
    armedForces,
    president,
    protection,
    foreign,
    exported,
    resident,
    diplomatic,
  ];

  /// A field as one slot spanning its glyphs; the pitch is the span over the
  /// count, and spacing lifts the font's advance to it.
  static PlateSlot _slot(_Field f) {
    final double width = f.right - f.left;
    return PlateSlot(
      alphabet: f.alphabet,
      box: PlateBox(f.left, _Layout.top, width, _Layout.box),
      length: f.count,
      spacing: f.count > 1 ? plateRunSpacing(width / f.count, _Layout.box) : 0,
    );
  }

  static PlateSlot _expiry(double top) => PlateSlot(
    alphabet: _digits,
    box: PlateBox(
      _Layout.expiryLeft,
      top,
      _Layout.expiryWidth,
      _Layout.expiryHeight,
    ),
    length: 2,
  );

  static PlateSpec _spec({
    required String id,
    required List<_Field> fields,
    bool framed = false,
    bool expiry = false,
  }) {
    return PlateSpec(
      id: id,
      country: MoldovaCountry.moldova,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      panel: PlatePanel(
        box: framed ? _Layout.framedFlag : _Layout.flag,
        padding: EdgeInsets.zero,
      ),
      background: PlateSection.columns(<PlatePart>[
        PlatePart(
          const PlateSection.fill(PlateFill.panel),
          end: framed ? _Layout.framedBandEnd : _Layout.bandEnd,
        ),
        const PlatePart(PlateSection.plain),
      ]),
      slots: <PlateSlot>[
        for (final _Field f in fields) _slot(f),
        if (expiry) ...<PlateSlot>[
          _expiry(_Layout.monthTop),
          _expiry(_Layout.yearTop),
        ],
      ],
      labels: <PlateLabel>[
        PlateLabel(
          text: 'MD',
          box: framed ? _Layout.framedMd : _Layout.md,
          glyphHeight: _Layout.mdGlyph,
          color: MoldovaColors.white,
        ),
      ],
      textGroups: <PlateTextGroup>[
        for (int i = 0; i < fields.length; i++)
          PlateTextGroup(<int>[i], key: fields[i].key),
        if (expiry) ...<PlateTextGroup>[
          PlateTextGroup(<int>[fields.length], key: 'month'),
          PlateTextGroup(<int>[fields.length + 1], key: 'year'),
        ],
      ],
    );
  }
}

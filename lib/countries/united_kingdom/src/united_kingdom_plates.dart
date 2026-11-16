import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'united_kingdom_country.dart';
import 'united_kingdom_regions.dart';

/// Where the ink sits, in plate coordinates. Measured off the platekit-flattened
/// references (`UK_Rear_Registration_Plate`, `UK_Front_*`, `British_vehicle_
/// registration_plate_CYM_2`, `Regular_NI_*`, `Pre-1980_*`, `*_Forces_*`,
/// `UK_trailer_plates`, `United_Kingdom_trade_plate`) at the 520×111 mm the
/// article gives.
///
/// Reference ink on the one-line plates is y 7.8..103 (95 high). Ink fills
/// ~0.55 of its box, so matching would need a ~170 box on a 111 plate; the
/// boxes fill the plate between the frame instead and the ink comes out at
/// ~60% of the reference, on every row.
///
/// The artwork's ink runs x 20.8..499 on every one-line plate. Fields are laid
/// out on a uniform pitch over that span, a printed space counting as one cell:
/// `AA11 AAA` is 8 cells of 59.75. The reference's digits are narrower than its
/// letters (NI `BTZ 1999`: letters 64.7, digits 48), so a uniform pitch is an
/// average; it is not a measurement of each glyph.
abstract final class _Layout {
  static const double width = 520, height = 111, rowTop = 3, rowHeight = 105;

  static const double left = 20.8, right = 499;

  /// With the optional band (x 0..51 on the references) the characters start at
  /// x 72.8 (`CYM_2`: 3 glyph groups @72.8..499).
  static const double bandedLeft = 72.8, bandEnd = 51;

  static const PlatePanel panel = PlatePanel(
    box: PlateBox(0, 0, bandEnd, height),
    padding: EdgeInsets.symmetric(horizontal: 3, vertical: 14),
  );

  static const PlatePanel none = PlatePanel(box: PlateBox(0, 0, 0, 0));

  /// Motorcycle: 229×178 (the regulation's size; the reference photo is an
  /// oblique shot, so rows are laid out on the regulation instead — estimates).
  static const double bikeWidth = 229, bikeHeight = 178, bikeRowHeight = 78;
  static const double bikeTop1 = 9, bikeTop2 = 91, bikeLeft = 11;
  static const double bikePitch = 51.5;
}

class _Field {
  const _Field(
    this.key,
    this.alphabet,
    this.length, {
    int? minLength,
    this.gapBefore = false,
  }) : minLength = minLength ?? length;

  final String key;
  final PlateAlphabet alphabet;
  final int length, minLength;

  /// A printed space precedes this field.
  final bool gapBefore;
}

/// One builder lays a one-line plate out from its fields; colour is a theme
/// and the band is a country, so front, rear and ZEV plates share [standard]
/// and [banded].
abstract final class UnitedKingdomPlates {
  static double _spacing(double pitch, double height) =>
      plateRunSpacing(pitch, height);

  static PlateSpec _oneLine({
    required String id,
    required List<_Field> fields,
    required PlateCountry country,
    double left = _Layout.left,
    double right = _Layout.right,
    bool banded = false,
  }) {
    final cells = fields.fold<int>(
      0,
      (n, f) => n + f.length + (f.gapBefore ? 1 : 0),
    );
    final pitch = (right - left) / cells;
    final slots = <PlateSlot>[];
    var cursor = left;
    for (final f in fields) {
      if (f.gapBefore) cursor += pitch;
      slots.add(
        PlateSlot(
          alphabet: f.alphabet,
          box: PlateBox(
            cursor,
            _Layout.rowTop,
            f.length * pitch,
            _Layout.rowHeight,
          ),
          length: f.length,
          minLength: f.minLength,
          // A variable run is centred, not pitched.
          spacing: f.minLength == f.length
              ? _spacing(pitch, _Layout.rowHeight)
              : 0,
        ),
      );
      cursor += f.length * pitch;
    }
    return PlateSpec(
      id: id,
      country: country,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      panel: banded ? _Layout.panel : _Layout.none,
      noPanel: !banded,
      background: banded
          ? const PlateSection.columns(<PlatePart>[
              PlatePart(
                PlateSection.fill(PlateFill.panel),
                end: _Layout.bandEnd,
              ),
              PlatePart(PlateSection.plain),
            ])
          : PlateSection.plain,
      slots: slots,
      textGroups: <PlateTextGroup>[
        for (var i = 0; i < fields.length; i++)
          PlateTextGroup(
            <int>[i],
            key: fields[i].key,
            prefix: fields[i].gapBefore ? ' ' : '',
          ),
      ],
      resolveRegion: UnitedKingdomRegions.captionOf,
    );
  }

  static const _Field _area = _Field('area', UnitedKingdomAlphabets.letters, 2);
  static const _Field _age = _Field('age', UnitedKingdomAlphabets.digits, 2);
  static const _Field _random = _Field(
    'random',
    UnitedKingdomAlphabets.letters,
    3,
    gapBefore: true,
  );

  /// `AA11 AAA`. Front and rear differ only in theme.
  static final PlateSpec standard = _oneLine(
    id: 'gb.standard',
    fields: const <_Field>[_area, _age, _random],
    country: UnitedKingdomCountry.united_kingdom,
  );

  /// [standard] with the optional left band; the canvas's country picks the
  /// band (front, rear, ZEV or a nation).
  static final PlateSpec banded = _oneLine(
    id: 'gb.banded',
    fields: const <_Field>[_area, _age, _random],
    country: UnitedKingdomCountry.united_kingdom,
    left: _Layout.bandedLeft,
    banded: true,
  );

  /// Northern Ireland, `BTZ 1999`: the letters carry an `I` or `Z`.
  static final PlateSpec northernIreland = _oneLine(
    id: 'gb.ni',
    fields: const <_Field>[
      _Field('letters', UnitedKingdomAlphabets.letters, 3),
      _Field(
        'serial',
        UnitedKingdomAlphabets.digits,
        4,
        minLength: 1,
        gapBefore: true,
      ),
    ],
    country: UnitedKingdomCountry.united_kingdom,
  );

  /// Pre-1980 suffix format, `KAF 762L`. The 1983–2001 prefix series and the
  /// 1903–1932 plates are not implemented.
  static final PlateSpec historic = _oneLine(
    id: 'gb.historic',
    fields: const <_Field>[
      _Field('letters', UnitedKingdomAlphabets.letters, 3),
      _Field(
        'serial',
        UnitedKingdomAlphabets.digits,
        3,
        minLength: 1,
        gapBefore: true,
      ),
      _Field('year', UnitedKingdomAlphabets.letters, 1),
    ],
    country: UnitedKingdomCountry.united_kingdom,
  );

  /// Diplomatic, `127 D 932`: mission code, `D` (diplomat) or `X` (non-
  /// diplomatic staff), serial. Yellow rear / white front like [standard].
  static final PlateSpec diplomatic = _oneLine(
    id: 'gb.diplomatic',
    fields: const <_Field>[
      _Field('mission', UnitedKingdomAlphabets.digits, 3),
      _Field(
        'class',
        UnitedKingdomAlphabets.diplomaticClass,
        1,
        gapBefore: true,
      ),
      _Field('serial', UnitedKingdomAlphabets.digits, 3, gapBefore: true),
    ],
    country: UnitedKingdomCountry.united_kingdom,
  );

  /// Armed forces, `JJ 33 PP`.
  static final PlateSpec armedForces = _oneLine(
    id: 'gb.forces',
    fields: const <_Field>[
      _Field('first', UnitedKingdomAlphabets.letters, 2),
      _Field('digits', UnitedKingdomAlphabets.digits, 2, gapBefore: true),
      _Field('last', UnitedKingdomAlphabets.letters, 2, gapBefore: true),
    ],
    country: UnitedKingdomCountry.united_kingdom,
  );

  /// Trailer, `C335004`.
  static final PlateSpec trailer = _oneLine(
    id: 'gb.trailer',
    fields: const <_Field>[
      _Field('prefix', UnitedKingdomAlphabets.letters, 1),
      _Field('serial', UnitedKingdomAlphabets.digits, 6),
    ],
    country: UnitedKingdomCountry.united_kingdom,
  );

  /// Trade plate. The DVLA crest and wordmark at the right (x 403..477) are
  /// not drawn.
  static final PlateSpec trade = _oneLine(
    id: 'gb.trade',
    fields: const <_Field>[_Field('serial', UnitedKingdomAlphabets.digits, 5)],
    country: UnitedKingdomCountry.united_kingdom,
    left: 65.2,
    right: 400,
  );

  static PlateSlot _bikeSlot(
    PlateAlphabet a,
    int length,
    double cell,
    double top,
  ) => PlateSlot(
    alphabet: a,
    box: PlateBox(
      _Layout.bikeLeft + cell * _Layout.bikePitch,
      top,
      length * _Layout.bikePitch,
      _Layout.bikeRowHeight,
    ),
    length: length,
    spacing: _spacing(_Layout.bikePitch, _Layout.bikeRowHeight),
  );

  /// Motorcycle, `AA11` over `AAA`, the bottom run centred under the top.
  static final PlateSpec motorcycle = PlateSpec(
    id: 'gb.motorcycle',
    country: UnitedKingdomCountry.united_kingdom,
    canvasWidth: _Layout.bikeWidth,
    canvasHeight: _Layout.bikeHeight,
    panel: _Layout.none,
    noPanel: true,
    slots: <PlateSlot>[
      _bikeSlot(UnitedKingdomAlphabets.letters, 2, 0, _Layout.bikeTop1),
      _bikeSlot(UnitedKingdomAlphabets.digits, 2, 2, _Layout.bikeTop1),
      _bikeSlot(UnitedKingdomAlphabets.letters, 3, 0.5, _Layout.bikeTop2),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'area'),
      PlateTextGroup(<int>[1], key: 'age'),
      PlateTextGroup(<int>[2], key: 'random', prefix: ' '),
    ],
    resolveRegion: UnitedKingdomRegions.captionOf,
  );
}

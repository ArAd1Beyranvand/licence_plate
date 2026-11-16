import 'package:flutter/widgets.dart' show AssetImage, Color, EdgeInsets;
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'san_marino_colors.dart';
import 'san_marino_country.dart';

class _Field {
  const _Field(
    this.left,
    this.width,
    this.length, {
    this.minLength,
    this.top = 0,
    this.height = _Layout.height,
    this.color,
  });

  final double left, width;
  final int length;
  final int? minLength;
  final double top, height;

  /// Ink of the field where it is not the theme's — the red prefix.
  final Color? color;
}

/// Where the ink sits, in plate units.
///
/// Canvas 390×120 mm, the rear plate; the reference photos were flattened to
/// that and their ink columns measured (`.plateref/sm/photos.json`, plus a
/// column projection of each flat image). One design: the coat of arms and
/// its caption at the left, then a `prefix` field and a `number` field on one
/// row, no divider, no panel.
///
/// Reference ink is y 18–104 (about 86 tall) on every plate; a glyph box
/// cannot leave the 120 canvas and ink is ~55% of its box, so the digits come
/// out near 66 (~77% of reference) on the full-height box.
///
/// Ink x-spans (prefix | number): private `L3237` 105–154 | 162–376;
/// trailer `R2558` 101–150 | 157–380; export `E 2001` 85–122 | 182–376;
/// electric `VE001` 107–194 | 203–368; diplomatic `CD 60` 88–211 | 262–372;
/// police `POLIZIA 145` 101–200 (37 tall, small) | 219–380. `CRS 16` is
/// estimated from the 330-px original (the flattened photo is unusable):
/// 112–262 | 284–372.
///
/// Number fields are variable ("up to four numbers"), so one slot with
/// `minLength: 1` and no letter spacing. `PROVA` (a small card tied to the
/// bumper, too small to measure), `GE`, `VU` and the year sticker have no
/// usable picture and are not drawn. The two limousine photos are the
/// Regents' cars, not a category.
abstract final class _Layout {
  static const double width = 390, height = 120;

  /// The coat of arms: ink x 17–78, y 7–76 in the L3237 photo.
  static const PlateBox crest = PlateBox(19, 8, 56, 67);

  /// The two caption lines under the crest.
  static const PlateBox caption1 = PlateBox(16, 88, 64, 10);
  static const PlateBox caption2 = PlateBox(16, 97, 64, 10);
  static const double captionGlyph = 10;

  static const _Field privatePrefix = _Field(100, 60, 1);
  static const _Field privateNumber = _Field(160, 220, 4, minLength: 1);

  static const _Field trailerPrefix = _Field(
    96,
    60,
    1,
    color: SanMarinoColors.redTrailer,
  );
  static const _Field trailerNumber = _Field(155, 227, 4, minLength: 1);

  static const _Field exportPrefix = _Field(
    80,
    48,
    1,
    color: SanMarinoColors.redExport,
  );
  static const _Field exportNumber = _Field(180, 200, 4, minLength: 1);

  static const _Field electricPrefix = _Field(100, 100, 2);
  static const _Field electricNumber = _Field(201, 172, 3);

  static const _Field diplomaticPrefix = _Field(
    86,
    128,
    2,
    color: SanMarinoColors.redLight,
  );
  static const _Field diplomaticNumber = _Field(257, 120, 2, minLength: 1);

  static const _Field redCrossPrefix = _Field(
    100,
    170,
    3,
    color: SanMarinoColors.redLight,
  );
  static const _Field redCrossNumber = _Field(275, 105, 2, minLength: 1);

  static const _Field policePrefix = _Field(
    100,
    102,
    7,
    top: 35,
    height: 50,
    color: SanMarinoColors.redLight,
  );
  static const _Field policeNumber = _Field(215, 170, 3, minLength: 1);
}

/// The San Marino plates. Groups `prefix` and `number`.
///
/// [private] is a letter and up to four digits, blue; [trailer] a red `R`;
/// [export] a red `E` on grey with black digits; [electric] the green `VE`
/// and three digits; [diplomatic] the red `CD` and light-blue digits;
/// [redCross] the red `CRS`; [police] the red `POLIZIA`. The prefix's red is
/// the slot's, the digits' ink the theme's.
abstract final class SanMarinoPlates {
  static final PlateSpec private = _spec(
    'sm.private',
    _Layout.privatePrefix,
    _Layout.privateNumber,
  );
  static final PlateSpec trailer = _spec(
    'sm.trailer',
    _Layout.trailerPrefix,
    _Layout.trailerNumber,
  );
  static final PlateSpec export = _spec(
    'sm.export',
    _Layout.exportPrefix,
    _Layout.exportNumber,
  );
  static final PlateSpec electric = _spec(
    'sm.electric',
    _Layout.electricPrefix,
    _Layout.electricNumber,
  );
  static final PlateSpec diplomatic = _spec(
    'sm.diplomatic',
    _Layout.diplomaticPrefix,
    _Layout.diplomaticNumber,
  );
  static final PlateSpec redCross = _spec(
    'sm.red_cross',
    _Layout.redCrossPrefix,
    _Layout.redCrossNumber,
  );
  static final PlateSpec police = _spec(
    'sm.police',
    _Layout.policePrefix,
    _Layout.policeNumber,
  );

  static List<PlateSpec> get all => <PlateSpec>[
    private,
    trailer,
    export,
    electric,
    diplomatic,
    redCross,
    police,
  ];

  static PlateSlot _slot(PlateAlphabet alphabet, _Field f) => PlateSlot(
    alphabet: alphabet,
    box: PlateBox(f.left, f.top, f.width, f.height),
    length: f.length,
    minLength: f.minLength,
    color: f.color,
  );

  static PlateSpec _spec(String id, _Field prefix, _Field number) {
    return PlateSpec(
      id: id,
      country: SanMarinoCountry.san_marino,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      panel: const PlatePanel(
        box: PlateBox(0, 0, 0, 0),
        padding: EdgeInsets.zero,
      ),
      noPanel: true,
      slots: <PlateSlot>[
        _slot(SanMarinoAlphabets.letters, prefix),
        _slot(SanMarinoAlphabets.digits, number),
      ],
      textGroups: PlateTextGroup.perSlot(<String>['prefix', 'number']),
      decals: const <PlateDecal>[
        // Coat of arms of San Marino, vector from Wikimedia Commons
        // "File:Coat of arms of San Marino.svg", rasterised to 256 px high.
        PlateDecal(
          image: AssetImage(
            'assets/countries/san_marino/icons/coat_of_arms.png',
            package: 'license_plate',
          ),
          box: _Layout.crest,
        ),
      ],
      labels: const <PlateLabel>[
        PlateLabel(
          text: 'REPUBBLICA DI',
          box: _Layout.caption1,
          glyphHeight: _Layout.captionGlyph,
        ),
        PlateLabel(
          text: 'SAN MARINO',
          box: _Layout.caption2,
          glyphHeight: _Layout.captionGlyph,
        ),
      ],
    );
  }
}

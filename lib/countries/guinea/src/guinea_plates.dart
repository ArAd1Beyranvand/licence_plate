import 'package:flutter/widgets.dart';
import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'guinea_colors.dart';
import 'guinea_country.dart';
import 'guinea_regions.dart';

/// Where the ink sits, in plate units.
///
/// The references were flattened to 520×280; one-row y values are scaled by
/// 110/280 and motorcycle by 295/280. Two-row plates keep the photo aspect
/// (1.86) rather than the documented 2.0. A row's box is capped by the canvas,
/// so with the 0.55 ink ratio the characters land at 65–80% of reference height.
abstract final class _Layout {
  static const double width = 520;

  // ---- current one-row (520×110): ink y 15.7–91.3 -------------------------
  static const double rowHeight = 110, rowCy = 53.5, rowBox = 100;
  static const (double, double) rowSeries = (39, 183);
  static const (double, double) rowNumber = (225, 429);

  /// "02", ink x 462–495, y 45–69.
  static const (double, double) rowRegion = (462, 495);
  static const PlateBox rowCode = PlateBox(17, 66, 40, 30);
  static const double rowCodeGlyph = 38;
  static const PlateBox rowMap = PlateBox(17, 14, 43, 31);
  static const PlateBox rowSticker = PlateBox(192, 45, 19.5, 18);

  // ---- current two-row (520×280) -------------------------------------------
  static const double sqHeight = 280, sqBox = 128;
  static const double sqRow1Cy = 65.5, sqRow2Cy = 188.5;
  static const (double, double) sqSeries = (145, 280);
  static const (double, double) sqNumber = (135, 386);

  /// "02", ink x 413–458, y 142–184.
  static const (double, double) sqRegion = (413, 458);
  static const double sqRegionCy = 163, sqRegionBox = 60;
  static const PlateBox sqCode = PlateBox(30, 114, 78, 51);
  static const double sqCodeGlyph = 78;
  static const PlateBox sqMap = PlateBox(27, 12, 80, 60);
  static const PlateBox sqSticker = PlateBox(51.5, 201.5, 35.5, 35.5);

  // ---- current motorcycle (520×295) ----------------------------------------
  static const double motoHeight = 295, motoBox = 140;
  static const double motoRow1Cy = 72, motoRow2Cy = 215;
  static const (double, double) motoSeries = (117, 282);
  static const (double, double) motoNumber = (121, 357);
  static const (double, double) motoSuffix = (414, 493);

  /// "02", ink x 384–426, y 53–87.
  static const (double, double) motoRegion = (384, 426);
  static const double motoRegionCy = 70, motoRegionBox = 62;
  static const PlateBox motoCode = PlateBox(36, 122, 46, 32);
  static const double motoCodeGlyph = 49;
  static const PlateBox motoMap = PlateBox(18, 10, 80, 60);
  static const PlateBox motoSticker = PlateBox(446.5, 50, 41, 40);

  // ---- 1994 one-row (520×110): ink y 15.6–93.4 ----------------------------
  static const double legacyCy = 54.5;
  static const (double, double) legacyPrefix = (38.8, 112.2);
  static const (double, double) legacyNumber = (149.5, 301.2);
  static const (double, double) legacySeries = (337.8, 418.8);
  static const PlateBox legacyGap1 = PlateBox(112, 4.5, 38, 100);
  static const PlateBox legacyGap2 = PlateBox(301, 4.5, 37, 100);

  /// The disc: white ring x 455–494, y 15–55; black inside.
  static const PlateBox rowRing = PlateBox(455, 15, 39, 40);
  static const PlateBox rowDisc = PlateBox(457, 17, 35, 36);
  static const PlateBox rowDiscMap = PlateBox(460, 22, 29, 22);
  static const PlateBox rowLegacyCode = PlateBox(454, 62, 40, 34);
  static const double rowLegacyCodeGlyph = 52;

  // ---- 1994 two-row (520×280) ----------------------------------------------
  static const double legacySqBox = 140, legacyRow1Cy = 75, legacyRow2Cy = 206;
  static const (double, double) legacySqPrefix = (84.5, 191.2);
  static const (double, double) legacySqNumber = (58, 280);
  static const (double, double) legacySqSeries = (340, 457);
  static const PlateBox legacySqDash = PlateBox(283, 136, 55, 140);
  static const PlateBox sqRing = PlateBox(261, 37, 74, 74);
  static const PlateBox sqDisc = PlateBox(264, 40, 68, 68);
  static const PlateBox sqDiscMap = PlateBox(270, 52, 56, 42);
  static const PlateBox sqLegacyCode = PlateBox(350, 50, 60, 50);
  static const double sqLegacyCodeGlyph = 80;
}

/// Pair each spec with the [GuineaThemes] member of the same name.
///
/// The number is 4 digits as the picture shows. The QR code beside the map is
/// not drawn.
abstract final class GuineaPlates {
  static final PlateSpec standard = _currentRow('gn.standard');
  static final PlateSpec standardSquare = _currentSquare('gn.standard_square');
  static final PlateSpec motorcycle = _motorcycle('gn.motorcycle');
  static final PlateSpec legacy = _legacyRow('gn.legacy', '·', 2);
  static final PlateSpec legacySquare = _legacySquare('gn.legacy_square', 2);
  static final PlateSpec taxi = _legacyRow('gn.taxi', '-', 1);
  static final PlateSpec taxiSquare = _legacySquare('gn.taxi_square', 1);

  static List<PlateSpec> get all => <PlateSpec>[
    standard,
    standardSquare,
    motorcycle,
    legacy,
    legacySquare,
    taxi,
    taxiSquare,
  ];

  /// https://commons.wikimedia.org/wiki/File:Flag_map_of_Guinea.svg
  /// (`assets/icons/guinea_flag_map.svg`, rasterised to the PNG).
  static const ImageProvider _mapImage = AssetImage(
    'assets/countries/guinea/icons/guinea_flag_map.png',
    package: 'license_plate',
  );

  static PlateDecal _map(PlateBox box) =>
      PlateDecal(image: _mapImage, box: box);

  /// One field over its `(left, right)` ink span. A fixed multi-character
  /// field gets the spacing that brings the font's ~0.6 em advance up to the
  /// printed pitch; a variable one is left to centre.
  static PlateSlot _field(
    PlateAlphabet alphabet,
    (double, double) span,
    double cy,
    double h,
    int length,
  ) {
    final double pitch = (span.$2 - span.$1) / length;
    return PlateSlot(
      alphabet: alphabet,
      box: PlateBox(span.$1, cy - h / 2, span.$2 - span.$1, h),
      length: length,
      spacing: length > 1 ? plateRunSpacing(pitch, h) : 0,
    );
  }

  static PlateSpec _spec(
    String id,
    double height,
    List<PlateSlot> slots,
    List<PlateTextGroup> groups, {
    List<PlateBand> bands = const <PlateBand>[],
    List<PlateLabel> labels = const <PlateLabel>[],
    List<PlateDecal> decals = const <PlateDecal>[],
  }) => PlateSpec(
    id: id,
    country: GuineaCountry.guinea,
    canvasWidth: _Layout.width,
    canvasHeight: height,
    slots: slots,
    bands: bands,
    labels: labels,
    decals: decals,
    textGroups: groups,
    resolveRegion: groups.any((PlateTextGroup g) => g.key == 'region')
        ? GuineaRegions.captionOf
        : GuineaRegions.legacyCaptionOf,
  );

  static PlateBand _sticker(PlateBox box) => PlateBand(
    box: box,
    color: GuineaColors.sticker,
    topCornerRadius: 1.5,
    bottomCornerRadius: 1.5,
  );

  /// A floating disc: a band whose radii are half its side.
  static PlateBand _disc(PlateBox box, Color color) => PlateBand(
    box: box,
    color: color,
    topCornerRadius: box.width / 2,
    bottomCornerRadius: box.width / 2,
  );

  static PlateLabel _code(PlateBox box, double glyph, {Color? color}) =>
      PlateLabel(text: 'RG', box: box, glyphHeight: glyph, color: color);

  static PlateSpec _currentRow(String id) => _spec(
    id,
    _Layout.rowHeight,
    <PlateSlot>[
      _field(
        GuineaAlphabets.letters,
        _Layout.rowSeries,
        _Layout.rowCy,
        _Layout.rowBox,
        2,
      ),
      _field(
        GuineaAlphabets.digits,
        _Layout.rowNumber,
        _Layout.rowCy,
        _Layout.rowBox,
        4,
      ),
      _field(GuineaAlphabets.digits, _Layout.rowRegion, 57, 42, 2),
    ],
    _groups(<String>['series', 'number', 'region']),
    bands: <PlateBand>[_sticker(_Layout.rowSticker)],
    labels: <PlateLabel>[
      _code(_Layout.rowCode, _Layout.rowCodeGlyph, color: GuineaColors.codeInk),
    ],
    decals: <PlateDecal>[_map(_Layout.rowMap)],
  );

  static PlateSpec _currentSquare(String id) => _spec(
    id,
    _Layout.sqHeight,
    <PlateSlot>[
      _field(
        GuineaAlphabets.letters,
        _Layout.sqSeries,
        _Layout.sqRow1Cy,
        _Layout.sqBox,
        2,
      ),
      _field(
        GuineaAlphabets.digits,
        _Layout.sqNumber,
        _Layout.sqRow2Cy,
        _Layout.sqBox,
        4,
      ),
      _field(
        GuineaAlphabets.digits,
        _Layout.sqRegion,
        _Layout.sqRegionCy,
        _Layout.sqRegionBox,
        2,
      ),
    ],
    _groups(<String>['series', 'number', 'region']),
    bands: <PlateBand>[_sticker(_Layout.sqSticker)],
    labels: <PlateLabel>[
      _code(_Layout.sqCode, _Layout.sqCodeGlyph, color: GuineaColors.codeInk),
    ],
    decals: <PlateDecal>[_map(_Layout.sqMap)],
  );

  static PlateSpec _motorcycle(String id) => _spec(
    id,
    _Layout.motoHeight,
    <PlateSlot>[
      _field(
        GuineaAlphabets.letters,
        _Layout.motoSeries,
        _Layout.motoRow1Cy,
        _Layout.motoBox,
        2,
      ),
      _field(
        GuineaAlphabets.digits,
        _Layout.motoRegion,
        _Layout.motoRegionCy,
        _Layout.motoRegionBox,
        2,
      ),
      _field(
        GuineaAlphabets.digits,
        _Layout.motoNumber,
        _Layout.motoRow2Cy,
        _Layout.motoBox,
        3,
      ),
      _field(
        GuineaAlphabets.letters,
        _Layout.motoSuffix,
        _Layout.motoRow2Cy,
        _Layout.motoBox,
        1,
      ),
    ],
    _groups(<String>['series', 'region', 'number', 'suffix']),
    bands: <PlateBand>[_sticker(_Layout.motoSticker)],
    labels: <PlateLabel>[
      _code(
        _Layout.motoCode,
        _Layout.motoCodeGlyph,
        color: GuineaColors.codeInk,
      ),
    ],
    decals: <PlateDecal>[_map(_Layout.motoMap)],
  );

  /// [seriesLength] is 2 for the private plate and 1 for taxis and trucks;
  /// [separator] is the dot the red plate prints and the dash the black one.
  static PlateSpec _legacyRow(String id, String separator, int seriesLength) =>
      _spec(
        id,
        _Layout.rowHeight,
        <PlateSlot>[
          _field(
            GuineaAlphabets.letters,
            _Layout.legacyPrefix,
            _Layout.legacyCy,
            _Layout.rowBox,
            2,
          ),
          _field(
            GuineaAlphabets.digits,
            _Layout.legacyNumber,
            _Layout.legacyCy,
            _Layout.rowBox,
            4,
          ),
          _field(
            GuineaAlphabets.letters,
            _Layout.legacySeries,
            _Layout.legacyCy,
            _Layout.rowBox,
            seriesLength,
          ),
        ],
        _groups(<String>['prefix', 'number', 'series']),
        bands: <PlateBand>[
          _disc(_Layout.rowRing, GuineaColors.redInk),
          _disc(_Layout.rowDisc, GuineaColors.black),
        ],
        labels: <PlateLabel>[
          PlateLabel(
            text: separator,
            box: _Layout.legacyGap1,
            glyphHeight: _Layout.rowBox,
          ),
          PlateLabel(
            text: separator,
            box: _Layout.legacyGap2,
            glyphHeight: _Layout.rowBox,
          ),
          _code(_Layout.rowLegacyCode, _Layout.rowLegacyCodeGlyph),
        ],
        decals: <PlateDecal>[_map(_Layout.rowDiscMap)],
      );

  static PlateSpec _legacySquare(String id, int seriesLength) => _spec(
    id,
    _Layout.sqHeight,
    <PlateSlot>[
      _field(
        GuineaAlphabets.letters,
        _Layout.legacySqPrefix,
        _Layout.legacyRow1Cy,
        _Layout.legacySqBox,
        2,
      ),
      _field(
        GuineaAlphabets.digits,
        _Layout.legacySqNumber,
        _Layout.legacyRow2Cy,
        _Layout.legacySqBox,
        4,
      ),
      _field(
        GuineaAlphabets.letters,
        _Layout.legacySqSeries,
        _Layout.legacyRow2Cy,
        _Layout.legacySqBox,
        seriesLength,
      ),
    ],
    _groups(<String>['prefix', 'number', 'series']),
    bands: <PlateBand>[
      _disc(_Layout.sqRing, GuineaColors.redInk),
      _disc(_Layout.sqDisc, GuineaColors.black),
    ],
    labels: <PlateLabel>[
      const PlateLabel(
        text: '-',
        box: _Layout.legacySqDash,
        glyphHeight: _Layout.legacySqBox,
      ),
      _code(_Layout.sqLegacyCode, _Layout.sqLegacyCodeGlyph),
    ],
    decals: <PlateDecal>[_map(_Layout.sqDiscMap)],
  );

  /// One keyed group per slot, in slot order.
  static List<PlateTextGroup> _groups(List<String> keys) =>
      PlateTextGroup.perSlot(keys);
}

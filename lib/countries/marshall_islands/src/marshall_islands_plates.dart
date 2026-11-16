import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'marshall_islands_colors.dart';
import 'marshall_islands_country.dart';

/// Where the ink sits, in plate units.
///
/// Both references are pictures flattened to the 6×12 in (305×152 mm) the
/// article gives, measured on a 150×74.3 grid and scaled by 305/150 = 2.033.
///
/// Majuro Atoll (`Marshall_Islands_license_plate_graphic`, white on green):
/// caption REPUBLIC OF THE MARSHALL ISLANDS ink y 9.8–14.8 x 9–139.8 (cx 151.3,
/// cy 25); four digits y 18.8–56 (cy 76, 75.6 tall) x 64.2–141.8 (130.5–288.3);
/// MAJURO ATOLL y 62.2–69.2 x 41.2–109.2 (cx 152.9, cy 133.5); grey sticker
/// x 16–33.5 y 29–40.
///
/// 1972 (`TRUST_TERRITORY_…_1972_…`, black on cream, historic): caption TRUST
/// TERRITORY PACIFIC ISLANDS y 11–20 x 6.2–144.8; one to three digits y 25–52
/// x 52.5–94.5 (cy 78.5); year 1972 x 112.2–140.8, cy 80.5; MARSHALLS x 44–106,
/// cy 127; a ring of six stars centred (44.3, 77.7), ring radius 22.
///
/// Digits are sized so a full run fits its span in the theme font (no
/// condensed face): ink ~70% of the green plate's 75.6 and ~90% of the 1972's.
/// Captions are sized by width, so the 1972 caption is ~60% of its printed height.
abstract final class _Layout {
  static const double width = 305, height = 152;

  static const double currentCaptionCx = 151.3, currentCaptionCy = 25;
  static const double currentCaptionGlyph = 18.5;
  static const double currentSerialLeft = 130.5, currentSerialRight = 288.3;
  static const double currentSerialCy = 76, currentSerialBox = 96;
  static const double siteCx = 152.9, siteCy = 133.5, siteGlyph = 24;
  static const PlateBox sticker = PlateBox(32.5, 59, 35.6, 22.3);

  static const double trustCaptionCx = 153.5, trustCaptionCy = 31.5;
  static const double trustCaptionGlyph = 21;
  static const double trustSerialCx = 149.6, trustSerialCy = 78.5;
  static const double trustSerialWidth = 110, trustSerialBox = 90;
  static const double yearCx = 257.5, yearCy = 80.5, yearGlyph = 33;
  static const double marshallsCx = 152.8,
      marshallsCy = 127,
      marshallsGlyph = 31;
  static const double ringCx = 44.3, ringCy = 77.7, ringHalf = 28;
  static const double ringRadius = 22, starRadius = 5.5;
}

/// The Marshall Islands' plates, each a caption row over one serial field.
/// Pair [current] with [MarshallIslandsThemes.current] and [trustTerritory]
/// with [MarshallIslandsThemes.trustTerritory].
///
/// [current] is the white-on-green Majuro Atoll plate (`1234`); the article
/// dates it "when?". [trustTerritory] is the 1972 plate (`123`), historic but
/// shown as the article's second design; the year is a fixed label. The
/// article names no Israel-specific value.
abstract final class MarshallIslandsPlates {
  static final PlateSpec current = PlateSpec(
    id: 'mh.current',
    country: MarshallIslandsCountry.marshall_islands,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    bands: const <PlateBand>[
      PlateBand(box: _Layout.sticker, color: MarshallIslandsColors.sticker),
    ],
    slots: const <PlateSlot>[
      PlateSlot(
        alphabet: MarshallIslandsAlphabets.digits,
        box: PlateBox(
          _Layout.currentSerialLeft,
          _Layout.currentSerialCy - _Layout.currentSerialBox / 2,
          _Layout.currentSerialRight - _Layout.currentSerialLeft,
          _Layout.currentSerialBox,
        ),
        length: 4,
        group: 'serial',
      ),
    ],
    labels: <PlateLabel>[
      _label(
        'REPUBLIC OF THE MARSHALL ISLANDS',
        _Layout.currentCaptionCx,
        _Layout.currentCaptionCy,
        280,
        _Layout.currentCaptionGlyph,
      ),
      _label(
        'MAJURO ATOLL',
        _Layout.siteCx,
        _Layout.siteCy,
        160,
        _Layout.siteGlyph,
      ),
    ],
  );

  static final PlateSpec trustTerritory = PlateSpec(
    id: 'mh.trust_territory',
    country: MarshallIslandsCountry.marshall_islands,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    slots: const <PlateSlot>[
      PlateSlot(
        alphabet: MarshallIslandsAlphabets.digits,
        box: PlateBox.centered(
          _Layout.trustSerialCx,
          _Layout.trustSerialCy,
          _Layout.trustSerialWidth,
          _Layout.trustSerialBox,
        ),
        length: 3,
        minLength: 1,
        group: 'serial',
      ),
    ],
    decals: const <PlateDecal>[
      PlateDecal(
        drawing: PlateDrawing(
          _Layout.ringHalf * 2,
          _Layout.ringHalf * 2,
          <PlateShape>[
            PlateStarRingShape(
              _Layout.ringHalf,
              _Layout.ringHalf,
              _Layout.ringRadius,
              _Layout.starRadius,
              6,
              MarshallIslandsColors.trustInk,
            ),
          ],
        ),
        box: PlateBox(
          _Layout.ringCx - _Layout.ringHalf,
          _Layout.ringCy - _Layout.ringHalf,
          _Layout.ringHalf * 2,
          _Layout.ringHalf * 2,
        ),
      ),
    ],
    labels: <PlateLabel>[
      _label(
        'TRUST TERRITORY PACIFIC ISLANDS',
        _Layout.trustCaptionCx,
        _Layout.trustCaptionCy,
        290,
        _Layout.trustCaptionGlyph,
      ),
      _label('1972', _Layout.yearCx, _Layout.yearCy, 70, _Layout.yearGlyph),
      _label(
        'MARSHALLS',
        _Layout.marshallsCx,
        _Layout.marshallsCy,
        140,
        _Layout.marshallsGlyph,
      ),
    ],
  );

  static List<PlateSpec> get all => <PlateSpec>[current, trustTerritory];

  /// A label centred on ([cx], [cy]) in a box [width] wide and [glyph] tall.
  static PlateLabel _label(
    String text,
    double cx,
    double cy,
    double width,
    double glyph,
  ) => PlateLabel(
    text: text,
    box: PlateBox.centered(cx, cy, width, glyph),
    glyphHeight: glyph,
  );
}

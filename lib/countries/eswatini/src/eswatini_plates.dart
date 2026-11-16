import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'eswatini_country.dart';

/// Where the ink sits, in plate units.
///
/// Front: the 520×110 South African size, measured off the flattened
/// `JSD 884 BM` photograph (aspect 4.73): ink y 19.2–102.2 (83 tall, centre
/// 60.7), series x 24.2–223, digits from 259.8, suffix ending at 499. The
/// digit/suffix split (385/400) is read off the sheet, not measured.
///
/// Rear: the photographed square plate is cropped at the top and its aspect
/// (1.59) is the photo's, not a documented size — the 340×214 canvas and every
/// row position are ESTIMATED from fractions of the cropped photo (`HSD`
/// x 7–54%, `205` 6–51%, `AH` 56–91%). Check against a full photo.
///
/// Ink is ~55% of a slot box; the front's 83-unit ink would need a box of
/// ~150 on a 110-unit plate, so the box is capped at 100 (~66% of reference).
abstract final class _Layout {
  static const double frontWidth = 520, frontHeight = 110;
  static const double frontBox = 100, frontCy = 60;
  static const double seriesLeft = 24.2, seriesRight = 223;
  static const double numberLeft = 259.8, numberRight = 385;
  static const double suffixLeft = 400, suffixRight = 499;

  static const double rearWidth = 340, rearHeight = 214;
  static const double rearBox = 90, row1Cy = 52, row2Cy = 156;
  static const double rearSeriesLeft = 24, rearSeriesRight = 184;
  static const double rearNumberLeft = 21, rearNumberRight = 175;
  static const double rearSuffixLeft = 192, rearSuffixRight = 309;
}

/// Eswatini's plates, `JSD 884 BM`: a random letter plus the fixed `SD`,
/// three digits, then a letter and the region's initial.
///
/// * [front] — one row, 520×110.
/// * [rear] — the same three fields on two rows: series above, number and
///   suffix below.
///
/// Not implemented: the pre-1980 white-on-black, the 1980–2011 black-on-yellow
/// and the royal, government (`GSD`), diplomatic and UN plates; the 2015/2016
/// stickers and the printed landscape are artwork.
abstract final class EswatiniPlates {
  static final PlateSpec front = PlateSpec(
    id: 'sz.front',
    country: EswatiniCountry.eswatini,
    canvasWidth: _Layout.frontWidth,
    canvasHeight: _Layout.frontHeight,
    slots: <PlateSlot>[
      _slot(
        EswatiniAlphabets.letters,
        _Layout.seriesLeft,
        _Layout.seriesRight,
        _Layout.frontCy,
        _Layout.frontBox,
        3,
      ),
      _slot(
        EswatiniAlphabets.digits,
        _Layout.numberLeft,
        _Layout.numberRight,
        _Layout.frontCy,
        _Layout.frontBox,
        3,
      ),
      _slot(
        EswatiniAlphabets.letters,
        _Layout.suffixLeft,
        _Layout.suffixRight,
        _Layout.frontCy,
        _Layout.frontBox,
        2,
      ),
    ],
    textGroups: _groups,
  );

  static final PlateSpec rear = PlateSpec(
    id: 'sz.rear',
    country: EswatiniCountry.eswatini,
    canvasWidth: _Layout.rearWidth,
    canvasHeight: _Layout.rearHeight,
    slots: <PlateSlot>[
      _slot(
        EswatiniAlphabets.letters,
        _Layout.rearSeriesLeft,
        _Layout.rearSeriesRight,
        _Layout.row1Cy,
        _Layout.rearBox,
        3,
      ),
      _slot(
        EswatiniAlphabets.digits,
        _Layout.rearNumberLeft,
        _Layout.rearNumberRight,
        _Layout.row2Cy,
        _Layout.rearBox,
        3,
      ),
      _slot(
        EswatiniAlphabets.letters,
        _Layout.rearSuffixLeft,
        _Layout.rearSuffixRight,
        _Layout.row2Cy,
        _Layout.rearBox,
        2,
      ),
    ],
    textGroups: _groups,
  );

  static List<PlateSpec> get all => <PlateSpec>[front, rear];

  static const List<PlateTextGroup> _groups = <PlateTextGroup>[
    PlateTextGroup(<int>[0], key: 'series'),
    PlateTextGroup(<int>[1], key: 'number'),
    PlateTextGroup(<int>[2], key: 'suffix'),
  ];

  static PlateSlot _slot(
    PlateAlphabet alphabet,
    double left,
    double right,
    double cy,
    double box,
    int length,
  ) => PlateSlot(
    alphabet: alphabet,
    box: PlateBox(left, cy - box / 2, right - left, box),
    length: length,
  );
}

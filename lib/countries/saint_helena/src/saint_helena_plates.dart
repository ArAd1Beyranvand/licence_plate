import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'saint_helena_country.dart';

/// The article says only that Saint Helena plates "just have digits on them,
/// with government vehicles having a prefix of 'SHG'", black on white at the
/// front and black on yellow at the rear, "UK dimensions". Its one photograph
/// of them is a car park with plates a few pixels wide, and the other
/// photographs on the page are of other territories (Falkland Islands,
/// Gibraltar, Cayman Islands, ...), so nothing here is measured off a Saint
/// Helena plate. The canvas is the UK's 520×111 and the ink spans x 20.8..499,
/// y 3..108 as on `united_kingdom_plate` and `ascension_island_plate`.
///
/// The digit count is not stated; the Saint Helena photo shows 3 and 4 digits
/// (`260`, `3998`), so the run is 1 to 4. `SHG` takes three of seven equal
/// cells and the digits the other four; the private run is one field centred
/// across the whole ink span.
///
/// Not implemented: the Governor's car, a crown on a white plate. It is
/// artwork with no reference to measure, and the article gives no number.
abstract final class _Layout {
  static const double width = 520, height = 111, rowTop = 3, rowHeight = 105;
  static const double left = 20.8, right = 499;

  static const double pitch = (right - left) / 7;
}

abstract final class SaintHelenaPlates {
  /// `1234`: 1 to 4 digits. Front and rear differ only in theme.
  static const PlateSpec private = PlateSpec(
    id: 'sh.private',
    country: SaintHelenaCountry.saint_helena,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: SaintHelenaAlphabets.digits,
        box: PlateBox(
          _Layout.left,
          _Layout.rowTop,
          _Layout.right - _Layout.left,
          _Layout.rowHeight,
        ),
        length: 4,
        minLength: 1,
        group: 'serial',
      ),
    ],
  );

  /// `SHG 1234`: the prefix, then 1 to 4 digits.
  static const PlateSpec government = PlateSpec(
    id: 'sh.government',
    country: SaintHelenaCountry.saint_helena,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    slots: <PlateSlot>[
      PlateSlot(
        alphabet: SaintHelenaAlphabets.government,
        box: PlateBox(
          _Layout.left,
          _Layout.rowTop,
          3 * _Layout.pitch,
          _Layout.rowHeight,
        ),
        length: 3,
      ),
      PlateSlot(
        alphabet: SaintHelenaAlphabets.digits,
        box: PlateBox(
          _Layout.left + 3 * _Layout.pitch,
          _Layout.rowTop,
          4 * _Layout.pitch,
          _Layout.rowHeight,
        ),
        length: 4,
        minLength: 1,
      ),
    ],
    textGroups: <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'prefix'),
      PlateTextGroup(<int>[1], key: 'serial', prefix: ' '),
    ],
  );
}

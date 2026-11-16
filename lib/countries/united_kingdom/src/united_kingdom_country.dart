// ignore_for_file: constant_identifier_names
import 'package:flutter/widgets.dart';
import 'package:license_plate/core/plate_core.dart';

import 'united_kingdom_colors.dart';

/// The optional left band: a flag over its code. From 28 September 2021 the
/// band is `UK` with no colour behind it (or the zero-emission green), so the
/// default panels take the field's own colour; the nation plates keep the blue
/// of the artwork.
///
/// Flags are from Wikimedia Commons: `Flag_of_the_United_Kingdom_(1-2).svg`,
/// `Flag_of_England.svg`, `Flag_of_Scotland.svg`, `Flag_of_Wales.svg`.
abstract final class UnitedKingdomCountry {
  static const PlateDrawing _scotland = PlateDrawing(1000, 600, <PlateShape>[
    PlateRectShape(0, 0, 1000, 600, Color(0xFF005EB8)),
    PlatePolygonShape(<Offset>[
      Offset(0, 0),
      Offset(116.62, 0),
      Offset(1000, 530.03),
      Offset(1000, 600),
      Offset(883.38, 600),
      Offset(0, 69.97),
    ], Color(0xFFFFFFFF)),
    PlatePolygonShape(<Offset>[
      Offset(0, 600),
      Offset(116.62, 600),
      Offset(1000, 69.97),
      Offset(1000, 0),
      Offset(883.38, 0),
      Offset(0, 530.03),
    ], Color(0xFFFFFFFF)),
  ]);

  static const PlateDrawing _england = PlateDrawing(25, 15, <PlateShape>[
    PlateRectShape(0, 0, 25, 15, Color(0xFFFFFFFF)),
    PlateRectShape(11, 0, 3, 15, Color(0xFFCE1124)),
    PlateRectShape(0, 6, 25, 3, Color(0xFFCE1124)),
  ]);

  static const PlateDrawing _union = PlateDrawing(60, 30, <PlateShape>[
    PlateRectShape(0, 0, 60, 30, Color(0xFF012169)),
    PlatePolygonShape(<Offset>[
      Offset(0, 0),
      Offset(6.708, 0),
      Offset(60, 26.646),
      Offset(60, 30),
      Offset(53.292, 30),
      Offset(0, 3.354),
    ], Color(0xFFFFFFFF)),
    PlatePolygonShape(<Offset>[
      Offset(0, 30),
      Offset(6.708, 30),
      Offset(60, 3.354),
      Offset(60, 0),
      Offset(53.292, 0),
      Offset(0, 26.646),
    ], Color(0xFFFFFFFF)),
    PlatePolygonShape(<Offset>[
      Offset(30, 15),
      Offset(34.472, 15),
      Offset(60, 27.764),
      Offset(60, 30),
    ], Color(0xFFC8102E)),
    PlatePolygonShape(<Offset>[
      Offset(30, 15),
      Offset(25.528, 15),
      Offset(0, 2.236),
      Offset(0, 0),
    ], Color(0xFFC8102E)),
    PlatePolygonShape(<Offset>[
      Offset(30, 15),
      Offset(30, 17.236),
      Offset(4.472, 30),
      Offset(0, 30),
    ], Color(0xFFC8102E)),
    PlatePolygonShape(<Offset>[
      Offset(30, 15),
      Offset(30, 12.764),
      Offset(55.528, 0),
      Offset(60, 0),
    ], Color(0xFFC8102E)),
    PlateRectShape(25, 0, 10, 30, Color(0xFFFFFFFF)),
    PlateRectShape(0, 10, 60, 10, Color(0xFFFFFFFF)),
    PlateRectShape(27, 0, 6, 30, Color(0xFFC8102E)),
    PlateRectShape(0, 12, 60, 6, Color(0xFFC8102E)),
  ]);

  /// The rear plate.
  static const PlateCountry united_kingdom = PlateCountry(
    code: 'gb',
    captionLines: <String>['UK'],
    panelColor: UnitedKingdomColors.rearYellow,
    panelTextColor: UnitedKingdomColors.black,
    flagAspectRatio: 2,
    flag: _union,
  );

  /// The front plate.
  static const PlateCountry front = PlateCountry(
    code: 'gb-front',
    captionLines: <String>['UK'],
    panelColor: UnitedKingdomColors.white,
    panelTextColor: UnitedKingdomColors.black,
    flagAspectRatio: 2,
    flag: _union,
  );

  /// The zero-emission band.
  static const PlateCountry zev = PlateCountry(
    code: 'gb-zev',
    captionLines: <String>['UK'],
    panelColor: UnitedKingdomColors.zevGreen,
    panelTextColor: UnitedKingdomColors.black,
    flagAspectRatio: 2,
    flag: _union,
  );

  static const PlateCountry england = PlateCountry(
    code: 'gb-eng',
    captionLines: <String>['ENG'],
    panelColor: UnitedKingdomColors.bandBlue,
    panelTextColor: UnitedKingdomColors.white,
    flagAspectRatio: 5 / 3,
    flag: _england,
  );

  static const PlateCountry scotland = PlateCountry(
    code: 'gb-sct',
    captionLines: <String>['SCO'],
    panelColor: UnitedKingdomColors.bandBlue,
    panelTextColor: UnitedKingdomColors.white,
    flagAspectRatio: 5 / 3,
    flag: _scotland,
  );

  static const PlateCountry wales = PlateCountry(
    code: 'gb-wls',
    captionLines: <String>['CYM'],
    panelColor: UnitedKingdomColors.bandBlue,
    panelTextColor: UnitedKingdomColors.white,
    flagAspectRatio: 5 / 3,
    flag: SvgPlateAsset(
      'assets/countries/united_kingdom/icons/flag_of_wales.svg',
      package: 'license_plate',
    ),
  );
}

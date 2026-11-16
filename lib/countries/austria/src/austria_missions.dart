import 'package:license_plate/core/plate_core.dart';

/// The diplomatic mission codes: the number after `WD-`.
///
/// Code `33` is deliberately absent and refused: [name] throws for it, and
/// [restriction] carries it into the diplomatic spec so `plate_core` refuses
/// it everywhere.
abstract final class AustriaMissions {
  /// The error every layer shows for a refused code.
  static const String notFound = 'COUNTRY NOT FOUND';

  static const List<String> refused = <String>['33'];

  /// The restriction on the diplomatic spec's `mission` register.
  static const PlateRestriction restriction = PlateRestriction(
    group: 'mission',
    values: refused,
    reason: notFound,
  );

  static bool isRefused(String code) => refused.contains(code);

  /// The mission for [code], or null for a code the list does not have.
  ///
  /// Throws [PlateRestrictionException] for a refused code.
  static String? name(String code) {
    if (isRefused(code)) throw const PlateRestrictionException(restriction);
    return _missions[code];
  }

  /// Every listed code and its mission, refused codes excluded.
  static Map<String, String> get all => Map.unmodifiable(_missions);

  static const Map<String, String> _missions = <String, String>{
    '1': 'Vatican City',
    '2': 'South Africa',
    '3': 'Albania',
    '4': 'Germany',
    '5': 'United States',
    '6': 'Saudi Arabia',
    '7': 'Egypt',
    '8': 'Argentina',
    '9': 'Australia',
    '11': 'Belgium',
    '12': 'Brazil',
    '13': 'Bulgaria',
    '14': 'Canada',
    '15': 'Chile',
    '16': 'Colombia',
    '17': 'South Korea',
    '18': 'Cuba',
    '19': 'Denmark',
    '21': 'Luxembourg',
    '22': 'Spain',
    '23': 'Finland',
    '24': 'France',
    '25': 'United Kingdom',
    '26': 'Greece',
    '27': 'Hungary',
    '28': 'India',
    '29': 'Indonesia',
    '31': 'Iraq',
    '32': 'Iran',
    '34': 'Italy',
    '35': 'Japan',
    '36': 'Lebanon',
    '37': 'Mexico',
    '38': 'Norway',
    '39': 'Sovereign Military Order of Malta',
    '41': 'Pakistan',
    '42': 'Panama',
    '43': 'Netherlands',
  };
}

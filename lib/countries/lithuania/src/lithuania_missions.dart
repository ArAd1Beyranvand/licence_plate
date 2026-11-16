import 'package:license_plate/core/plate_core.dart';

/// The diplomatic mission codes: the first two digits of a diplomatic plate.
///
/// Code `41` (Israel) is deliberately absent and refused: [name] throws for
/// it, and [restriction] carries it into the diplomatic spec so `plate_core`
/// refuses it everywhere.
abstract final class LithuaniaMissions {
  /// The error every layer shows for a refused code.
  static const String notFound = 'COUNTRY NOT FOUND';

  static const List<String> refused = <String>['41'];

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

  /// The third digit: the status of the vehicle.
  static const Map<String, String> statuses = <String, String>{
    '1': 'Chief of mission',
    '2': 'Embassy vehicle',
    '3': 'Diplomatic personnel',
    '4': 'Administrative and technical personnel',
  };

  static const Map<String, String> _missions = <String, String>{
    '01': 'Sweden',
    '02': 'Germany',
    '03': 'France',
    '04': 'Latvia',
    '05': 'Denmark',
    '06': 'Canada',
    '07': 'United Kingdom',
    '08': 'Italy',
    '09': 'Norway',
    '10': 'Finland',
    '11': 'Holy See',
    '12': 'Turkey',
    '13': 'Czech Republic',
    '14': 'United States',
    '15': 'China',
    '16': 'Poland',
    '18': 'Estonia',
    '19': 'Russia',
    '20': 'Russia (Consulate General in Klaipėda)',
    '21': 'Romania',
    '22': 'Ukraine',
    '23': 'Belarus',
    '24': 'Kazakhstan',
    '25': 'Georgia',
    '26': 'Japan',
    '28': 'Belgium (Flanders Investment and Trade Division)',
    '29': 'Netherlands',
    '30': 'Hungary',
    '31': 'Spain',
    '32': 'Sovereign Military Order of Malta',
    '33': 'Greece',
    '34': 'Ireland',
    '36': 'Moldova',
    '37': 'Azerbaijan',
    '39': 'Armenia',
    '40': 'Croatia',
    '42': 'Nigeria',
    '43': 'India',
  };
}

import 'package:license_plate/core/plate_core.dart';

/// The diplomatic mission codes: the two digits that open a diplomatic plate.
///
/// Source: the mission table in the Wikipedia article. Code `35` is the
/// article's entry for Israel; it is deliberately absent and refused:
/// [name] throws for it, and [restriction] carries it into the diplomatic
/// spec so `plate_core` refuses it everywhere.
abstract final class NorthMacedoniaMissions {
  /// The error every layer shows for a refused code.
  static const String notFound = 'COUNTRY NOT FOUND';

  static const List<String> refused = <String>['35'];

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
    '01': 'Slovenia',
    '02': 'Turkey',
    '03': 'United Kingdom',
    '04': 'Germany',
    '05': 'Denmark',
    '06': 'China',
    '07': 'Bulgaria',
    '08': 'Sweden',
    '09': 'France',
    '10': 'Switzerland',
    '11': 'Netherlands',
    '12': 'Albania',
    '13': 'Belgium',
    '14': 'Bosnia',
    '15': 'Russia',
    '16': 'Italy',
    '17': 'Finland',
    '18': 'Japan',
    '19': 'Romania',
    '20': 'Czech Republic',
    '21': 'Spain',
    '22': 'Austria',
    '23': 'Croatia',
    '24': 'Egypt',
    '25': 'United States',
    '26': 'South Korea',
    '27': 'Greece',
    '28': 'Hungary',
    '29': 'Serbia',
    '30': 'Iran',
    '31': 'Poland',
    '32': 'Thailand',
    '33': 'Canada',
    '34': 'Norway',
    '36': 'European Union',
    '37': 'Sovereign Military Order of Malta',
    '38': 'Ukraine',
    '39': 'Slovakia',
  };
}

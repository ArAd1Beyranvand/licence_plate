import 'package:license_plate/core/plate_core.dart';

/// Embassy codes: the `mission` register of `GeorgiaCountryPlates.diplomatic`.
///
/// The article's table is three-digit (`001`..`040`) while its prose says the
/// first two digits; the table wins, so the register is three digits.
///
/// Code `004` is deliberately absent and refused: [restriction] carries it
/// into the spec so `plate_core` refuses it everywhere, and [name] throws.
abstract final class GeorgiaCountryMissions {
  /// The error every layer shows for a refused code.
  static const String notFound = 'COUNTRY NOT FOUND';

  static const List<String> refused = <String>['004'];

  static const PlateRestriction restriction = PlateRestriction(
    group: 'mission',
    values: refused,
    reason: notFound,
  );

  static bool isRefused(String code) => refused.contains(code);

  /// The mission for [code], or null for an unlisted code. Throws
  /// [PlateRestrictionException] for a refused one.
  static String? name(String code) {
    if (isRefused(code)) throw const PlateRestrictionException(restriction);
    return _missions[code];
  }

  static Map<String, String> get all => Map.unmodifiable(_missions);

  static const Map<String, String> _missions = <String, String>{
    '001': 'Germany',
    '002': 'United States',
    '003': 'Turkey',
    '005': 'China',
    '006': 'Russia',
    '007': 'United Nations',
    '008': 'Organization for Security and Co-operation in Europe',
    '009': 'Iran',
    '010': 'Vatican City',
    '011': 'Armenia',
    '012': 'France',
    '013': 'Red Cross',
    '014': 'Ukraine',
    '015': 'International organizations',
    '016': 'European Union',
    '017': 'Great Britain',
    '018': 'Greece',
    '019': 'Azerbaijan',
    '020': 'World Bank',
    '021': 'Romania',
    '022': 'Poland',
    '023': "Cote d'Ivoire",
    '024': 'Latvia',
    '025': 'European Bank for Reconstruction and Development',
    '026': 'Bulgaria',
    '027': 'International Committee of the Red Cross',
    '028': 'Switzerland',
    '029': 'Italy',
    '030': 'San Marino',
    '031': 'Netherlands',
    '032': 'Czech Republic',
    '033': 'Sweden',
    '035': 'Kazakhstan',
    '036': 'Council of Europe',
    '037': 'Philippines',
    '038': 'Denmark',
    '039': 'Lithuania',
    '040': 'Estonia',
  };
}

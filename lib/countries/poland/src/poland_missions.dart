import 'package:license_plate/core/plate_core.dart';

/// The diplomatic mission codes: the first three digits after the `W`.
///
/// Codes 049 and 095 are deliberately absent and refused: [name] throws for
/// them, and [restriction] carries them into the diplomatic spec so
/// `plate_core` refuses them everywhere.
abstract final class PolandMissions {
  /// The error every layer shows for a refused code.
  static const String notFound = 'COUNTRY NOT FOUND';

  static const List<String> refused = <String>['049', '095'];

  /// The restriction on the diplomatic spec's `mission` field.
  static const PlateRestriction restriction = PlateRestriction(
    group: 'mission',
    values: refused,
    reason: notFound,
  );

  static bool isRefused(String code) => refused.contains(code);

  /// The country or organization for [code], or null for a code the list does
  /// not have.
  ///
  /// Throws [PlateRestrictionException] for a refused code: unlike an unknown
  /// one, a refused code is never a lookup miss a caller may shrug off.
  static String? name(String code) {
    if (isRefused(code)) throw const PlateRestrictionException(restriction);
    return _missions[code];
  }

  /// Every listed code and its name, refused codes excluded.
  static Map<String, String> get all => Map.unmodifiable(_missions);

  static const Map<String, String> _missions = <String, String>{
    '001': 'United States',
    '002': 'United Kingdom',
    '003': 'France',
    '004': 'Canada',
    '005': 'Germany',
    '006': 'Netherlands',
    '007': 'Italy',
    '008': 'Austria',
    '009': 'Japan',
    '010': 'Turkey',
    '011': 'Belgium',
    '012': 'Denmark',
    '013': 'Norway',
    '014': 'Greece',
    '015': 'Australia',
    '016': 'Algeria',
    '017': 'Afghanistan',
    '018': 'Argentina',
    '019': 'Brazil',
    '020': 'Bangladesh',
    '021': 'Egypt',
    '022': 'Ecuador',
    '023': 'Finland',
    '024': 'Spain',
    '025': 'Iraq',
    '026': 'Iran',
    '027': 'India',
    '028': 'Indonesia',
    '029': 'Colombia',
    '030': 'Malaysia',
    '031': 'Libya',
    '032': 'Morocco',
    '033': 'Mexico',
    '034': 'Nigeria',
    '035': 'Pakistan',
    '036': 'Portugal',
    '037': 'Palestine',
    '038': 'Syria',
    '039': 'Sweden',
    '040': 'Switzerland',
    '041': 'Tunisia',
    '042': 'Thailand',
    '043': 'Venezuela',
    '044': 'Uruguay',
    '045': 'Peru',
    '046': 'Yemen',
    '047': 'Costa Rica',
    '048': 'Democratic Republic of Congo',
    '050': 'Nicaragua',
    '051': 'Chile',
    '052': 'Holy See',
    '053': 'South Korea',
    '054': 'European Commission',
    '055': 'Ireland',
    '056': 'World Bank Group',
    '057': 'International Monetary Fund',
    '058': 'Philippines',
    '059': 'International Finance Corporation',
    '060': 'South Africa',
    '061': 'Office for Democratic Institutions and Human Rights',
    '062': 'Cyprus',
    '063': 'Kuwait',
    '064': 'United Nations',
    '065': 'Russia',
    '066': 'Slovakia',
    '067': 'Czech Republic',
    '068': 'Bulgaria',
    '069': 'Hungary',
    '070': 'Romania',
    '071': 'Vietnam',
    '072': 'Serbia',
    '073': 'North Korea',
    '074': 'Cuba',
    '075': 'Albania',
    '076': 'China',
    '077': 'Mongolia',
    '078': 'International Labour Organization',
    '079': 'Organization for Cooperation of Railways',
    '081': 'Laos',
    '082': 'Angola',
    '083': 'Ukraine',
    '084': 'European Bank for Reconstruction and Development',
    '085': 'Lithuania',
    '086': 'Belarus',
    '087': 'Latvia',
    '088': 'Croatia',
    '089': 'Lebanon',
    '090': 'Slovenia',
    '091': 'Guatemala (disputed)',
    '092': 'Estonia',
    '093': 'North Macedonia',
    '094': 'Moldova',
    '096': 'Armenia',
    '097': 'Sri Lanka',
    '098': 'Kazakhstan',
    '099': 'Saudi Arabia',
    '100': 'Georgia',
    '101': 'Uzbekistan',
    '102': 'United Nations Human Settlements Program',
    '103': 'New Zealand',
    '104': 'Azerbaijan',
    '105': 'Sovereign Military Order of Malta',
    '106': 'Cambodia',
    '107': 'Frontex',
    '108': 'Luxembourg',
    '109': 'Bosnia and Herzegovina',
    '110': 'Panama',
    '111': 'Qatar',
    '112': 'Malta',
    '113': 'United Arab Emirates',
    '114': 'Montenegro',
    '115': 'Senegal',
    '116': 'Bangladesh',
    '117': 'Rwanda',
    '118': 'Iceland',
    '119': 'UNICEF',
    '120': 'World Health Organization',
    '121': 'Kosovo',
  };
}

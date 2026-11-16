import 'package:license_plate/core/plate_core.dart';

/// Diplomatic mission codes: the three digits after the `D`. Code `012` is
/// Israel's in the article's table and is refused in every layer; nothing in
/// this package stores it.
abstract final class UkraineMissions {
  static const String notFound = 'COUNTRY NOT FOUND';

  static const List<String> refused = <String>['012'];

  static const PlateRestriction restriction = PlateRestriction(
    group: 'mission',
    values: refused,
    reason: notFound,
  );

  static bool isRefused(String code) => refused.contains(code);

  /// Throws [PlateRestrictionException] for a refused code.
  static String? name(String code) {
    if (isRefused(code)) throw const PlateRestrictionException(restriction);
    return _missions[code];
  }

  static Map<String, String> get all => Map.unmodifiable(_missions);

  static const Map<String, String> _missions = <String, String>{
    '002': 'United States',
    '003': 'China',
    '004': 'United Kingdom',
    '005': 'France',
    '006': 'Germany',
    '007': 'Hungary',
    '008': 'Lithuania',
    '009': 'Bulgaria',
    '010': 'Armenia',
    '011': 'Australia',
    '013': 'Belarus',
    '014': 'Poland',
    '015': 'Estonia',
    '017': 'Sweden',
    '018': 'Mexico',
    '019': 'Greece',
    '020': 'India',
    '021': 'Iran',
    '022': 'Mongolia',
    '023': 'Vietnam',
    '024': 'Austria',
    '025': 'Egypt',
    '026': 'Argentina',
    '027': 'Japan',
    '028': 'Canada',
    '029': 'Portugal',
    '030': 'Chile',
    '031': 'Italy',
    '032': 'Spain',
    '033': 'Slovakia',
    '034': 'Romania',
    '035': 'Turkey',
    '036': 'Norway',
    '037': 'Algeria',
    '038': 'Switzerland',
    '039': 'Niger',
    '040': 'Vatican City',
    '041': 'Azerbaijan',
    '042': 'South Korea',
    '043': 'Brazil',
    '044': 'Denmark',
    '045': 'Latvia',
    '046': 'Croatia',
    '047': 'Cyprus',
    '048': 'Czech Republic',
    '049': 'Finland',
    '050': 'Seychelles',
    '051': 'United Nations',
    '052': 'Central African Republic',
    '053': 'Slovenia',
    '054': 'Belgium',
    '055': 'Moldova',
    '056': 'Cuba',
    '057': 'Philippines',
    '058': 'South Africa',
    '059': 'Pakistan',
    '060': 'Libya',
    '061': 'IBRD',
    '062': 'IFC',
    '063': 'Syria',
    '064': 'Singapore',
    '065': 'Ireland',
    '066': 'Netherlands',
    '067': 'Kazakhstan',
    '068': 'Georgia',
    '069': 'Iraq',
    '070': 'Kyrgyzstan',
    '071': 'Tajikistan',
    '072': 'Uzbekistan',
    '073': 'Turkmenistan',
    '074': 'Thailand',
    '075': 'Tunisia',
    '076': 'Ghana',
    '077': 'Serbia',
    '078': 'Liechtenstein',
    '079': 'Indonesia',
    '080': 'Morocco',
    '081': 'Jordan',
    '082': 'Kuwait',
    '083': 'Luxembourg',
    '084': 'OSCE',
    '085': 'Uruguay',
    '086': 'Peru',
    '087': 'Red Cross',
    '088': 'Afghanistan',
    '089': 'SCTU',
    '090': 'Serbia',
    '091': 'Albania',
    '092': 'North Macedonia',
    '093': 'NATO',
    '094': 'NATO Information Center',
    '095': 'IMF',
    '096': 'New Zealand',
    '097': 'Bangladesh',
    '098': 'European Union',
    '099': 'EBRD',
    '100': 'GDIP',
    '199': 'Bank for reconstruction',
    '206': 'OSCE',
  };
}

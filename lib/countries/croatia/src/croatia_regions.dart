import 'package:license_plate/core/plate_core.dart';

/// Locates a Croatian plate from its two-letter city code.
///
/// Source: the city-code table of
/// https://en.wikipedia.org/wiki/Vehicle_registration_plates_of_Croatia ; each
/// code is named for its seat, the first town the table lists. Only that is
/// read off a plate: a code covers many towns and municipalities.
abstract final class CroatiaRegions {
  static const Map<String, String> _areas = <String, String>{
    'BJ': 'Bjelovar',
    'BM': 'Beli Manastir',
    'ČK': 'Čakovec',
    'DA': 'Daruvar',
    'DE': 'Delnice',
    'DJ': 'Đakovo',
    'DU': 'Dubrovnik',
    'GS': 'Gospić',
    'IM': 'Imotski',
    'KA': 'Karlovac',
    'KC': 'Koprivnica',
    'KR': 'Krapina',
    'KT': 'Kutina',
    'KŽ': 'Križevci',
    'MA': 'Makarska',
    'NA': 'Našice',
    'NG': 'Nova Gradiška',
    'OG': 'Ogulin',
    'OS': 'Osijek',
    'PU': 'Pula',
    'PŽ': 'Požega',
    'RI': 'Rijeka',
    'SB': 'Slavonski Brod',
    'SK': 'Sisak',
    'SL': 'Slatina',
    'ST': 'Split',
    'ŠI': 'Šibenik',
    'VK': 'Vinkovci',
    'VT': 'Virovitica',
    'VU': 'Vukovar',
    'VŽ': 'Varaždin',
    'ZD': 'Zadar',
    'ZG': 'Zagreb',
    'ŽU': 'Županja',
  };

  /// The seat of [code] (one or two letters), or null when it matches no code
  /// or several.
  static String? lookup(String code) {
    if (code.isEmpty) return null;
    final Set<String> names = <String>{
      for (final MapEntry<String, String> e in _areas.entries)
        if (e.key.startsWith(code)) e.value,
    };
    return names.length == 1 ? names.single : null;
  }

  /// A [PlateLabelResolver] for [PlateSpec.resolveRegion].
  static String? captionOf(String Function(String key) group) =>
      lookup(group('region'));
}

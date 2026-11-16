import 'package:license_plate/core/plate_core.dart';

/// Names the registration area from its two-letter code.
///
/// Source: the area-code table in
/// https://en.wikipedia.org/wiki/Vehicle_registration_plates_of_North_Macedonia
/// (the principal municipality; the article lists the others each code also
/// covers). `ŠT` and `TV` are retired and not listed.
abstract final class NorthMacedoniaRegions {
  static const Map<String, String> areas = <String, String>{
    'BE': 'Berovo',
    'BT': 'Bitola',
    'DB': 'Debar',
    'DE': 'Delčevo',
    'DH': 'Demir Hisar',
    'DK': 'Demir Kapija',
    'GE': 'Gevgelija',
    'GV': 'Gostivar',
    'KA': 'Kavadarci',
    'KI': 'Kičevo',
    'KO': 'Kočani',
    'KR': 'Kratovo',
    'KP': 'Kriva Palanka',
    'KS': 'Kruševo',
    'KU': 'Kumanovo',
    'MB': 'Makedonski Brod',
    'MK': 'Makedonska Kamenica',
    'NE': 'Negotino',
    'OH': 'Ohrid',
    'PE': 'Pehčevo',
    'PP': 'Prilep',
    'PS': 'Probištip',
    'RA': 'Radoviš',
    'RE': 'Resen',
    'SK': 'Skopje',
    'SN': 'Sveti Nikole',
    'SU': 'Struga',
    'SR': 'Strumica',
    'ST': 'Štip',
    'TE': 'Tetovo',
    'VA': 'Valandovo',
    'VE': 'Veles',
    'VI': 'Vinica',
    'VV': 'Vevčani',
  };

  /// The area of [code] (one or two letters), or null when it matches no
  /// code or several.
  static String? lookup(String code) {
    if (code.isEmpty) return null;
    final Set<String> names = <String>{
      for (final MapEntry<String, String> e in areas.entries)
        if (e.key.startsWith(code)) e.value,
    };
    return names.length == 1 ? names.single : null;
  }

  /// A [PlateLabelResolver] for [PlateSpec.resolveRegion].
  static String? captionOf(String Function(String key) group) =>
      lookup(group('region'));
}

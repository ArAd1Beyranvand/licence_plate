import 'package:license_plate/core/plate_core.dart';

/// Names the municipality from its two-letter code.
///
/// Source: the municipal codes table in
/// https://en.wikipedia.org/wiki/Vehicle_registration_plates_of_Montenegro
abstract final class MontenegroRegions {
  static const Map<String, String> _areas = <String, String>{
    'AN': 'Andrijevica',
    'BA': 'Berane',
    'BD': 'Budva',
    'BP': 'Bijelo Polje',
    'BR': 'Bar',
    'CT': 'Cetinje',
    'DG': 'Danilovgrad',
    'GS': 'Gusinje',
    'HN': 'Herceg Novi',
    'KL': 'Kolašin',
    'KO': 'Kotor',
    'MK': 'Mojkovac',
    'NK': 'Nikšić',
    'PG': 'Podgorica',
    'PL': 'Plav',
    'PT': 'Petnjica',
    'PŽ': 'Plužine',
    'PV': 'Pljevlja',
    'RO': 'Rožaje',
    'ŠN': 'Šavnik',
    'TV': 'Tivat',
    'TZ': 'Tuzi',
    'UL': 'Ulcinj',
    'ZT': 'Zeta',
    'ŽB': 'Žabljak',
  };

  /// The municipality of [code] (one or two letters), or null when it matches
  /// no code or several.
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

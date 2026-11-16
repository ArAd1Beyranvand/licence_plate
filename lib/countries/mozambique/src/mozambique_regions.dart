/// Locates a plate from its two-letter province code.
///
/// Source: the "Province Codes" section of
/// https://en.wikipedia.org/wiki/Vehicle_registration_plates_of_Mozambique
abstract final class MozambiqueRegions {
  static const Map<String, String> _codes = <String, String>{
    'CA': 'Cabo Delgado',
    'GZ': 'Gaza',
    'IB': 'Inhambane',
    'MC': 'Maputo (city)',
    'MP': 'Maputo',
    'MN': 'Manica',
    'NP': 'Nampula',
    'NS': 'Niassa',
    'SF': 'Sofala',
    'TT': 'Tete',
    'ZB': 'Zambezia',
  };

  /// The name for [code], or null when it matches no code or several.
  static String? lookup(String code) {
    if (code.isEmpty) return null;
    final Set<String> names = <String>{
      for (final MapEntry<String, String> e in _codes.entries)
        if (e.key.startsWith(code)) e.value,
    };
    return names.length == 1 ? names.single : null;
  }

  static String? captionOf(String Function(String key) group) =>
      lookup(group('province'));
}

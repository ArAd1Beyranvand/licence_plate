/// Locates a plate from its two-letter province code.
abstract final class EquatorialGuineaRegions {
  static const Map<String, String> _provinces = <String, String>{
    'AN': 'Annobón',
    'BN': 'Bioko Norte',
    'BS': 'Bioko Sur',
    'CS': 'Centro Sur',
    'KN': 'Kié-Ntem',
    'LT': 'Litoral',
    'WN': 'Wele-Nzas',
  };

  /// The province of [code] (one or two letters), or null when it matches no
  /// code or several (`B` is either Bioko).
  static String? lookup(String code) {
    if (code.isEmpty) return null;
    final Set<String> names = <String>{
      for (final MapEntry<String, String> e in _provinces.entries)
        if (e.key.startsWith(code)) e.value,
    };
    return names.length == 1 ? names.single : null;
  }

  static String? captionOf(String Function(String key) group) =>
      lookup(group('province'));
}

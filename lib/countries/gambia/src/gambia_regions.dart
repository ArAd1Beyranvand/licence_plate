/// Locates a plate from its regional code, current (2019-) or previous (1994-2019).
abstract final class GambiaRegions {
  static const Map<String, String> _regions = <String, String>{
    'BJL': 'Banjul',
    'WCR': 'West Coast Region',
    'WD': 'West Coast Region',
    'NBR': 'North Bank Region',
    'NBD': 'North Bank Region',
    'LRR': 'Lower River Region',
    'LRD': 'Lower River Region',
    'CRR': 'Central River Region',
    'CRD': 'Central River Region',
    'URR': 'Upper River Region',
    'URD': 'Upper River Region',
    'KM': 'Kanifing Municipality',
  };

  /// The region [code] already pins down, or null when it is empty, matches
  /// no code, or could still become codes of different regions.
  static String? lookup(String code) {
    if (code.isEmpty) return null;
    final String c = code.toUpperCase();
    final Set<String> names = <String>{
      for (final MapEntry<String, String> e in _regions.entries)
        if (e.key.startsWith(c)) e.value,
    };
    return names.length == 1 ? names.single : null;
  }

  static String? captionOf(String Function(String key) group) =>
      lookup(group('region'));
}

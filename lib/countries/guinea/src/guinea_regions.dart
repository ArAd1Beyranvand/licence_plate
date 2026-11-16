/// Region captions: two digits on the current series (2021–); the 1994 series
/// lists only `RC` (Conakry).
abstract final class GuineaRegions {
  static const Map<String, String> _current = <String, String>{
    '01': 'Boké',
    '02': 'Conakry',
    '03': 'Faranah',
    '04': 'Kankan',
    '05': 'Kindia',
    '06': 'Labé',
    '07': 'Mamou',
    '08': 'Nzérékoré',
  };

  static String? lookup(String code) => _current[code];

  static String? lookupLegacy(String prefix) =>
      prefix == 'RC' ? 'Conakry' : null;

  static String? captionOf(String Function(String key) group) =>
      lookup(group('region'));

  static String? legacyCaptionOf(String Function(String key) group) =>
      lookupLegacy(group('prefix'));
}

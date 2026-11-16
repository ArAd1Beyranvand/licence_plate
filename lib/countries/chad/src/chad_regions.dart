/// Locates a Chadian plate from its leading two-digit region code.
///
/// Source: the "Regional coding" section of
/// https://en.wikipedia.org/wiki/Vehicle_registration_plates_of_Chad
/// The article has no assignment for code 23, so it names nothing.
abstract final class ChadRegions {
  static const Map<String, String> _regions = <String, String>{
    '01': 'Batha',
    '02': 'Borkou',
    '03': 'Chari-Baguirmi',
    '04': 'Guéra',
    '05': 'Hadjer-Lamis',
    '06': 'Kanem',
    '07': 'Lac',
    '08': 'Logone Occidental',
    '09': 'Logone Oriental',
    '10': 'Mandoul',
    '11': 'Mayo-Kebbi Est',
    '12': 'Mayo-Kebbi Ouest',
    '13': 'Moyen-Chari',
    '14': 'Ouaddaï',
    '15': 'Salamat',
    '16': 'Tandjilé',
    '17': 'Wadi Fira',
    '18': 'N\'Djamena',
    '19': 'Bahr El Gazel',
    '20': 'Ennedi',
    '21': 'Sila',
    '22': 'Tibesti',
  };

  /// The region of [code], or null until both digits are typed and while the
  /// code is unissued.
  static String? lookup(String code) => _regions[code];

  static String? captionOf(String Function(String key) group) =>
      lookup(group('region'));
}

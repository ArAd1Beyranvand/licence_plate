/// The provinces behind the one- and two-letter codes, as the article tables
/// them (codes in their Latin forms).
abstract final class BulgariaRegions {
  /// The province for [code], or null for a code the table lacks.
  static String? nameOf(String code) => _provinces[code];

  static const Map<String, String> _provinces = <String, String>{
    'A': 'Burgas', 'B': 'Varna', 'BH': 'Vidin', 'BP': 'Vratsa', //
    'BT': 'Veliko Tarnovo', 'E': 'Blagoevgrad', 'EB': 'Gabrovo',
    'EH': 'Pleven', 'K': 'Kardzhali', 'KH': 'Kyustendil', 'M': 'Montana',
    'H': 'Shumen', 'OB': 'Lovech', 'P': 'Ruse', 'PA': 'Pazardzhik',
    'PB': 'Plovdiv', 'PK': 'Pernik', 'PP': 'Razgrad', 'C': 'Sofia',
    'CA': 'Sofia', 'CB': 'Sofia', 'CH': 'Sliven', 'CM': 'Smolyan',
    'CO': 'Sofia Province', 'CC': 'Silistra', 'CT': 'Stara Zagora',
    'T': 'Targovishte', 'TX': 'Dobrich', 'Y': 'Yambol', 'X': 'Haskovo',
  };
}

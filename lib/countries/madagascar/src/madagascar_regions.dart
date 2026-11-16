/// Locates a Malagasy plate from its province letter.
///
/// On a regular plate the province is the first letter of the series; on a
/// temporary plate (`WW` + letter) and a dealer plate (`W 123 T`) it is the
/// last.
abstract final class MadagascarRegions {
  static const Map<String, String> _provinces = <String, String>{
    'A': 'Toamasina',
    'D': 'Antsiranana',
    'F': 'Fianarantsoa',
    'M': 'Mahajanga',
    'T': 'Antananarivo',
    'U': 'Toliara',
  };

  /// The province of a [letter], or null when empty or unissued.
  static String? lookup(String letter) => _provinces[letter];

  /// For the regular plate: the first letter of `series`.
  static String? captionOf(String Function(String key) group) {
    final String series = group('series');
    return series.isEmpty ? null : lookup(series[0]);
  }

  /// For the temporary plate: the letter after `WW`.
  static String? temporaryCaptionOf(String Function(String key) group) {
    final String series = group('series');
    return series.length == 3 && series.startsWith('WW')
        ? lookup(series[2])
        : null;
  }

  /// For the dealer plate: the single letter of `series`.
  static String? dealerCaptionOf(String Function(String key) group) =>
      lookup(group('series'));
}

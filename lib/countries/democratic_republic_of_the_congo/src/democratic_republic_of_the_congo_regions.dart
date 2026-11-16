/// Locates a private plate from its province code (the last two digits).
///
/// Source: the province table of
/// https://en.wikipedia.org/wiki/Vehicle_registration_plates_of_the_Democratic_Republic_of_the_Congo
abstract final class DemocraticRepublicOfTheCongoRegions {
  static const Map<String, String> _provinces = <String, String>{
    '01': 'Kinshasa',
    '02': 'Bas-Uele',
    '03': 'Équateur',
    '04': 'Haut-Lomami',
    '05': 'Haut-Katanga',
    '06': 'Haut-Uele',
    '07': 'Ituri',
    '08': 'Kasaï',
    '09': 'Kasaï-Oriental',
    '10': 'Kongo Central',
    '11': 'Kwango',
    '12': 'Kwilu',
    '13': 'Lomami',
    '14': 'Lualaba',
    '15': 'Kasaï-Central',
    '16': 'Mai-Ndombe',
    '17': 'Maniema',
    '18': 'Mongala',
    '19': 'Nord-Kivu',
    '20': 'Nord-Ubangi',
    '21': 'Sankuru',
    '22': 'Sud-Kivu',
    '23': 'Sud-Ubangi',
    '24': 'Tanganyika',
    '25': 'Tshopo',
    '26': 'Tshuapa',
  };

  static String? lookup(String code) => _provinces[code];

  static String? captionOf(String Function(String key) group) =>
      lookup(group('province'));
}

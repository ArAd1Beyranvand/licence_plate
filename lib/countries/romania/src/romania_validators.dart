import 'package:license_plate/core/plate_core.dart';

/// The county codes, from the article's table (Bucharest is `B`; `IF` is
/// Ilfov, which surrounds it).
abstract final class RomaniaCounties {
  static const Map<String, String> names = <String, String>{
    'B': 'Bucharest', 'AB': 'Alba', 'AG': 'Argeș', 'AR': 'Arad', //
    'BC': 'Bacău', 'BH': 'Bihor', 'BN': 'Bistrița-Năsăud', 'BR': 'Brăila',
    'BT': 'Botoșani', 'BV': 'Brașov', 'BZ': 'Buzău', 'CJ': 'Cluj',
    'CL': 'Călărași', 'CS': 'Caraș-Severin', 'CT': 'Constanța',
    'CV': 'Covasna', 'DB': 'Dâmbovița', 'DJ': 'Dolj', 'GJ': 'Gorj',
    'GL': 'Galați', 'GR': 'Giurgiu', 'HD': 'Hunedoara', 'HR': 'Harghita',
    'IF': 'Ilfov', 'IL': 'Ialomița', 'IS': 'Iași', 'MH': 'Mehedinți',
    'MM': 'Maramureș', 'MS': 'Mureș', 'NT': 'Neamț', 'OT': 'Olt',
    'PH': 'Prahova', 'SB': 'Sibiu', 'SJ': 'Sălaj', 'SM': 'Satu Mare',
    'SV': 'Suceava', 'TL': 'Tulcea', 'TM': 'Timiș', 'TR': 'Teleorman',
    'VL': 'Vâlcea', 'VN': 'Vrancea', 'VS': 'Vaslui',
  };
}

bool _county(String code) => RomaniaCounties.names.containsKey(code);

/// Judges a [RomaniaPlates.standard] value: a county code, two digits (three
/// in Bucharest, never `00`) and three letters without Q or a leading I or O.
/// Advisory: reports, never bars a keystroke.
class RomaniaValidator extends GatedPlateValidator {
  const RomaniaValidator() : super('letters');

  static const String reasonCounty = 'The county code is one of the 42 codes.';
  static const String reasonNumber =
      'The number is two digits, or two or three in Bucharest; not 00.';
  static const String reasonLetters =
      'The letters are three, without Q, and do not begin with I or O.';

  static final RegExp _letters = RegExp(r'^[A-HJ-NP-Z][A-PR-Z]{2}$');

  @override
  PlateValidation judge(PlateEntry entry) {
    final String county = entry.group('county');
    if (!_county(county)) return const PlateValidation.invalid(reasonCounty);
    final String number = entry.group('number');
    final bool lengthOk =
        number.length == 2 || (county == 'B' && number.length == 3);
    if (!lengthOk || !isDigits(number) || int.parse(number) == 0) {
      return const PlateValidation.invalid(reasonNumber);
    }
    final String letters = entry.group('letters');
    if (!_letters.hasMatch(letters) || letters.contains('Q')) {
      return const PlateValidation.invalid(reasonLetters);
    }
    return const PlateValidation.valid();
  }
}

/// Judges a [RomaniaPlates.temporary] value: a county code and three to six
/// digits, the first `0` and the second not.
class RomaniaTemporaryValidator extends GatedPlateValidator {
  const RomaniaTemporaryValidator() : super('number');

  static const String reasonNumber =
      'The number is three to six digits, the first 0 and the second not.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!_county(entry.group('county'))) {
      return const PlateValidation.invalid(RomaniaValidator.reasonCounty);
    }
    final String n = entry.group('number');
    if (n.length < 3 || !isDigits(n) || n[0] != '0' || n[1] == '0') {
      return const PlateValidation.invalid(reasonNumber);
    }
    return const PlateValidation.valid();
  }
}

/// Judges a [RomaniaPlates.test] value: a county code and a three-digit number
/// from 101.
class RomaniaTestValidator extends GatedPlateValidator {
  const RomaniaTestValidator() : super('number');

  static const String reasonNumber = 'The number is three digits, from 101.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!_county(entry.group('county'))) {
      return const PlateValidation.invalid(RomaniaValidator.reasonCounty);
    }
    final String n = entry.group('number');
    if (!isDigitsOfLength(n, 3) || int.parse(n) < 101) {
      return const PlateValidation.invalid(reasonNumber);
    }
    return const PlateValidation.valid();
  }
}

/// Judges a [RomaniaPlates.diplomatic] value: `CD`, `TC` or `CO` and two
/// three-digit codes, the lowest of either being 101. The article's table of
/// mission codes is partial, so the mission code is only range-checked.
class RomaniaDiplomaticValidator extends GatedPlateValidator {
  const RomaniaDiplomaticValidator() : super('rank');

  static const String reasonCode = 'The code is CD, TC or CO.';
  static const String reasonDigits =
      'The mission and the rank are each three digits, from 101.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!const <String>{'CD', 'TC', 'CO'}.contains(entry.group('code'))) {
      return const PlateValidation.invalid(reasonCode);
    }
    for (final String key in const <String>['mission', 'rank']) {
      final String v = entry.group(key);
      if (!isDigitsOfLength(v, 3) || int.parse(v) < 101) {
        return const PlateValidation.invalid(reasonDigits);
      }
    }
    return const PlateValidation.valid();
  }
}

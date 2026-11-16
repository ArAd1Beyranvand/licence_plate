import 'package:license_plate/core/plate_core.dart';

/// Judges a Pakistani registration: two or three letters (none of I, O, U),
/// three or four digits, and on Punjab's plate a two-digit year. Reports,
/// never bars a keystroke.
///
/// Balochistan, Khyber Pakhtunkhwa and Punjab print four digits; Islamabad,
/// Azad Jammu & Kashmir and Sindh print three (the article: "two to three
/// numbers and three to four letters", the pictures show two or three letters
/// and three or four digits).
class PakistanValidator extends GatedPlateValidator {
  const PakistanValidator() : super('digits');

  static const String reasonLetters =
      'The letters are two or three, none of I, O, U.';
  static const String reasonDigits = 'The number is three or four digits.';
  static const String reasonYear = 'The year is two digits.';

  static final RegExp _letters = RegExp(r'^[A-HJ-NP-TV-Z]{2,3}$');

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!_letters.hasMatch(entry.group('letters'))) {
      return const PlateValidation.invalid(reasonLetters);
    }
    final String digits = entry.group('digits');
    if (!isDigits(digits) || digits.length < 3 || digits.length > 4) {
      return const PlateValidation.invalid(reasonDigits);
    }
    final String year = entry.group('year');
    if (year.isNotEmpty && !isDigitsOfLength(year, 2)) {
      return const PlateValidation.invalid(reasonYear);
    }
    return const PlateValidation.valid();
  }
}

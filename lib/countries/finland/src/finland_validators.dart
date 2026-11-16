import 'package:license_plate/core/plate_core.dart';

/// Judges a Finnish plate, field by field. Reports, never bars a keystroke.
///
/// Regular and motorcycle plates are two or three letters and one to three
/// digits not starting with 0 (`ABC-123`); the rule barring a leading P, W or
/// D is not enforced, because vanity plates may break it. Åland plates start
/// `ÅL` and take up to five digits. Export plates are one letter and up to
/// four digits. Diplomatic plates are `CD` with up to four digits or `C` with
/// up to five.
class FinlandValidator extends GatedPlateValidator {
  const FinlandValidator() : super('number');

  static final RegExp _lettersPattern = RegExp(r'^[A-ZÅÄÖ]+$');

  static const String reasonLetters =
      'The letters are two or three of A–Z, Å, Ä, Ö.';
  static const String reasonNumber =
      'The number is one to three digits, not starting with 0.';
  static const String reasonAland = 'The Åland number is up to five digits.';
  static const String reasonExport = 'The export number is up to four digits.';
  static const String reasonCode = 'The prefix is C or CD.';
  static const String reasonDiplomatic =
      'CD takes up to four digits, C up to five.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final String number = entry.group('number'), code = entry.group('code');
    if (code.isNotEmpty) {
      if (code != 'C' && code != 'CD') {
        return const PlateValidation.invalid(reasonCode);
      }
      final int max = code == 'C' ? 5 : 4;
      if (!isDigits(number) || number.length > max) {
        return const PlateValidation.invalid(reasonDiplomatic);
      }
      return const PlateValidation.valid();
    }
    final String letters = entry.group('letters');
    if (!_lettersPattern.hasMatch(letters)) {
      return const PlateValidation.invalid(reasonLetters);
    }
    if (letters.length == 1) {
      if (!isDigits(number) || number.length > 4) {
        return const PlateValidation.invalid(reasonExport);
      }
      return const PlateValidation.valid();
    }
    if (letters.length > 3) {
      return const PlateValidation.invalid(reasonLetters);
    }
    if (letters.startsWith('ÅL')) {
      if (!isDigits(number) || number.length > 5) {
        return const PlateValidation.invalid(reasonAland);
      }
      return const PlateValidation.valid();
    }
    if (!isDigits(number) || number.length > 3 || number.startsWith('0')) {
      return const PlateValidation.invalid(reasonNumber);
    }
    return const PlateValidation.valid();
  }
}

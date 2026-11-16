import 'package:license_plate/core/plate_core.dart';

/// A registration is three letters, two digits and a digit or letter; a dealer
/// plate is three letters and three digits; a diplomatic plate is a two-letter
/// mission code, three digits and a status letter A-I; a military plate is
/// four to six digits. Reports, never bars a keystroke; the one refusal is the
/// diplomatic spec's restriction.
class SwedenValidator extends GatedPlateValidator {
  const SwedenValidator() : super('number');

  static const String reasonLetters =
      'The letters are three, none of I, Q, V, Å, Ä, Ö.';
  static const String reasonNumber =
      'The number is two digits and a digit or a letter (not O).';
  static const String reasonDigits = 'The number is three digits.';
  static const String reasonCode =
      'The mission code is two letters (no I, O, Q, V).';
  static const String reasonStatus = 'The status letter is A to I.';
  static const String reasonMilitary = 'The number is four to six digits.';

  static final RegExp _letters = RegExp(r'^[A-HJ-PR-UW-Z]{3}$');
  static final RegExp _last = RegExp(r'^[0-9]{2}[0-9A-HJ-NPR-UW-Z]$');
  static final RegExp _mission = RegExp(r'^[A-HJ-NPR-UW-Z]{2}$');
  static final RegExp _status = RegExp(r'^[A-I]$');

  @override
  PlateValidation judge(PlateEntry entry) {
    final String number = entry.group('number'), code = entry.group('code');
    if (code.isNotEmpty) {
      if (!_mission.hasMatch(code)) {
        return const PlateValidation.invalid(reasonCode);
      }
      if (!isDigitsOfLength(number, 3)) {
        return const PlateValidation.invalid(reasonDigits);
      }
      if (!_status.hasMatch(entry.group('status'))) {
        return const PlateValidation.invalid(reasonStatus);
      }
      return const PlateValidation.valid();
    }
    final String letters = entry.group('letters');
    if (letters.isEmpty) {
      if (!isDigits(number) || number.length < 4 || number.length > 6) {
        return const PlateValidation.invalid(reasonMilitary);
      }
      return const PlateValidation.valid();
    }
    if (!_letters.hasMatch(letters)) {
      return const PlateValidation.invalid(reasonLetters);
    }
    // Dealer plates (three digits) and registrations (two digits and a last
    // character) both pass; the temporary plate's last field is a letter.
    if (!isDigitsOfLength(number, 3) && !_last.hasMatch(number)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    return const PlateValidation.valid();
  }
}

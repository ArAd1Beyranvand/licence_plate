import 'package:license_plate/core/plate_core.dart';

import 'ethiopia_missions.dart';

bool _letters(String s, int n) => RegExp('^[A-Z]{$n}\$').hasMatch(s);

/// Judges the 2026 private plate: six digits. Reports, never bars a keystroke.
class EthiopiaValidator extends GatedPlateValidator {
  const EthiopiaValidator() : super('number');

  static const String reasonNumber = 'The number is six digits.';

  @override
  PlateValidation judge(PlateEntry entry) =>
      isDigitsOfLength(entry.group('number'), 6)
      ? const PlateValidation.valid()
      : const PlateValidation.invalid(reasonNumber);
}

/// Judges the regional plate: a one-digit class, two Ge'ez letters, six digits
/// and the two-letter Latin region code.
class EthiopiaRegionalValidator extends GatedPlateValidator {
  const EthiopiaRegionalValidator() : super('code');

  static const String reasonClass = 'The class is one digit.';
  static const String reasonGeez = 'The region is two Ge\'ez letters.';
  static const String reasonNumber = 'The number is six digits.';
  static const String reasonCode = 'The region code is two letters.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!isDigitsOfLength(entry.group('class'), 1)) {
      return const PlateValidation.invalid(reasonClass);
    }
    if (entry.group('geez').runes.length != 2) {
      return const PlateValidation.invalid(reasonGeez);
    }
    if (!isDigitsOfLength(entry.group('number'), 6)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    if (!_letters(entry.group('code'), 2)) {
      return const PlateValidation.invalid(reasonCode);
    }
    return const PlateValidation.valid();
  }
}

/// Judges the diplomatic plate: a two-digit mission code, two Ge'ez letters,
/// four digits and the two-letter type. Refuses code `84` on its own account,
/// so it holds even against a spec built without [EthiopiaMissions.restriction].
class EthiopiaDiplomaticValidator extends GatedPlateValidator {
  const EthiopiaDiplomaticValidator() : super('type');

  static const String reasonMission = 'The mission code is two digits.';
  static const String reasonGeez = 'The series is two Ge\'ez letters.';
  static const String reasonNumber = 'The number is four digits.';
  static const String reasonType = 'The type is two letters.';

  @override
  PlateValidation validate(PlateEntry entry) {
    if (EthiopiaMissions.isRefused(entry.group('mission'))) {
      return const PlateValidation.invalid(EthiopiaMissions.notFound);
    }
    return super.validate(entry);
  }

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!isDigitsOfLength(entry.group('mission'), 2)) {
      return const PlateValidation.invalid(reasonMission);
    }
    if (entry.group('series').runes.length != 2) {
      return const PlateValidation.invalid(reasonGeez);
    }
    if (!isDigitsOfLength(entry.group('number'), 4)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    if (!_letters(entry.group('type'), 2)) {
      return const PlateValidation.invalid(reasonType);
    }
    return const PlateValidation.valid();
  }
}

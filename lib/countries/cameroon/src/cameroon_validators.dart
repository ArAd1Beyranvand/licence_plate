import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

/// Judges a regular plate (`LT 128 AB`): region code, three or four digits,
/// one- or two-letter series. Reports, never bars a keystroke.
class CameroonValidator extends GatedPlateValidator {
  const CameroonValidator() : super('number');

  static const Set<String> regions = <String>{
    'AD', 'CE', 'EN', 'ES', 'LT', 'NO', 'NW', 'OU', 'SU', 'SW', //
  };

  static const String reasonRegion =
      'The region is one of the ten region codes.';
  static const String reasonNumber = 'The number is three or four digits.';
  static const String reasonSeries = 'The series is one or two letters.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!regions.contains(entry.group('region'))) {
      return const PlateValidation.invalid(reasonRegion);
    }
    final String number = entry.group('number');
    if (!isDigitsOfLength(number, 3) && !isDigitsOfLength(number, 4)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    final String series = entry.group('series');
    if (series.isEmpty ||
        series.length > 2 ||
        !series
            .split('')
            .every(CameroonAlphabets.letters.characters.contains)) {
      return const PlateValidation.invalid(reasonSeries);
    }
    return const PlateValidation.valid();
  }
}

/// Judges a diplomatic plate (`CMD 38 2`): `CM`, `D`, a two-digit mission code
/// and a one-digit suffix. Only digit counts are checked; how codes split
/// across the cells is undocumented.
class CameroonDiplomaticValidator extends GatedPlateValidator {
  const CameroonDiplomaticValidator() : super('number');

  static const String reasonPrefix = 'The prefix is CMD.';
  static const String reasonNumber = 'The mission code is two digits.';
  static const String reasonSuffix = 'The suffix is one digit.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (entry.group('mission') != 'CM' || entry.group('type') != 'D') {
      return const PlateValidation.invalid(reasonPrefix);
    }
    if (!isDigitsOfLength(entry.group('number'), 2)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    if (!isDigitsOfLength(entry.group('suffix'), 1)) {
      return const PlateValidation.invalid(reasonSuffix);
    }
    return const PlateValidation.valid();
  }
}

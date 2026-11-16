import 'package:license_plate/core/plate_core.dart';

/// Judges an Order of Malta plate: the prefix `SMOM` and a two-digit number.
/// Reports, never bars a keystroke. The article gives no number range; two
/// digits is what the one photographed plate shows.
class SovereignMilitaryOrderOfMaltaValidator extends GatedPlateValidator {
  const SovereignMilitaryOrderOfMaltaValidator() : super('number');

  static const String reasonPrefix = 'The prefix is SMOM.';
  static const String reasonNumber = 'The number is two digits.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (entry.group('prefix') != 'SMOM') {
      return const PlateValidation.invalid(reasonPrefix);
    }
    if (!isDigitsOfLength(entry.group('number'), 2)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    return const PlateValidation.valid();
  }
}

import 'package:license_plate/core/plate_core.dart';

/// Judges a 2011 plate: three letters, three digits, two letters
/// (`GGE-123ZY`). Reports, never bars a keystroke.
///
/// The article gives no format; the references (Lagos, Anambra, Kaduna,
/// Benue, Sokoto…) all print letters-digits-letters as 3-3-2. Plates of Kogi
/// and Niger mix letters and digits in the first field and are not modelled.
class NigeriaValidator extends GatedPlateValidator {
  const NigeriaValidator() : super('suffix');

  static const String reasonArea = 'The area code is three letters.';
  static const String reasonSerial = 'The number is three digits.';
  static const String reasonSuffix = 'The suffix is two letters.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!RegExp(r'^[A-Z]{3}$').hasMatch(entry.group('area'))) {
      return const PlateValidation.invalid(reasonArea);
    }
    if (!isDigitsOfLength(entry.group('serial'), 3)) {
      return const PlateValidation.invalid(reasonSerial);
    }
    if (!RegExp(r'^[A-Z]{2}$').hasMatch(entry.group('suffix'))) {
      return const PlateValidation.invalid(reasonSuffix);
    }
    return const PlateValidation.valid();
  }
}

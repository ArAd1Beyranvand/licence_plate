import 'package:license_plate/core/plate_core.dart';

/// Judges a Fijian plate: letters then digits (`AA 001`, `E 0845`) or, for a
/// motorcycle, digits then a letter (`001 A`). Reports, never bars a keystroke.
class FijiValidator extends GatedPlateValidator {
  const FijiValidator() : super('serial');

  static const String reasonLetters = 'The register is one or two letters.';
  static const String reasonSerial = 'The number is three or four digits.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final String letters = entry.group('letters');
    if (!RegExp(r'^[A-Z]{1,2}$').hasMatch(letters)) {
      return const PlateValidation.invalid(reasonLetters);
    }
    final String serial = entry.group('serial');
    if (!isDigits(serial) || serial.length < 3 || serial.length > 4) {
      return const PlateValidation.invalid(reasonSerial);
    }
    return const PlateValidation.valid();
  }
}

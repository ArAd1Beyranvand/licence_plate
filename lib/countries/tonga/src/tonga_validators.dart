import 'package:license_plate/core/plate_core.dart';

/// Judges a plate: a vehicle-type letter (two for `MC`) and one to five digits
/// (`C 12345`). Reports, never bars a keystroke.
class TongaValidator extends GatedPlateValidator {
  const TongaValidator() : super('serial');

  static const String reasonLetters = 'The register is one or two letters.';
  static const String reasonSerial = 'The number is one to five digits.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!RegExp(r'^[A-Z]{1,2}$').hasMatch(entry.group('letters'))) {
      return const PlateValidation.invalid(reasonLetters);
    }
    if (!RegExp(r'^[0-9]{1,5}$').hasMatch(entry.group('serial'))) {
      return const PlateValidation.invalid(reasonSerial);
    }
    return const PlateValidation.valid();
  }
}

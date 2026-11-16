import 'package:license_plate/core/plate_core.dart';

/// Requires exactly three digits. Reports, never bars a keystroke.
class DominicaValidator extends GatedPlateValidator {
  const DominicaValidator() : super('serial');

  static const String reasonSerial = 'The number is three digits.';

  @override
  PlateValidation judge(PlateEntry entry) {
    return isDigitsOfLength(entry.group('serial'), 3)
        ? const PlateValidation.valid()
        : const PlateValidation.invalid(reasonSerial);
  }
}

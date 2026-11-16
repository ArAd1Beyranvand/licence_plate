import 'package:license_plate/core/plate_core.dart';

/// Judges a Marshallese plate by its `serial` group: four digits on the
/// Majuro Atoll plate, one to three on the 1972 plate (both fit one to four).
/// Reports, never bars a keystroke.
class MarshallIslandsValidator extends GatedPlateValidator {
  const MarshallIslandsValidator() : super('serial');

  static const String reasonSerial = 'The number is one to four digits.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final String serial = entry.group('serial');
    if (!isDigits(serial) || serial.length > 4) {
      return const PlateValidation.invalid(reasonSerial);
    }
    return const PlateValidation.valid();
  }
}

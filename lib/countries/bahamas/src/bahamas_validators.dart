import 'package:license_plate/core/plate_core.dart';

final RegExp _letter = RegExp(r'^[A-Z]$');

/// Judges a Bahamian registration: an optional class letter (`prefix`, the
/// `T` of the truck series) and a numeric `serial` of up to five digits.
/// Reports, never bars a keystroke. The 2016 format has no photograph and is
/// not modelled.
class BahamasValidator extends GatedPlateValidator {
  const BahamasValidator() : super('serial');

  static const int maxSerial = 5;

  static const String reasonSerial = 'The serial is one to five digits.';
  static const String reasonPrefix = 'The class prefix is one letter.';

  @override
  PlateValidation judge(PlateEntry entry) => validateFields(
    prefix: entry.group('prefix'),
    serial: entry.group('serial'),
  );

  static PlateValidation validateFields({
    required String prefix,
    required String serial,
  }) {
    if (prefix.isNotEmpty && !_letter.hasMatch(prefix)) {
      return const PlateValidation.invalid(reasonPrefix);
    }
    if (!isDigits(serial) || serial.length > maxSerial) {
      return const PlateValidation.invalid(reasonSerial);
    }
    return const PlateValidation.valid();
  }
}

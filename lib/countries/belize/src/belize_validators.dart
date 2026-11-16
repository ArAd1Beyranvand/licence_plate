import 'package:license_plate/core/plate_core.dart';

/// Judges a Belizean registration: a `prefix` of one letter (class or
/// district: `C`, `A`, `D`) or three (the defence ministry's `DFS`), absent on
/// auto-dealer plates, and a numeric `serial`. The article gives the formats
/// `A-1234`, `A-12345`, `ABC-123` and `12345`; the pictures show three to five
/// digits (`A-816` on a truck plate), so the serial is three to five.
/// Reports, never bars a keystroke.
class BelizeValidator extends GatedPlateValidator {
  const BelizeValidator() : super('serial');

  static const int minSerial = 3, maxSerial = 5, maxPrefix = 3;
  static final RegExp _prefix = RegExp('^[A-Z]{1,$maxPrefix}\$');

  static const String reasonSerial = 'The serial is three to five digits.';
  static const String reasonPrefix = 'The prefix is one to three letters.';

  @override
  PlateValidation judge(PlateEntry entry) => validateFields(
    prefix: entry.group('prefix'),
    serial: entry.group('serial'),
  );

  static PlateValidation validateFields({
    required String prefix,
    required String serial,
  }) {
    if (prefix.isNotEmpty && !_prefix.hasMatch(prefix)) {
      return const PlateValidation.invalid(reasonPrefix);
    }
    if (!isDigits(serial) ||
        serial.length < minSerial ||
        serial.length > maxSerial) {
      return const PlateValidation.invalid(reasonSerial);
    }
    return const PlateValidation.valid();
  }
}

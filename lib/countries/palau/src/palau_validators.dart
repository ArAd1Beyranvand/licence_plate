import 'package:license_plate/core/plate_core.dart';

/// Judges a Palauan registration. Reports, never bars a keystroke.
///
/// The article gives no format except the odd example (`A 123`, `1234`,
/// `K79-123`, `BNM-1234`, `PICRC-12`), so this checks only what the plates
/// show: optional `letters` (one to three capitals), an optional two-digit
/// `code`, and a run of one to five `digits`, or a single mixed `serial`
/// (Koror's black plate, `2K5136`).
class PalauValidator extends PlateValidator {
  const PalauValidator();

  static const String reasonLetters = 'The letters are one to three capitals.';
  static const String reasonCode = 'The code is two digits.';
  static const String reasonDigits = 'The number is one to five digits.';
  static const String reasonSerial =
      'The serial is up to eight letters and digits.';

  static final RegExp _letters = RegExp(r'^[A-Z]{1,3}$');
  static final RegExp _serial = RegExp(r'^[A-Z0-9]{1,8}$');

  @override
  PlateValidation validate(PlateEntry entry) {
    final PlateValidation? refused = restrictionVerdict(entry);
    if (refused != null) return refused;
    final String digits = entry.group('digits'), serial = entry.group('serial');
    if (digits.isEmpty && serial.isEmpty) return const PlateValidation.valid();
    final String letters = entry.group('letters');
    if (letters.isNotEmpty && !_letters.hasMatch(letters)) {
      return const PlateValidation.invalid(reasonLetters);
    }
    final String code = entry.group('code');
    if (code.isNotEmpty && !isDigitsOfLength(code, 2)) {
      return const PlateValidation.invalid(reasonCode);
    }
    if (digits.isNotEmpty && (!isDigits(digits) || digits.length > 5)) {
      return const PlateValidation.invalid(reasonDigits);
    }
    if (serial.isNotEmpty && !_serial.hasMatch(serial)) {
      return const PlateValidation.invalid(reasonSerial);
    }
    return const PlateValidation.valid();
  }
}

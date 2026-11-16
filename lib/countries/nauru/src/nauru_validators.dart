import 'package:license_plate/core/plate_core.dart';

/// Judges a Nauruan plate by its groups: `letters` (three) with `serial`
/// (three digits) on the 2015 plate, `serial` alone (four digits) on the
/// 1975 plate, `prefix` (one digit) with `serial` (three) on the 1970 plate.
/// Reports, never bars a keystroke.
class NauruValidator extends GatedPlateValidator {
  const NauruValidator() : super('serial');

  static const String reasonLetters = 'The register is three letters.';
  static const String reasonPrefix = 'The prefix is one digit.';
  static const String reasonSerial = 'The number has the wrong digit count.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final String letters = entry.group('letters');
    final String prefix = entry.group('prefix'), serial = entry.group('serial');
    final bool hasLetters = letters.isNotEmpty, hasPrefix = prefix.isNotEmpty;
    if (hasLetters && !RegExp(r'^[A-Z]{3}$').hasMatch(letters)) {
      return const PlateValidation.invalid(reasonLetters);
    }
    if (hasPrefix && !isDigitsOfLength(prefix, 1)) {
      return const PlateValidation.invalid(reasonPrefix);
    }
    final int digits = hasLetters || hasPrefix ? 3 : 4;
    if (!isDigitsOfLength(serial, digits)) {
      return const PlateValidation.invalid(reasonSerial);
    }
    return const PlateValidation.valid();
  }
}

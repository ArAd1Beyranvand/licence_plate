import 'package:license_plate/core/plate_core.dart';

/// Judges a Kiribati plate by its groups: `letters` (three) and `serial`
/// (three digits), `ABC 123`. Reports, never bars a keystroke.
class KiribatiValidator extends GatedPlateValidator {
  const KiribatiValidator() : super('serial');

  static const String reasonLetters = 'The register is three letters.';
  static const String reasonSerial = 'The number is three digits.';

  static final RegExp _letters = RegExp(r'^[A-Z]{3}$');

  @override
  PlateValidation judge(PlateEntry entry) {
    final letters = entry.group('letters');
    if (letters.isNotEmpty && !_letters.hasMatch(letters)) {
      return const PlateValidation.invalid(reasonLetters);
    }
    if (!isDigitsOfLength(entry.group('serial'), 3)) {
      return const PlateValidation.invalid(reasonSerial);
    }
    return const PlateValidation.valid();
  }
}

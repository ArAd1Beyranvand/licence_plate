import 'package:license_plate/core/plate_core.dart';

/// Judges a Tuvalu plate by its groups: `letters` (two) and `serial` (four
/// digits), `AB 1234`. Reports, never bars a keystroke.
class TuvaluValidator extends GatedPlateValidator {
  const TuvaluValidator() : super('serial');

  static const String reasonLetters = 'The register is two letters.';
  static const String reasonSerial = 'The number is four digits.';

  static final RegExp _letters = RegExp(r'^[A-Z]{2}$');

  @override
  PlateValidation judge(PlateEntry entry) {
    if (entry.group('letters').isNotEmpty &&
        !_letters.hasMatch(entry.group('letters'))) {
      return const PlateValidation.invalid(reasonLetters);
    }
    if (!isDigitsOfLength(entry.group('serial'), 4)) {
      return const PlateValidation.invalid(reasonSerial);
    }
    return const PlateValidation.valid();
  }
}

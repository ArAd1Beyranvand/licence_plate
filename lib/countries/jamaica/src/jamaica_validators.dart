import 'package:license_plate/core/plate_core.dart';

/// Judges a Jamaican private registration: a `serial` of four digits and
/// `letters` of one to two (one for motorcycles). Reports, never bars a
/// keystroke.
class JamaicaValidator extends GatedPlateValidator {
  const JamaicaValidator() : super('serial');

  static const int serialLength = 4, minLetters = 1, maxLetters = 2;

  static const String reasonSerial = 'The serial is four digits.';
  static const String reasonLetters = 'The series is one or two letters.';

  @override
  PlateValidation judge(PlateEntry entry) => validateFields(
    serial: entry.group('serial'),
    letters: entry.group('letters'),
  );

  static PlateValidation validateFields({
    required String serial,
    required String letters,
  }) {
    if (!isDigitsOfLength(serial, serialLength)) {
      return const PlateValidation.invalid(reasonSerial);
    }
    if (!RegExp('^[A-Z]{$minLetters,$maxLetters}\$').hasMatch(letters)) {
      return const PlateValidation.invalid(reasonLetters);
    }
    return const PlateValidation.valid();
  }
}

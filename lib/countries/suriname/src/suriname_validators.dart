import 'package:license_plate/core/plate_core.dart';

/// Judges a plate: two letters, the first always `P`, and four digits
/// (`PA 1234`). Reports, never bars a keystroke.
class SurinameValidator extends RuledPlateValidator {
  const SurinameValidator();

  static const String reasonLetters =
      'The register is two letters, the first one P.';
  static const String reasonSerial = 'The number is four digits.';

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('letters', r'P[A-Z]', reasonLetters),
    PlateCheck('serial', r'[0-9]{4}', reasonSerial),
  ];
}

import 'package:license_plate/core/plate_core.dart';

/// Judges a 2017 plate: three digits, then one or two letters (`560 AT`).
/// Reports, never bars a keystroke.
class SouthSudanValidator extends RuledPlateValidator {
  const SouthSudanValidator();

  static const String reasonSerial = 'The number is three digits.';
  static const String reasonLetters = 'The register is one or two letters.';

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('serial', r'[0-9]{3}', reasonSerial),
    PlateCheck('letters', r'[A-Z]{1,2}', reasonLetters),
  ];
}

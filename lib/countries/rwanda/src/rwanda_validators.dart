import 'package:license_plate/core/plate_core.dart';

/// Judges a plate `RXX ###X`: a register of three letters starting with `R`,
/// then three digits and a letter. Reports, never bars a keystroke.
class RwandaValidator extends RuledPlateValidator {
  const RwandaValidator();

  static const String reasonRegister =
      'The register is three letters starting with R.';
  static const String reasonSerial = 'The number is three digits and a letter.';

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('register', r'R[A-Z]{2}', reasonRegister),
    PlateCheck('serial', r'[0-9]{3}[A-Z]', reasonSerial),
  ];
}

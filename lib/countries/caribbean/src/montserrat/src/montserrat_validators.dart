import 'package:license_plate/core/plate_core.dart';

/// Judges a Montserrat plate: a type letter and one to four digits (`M 1667`).
/// Reports, never bars a keystroke.
class MontserratValidator extends RuledPlateValidator {
  const MontserratValidator();

  static const String reasonType = 'The type is one letter.';
  static const String reasonSerial = 'The number is one to four digits.';

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('type', r'[A-Z]', reasonType),
    PlateCheck('serial', r'[0-9]{1,4}', reasonSerial),
  ];
}

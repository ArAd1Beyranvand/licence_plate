import 'package:license_plate/core/plate_core.dart';

/// Judges a plate (`S 11111`): one letter and up to five digits. The tag of
/// the plate since 2018 is not judged. Reports, never bars a keystroke.
class SeychellesValidator extends RuledPlateValidator {
  const SeychellesValidator();

  static const String reasonLetter = 'The series is one letter.';
  static const String reasonSerial = 'The number is one to five digits.';

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('letter', r'[A-Z]', reasonLetter),
    PlateCheck('serial', r'[0-9]{1,5}', reasonSerial),
  ];
}

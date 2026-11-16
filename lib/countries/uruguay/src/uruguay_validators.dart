import 'package:license_plate/core/plate_core.dart';

/// Judges a Uruguayan serial `A BC 1234`: three letters in `first`, the first
/// a department code (A to S), and one to four digits in `number` (the
/// President of a Departmental Assembly's plate carries one).
///
/// The category letters are not checked. Reports, never bars a keystroke.
class UruguayValidator extends RuledPlateValidator {
  const UruguayValidator();

  static const String reasonLetters =
      'A serial is three letters, the first a department code (A to S).';
  static const String reasonNumber = 'The number is one to four digits.';

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('first', r'[A-S][A-Z]{2}', reasonLetters),
    PlateCheck('number', r'[0-9]{1,4}', reasonNumber),
  ];
}

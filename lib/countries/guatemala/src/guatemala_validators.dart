import 'package:license_plate/core/plate_core.dart';

/// Judges a Guatemalan serial `P 123 ABC`: a class letter, three digits and
/// three letters. The class letter is not checked beyond being a letter.
///
/// Reports, never bars a keystroke.
class GuatemalaValidator extends RuledPlateValidator {
  const GuatemalaValidator();

  static const String reasonClass = 'The class is one letter, such as P or C.';
  static const String reasonDigits = 'The number is three digits.';
  static const String reasonLetters = 'The serial ends in three letters.';

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('class', r'[A-Z]', reasonClass),
    PlateCheck('digits', r'[0-9]{3}', reasonDigits),
    PlateCheck('letters', r'[A-Z]{3}', reasonLetters),
  ];
}

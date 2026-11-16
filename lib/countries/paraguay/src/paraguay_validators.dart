import 'package:license_plate/core/plate_core.dart';

/// Judges a Paraguayan Mercosur serial `AAAA 123`: four letters in `letters`
/// and three digits in `number`. (Motorcycles print `123 ABC`; not modelled.)
///
/// Reports, never bars a keystroke.
class ParaguayValidator extends RuledPlateValidator {
  const ParaguayValidator();

  static const String reasonLetters = 'The series is four letters.';
  static const String reasonNumber = 'The number is three digits.';

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('letters', r'[A-Z]{4}', reasonLetters),
    PlateCheck('number', r'[0-9]{3}', reasonNumber),
  ];
}

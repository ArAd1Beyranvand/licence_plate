import 'package:license_plate/core/plate_core.dart';

/// Advisory validator for `A 1705`: one or two letters, four digits.
class LesothoValidator extends RuledPlateValidator {
  const LesothoValidator();

  static const String reasonLetters = 'The prefix is one or two letters.';
  static const String reasonSerial = 'The number is four digits.';

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('letters', r'[A-Z]{1,2}', reasonLetters),
    PlateCheck('serial', r'[0-9]{4}', reasonSerial),
  ];
}

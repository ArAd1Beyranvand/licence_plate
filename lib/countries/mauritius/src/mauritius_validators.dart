import 'package:license_plate/core/plate_core.dart';

/// Judges a government plate (`GM 3345`): two letters and four digits.
/// Reports, never bars a keystroke.
class MauritiusValidator extends RuledPlateValidator {
  const MauritiusValidator();

  static const String reasonLetters = 'The prefix is two letters.';
  static const String reasonSerial = 'The number is four digits.';

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('letters', r'[A-Z]{2}', reasonLetters),
    PlateCheck('serial', r'[0-9]{4}', reasonSerial),
  ];
}

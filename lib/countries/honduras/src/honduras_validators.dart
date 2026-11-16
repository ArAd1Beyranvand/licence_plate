import 'package:license_plate/core/plate_core.dart';

/// Judges a 2018 plate: a class letter (`H`; `B` for motorcycles), two series
/// letters and four digits (`HAB 0123`). Reports, never bars a keystroke.
class HondurasValidator extends GatedPlateValidator {
  const HondurasValidator() : super('serial');

  static const String reasonClass = 'The class is one letter.';
  static const String reasonSeries = 'The series is two letters.';
  static const String reasonSerial = 'The number is four digits.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!RegExp(r'^[A-Z]$').hasMatch(entry.group('class'))) {
      return const PlateValidation.invalid(reasonClass);
    }
    if (!RegExp(r'^[A-Z]{2}$').hasMatch(entry.group('series'))) {
      return const PlateValidation.invalid(reasonSeries);
    }
    if (!isDigitsOfLength(entry.group('serial'), 4)) {
      return const PlateValidation.invalid(reasonSerial);
    }
    return const PlateValidation.valid();
  }
}

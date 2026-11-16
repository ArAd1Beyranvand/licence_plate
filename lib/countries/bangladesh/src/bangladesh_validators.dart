import 'package:license_plate/core/plate_core.dart';

/// Judges a Bangladeshi car plate: city, class letter, a two-digit series of
/// 11–99 and a four-digit number from 0001. Quiet until the number has
/// something in it. Reports, never bars a keystroke.
class BangladeshValidator extends GatedPlateValidator {
  const BangladeshValidator() : super('number');

  @override
  PlateValidation judge(PlateEntry entry) {
    if (entry.group('city').isEmpty) {
      return const PlateValidation.invalid('Choose a city.');
    }
    if (entry.group('class').isEmpty) {
      return const PlateValidation.invalid('Choose a vehicle class letter.');
    }
    final String series = entry.group('series');
    if (!isDigitsOfLength(series, 2) || int.parse(series) < 11) {
      return const PlateValidation.invalid('The series is 11 to 99.');
    }
    final String number = entry.group('number');
    if (!isDigitsOfLength(number, 4) || number == '0000') {
      return const PlateValidation.invalid('The number is 0001 to 9999.');
    }
    return const PlateValidation.valid();
  }
}

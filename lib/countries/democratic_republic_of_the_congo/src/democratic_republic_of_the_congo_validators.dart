import 'package:license_plate/core/plate_core.dart';

import 'democratic_republic_of_the_congo_regions.dart';

/// Judges a private plate: `1234 AB 10` — four digits, two letters and a
/// province code 01–26. Reports, never bars input.
class DemocraticRepublicOfTheCongoValidator extends GatedPlateValidator {
  const DemocraticRepublicOfTheCongoValidator() : super('province');

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!isDigitsOfLength(entry.group('number'), 4)) {
      return const PlateValidation.invalid('The number is 4 digits.');
    }
    if (!RegExp(r'^[A-Z]{2}$').hasMatch(entry.group('series'))) {
      return const PlateValidation.invalid('The series is 2 letters.');
    }
    if (DemocraticRepublicOfTheCongoRegions.lookup(entry.group('province')) ==
        null) {
      return const PlateValidation.invalid('The province code is 01 to 26.');
    }
    return const PlateValidation.valid();
  }
}

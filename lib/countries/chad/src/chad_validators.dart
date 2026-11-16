import 'package:license_plate/core/plate_core.dart';

final RegExp _letter = RegExp(r'^[A-Z]$');

/// Judges a Chadian plate: `12 V 3456 B` — region 01–23, a vehicle-type
/// letter, a four-digit number and a series letter. Temporary plates end in
/// `TT` instead of the series letter. Reports, never bars a keystroke.
class ChadValidator extends GatedPlateValidator {
  const ChadValidator() : super('number');

  @override
  PlateValidation judge(PlateEntry entry) {
    final int? region = int.tryParse(entry.group('region'));
    if (!isDigitsOfLength(entry.group('region'), 2) ||
        region == null ||
        region < 1 ||
        region > 23) {
      return const PlateValidation.invalid('The region is 01 to 23.');
    }
    if (!_letter.hasMatch(entry.group('type'))) {
      return const PlateValidation.invalid(
        'The vehicle type is 1 letter (B, C, M, P, S, T, V).',
      );
    }
    if (!isDigitsOfLength(entry.group('number'), 4)) {
      return const PlateValidation.invalid('The number is 4 digits.');
    }
    final String tail = entry.group('tail');
    if (tail.isNotEmpty && !_letter.hasMatch(tail) && tail != 'TT') {
      return const PlateValidation.invalid(
        'The series is 1 letter, or TT on a temporary plate.',
      );
    }
    return const PlateValidation.valid();
  }
}

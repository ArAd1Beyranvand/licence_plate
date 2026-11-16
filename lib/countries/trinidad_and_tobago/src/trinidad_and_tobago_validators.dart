import 'package:license_plate/core/plate_core.dart';

/// Judges a Trinidad and Tobago plate field by field: one to three series
/// letters (the first is the vehicle class) and one to four digits. I, O, Q and
/// V are never issued in a series. Quiet until the letters have something in
/// them. Reports, never bars a keystroke.
class TrinidadAndTobagoValidator extends PlateValidator {
  const TrinidadAndTobagoValidator();

  static final RegExp _letters = RegExp(r'^[A-HJ-NP-UW-Z]{1,3}$');
  static final RegExp _digits = RegExp(r'^[0-9]{1,4}$');

  @override
  PlateValidation validate(PlateEntry entry) {
    final PlateValidation? refused = restrictionVerdict(entry);
    if (refused != null) return refused;
    if (entry.group('letters').isEmpty) return const PlateValidation.valid();
    if (!_letters.hasMatch(entry.group('letters'))) {
      return const PlateValidation.invalid(
        'The series is one to three letters, never I, O, Q or V.',
      );
    }
    if (!_digits.hasMatch(entry.group('serial'))) {
      return const PlateValidation.invalid('The number is one to four digits.');
    }
    return const PlateValidation.valid();
  }
}

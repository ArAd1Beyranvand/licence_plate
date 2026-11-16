import 'package:license_plate/core/plate_core.dart';

/// Judges a Grenadian plate field by field: three letters then three digits
/// (`ABC123`). Quiet until the last field has something in it. Reports, never
/// bars a keystroke.
class GrenadaValidator extends PlateValidator {
  const GrenadaValidator();

  static final RegExp _letters = RegExp(r'^[A-Z]{3}$');
  static final RegExp _digits = RegExp(r'^[0-9]{3}$');

  @override
  PlateValidation validate(PlateEntry entry) {
    final PlateValidation? refused = restrictionVerdict(entry);
    if (refused != null) return refused;
    if (entry.group('number').isEmpty) return const PlateValidation.valid();
    if (!_letters.hasMatch(entry.group('letters'))) {
      return const PlateValidation.invalid('The series is 3 letters.');
    }
    if (!_digits.hasMatch(entry.group('number'))) {
      return const PlateValidation.invalid('The number is 3 digits.');
    }
    return const PlateValidation.valid();
  }
}

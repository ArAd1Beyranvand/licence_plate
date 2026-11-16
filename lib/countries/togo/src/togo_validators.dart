import 'package:license_plate/core/plate_core.dart';

/// Judges a Togolese plate field by field: `1234·AB`, four digits and a
/// two-letter series. Quiet until the series has something in it. Reports,
/// never bars a keystroke.
class TogoValidator extends PlateValidator {
  const TogoValidator();

  static final RegExp _digits4 = RegExp(r'^[0-9]{4}$');
  static final RegExp _letters2 = RegExp(r'^[A-Z]{2}$');

  @override
  PlateValidation validate(PlateEntry entry) {
    final PlateValidation? refused = restrictionVerdict(entry);
    if (refused != null) return refused;
    if (entry.group('series').isEmpty) return const PlateValidation.valid();
    if (!_digits4.hasMatch(entry.group('number'))) {
      return const PlateValidation.invalid('The number is 4 digits.');
    }
    if (!_letters2.hasMatch(entry.group('series'))) {
      return const PlateValidation.invalid('The series is 2 letters.');
    }
    return const PlateValidation.valid();
  }
}

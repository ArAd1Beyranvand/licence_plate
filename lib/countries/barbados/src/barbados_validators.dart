import 'package:license_plate/core/plate_core.dart';

final RegExp _digits = RegExp(r'^[0-9]{1,4}$');
final RegExp _letters = RegExp(r'^[A-Z]{1,2}$');

/// Judges a Barbadian plate: one or two letters (the parish or category code)
/// and one to four digits (`L 4159`, `MA 999`). Reports, never bars a keystroke.
class BarbadosValidator extends GatedPlateValidator {
  const BarbadosValidator() : super('digits');

  static const String reason =
      'A plate is one or two letters and one to four digits.';

  @override
  PlateValidation judge(PlateEntry entry) =>
      _digits.hasMatch(entry.group('digits')) &&
          _letters.hasMatch(entry.group('letters'))
      ? const PlateValidation.valid()
      : const PlateValidation.invalid(reason);
}

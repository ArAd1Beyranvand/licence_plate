import 'package:license_plate/core/plate_core.dart';

/// Judges a plate: the `P` prefix, optionally with a second letter (`P(A)`
/// since 1997), and one to four digits. Reports, never bars a keystroke.
class SaintKittsAndNevisValidator extends GatedPlateValidator {
  const SaintKittsAndNevisValidator() : super('digits');

  static const String reason =
      'A plate is one or two letters and one to four digits.';

  static final RegExp _digits = RegExp(r'^[0-9]{1,4}$');
  static final RegExp _letters = RegExp(r'^[A-Z]{1,2}$');

  @override
  PlateValidation judge(PlateEntry entry) =>
      _digits.hasMatch(entry.group('digits')) &&
          _letters.hasMatch(entry.group('letters'))
      ? const PlateValidation.valid()
      : const PlateValidation.invalid(reason);
}

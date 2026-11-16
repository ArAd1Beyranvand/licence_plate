import 'package:license_plate/core/plate_core.dart';

/// Judges a Saint Lucian plate: a one to three letter prefix (`P`, `PA`, `TX`,
/// `M`, `DM`, `SLG`, `MP`) and one to four digits. Reports, never bars a
/// keystroke; the per-category prefix and digit limits are not enforced.
class SaintLuciaValidator extends GatedPlateValidator {
  const SaintLuciaValidator() : super('digits');

  static const String reason =
      'A plate is a one to three letter prefix and one to four digits.';

  static final RegExp _digits = RegExp(r'^[0-9]{1,4}$');
  static final RegExp _letters = RegExp(r'^[A-Z]{1,3}$');

  @override
  PlateValidation judge(PlateEntry entry) =>
      _digits.hasMatch(entry.group('digits')) &&
          _letters.hasMatch(entry.group('letters'))
      ? const PlateValidation.valid()
      : const PlateValidation.invalid(reason);
}

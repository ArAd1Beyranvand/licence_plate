import 'package:license_plate/core/plate_core.dart';

/// Judges an Andorran plate by its groups. Reports, never bars a keystroke.
///
/// A standard plate is one letter and four digits (`L 3705`). A temporary plate
/// is `MT`, four digits and an expiry month (a Roman numeral, I to XII) and
/// two-digit year.
class AndorraValidator extends GatedPlateValidator {
  const AndorraValidator() : super('digits');

  static const String reasonStandard = 'A plate is one letter and four digits.';
  static const String reasonTemporary =
      'A temporary plate is four digits, a month (I to XII) and a year.';

  static final RegExp _month = RegExp(r'^(I{1,3}|IV|IX|VI{0,3}|XI{0,2})$');
  static final RegExp _letter = RegExp(r'^[A-Z]$');

  @override
  PlateValidation judge(PlateEntry entry) {
    final String digits = entry.group('digits'), month = entry.group('month');
    if (month.isNotEmpty || entry.group('year').isNotEmpty) {
      return isDigitsOfLength(digits, 4) &&
              _month.hasMatch(month) &&
              isDigitsOfLength(entry.group('year'), 2)
          ? const PlateValidation.valid()
          : const PlateValidation.invalid(reasonTemporary);
    }
    return isDigitsOfLength(digits, 4) &&
            _letter.hasMatch(entry.group('letter'))
        ? const PlateValidation.valid()
        : const PlateValidation.invalid(reasonStandard);
  }
}

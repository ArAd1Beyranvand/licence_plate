import 'package:license_plate/core/plate_core.dart';

/// Judges a Latvian plate, field by field. Reports, never bars a keystroke.
///
/// Ordinary, taxi and electric plates are two letters and one to four digits;
/// diplomatic plates are
/// `CD` (or `C`) and four digits whose first two name the mission.
class LatviaValidator extends PlateValidator {
  const LatviaValidator();

  static const String reasonRegular = 'Two letters, then one to four digits.';
  static const String reasonDiplomatic = 'CD, then four digits.';

  @override
  PlateValidation validate(PlateEntry entry) {
    final PlateValidation? refused = restrictionVerdict(entry);
    if (refused != null) return refused;
    final String letters = entry.group('letters');
    final String number = entry.group('number');
    if (letters.isEmpty || number.isEmpty) return const PlateValidation.valid();
    final String id = entry.spec.id;
    if (id == 'lv.diplomatic') {
      return (letters == 'CD' || letters == 'C') && isDigitsOfLength(number, 4)
          ? const PlateValidation.valid()
          : const PlateValidation.invalid(reasonDiplomatic);
    }
    if (letters.length != 2 || !isDigits(number)) {
      return const PlateValidation.invalid(reasonRegular);
    }
    return const PlateValidation.valid();
  }
}

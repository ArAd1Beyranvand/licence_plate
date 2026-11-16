import 'package:license_plate/core/plate_core.dart';

/// Judges an Estonian plate, field by field. Reports, never bars a keystroke.
///
/// Regular plates are three digits and three letters. Diplomatic plates are
/// `CD` or `AT` with three or four digits, or `CMD` (heads of mission) with
/// two or three. Defence Forces plates are three digits then `K` and a letter,
/// or `EK` and a letter.
class EstoniaValidator extends PlateValidator {
  const EstoniaValidator();

  static const String reasonRegular = 'Three digits then three letters.';
  static const String reasonCode = 'The prefix is CD, AT or CMD.';
  static const String reasonDiplomatic =
      'CD and AT take three or four digits, CMD two or three.';
  static const String reasonDefence =
      'Three digits, then K and a letter or EK and a letter.';

  @override
  PlateValidation validate(PlateEntry entry) {
    final PlateValidation? refused = restrictionVerdict(entry);
    if (refused != null) return refused;
    final String number = entry.group('number');
    final String letters = entry.group('letters'), code = entry.group('code');
    if (code.isNotEmpty) return _diplomatic(code, number);
    if (number.isEmpty || letters.isEmpty) return const PlateValidation.valid();
    if (entry.spec.id == 'ee.defence') {
      final bool shape =
          letters.length == 2 && letters.startsWith('K') ||
          letters.length == 3 && letters.startsWith('EK');
      return isDigitsOfLength(number, 3) && shape
          ? const PlateValidation.valid()
          : const PlateValidation.invalid(reasonDefence);
    }
    return isDigitsOfLength(number, 3) && letters.length == 3
        ? const PlateValidation.valid()
        : const PlateValidation.invalid(reasonRegular);
  }

  PlateValidation _diplomatic(String code, String number) {
    final int? min = switch (code) {
      'CD' || 'AT' => 3,
      'CMD' => 2,
      _ => null,
    };
    if (min == null) {
      return code.length < 2
          ? const PlateValidation.valid()
          : const PlateValidation.invalid(reasonCode);
    }
    if (number.isEmpty) return const PlateValidation.valid();
    return isDigits(number) && number.length >= min && number.length <= min + 1
        ? const PlateValidation.valid()
        : const PlateValidation.invalid(reasonDiplomatic);
  }
}

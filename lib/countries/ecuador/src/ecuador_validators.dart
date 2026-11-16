import 'package:license_plate/core/plate_core.dart';

/// Judges an Ecuadorian plate field by field: `ABC-123` or `ABC-1234` on
/// `EcuadorPlates.standard`, `CD-0123` on `EcuadorPlates.protocol`. Quiet
/// until the number has something in it. Reports, never bars a keystroke.
class EcuadorValidator extends PlateValidator {
  const EcuadorValidator();

  /// The first letter of a standard plate names the province of issue.
  static const Set<String> provinces = <String>{
    'A', 'B', 'U', 'C', 'X', 'H', 'O', 'E', 'W', 'G', 'I', 'L', 'R', 'M', //
    'V', 'N', 'S', 'P', 'Q', 'K', 'T', 'Z', 'Y', 'J',
  };

  /// Consular corps, diplomatic corps, international organisation,
  /// administrative and technical personnel, and temporary international
  /// organisation.
  static const Set<String> protocolCodes = <String>{
    'CC',
    'CD',
    'OI',
    'AT',
    'IT',
  };

  static final RegExp _letters3 = RegExp(r'^[A-Z]{3}$');
  static final RegExp _number = RegExp(r'^[0-9]{3,4}$');

  static const String reasonProvince = 'The first letter names a province.';
  static const String reasonLetters = 'A plate starts with three letters.';
  static const String reasonCode = 'The code is CC, CD, OI, AT or IT.';
  static const String reasonNumber = 'The number is 3 or 4 digits.';

  @override
  PlateValidation validate(PlateEntry entry) {
    final PlateValidation? refused = restrictionVerdict(entry);
    if (refused != null) return refused;
    final String letters = entry.group('letters');
    final String number = entry.group('number');
    if (number.isEmpty) return const PlateValidation.valid();
    if (entry.spec.id == 'ec.protocol') {
      if (!protocolCodes.contains(letters)) {
        return const PlateValidation.invalid(reasonCode);
      }
    } else if (!_letters3.hasMatch(letters)) {
      return const PlateValidation.invalid(reasonLetters);
    } else if (!provinces.contains(letters[0])) {
      return const PlateValidation.invalid(reasonProvince);
    }
    if (!_number.hasMatch(number)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    return const PlateValidation.valid();
  }
}

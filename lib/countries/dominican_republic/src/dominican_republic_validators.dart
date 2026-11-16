import 'package:license_plate/core/plate_core.dart';

final RegExp _letter = RegExp(r'^[A-Z]$');
final RegExp _letterPair = RegExp(r'^[A-Z]{2}$');

/// Judges a `DominicanRepublicPlates.private1990`, `passenger1980` or
/// `private1994` value: two fields of three digits (`953-147`). Reports,
/// never bars a keystroke.
class DominicanRepublicValidator extends GatedPlateValidator {
  const DominicanRepublicValidator() : super('last');

  static const String reason = 'A plate is two fields of three digits.';

  @override
  PlateValidation judge(PlateEntry entry) =>
      isDigitsOfLength(entry.group('first'), 3) &&
          isDigitsOfLength(entry.group('last'), 3)
      ? const PlateValidation.valid()
      : const PlateValidation.invalid(reason);
}

/// Judges a `DominicanRepublicPlates.passenger1986` value: a letter, two
/// digits and four digits (`P06-2686`; the article gives `P01-2345`).
class DominicanRepublicLetteredValidator extends GatedPlateValidator {
  const DominicanRepublicLetteredValidator() : super('tail');

  static const String reason =
      'A plate is a letter, two digits and four digits.';

  @override
  PlateValidation judge(PlateEntry entry) =>
      _letter.hasMatch(entry.group('letter')) &&
          isDigitsOfLength(entry.group('head'), 2) &&
          isDigitsOfLength(entry.group('tail'), 4)
      ? const PlateValidation.valid()
      : const PlateValidation.invalid(reason);
}

/// Judges a `DominicanRepublicPlates.exempt` value: two letters and five
/// digits (`EA 01320`; the article gives `AB 01234`).
class DominicanRepublicExemptValidator extends GatedPlateValidator {
  const DominicanRepublicExemptValidator() : super('digits');

  static const String reason = 'A plate is two letters and five digits.';

  @override
  PlateValidation judge(PlateEntry entry) =>
      _letterPair.hasMatch(entry.group('letters')) &&
          isDigitsOfLength(entry.group('digits'), 5)
      ? const PlateValidation.valid()
      : const PlateValidation.invalid(reason);
}

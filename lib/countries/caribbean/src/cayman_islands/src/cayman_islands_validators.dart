import 'package:license_plate/core/plate_core.dart';

/// Judges a `CaymanIslandsPlates.pair` or `taxi` value: two three-digit
/// fields. Reports, never bars a keystroke.
class CaymanIslandsValidator extends GatedPlateValidator {
  const CaymanIslandsValidator() : super('second');

  static const String reasonDigits = 'A plate is two groups of three digits.';

  @override
  PlateValidation judge(PlateEntry entry) =>
      isDigitsOfLength(entry.group('first'), 3) &&
          isDigitsOfLength(entry.group('second'), 3)
      ? const PlateValidation.valid()
      : const PlateValidation.invalid(reasonDigits);
}

/// Judges a `CaymanIslandsPlates.single` value: five digits.
class CaymanIslandsSingleValidator extends GatedPlateValidator {
  const CaymanIslandsSingleValidator() : super('serial');

  static const String reasonDigits = 'The serial is five digits.';

  @override
  PlateValidation judge(PlateEntry entry) =>
      isDigitsOfLength(entry.group('serial'), 5)
      ? const PlateValidation.valid()
      : const PlateValidation.invalid(reasonDigits);
}

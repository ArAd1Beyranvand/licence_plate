import 'package:license_plate/core/plate_core.dart';

/// Judges a Danish serial plate field by field. Reports, never bars a
/// keystroke.
///
/// Letters are two of A–Z. [midDigits] is the two-digit field (0 where the
/// plate has none), [numberDigits] the last field, [yearDigits] the export
/// plate's validity year (0 where absent). [allowedLetters] narrows the
/// letters, as Greenland's `GR` and `GL`.
class DenmarkValidator extends GatedPlateValidator {
  const DenmarkValidator({
    this.yearDigits = 0,
    this.midDigits = 2,
    this.numberDigits = 3,
    this.allowedLetters,
  }) : super('number');

  /// Greenland: serial letters `GR` and `GL` are reserved for it.
  const DenmarkValidator.greenland()
    : this(allowedLetters: const <String>{'GR', 'GL'});

  /// Fixed temporary plate `DD 12`: letters and two digits.
  const DenmarkValidator.fixedTemporary() : this(midDigits: 0, numberDigits: 2);

  /// Faroese plate: two letters and three digits.
  const DenmarkValidator.faroeIslands() : this(midDigits: 0);

  /// Temporary export plate: year, then two and three digits.
  const DenmarkValidator.exportTemporary() : this(yearDigits: 2);

  final int yearDigits, midDigits, numberDigits;
  final Set<String>? allowedLetters;

  static const String reasonLetters = 'The letters are two of A–Z.';
  static const String reasonGreenland = 'Greenland uses the letters GR or GL.';
  static const String reasonDigits = 'The digits do not fit the plate.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final String letters = entry.group('letters');
    final bool hasLetters = yearDigits == 0;
    if (hasLetters && !RegExp(r'^[A-Z]{2}$').hasMatch(letters)) {
      return const PlateValidation.invalid(reasonLetters);
    }
    if (hasLetters &&
        allowedLetters != null &&
        !allowedLetters!.contains(letters)) {
      return const PlateValidation.invalid(reasonGreenland);
    }
    if ((yearDigits > 0 &&
            !isDigitsOfLength(entry.group('year'), yearDigits)) ||
        (midDigits > 0 && !isDigitsOfLength(entry.group('mid'), midDigits)) ||
        !isDigitsOfLength(entry.group('number'), numberDigits)) {
      return const PlateValidation.invalid(reasonDigits);
    }
    return const PlateValidation.valid();
  }
}

/// Judges a vanity plate: two to seven letters or digits, with Æ, Ø and Å.
class DenmarkVanityValidator extends GatedPlateValidator {
  const DenmarkVanityValidator() : super('text');

  static const String reasonText =
      'A vanity plate is two to seven letters or digits.';

  @override
  PlateValidation judge(PlateEntry entry) =>
      RegExp(r'^[A-ZÆØÅ0-9]{2,7}$').hasMatch(entry.group('text'))
      ? const PlateValidation.valid()
      : const PlateValidation.invalid(reasonText);
}

import 'package:license_plate/core/plate_core.dart';

/// Judges a standard Guyanese registration on `GuyanaPlates.singleLine` or
/// `twoRow`: a `letters` series of two or three letters, then a `number` of
/// one to four digits without a leading zero. Reports, never bars a keystroke.
///
/// The first letter names the vehicle type (see [GuyanaVehicleTypes]); it is
/// not enforced, because the article lists official series (`CRG`, `GUY`,
/// `DPL`, ...) that break the pattern. The Presidential and Prime Minister's
/// plates carry no characters.
class GuyanaValidator extends GatedPlateValidator {
  const GuyanaValidator() : super('number');

  static const int minLetters = 2, maxLetters = 3, maxDigits = 4;

  static const String reasonLetters = 'The series is two or three letters.';
  static const String reasonNumber =
      'The number is one to four digits, with no leading zero.';

  @override
  PlateValidation judge(PlateEntry entry) => validateFields(
    letters: entry.group('letters'),
    number: entry.group('number'),
  );

  static PlateValidation validateFields({
    required String letters,
    required String number,
  }) {
    if (!RegExp('^[A-Z]{$minLetters,$maxLetters}\$').hasMatch(letters)) {
      return const PlateValidation.invalid(reasonLetters);
    }
    if (!RegExp('^[1-9][0-9]{0,${maxDigits - 1}}\$').hasMatch(number)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    return const PlateValidation.valid();
  }
}

/// What the first letter of a series stands for, from the article.
abstract final class GuyanaVehicleTypes {
  static const Map<String, String> names = <String, String>{
    'P': 'Private',
    'H': 'Hire / taxi',
    'B': 'Bus',
    'G': 'Goods (powered trade vehicle)',
    'C': 'Cycle',
    'T': 'Trailer (non-powered trade vehicle)',
  };
}

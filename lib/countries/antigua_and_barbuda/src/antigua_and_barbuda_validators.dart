import 'package:license_plate/core/plate_core.dart';

/// Judges `A 1234`: one class letter and up to [maxDigits] digits (three on
/// government plates). Reports, never bars a keystroke.
class AntiguaAndBarbudaValidator extends GatedPlateValidator {
  const AntiguaAndBarbudaValidator({this.maxDigits = 4}) : super('serial');

  final int maxDigits;

  static const String reasonLetter = 'The class is one letter.';

  static final RegExp _letter = RegExp(r'^[A-Z]$');

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!_letter.hasMatch(entry.group('letter'))) {
      return const PlateValidation.invalid(reasonLetter);
    }
    final String serial = entry.group('serial');
    if (serial.isEmpty || serial.length > maxDigits || !isDigits(serial)) {
      return PlateValidation.invalid('The number is one to $maxDigits digits.');
    }
    return const PlateValidation.valid();
  }
}

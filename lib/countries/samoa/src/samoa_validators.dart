import 'package:license_plate/core/plate_core.dart';

/// Judges a Samoan plate by its `serial` field: one to four digits (`1234`;
/// the earlier plates print three, the 1979 plate one digit then three).
/// Reports, never bars a keystroke.
class SamoaValidator extends GatedPlateValidator {
  const SamoaValidator() : super('serial');

  static const String reasonSerial = 'The number is one to four digits.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final String serial = entry.group('serial');
    if (serial.isEmpty || serial.length > 4 || !isDigits(serial)) {
      return const PlateValidation.invalid(reasonSerial);
    }
    final String mark = entry.spec.textGroups.any((g) => g.key == 'mark')
        ? entry.group('mark')
        : '';
    if (mark.isNotEmpty && !isDigitsOfLength(mark, 1)) {
      return const PlateValidation.invalid(reasonSerial);
    }
    return const PlateValidation.valid();
  }
}

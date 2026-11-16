import 'package:license_plate/core/plate_core.dart';

/// Judges a plate: six digits on a car (`686120`), `M` and five digits on a
/// motorcycle (`M 42421`). Reports, never bars a keystroke.
///
/// The 2013 `AB1234` format and its class letters (T, B, G, D, CD, ...) are
/// not modelled: no reference of it was measured.
class PanamaValidator extends GatedPlateValidator {
  const PanamaValidator() : super('serial');

  static const String reasonClass = 'A motorcycle plate starts with M.';
  static const String reasonSerial =
      'The number is six digits, five on a motorcycle.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final String serial = entry.group('serial'), prefix = entry.group('class');
    if (prefix.isNotEmpty && prefix != 'M') {
      return const PlateValidation.invalid(reasonClass);
    }
    if (!isDigitsOfLength(serial, prefix.isEmpty ? 6 : 5)) {
      return const PlateValidation.invalid(reasonSerial);
    }
    return const PlateValidation.valid();
  }
}

import 'package:license_plate/core/plate_core.dart';

/// Judges a 2010 plate field by field: a register and a serial, with the
/// lengths of its layout (`ABC-123`, `AB-1234`, or `E UA-123`). Reports, never
/// bars a keystroke.
class PeruValidator extends GatedPlateValidator {
  const PeruValidator() : super('serial');

  static const String reasonRegister =
      'The register is three letters or digits '
      '(AB1), two on a motorcycle, two letters on a special plate.';
  static const String reasonSerial =
      'The number is three digits, four on a '
      'motorcycle.';
  static const String reasonSpecial =
      'E marks the special series; a regular '
      'register does not start with it.';

  static final RegExp _alphanumeric = RegExp(r'^[A-Z0-9]+$');
  static final RegExp _letters = RegExp(r'^[A-Z]+$');

  @override
  PlateValidation judge(PlateEntry entry) {
    final String id = entry.spec.id;
    final bool special = id == 'pe.special';
    final int registerLength = id == 'pe.regular' ? 3 : 2;
    final int serialLength = id == 'pe.motorcycle' ? 4 : 3;
    final String register = entry.group('register');
    if (register.length != registerLength ||
        !(special ? _letters : _alphanumeric).hasMatch(register)) {
      return const PlateValidation.invalid(reasonRegister);
    }
    if (!special && register.startsWith('E')) {
      return const PlateValidation.invalid(reasonSpecial);
    }
    if (!isDigitsOfLength(entry.group('serial'), serialLength)) {
      return const PlateValidation.invalid(reasonSerial);
    }
    return const PlateValidation.valid();
  }
}

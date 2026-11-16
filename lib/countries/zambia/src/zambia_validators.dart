import 'package:license_plate/core/plate_core.dart';

/// Judges the plate (`ADD 4077 T`): three letters, four digits, one letter.
/// Reports, never bars a keystroke.
class ZambiaValidator extends RuledPlateValidator {
  const ZambiaValidator() : super('serial');

  static const String reasonPrefix = 'The prefix is three letters.';
  static const String reasonSerial = 'The number is four digits.';
  static const String reasonSuffix = 'The suffix is one letter.';

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('prefix', r'[A-Z]{3}', reasonPrefix),
    PlateCheck('serial', r'[0-9]{4}', reasonSerial),
    PlateCheck('suffix', r'[A-Z]', reasonSuffix),
  ];
}

import 'package:license_plate/core/plate_core.dart';

/// A two-letter series (`UP` police, `UU` prisons) and a serial of four or
/// five digits. Reports, never bars a keystroke.
class UgandaValidator extends RuledPlateValidator {
  const UgandaValidator();

  static const String reasonSeries = 'The series is two letters.';
  static const String reasonNumber = 'The number is four or five digits.';

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('series', r'[A-Z]{2}', reasonSeries),
    PlateCheck('number', r'[0-9]{4,5}', reasonNumber),
  ];
}

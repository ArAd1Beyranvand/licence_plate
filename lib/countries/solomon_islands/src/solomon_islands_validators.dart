import 'package:license_plate/core/plate_core.dart';

/// Judges a `SolomonIslandsPlates.private` value: two letters and four digits
/// (`MA 5021`). Reports, never bars.
class SolomonIslandsValidator extends RuledPlateValidator {
  const SolomonIslandsValidator();

  static const String reasonSeries = 'The series is two letters.';
  static const String reasonSerial = 'The serial is four digits.';

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('series', r'[A-Z]{2}', reasonSeries),
    PlateCheck('serial', r'[0-9]{4}', reasonSerial),
  ];
}

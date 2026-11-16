import 'package:license_plate/core/plate_core.dart';

/// Judges a Micronesian plate: one `serial` group of four digits, the same on
/// the Kosrae, Pohnpei and Yap plates. Reports, never bars.
class FederatedStatesOfMicronesiaValidator extends RuledPlateValidator {
  const FederatedStatesOfMicronesiaValidator();

  static const String reasonSerial = 'The serial is four digits.';

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('serial', r'[0-9]{4}', reasonSerial),
  ];
}

import 'package:license_plate/core/plate_core.dart';

/// Judges a [TurksAndCaicosIslandsPlates.modern] plate: five digits. Reports,
/// never bars a keystroke.
class TurksAndCaicosIslandsValidator extends RuledPlateValidator {
  const TurksAndCaicosIslandsValidator();

  static const String reasonSerial = 'The number is five digits.';

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('serial', r'[0-9]{5}', reasonSerial),
  ];
}

/// Judges a [TurksAndCaicosIslandsPlates.prefixed] or `selfDrive` plate:
/// `TC` and one to five digits.
class TurksAndCaicosIslandsPrefixedValidator extends GatedPlateValidator {
  const TurksAndCaicosIslandsPrefixedValidator() : super('serial');

  static const String reasonPrefix = 'The plate starts with TC.';
  static const String reasonSerial = 'The number is one to five digits.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (entry.group('prefix') != 'TC') {
      return const PlateValidation.invalid(reasonPrefix);
    }
    if (!RegExp(r'^[0-9]{1,5}$').hasMatch(entry.group('serial'))) {
      return const PlateValidation.invalid(reasonSerial);
    }
    return const PlateValidation.valid();
  }
}

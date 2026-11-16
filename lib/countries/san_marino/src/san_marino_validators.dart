import 'package:license_plate/core/plate_core.dart';

/// Judges a San Marino plate: a `prefix` of one to seven letters (a single
/// letter on a private plate; `CD`, `CRS`, `VE`, `POLIZIA` on the coded ones)
/// and a `number` of one to four digits. Reports, never bars a keystroke.
class SanMarinoValidator extends RuledPlateValidator {
  const SanMarinoValidator();

  static const String reasonPrefix = 'The prefix is one to seven letters.';
  static const String reasonNumber = 'The number is one to four digits.';

  @override
  List<PlateCheck> get checks => const <PlateCheck>[
    PlateCheck('prefix', r'[A-Z]{1,7}', reasonPrefix),
    PlateCheck('number', r'[0-9]{1,4}', reasonNumber),
  ];
}

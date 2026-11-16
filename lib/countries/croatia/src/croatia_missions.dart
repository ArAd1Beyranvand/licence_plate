import 'package:license_plate/core/plate_core.dart';

/// The diplomatic mission codes of the `023-A-002` plate: three digits for the
/// mission, then a class letter and a serial.
///
/// Code `071` is the article's entry for Israel. It is refused, never
/// plated: [restriction] rides on the diplomatic spec so `plate_core` rejects it
/// in every layer, with the same wording as `belarus_plate`.
abstract final class CroatiaMissions {
  static const String notFound = 'COUNTRY NOT FOUND';

  static const List<String> refused = <String>['071'];

  static const PlateRestriction restriction = PlateRestriction(
    group: 'mission',
    values: refused,
    reason: notFound,
  );

  static bool isRefused(String code) => refused.contains(code);
}

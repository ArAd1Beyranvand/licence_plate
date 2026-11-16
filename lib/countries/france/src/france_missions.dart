import 'package:license_plate/core/plate_core.dart';

/// Embassy code `59` is refused on the diplomatic plate's `embassy` register.
abstract final class FranceMissions {
  static const String notFound = 'COUNTRY NOT FOUND';

  static const List<String> refused = <String>['59'];

  static const PlateRestriction restriction = PlateRestriction(
    group: 'embassy',
    values: refused,
    reason: notFound,
  );

  static bool isRefused(String code) => refused.contains(code);
}

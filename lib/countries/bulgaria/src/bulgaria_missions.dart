import 'package:license_plate/core/plate_core.dart';

/// The diplomatic mission code: the first two digits of a diplomatic plate's
/// number.
///
/// Code `22` is Israel's and is refused, in every layer, by [restriction] on
/// the diplomatic spec's `mission` register.
abstract final class BulgariaMissions {
  /// The error every layer shows for a refused code.
  static const String notFound = 'COUNTRY NOT FOUND';

  static const List<String> refused = <String>['22'];

  static const PlateRestriction restriction = PlateRestriction(
    group: 'mission',
    values: refused,
    reason: notFound,
  );

  static bool isRefused(String code) => refused.contains(code);
}

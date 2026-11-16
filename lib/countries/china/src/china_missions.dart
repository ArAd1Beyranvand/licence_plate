import 'package:license_plate/core/plate_core.dart';

/// The mission codes a diplomatic plate carries (the first three digits).
///
/// The article's list gives 157 to Israel. That code is refused: the
/// diplomatic spec carries [restriction], so `plate_core` rejects it in
/// every layer.
abstract final class ChinaMissions {
  /// The error every layer shows for a refused code.
  static const String notFound = 'COUNTRY NOT FOUND';

  static const List<String> refused = <String>['157'];

  /// The restriction on a diplomatic spec's `mission` field.
  static const PlateRestriction restriction = PlateRestriction(
    group: 'mission',
    values: refused,
    reason: notFound,
  );

  static bool isRefused(String code) => refused.contains(code);
}

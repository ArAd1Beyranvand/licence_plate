import 'package:license_plate/core/plate_core.dart';

/// The diplomatic code is the two digits before the Ge'ez series. The article
/// lists the codes by country; code `84` is the one refused here, carried into
/// the diplomatic spec so `plate_core` rejects it everywhere.
abstract final class EthiopiaMissions {
  /// The error every layer shows for a refused code.
  static const String notFound = 'COUNTRY NOT FOUND';

  static const List<String> refused = <String>['84'];

  static const PlateRestriction restriction = PlateRestriction(
    group: 'mission',
    values: refused,
    reason: notFound,
  );

  static bool isRefused(String code) => refused.contains(code);
}

import 'package:license_plate/core/plate_core.dart';

/// Diplomatic mission code `79` is refused on every diplomatic spec's `code`
/// field, whatever its place on the article's list.
abstract final class AlbaniaMissions {
  static const String notFound = 'COUNTRY NOT FOUND';

  static const List<String> refused = <String>['79'];

  static const PlateRestriction restriction = PlateRestriction(
    group: 'code',
    values: refused,
    reason: notFound,
  );

  static bool isRefused(String code) => refused.contains(code);
}

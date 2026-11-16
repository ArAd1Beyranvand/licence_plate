import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import '../../spanish_city/spanish_city_plates.dart';
import 'ceuta_country.dart';

/// Ceuta's plates: Spain's national series, as [SpanishCityPlates] describes,
/// under Ceuta's country and `ce.` spec ids.
abstract final class CeutaPlates {
  static final SpanishCityPlates _city = SpanishCityPlates(
    idPrefix: 'ce',
    country: CeutaCountry.ceuta,
    letters: CeutaAlphabets.letters,
    diplomaticLetters: CeutaAlphabets.diplomaticLetters,
  );

  /// The error every layer shows for a refused embassy code.
  static const String notFound = SpanishCityPlates.notFound;

  /// Embassy code 83 as typed, with and without a leading zero.
  static const PlateRestriction israel = SpanishCityPlates.israel;

  static final PlateSpec private = _city.private, historic = _city.historic;
  static final PlateSpec taxi = _city.taxi, trailer = _city.trailer;
  static final PlateSpec provisional = _city.provisional, dealer = _city.dealer;
  static final PlateSpec police = _city.police, diplomatic = _city.diplomatic;

  static List<PlateSpec> get all => _city.all;
}

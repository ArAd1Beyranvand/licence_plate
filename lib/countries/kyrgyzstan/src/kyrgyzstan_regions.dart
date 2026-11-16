import 'package:license_plate/core/plate_core.dart';

/// Locates a Kyrgyz plate from its two-digit region code.
///
/// Source: the "Region identifiers / Current" table of
/// https://en.wikipedia.org/wiki/Vehicle_registration_plates_of_Kyrgyzstan
/// (codes 10 "Legalized" and 11 "Temporary" name no place and are omitted).
abstract final class KyrgyzstanRegions {
  static const Map<String, String> _regions = <String, String>{
    '01': 'Bishkek',
    '02': 'Osh',
    '03': 'Batken Region',
    '04': 'Jalal-Abad Region',
    '05': 'Naryn Region',
    '06': 'Osh Region',
    '07': 'Talas Region',
    '08': 'Chüy Region',
    '09': 'Issyk-Kul Region',
  };

  /// The region of [code], or null when incomplete or unissued.
  static String? lookup(String code) => _regions[code];

  /// A [PlateLabelResolver] for [PlateSpec.resolveRegion].
  static String? captionOf(String Function(String key) group) =>
      lookup(group('region'));
}

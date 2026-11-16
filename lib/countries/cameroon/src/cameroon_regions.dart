import 'package:license_plate/core/plate_core.dart';

/// Maps a two-letter region code to its region name.
abstract final class CameroonRegions {
  static const Map<String, String> _codes = <String, String>{
    'AD': 'Adamawa',
    'CE': 'Centre',
    'EN': 'Far North',
    'ES': 'East',
    'LT': 'Littoral',
    'NO': 'North',
    'NW': 'Northwest',
    'OU': 'West',
    'SU': 'South',
    'SW': 'Southwest',
  };

  /// The name for [code], or null when it matches no code or several.
  static String? lookup(String code) {
    if (code.isEmpty) return null;
    final Set<String> names = <String>{
      for (final MapEntry<String, String> e in _codes.entries)
        if (e.key.startsWith(code)) e.value,
    };
    return names.length == 1 ? names.single : null;
  }

  /// A [PlateLabelResolver] for [PlateSpec.resolveRegion].
  static String? captionOf(String Function(String key) group) =>
      lookup(group('region'));
}

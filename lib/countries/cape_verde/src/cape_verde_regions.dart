import 'package:license_plate/core/plate_core.dart';

/// Maps a two-letter island code to its island name.
abstract final class CapeVerdeRegions {
  static const Map<String, String> _codes = <String, String>{
    'BR': 'Brava',
    'BV': 'Boa Vista',
    'FG': 'Fogo',
    'MA': 'Maio',
    'SA': 'Santo Antão',
    'SL': 'Sal',
    'SN': 'São Nicolau',
    'ST': 'Santiago',
    'SV': 'São Vicente',
  };

  /// The name for [code] (a prefix of one or two letters), or null when it
  /// matches no code or several.
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
      lookup(group('series'));
}

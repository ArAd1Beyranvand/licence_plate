import 'package:license_plate/core/plate_core.dart';

/// Names the area from the two-letter local memory tag of a current-format
/// Great Britain plate.
///
/// Source: "Local memory tags" in
/// https://en.wikipedia.org/wiki/Vehicle_registration_plates_of_the_United_Kingdom
/// The first letter is the DVLA mnemonic area, the second the DVLA office that
/// issued it (the offices closed by 2013; the tags stay). Second letters the
/// article lists as reserved or issued with approval, and the personal export
/// letter `X`, name the area alone or nothing.
abstract final class UnitedKingdomRegions {
  static const Map<String, String> _areas = <String, String>{
    'A': 'Anglia',
    'B': 'Birmingham',
    'C': 'Cymru (Wales)',
    'D': 'Deeside to Shrewsbury',
    'E': 'Essex',
    'F': 'Forest and Fens',
    'G': 'Garden of England',
    'H': 'Hampshire and Dorset',
    'L': 'London',
    'M': 'Manchester and Merseyside',
    'N': 'North',
    'O': 'Oxford',
    'P': 'Preston',
    'R': 'Reading',
    'S': 'Scotland',
    'V': 'Severn Valley',
    'W': 'West of England',
    'Y': 'Yorkshire',
  };

  /// Office name to the second letters it issued, per first letter.
  static const Map<String, Map<String, String>>
  _offices = <String, Map<String, String>>{
    'A': <String, String>{
      'Peterborough': 'ABCDEFGJKMN',
      'Norwich': 'OPRSTU',
      'Ipswich': 'VWXY',
    },
    'B': <String, String>{'Birmingham': 'ABCDEFGHJKLMNOPRSTUVWX'},
    'C': <String, String>{
      'Cardiff': 'ABCDEFGHJKLMNO',
      'Swansea': 'PRSTUV',
      'Bangor': 'WXY',
    },
    'D': <String, String>{
      'Chester': 'ABCDEFGHJK',
      'Shrewsbury': 'LMNOPSTUVWXY',
    },
    'E': <String, String>{'Chelmsford': 'ABCEFGJKLMNOPRSTUVWXY'},
    'F': <String, String>{'Nottingham': 'ABCDEFGHJKLMNP', 'Lincoln': 'RSTVWXY'},
    'G': <String, String>{
      'Maidstone': 'ABCDEFGHJKLMN',
      'Brighton': 'PRSTUVWXY',
    },
    'H': <String, String>{
      'Bournemouth': 'ABCDEFGHJ',
      'Portsmouth': 'KLMNPRSTUVXY',
    },
    'K': <String, String>{
      'Borehamwood': 'ABCDEFGHJKL',
      'Northampton': 'MNOPRSTUVWXY',
    },
    'L': <String, String>{
      'Wimbledon': 'ABCDEFGHJ',
      'Borehamwood': 'KLMNOPRST',
      'Sidcup': 'UVWXY',
    },
    'M': <String, String>{'Manchester': 'ABCDEFGHJKLMPTUVWX'},
    'N': <String, String>{
      'Newcastle': 'ABCDEGHJKLMNO',
      'Stockton': 'PRSTUVWXY',
    },
    'O': <String, String>{'Oxford': 'ABCDEFGHJLMOPTUVWXY'},
    'P': <String, String>{'Preston': 'ABCDEFGHJKLMNOPRST', 'Carlisle': 'UVWXY'},
    'R': <String, String>{'Reading': 'ABCDEFGHJKLMNOPRSTVWXY'},
    'S': <String, String>{
      'Glasgow': 'ABCDEFGHJ',
      'Edinburgh': 'KLMNO',
      'Dundee': 'PRST',
      'Aberdeen': 'VW',
      'Inverness': 'XY',
    },
    'V': <String, String>{'Worcester': 'ABCEFGHJKLMNOPRSTUVXY'},
    'W': <String, String>{
      'Exeter': 'ABDEFGHJ',
      'Truro': 'KL',
      'Bristol': 'MNOPRSTUVWXY',
    },
    'Y': <String, String>{
      'Leeds': 'ABCDEFGHJKL',
      'Sheffield': 'MNOPRSTUV',
      'Beverley': 'WXY',
    },
  };

  /// The area of the first letter, the issuing office once the second letter
  /// is known, or null when [tag] names neither.
  static String? lookup(String tag) {
    if (tag.isEmpty) return null;
    final String first = tag[0].toUpperCase();
    final String? area = _areas[first];
    if (tag.length == 1) return area;
    final String second = tag[1].toUpperCase();
    final Map<String, String>? offices = _offices[first];
    if (offices == null) return area;
    for (final MapEntry<String, String> e in offices.entries) {
      if (e.value.contains(second)) return e.key;
    }
    return area;
  }

  /// A [PlateLabelResolver] for [PlateSpec.resolveRegion].
  static String? captionOf(String Function(String key) group) =>
      lookup(group('area'));
}

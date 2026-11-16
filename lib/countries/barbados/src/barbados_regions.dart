import 'package:license_plate/core/plate_core.dart';

/// Locates a Barbadian plate from its leading letters.
///
/// Source: https://en.wikipedia.org/wiki/Vehicle_registration_plates_of_Barbados
abstract final class BarbadosRegions {
  static const Map<String, String> _parishes = <String, String>{
    'A': 'Saint Andrew',
    'E': 'Saint Peter',
    'G': 'Saint George',
    'J': 'Saint John',
    'L': 'Saint Lucy',
    'M': 'Saint Michael',
    'O': 'Saint Joseph',
    'P': 'Saint Philip',
    'S': 'Saint James',
    'T': 'Saint Thomas',
    'X': 'Christ Church',
  };

  /// Two-letter prefixes that start with a parish letter but mark a category.
  static const Set<String> _categories = <String>{'MP', 'ML', 'MO', 'PB', 'SL'};

  /// The parish of [letters], or null when empty, a vehicle category, or not a
  /// parish letter. The second letter only refines the series (`MA`, `XF`).
  static String? lookup(String letters) {
    if (letters.isEmpty || _categories.contains(letters)) return null;
    return _parishes[letters[0]];
  }

  /// A [PlateLabelResolver] for [PlateSpec.resolveRegion].
  static String? captionOf(String Function(String key) group) =>
      lookup(group('letters'));
}

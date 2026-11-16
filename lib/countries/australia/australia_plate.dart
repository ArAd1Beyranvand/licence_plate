/// Australia's licence plates for the `plate_core` library.
///
/// The standard plate of each state and territory, the National Heavy Vehicle,
/// Federal Interstate, Army, Air Force, Defence and Diplomatic plates, each a
/// spec with one slot per field, a theme, an advisory validator and a
/// serial generator.
library;

export 'package:license_plate/alphabet/plate_alphabet.dart' show AustraliaAlphabets;

export 'src/australia_colors.dart';
export 'src/australia_country.dart';
export 'src/australia_formats.dart';
export 'src/australia_plates.dart';
export 'src/australia_serial_generator.dart';
export 'src/australia_themes.dart';
export 'src/australia_validators.dart';

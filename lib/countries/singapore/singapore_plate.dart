/// Singapore's licence plates for the `plate_core` library.
///
/// Every plate is `prefix serial check`: one to three letters, one to four
/// digits and a checksum letter. One single-line geometry carries the black,
/// white and yellow standard liveries and the off-peak, hazardous-cargo and
/// Pulau Ubin plates; classic and restricted-use plates add a two-tone
/// background, and a two-line geometry carries motorcycles and plant.
library;

export 'package:license_plate/alphabet/plate_alphabet.dart' show SingaporeAlphabets;
export 'src/singapore_colors.dart';
export 'src/singapore_country.dart';
export 'src/singapore_plates.dart';
export 'src/singapore_serial_generator.dart';
export 'src/singapore_themes.dart';
export 'src/singapore_validators.dart';

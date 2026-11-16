/// Greece's licence plates for the `plate_core` library.
///
/// Private and trailer plates black on white or grey with the euroband,
/// government (orange), police (blue) and the AFG motorcycle plate; one theme
/// each, the Greek capital alphabet from `plate_alphabet`, and an advisory
/// validator that checks each field.
library;

export 'package:license_plate/alphabet/plate_alphabet.dart'
    show GreeceAlphabets;

export 'src/greece_colors.dart';
export 'src/greece_country.dart';
export 'src/greece_plates.dart';
export 'src/greece_regions.dart';
export 'src/greece_serial_generator.dart';
export 'src/greece_themes.dart';
export 'src/greece_validators.dart';

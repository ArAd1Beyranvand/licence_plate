/// Georgia's licence plates for the `plate_core` library.
///
/// The current series is Latin letters and digits, black on white with a blue
/// strip carrying the flag and `GE`: `AB-123-CD` private plates, `AA-123-A`
/// trailers, a red-ink temporary plate, squared and motorcycle plates with a
/// corner block, vanity, export, transit, the EU Monitoring Mission, military
/// (green strip) and the red embassy plate. Embassy code `004` is refused.
library;

export 'package:license_plate/alphabet/plate_alphabet.dart'
    show GeorgiaCountryAlphabets;

export 'src/georgia_country_colors.dart';
export 'src/georgia_country_country.dart';
export 'src/georgia_country_missions.dart';
export 'src/georgia_country_plates.dart';
export 'src/georgia_country_serial_generator.dart';
export 'src/georgia_country_themes.dart';
export 'src/georgia_country_validators.dart';

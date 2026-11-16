import 'package:license_plate/core/plate_core.dart';

/// One field of a plate: the text group it is read from, whether it is
/// letters or digits, and how many characters it holds.
class CostaRicaField {
  const CostaRicaField(
    this.key,
    this.name, {
    this.letters = false,
    required this.min,
    required this.max,
  });

  final String key;

  /// What the field is called in a verdict.
  final String name;
  final bool letters;
  final int min, max;

  bool accepts(String value) {
    final int n = value.length;
    if (n < min || n > max) return false;
    return letters ? RegExp(r'^[A-Z]+$').hasMatch(value) : isDigits(value);
  }

  String get reason {
    final String kind = letters ? 'letters' : 'digits';
    return min == max
        ? 'The $name is $max $kind.'
        : 'The $name is $min to $max $kind.';
  }
}

/// The fields of one design, in print order. The category's own letters
/// (`AB`, `TSJ`, `CD`, ...) are printed, not typed, so they are not fields.
class CostaRicaFormat {
  const CostaRicaFormat(this.fields);

  final List<CostaRicaField> fields;

  /// `ABC-123`: [CostaRicaPlates.private] and [CostaRicaPlates.electric].
  static const CostaRicaFormat private = CostaRicaFormat(<CostaRicaField>[
    CostaRicaField('letters', 'series', letters: true, min: 3, max: 3),
    CostaRicaField('number', 'number', min: 3, max: 3),
  ]);

  /// `D-123` or `D-1234`.
  static const CostaRicaFormat disabled = CostaRicaFormat(<CostaRicaField>[
    CostaRicaField('number', 'number', min: 3, max: 4),
  ]);

  /// Buses and taxis: `1234` or `12345`.
  static const CostaRicaFormat bus = CostaRicaFormat(<CostaRicaField>[
    CostaRicaField('number', 'number', min: 4, max: 5),
  ]);

  /// Commercial, light-load truck and motorcycle: `123456`.
  static const CostaRicaFormat commercial = CostaRicaFormat(<CostaRicaField>[
    CostaRicaField('number', 'number', min: 6, max: 6),
  ]);

  /// Diplomatic corps and international mission: a two-digit code, `123`.
  static const CostaRicaFormat protocol = CostaRicaFormat(<CostaRicaField>[
    CostaRicaField('code', 'code', min: 2, max: 2),
    CostaRicaField('number', 'number', min: 3, max: 3),
  ]);

  /// Power executive: a two-digit code, `1234`.
  static const CostaRicaFormat powerExecutive =
      CostaRicaFormat(<CostaRicaField>[
        CostaRicaField('code', 'code', min: 2, max: 2),
        CostaRicaField('number', 'number', min: 4, max: 4),
      ]);

  /// Consular corps: `1-23`.
  static const CostaRicaFormat consular = CostaRicaFormat(<CostaRicaField>[
    CostaRicaField('unit', 'first number', min: 1, max: 1),
    CostaRicaField('number', 'second number', min: 2, max: 2),
  ]);

  /// Official vehicle: `12-3456`.
  static const CostaRicaFormat official = CostaRicaFormat(<CostaRicaField>[
    CostaRicaField('unit', 'first number', min: 2, max: 2),
    CostaRicaField('number', 'second number', min: 4, max: 4),
  ]);

  /// Historical vehicle: two, three or four digits.
  static const CostaRicaFormat historical = CostaRicaFormat(<CostaRicaField>[
    CostaRicaField('number', 'number', min: 2, max: 4),
  ]);
}

/// Judges a Costa Rican value against a [CostaRicaFormat]. Reports, never
/// bars a keystroke.
class CostaRicaValidator extends GatedPlateValidator {
  const CostaRicaValidator([this.format = CostaRicaFormat.private]);

  final CostaRicaFormat format;

  @override
  String get gateGroup => format.fields.last.key;

  @override
  PlateValidation judge(PlateEntry entry) {
    for (final CostaRicaField field in format.fields) {
      if (!field.accepts(entry.group(field.key))) {
        return PlateValidation.invalid(field.reason);
      }
    }
    return const PlateValidation.valid();
  }
}

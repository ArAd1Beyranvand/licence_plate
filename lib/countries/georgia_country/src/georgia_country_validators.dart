import 'package:license_plate/core/plate_core.dart';

enum GeorgiaFieldKind { digits, letters, alphanumeric }

/// One field's rule: its kind and its length range.
class GeorgiaFieldRule {
  const GeorgiaFieldRule(this.key, this.kind, this.min, this.max);

  final String key;
  final GeorgiaFieldKind kind;
  final int min, max;

  bool accepts(String value) {
    if (value.length < min || value.length > max) return false;
    return value.codeUnits.every(
      (u) => switch (kind) {
        GeorgiaFieldKind.digits => u >= 0x30 && u <= 0x39,
        GeorgiaFieldKind.letters => u >= 0x41 && u <= 0x5A,
        GeorgiaFieldKind.alphanumeric =>
          (u >= 0x30 && u <= 0x39) || (u >= 0x41 && u <= 0x5A),
      },
    );
  }
}

/// Judges a Georgian plate field by field; reports, never bars a keystroke.
/// Quiet until the last field has content, and an embassy plate's refused
/// mission code is reported first (see `GeorgiaCountryMissions`).
class GeorgiaCountryValidator extends GatedPlateValidator {
  const GeorgiaCountryValidator(this.rules);

  final List<GeorgiaFieldRule> rules;

  @override
  String get gateGroup => rules.last.key;

  static const GeorgiaFieldRule _prefix = GeorgiaFieldRule(
    'prefix',
    GeorgiaFieldKind.letters,
    2,
    2,
  );
  static const GeorgiaFieldRule _serial3 = GeorgiaFieldRule(
    'serial',
    GeorgiaFieldKind.digits,
    3,
    3,
  );
  static const GeorgiaFieldRule _serial4 = GeorgiaFieldRule(
    'serial',
    GeorgiaFieldKind.digits,
    4,
    4,
  );

  /// `AB-123-CD`.
  static const GeorgiaCountryValidator private = GeorgiaCountryValidator(
    <GeorgiaFieldRule>[
      _prefix,
      _serial3,
      GeorgiaFieldRule('suffix', GeorgiaFieldKind.letters, 2, 2),
    ],
  );

  /// `AA-123-A`.
  static const GeorgiaCountryValidator trailer = GeorgiaCountryValidator(
    <GeorgiaFieldRule>[
      _prefix,
      _serial3,
      GeorgiaFieldRule('suffix', GeorgiaFieldKind.letters, 1, 1),
    ],
  );

  /// `GP-5891`: the article says the letters are `GA GE GG GC GP`.
  static const GeorgiaCountryValidator temporary = GeorgiaCountryValidator(
    <GeorgiaFieldRule>[_prefix, _serial4],
  );

  static const GeorgiaCountryValidator vanity = GeorgiaCountryValidator(
    <GeorgiaFieldRule>[
      GeorgiaFieldRule('text', GeorgiaFieldKind.alphanumeric, 1, 7),
    ],
  );

  /// `AA` over `1234`.
  static const GeorgiaCountryValidator motorcycle = GeorgiaCountryValidator(
    <GeorgiaFieldRule>[_prefix, _serial4],
  );

  /// `0092 04 AK`.
  static const GeorgiaCountryValidator export =
      GeorgiaCountryValidator(<GeorgiaFieldRule>[
        _serial4,
        GeorgiaFieldRule('year', GeorgiaFieldKind.digits, 2, 2),
        GeorgiaFieldRule('suffix', GeorgiaFieldKind.letters, 2, 2),
      ]);

  /// `5045 AT`.
  static const GeorgiaCountryValidator transit = GeorgiaCountryValidator(
    <GeorgiaFieldRule>[
      _serial4,
      GeorgiaFieldRule('suffix', GeorgiaFieldKind.letters, 2, 2),
    ],
  );

  /// `EUMM 085`.
  static const GeorgiaCountryValidator mission = GeorgiaCountryValidator(
    <GeorgiaFieldRule>[
      GeorgiaFieldRule('prefix', GeorgiaFieldKind.letters, 4, 4),
      _serial3,
    ],
  );

  /// `AD 217`.
  static const GeorgiaCountryValidator military = GeorgiaCountryValidator(
    <GeorgiaFieldRule>[_prefix, _serial3],
  );

  /// `004 CMD 001`: a three-digit mission code, `CMD`, `D` or `AS`, a serial.
  static const GeorgiaCountryValidator diplomatic =
      GeorgiaCountryValidator(<GeorgiaFieldRule>[
        GeorgiaFieldRule('mission', GeorgiaFieldKind.digits, 3, 3),
        GeorgiaFieldRule('kind', GeorgiaFieldKind.letters, 1, 3),
        _serial3,
      ]);

  static const String reason =
      'A field is the wrong length or has a wrong '
      'character for this plate.';

  @override
  PlateValidation judge(PlateEntry entry) {
    for (final GeorgiaFieldRule r in rules) {
      if (!r.accepts(entry.group(r.key))) {
        return const PlateValidation.invalid(reason);
      }
    }
    return const PlateValidation.valid();
  }
}

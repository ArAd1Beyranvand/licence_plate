import 'package:license_plate/core/plate_core.dart';

/// Judges a Cypriot plate by its groups. Reports, never bars a keystroke.
///
/// Every design names its last field `digits`, which gates the verdict; the
/// spec id picks the rule. A standard plate is three letters and three digits
/// (`KQL 343`); a trailer plate is `P` and five digits; a diplomatic plate is
/// a two-digit country code, `CD`, `CC` or `AT`, and one to three digits; a
/// Sovereign Base Areas plate is `SBAA` and two digits; a dealer plate is the
/// dealer's number (one or two digits) and a serial of one to three.
class CyprusValidator extends GatedPlateValidator {
  const CyprusValidator() : super('digits');

  static const String reasonStandard =
      'A plate is three letters, three digits.';
  static const String reasonTrailer = 'A trailer plate is P and five digits.';
  static const String reasonDiplomatic =
      'A diplomatic plate is a two-digit code, CD, CC or AT, and 1-3 digits.';
  static const String reasonSba = 'An SBA plate is SBAA and two digits.';
  static const String reasonDealer =
      'A dealer plate is the dealer number (1-2 digits) and a serial (1-3).';

  static const List<String> diplomaticClasses = <String>['CD', 'CC', 'AT'];

  static final RegExp _letters = RegExp(r'^[A-Z]{3}$');

  static bool _between(String v, int min, int max) =>
      isDigits(v) && v.length >= min && v.length <= max;

  @override
  PlateValidation judge(PlateEntry entry) {
    final String digits = entry.group('digits');
    final bool ok;
    final String reason;
    switch (entry.spec.id) {
      case 'cy.trailer':
        ok = isDigitsOfLength(digits, 5);
        reason = reasonTrailer;
      case 'cy.sba':
        ok = isDigitsOfLength(digits, 2);
        reason = reasonSba;
      case 'cy.diplomatic':
        ok =
            isDigitsOfLength(entry.group('code'), 2) &&
            diplomaticClasses.contains(entry.group('class')) &&
            _between(digits, 1, 3);
        reason = reasonDiplomatic;
      case 'cy.dealer':
        ok = _between(entry.group('dealer'), 1, 2) && _between(digits, 1, 3);
        reason = reasonDealer;
      default:
        ok =
            _letters.hasMatch(entry.group('letters')) &&
            isDigitsOfLength(digits, 3);
        reason = reasonStandard;
    }
    return ok ? const PlateValidation.valid() : PlateValidation.invalid(reason);
  }
}

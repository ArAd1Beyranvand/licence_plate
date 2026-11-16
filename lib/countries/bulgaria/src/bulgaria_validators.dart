import 'package:license_plate/alphabet/plate_alphabet.dart';
import 'package:license_plate/core/plate_core.dart';

import 'bulgaria_missions.dart';

final RegExp _series = RegExp(r'^[ABKMHPCTX]{1,2}$');

/// Judges a registration plate (`C 5096 MK`) by its `region`, `number` and
/// `series` registers: a province code from the table (or `EA`/`EM`), four
/// digits and a series of one or two of the nine series letters. Reports,
/// never bars a keystroke.
class BulgariaValidator extends GatedPlateValidator {
  const BulgariaValidator() : super('series');

  static const String reasonRegion =
      'The province code is not one of the table.';
  static const String reasonNumber = 'The number is four digits.';
  static const String reasonSeries =
      'The series is one or two of A B K M H P C T X.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final String region = entry.group('region');
    if (!BulgariaAlphabets.regionCodes.contains(region) &&
        region != 'EA' &&
        region != 'EM') {
      return const PlateValidation.invalid(reasonRegion);
    }
    if (!isDigitsOfLength(entry.group('number'), 4)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    return _series.hasMatch(entry.group('series'))
        ? const PlateValidation.valid()
        : const PlateValidation.invalid(reasonSeries);
  }
}

/// Judges the army `BA 509 096` and civil-protection `CP 59 096` plates by
/// their `code`, `first` and `second` registers.
class BulgariaServiceValidator extends GatedPlateValidator {
  const BulgariaServiceValidator() : super('second');

  static const String reasonCode =
      'The code is BA (army) or CP (civil protection).';
  static const String reasonDigits = 'BA takes 3 + 3 digits, CP 2 + 3.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final String code = entry.group('code');
    if (code != 'BA' && code != 'CP') {
      return const PlateValidation.invalid(reasonCode);
    }
    final int first = code == 'BA' ? 3 : 2;
    return isDigitsOfLength(entry.group('first'), first) &&
            isDigitsOfLength(entry.group('second'), 3)
        ? const PlateValidation.valid()
        : const PlateValidation.invalid(reasonDigits);
  }
}

/// Judges a foreigner's plate (`XX 9043 19`, `XH` since 2019) and a
/// diplomatic one (`CC 7711 20`) by their `region` and `year`, and, for a
/// diplomatic plate, the `mission` and `number` registers. The mission `22`
/// is refused on its own account as well as by the spec's restriction.
class BulgariaStampedValidator extends GatedPlateValidator {
  const BulgariaStampedValidator() : super('year');

  static const String reasonPrefix =
      'Foreigners are XX or XH; diplomats C, CC or CT.';
  static const String reasonDigits =
      "Four digits (a diplomat's two mission digits, then two) and a two-digit "
      'year.';

  @override
  PlateValidation validate(PlateEntry entry) {
    if (BulgariaMissions.isRefused(entry.group('mission'))) {
      return const PlateValidation.invalid(BulgariaMissions.notFound);
    }
    return super.validate(entry);
  }

  @override
  PlateValidation judge(PlateEntry entry) {
    final String region = entry.group('region');
    if (!const <String>['XX', 'XH', 'C', 'CC', 'CT'].contains(region)) {
      return const PlateValidation.invalid(reasonPrefix);
    }
    final bool digits = entry.spec.textGroups.any((g) => g.key == 'mission')
        ? isDigitsOfLength(entry.group('mission'), 2) &&
              isDigitsOfLength(entry.group('number'), 2)
        : isDigitsOfLength(entry.group('number'), 4);
    return digits && isDigitsOfLength(entry.group('year'), 2)
        ? const PlateValidation.valid()
        : const PlateValidation.invalid(reasonDigits);
  }
}

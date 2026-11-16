import { GatedPlateValidator, PlateCheck, type PlateEntry, type PlateValidation, RuledPlateValidator, invalid, isDigitsOfLength, valid } from 'plate_core';

/** Judges a `BermudaPlates.private` value: five digits. Reports, never bars a keystroke. */
export class BermudaValidator extends GatedPlateValidator {
  readonly gateGroup = 'serial';

  static readonly reasonSerial = 'The number is five digits.';

  judge(entry: PlateEntry): PlateValidation {
    return isDigitsOfLength(entry.group('serial'), 5) ? valid : invalid(BermudaValidator.reasonSerial);
  }
}

/** Judges a `BermudaPlates.prefixed` value: one to three letters, then three or four digits (`L1234`, `CL123`, `RMC001`). */
export class BermudaPrefixedValidator extends GatedPlateValidator {
  readonly gateGroup = 'serial';

  static readonly reasonLetters = 'The class prefix is one to three letters.';
  static readonly reasonSerial = 'The number is three or four digits.';

  judge(entry: PlateEntry): PlateValidation {
    if (!/^[A-Z]{1,3}$/.test(entry.group('letters'))) return invalid(BermudaPrefixedValidator.reasonLetters);
    if (!/^[0-9]{3,4}$/.test(entry.group('serial'))) return invalid(BermudaPrefixedValidator.reasonSerial);
    return valid;
  }
}

/** Judges a `BermudaPlates.suffixed` value: three digits and a letter (`123Y`). */
export class BermudaSuffixedValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('serial', '[0-9]{3}', 'The number is three digits.'),
    new PlateCheck('letter', '[A-Z]', 'The suffix is one letter.'),
  ];
}

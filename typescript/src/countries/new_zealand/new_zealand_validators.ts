import { GatedPlateValidator, PlateCheck, type PlateEntry, type PlateValidation, RuledPlateValidator, invalid, valid } from 'plate_core';

/** Judges a standard plate: three letters and three digits (`ABC 123`). Reports, never bars a keystroke. */
export class NewZealandValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('letters', '[A-Z]{3}', 'The letters are three capitals.'),
    new PlateCheck('serial', '[0-9]{3}', 'The number is three digits.'),
  ];
}

/** Judges the older plate: two letters and four digits (`GG 9094`). */
export class NewZealandLegacyValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('letters', '[A-Z]{2}', 'The letters are two capitals.'),
    new PlateCheck('serial', '[0-9]{4}', 'The number is four digits.'),
  ];
}

/** Judges a personalised plate: one to six letters and digits, one field. */
export class NewZealandPersonalisedValidator extends GatedPlateValidator {
  readonly gateGroup = 'serial';

  static readonly reasonRun = 'A personalised plate is one to six letters or digits.';

  judge(entry: PlateEntry): PlateValidation {
    return /^[A-Z0-9]{1,6}$/.test(entry.group('serial')) ? valid : invalid(NewZealandPersonalisedValidator.reasonRun);
  }
}

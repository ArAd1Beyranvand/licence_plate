import { PlateCheck, RuledPlateValidator } from 'plate_core';

/** Judges a 1976 car plate: a class letter and four digits (`P-0000`). Reports,
 * never bars a keystroke. */
export class ElSalvadorValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('letter', '[A-Z]', 'The class is one letter.'),
    new PlateCheck('serial', '[0-9]{4}', 'The number is four digits.'),
  ];
}

/** Judges a 1976 motorcycle plate: a letter, one digit and three digits
 * (`M-1-234`). */
export class ElSalvadorMotorcycleValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('letter', '[A-Z]', 'The class is one letter.'),
    new PlateCheck('series', '[0-9]{1}', 'The series is one digit.'),
    new PlateCheck('serial', '[0-9]{3}', 'The number is three digits.'),
  ];
}

import { PlateCheck, RuledPlateValidator } from 'plate_core';

/** Judges a Guatemalan serial `P 123 ABC`: a class letter, three digits and
 * three letters. The class letter is not checked beyond being a letter.
 *
 * Reports, never bars a keystroke. */
export class GuatemalaValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('class', '[A-Z]', 'The class is one letter, such as P or C.'),
    new PlateCheck('digits', '[0-9]{3}', 'The number is three digits.'),
    new PlateCheck('letters', '[A-Z]{3}', 'The serial ends in three letters.'),
  ];
}

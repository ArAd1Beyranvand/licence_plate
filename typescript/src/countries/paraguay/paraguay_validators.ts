import { PlateCheck, RuledPlateValidator } from 'plate_core';

/** Judges a Paraguayan Mercosur serial `AAAA 123`: four letters in `letters`
 * and three digits in `number`. (Motorcycles print `123 ABC`; not modelled.)
 *
 * Reports, never bars a keystroke. */
export class ParaguayValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('letters', '[A-Z]{4}', 'The series is four letters.'),
    new PlateCheck('number', '[0-9]{3}', 'The number is three digits.'),
  ];
}

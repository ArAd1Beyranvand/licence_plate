import { PlateCheck, RuledPlateValidator } from 'plate_core';

/** Judges a San Marino plate: a `prefix` of one to seven letters (a single
 * letter on a private plate; `CD`, `CRS`, `VE`, `POLIZIA` on the coded ones)
 * and a `number` of one to four digits. Reports, never bars a keystroke. */
export class SanMarinoValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('prefix', '[A-Z]{1,7}', 'The prefix is one to seven letters.'),
    new PlateCheck('number', '[0-9]{1,4}', 'The number is one to four digits.'),
  ];
}

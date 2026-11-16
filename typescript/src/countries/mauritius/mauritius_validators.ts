import { PlateCheck, RuledPlateValidator } from 'plate_core';

/** Judges a government plate (`GM 3345`): two letters and four digits.
 * Reports, never bars a keystroke. */
export class MauritiusValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('letters', '[A-Z]{2}', 'The prefix is two letters.'),
    new PlateCheck('serial', '[0-9]{4}', 'The number is four digits.'),
  ];
}

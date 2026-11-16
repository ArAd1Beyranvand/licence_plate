import { PlateCheck, RuledPlateValidator } from 'plate_core';

/** Judges a Wallis and Futuna plate: a four-digit serial followed by the
 * printed `WF`. Reports, never bars a keystroke. */
export class WallisAndFutunaValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('number', '[0-9]{4}', 'The serial is four digits.'),
  ];
}

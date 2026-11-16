import { PlateCheck, RuledPlateValidator } from 'plate_core';

/** Advisory validator for `A 1705`: one or two letters, four digits. */
export class LesothoValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('letters', '[A-Z]{1,2}', 'The prefix is one or two letters.'),
    new PlateCheck('serial', '[0-9]{4}', 'The number is four digits.'),
  ];
}

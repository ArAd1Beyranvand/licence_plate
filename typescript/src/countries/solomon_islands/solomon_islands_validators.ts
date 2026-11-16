import { PlateCheck, RuledPlateValidator } from 'plate_core';

/** Judges a `SolomonIslandsPlates.private` value: two letters and four digits (`MA 5021`). Reports, never bars. */
export class SolomonIslandsValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('series', '[A-Z]{2}', 'The series is two letters.'),
    new PlateCheck('serial', '[0-9]{4}', 'The serial is four digits.'),
  ];
}

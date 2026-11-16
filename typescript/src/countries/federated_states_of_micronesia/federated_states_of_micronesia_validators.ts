import { PlateCheck, RuledPlateValidator } from 'plate_core';

/** Judges a Micronesian plate: one `serial` group of four digits, the same on
 * the Kosrae, Pohnpei and Yap plates. Reports, never bars. */
export class FederatedStatesOfMicronesiaValidator extends RuledPlateValidator {
  readonly checks = [
    new PlateCheck('serial', '[0-9]{4}', 'The serial is four digits.'),
  ];
}

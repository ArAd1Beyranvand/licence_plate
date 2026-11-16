package plates.countries.south_sudan

import plates.core.validators.PlateCheck
import plates.core.validators.RuledPlateValidator

/** Judges a 2017 plate: three digits, then one or two letters (`560 AT`). Reports, never bars a keystroke. */
class SouthSudanValidator : RuledPlateValidator() {
    override val checks = listOf(
        PlateCheck("serial", "[0-9]{3}", "The number is three digits."),
        PlateCheck("letters", "[A-Z]{1,2}", "The register is one or two letters."),
    )
}

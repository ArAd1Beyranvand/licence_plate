package plates.countries.seychelles

import plates.core.validators.PlateCheck
import plates.core.validators.RuledPlateValidator

/** Judges a plate (`S 11111`): one letter and up to five digits. Reports, never bars a keystroke. */
class SeychellesValidator : RuledPlateValidator() {
    override val checks = listOf(
        PlateCheck("letter", "[A-Z]", "The series is one letter."),
        PlateCheck("serial", "[0-9]{1,5}", "The number is one to five digits."),
    )
}

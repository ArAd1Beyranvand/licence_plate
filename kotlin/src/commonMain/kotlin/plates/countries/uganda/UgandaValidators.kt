package plates.countries.uganda

import plates.core.validators.PlateCheck
import plates.core.validators.RuledPlateValidator

/** A two-letter series (`UP` police, `UU` prisons) and a serial of four or five digits. Reports, never bars a keystroke. */
class UgandaValidator : RuledPlateValidator() {
    override val checks = listOf(
        PlateCheck("series", "[A-Z]{2}", "The series is two letters."),
        PlateCheck("number", "[0-9]{4,5}", "The number is four or five digits."),
    )
}

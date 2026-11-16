package plates.countries.suriname

import plates.core.validators.PlateCheck
import plates.core.validators.RuledPlateValidator

/** Judges a plate: two letters, the first always P, and four digits (PA 1234). Reports, never bars a keystroke. */
class SurinameValidator : RuledPlateValidator() {
    override val checks = listOf(
        PlateCheck("letters", "P[A-Z]", "The register is two letters, the first one P."),
        PlateCheck("serial", "[0-9]{4}", "The number is four digits."),
    )
}

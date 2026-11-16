package plates.countries.paraguay

import plates.core.validators.PlateCheck
import plates.core.validators.RuledPlateValidator

/** Judges a Paraguayan Mercosur serial `AAAA 123`. Reports, never bars a keystroke. */
class ParaguayValidator : RuledPlateValidator() {
    override val checks = listOf(
        PlateCheck("letters", "[A-Z]{4}", "The series is four letters."),
        PlateCheck("number", "[0-9]{3}", "The number is three digits."),
    )
}

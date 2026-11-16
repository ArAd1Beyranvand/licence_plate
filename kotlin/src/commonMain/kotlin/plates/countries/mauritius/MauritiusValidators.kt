package plates.countries.mauritius

import plates.core.validators.*
import plates.core.validators.PlateCheck
import plates.core.validators.RuledPlateValidator

/** Judges a government plate (`GM 3345`): two letters and four digits. Reports, never bars a keystroke. */
class MauritiusValidator : RuledPlateValidator() {
    override val checks = listOf(
        PlateCheck("letters", "[A-Z]{2}", "The prefix is two letters."),
        PlateCheck("serial", "[0-9]{4}", "The number is four digits."),
    )
}

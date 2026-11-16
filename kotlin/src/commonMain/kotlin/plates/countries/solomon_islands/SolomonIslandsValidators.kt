package plates.countries.solomon_islands

import plates.core.validators.PlateCheck
import plates.core.validators.RuledPlateValidator

/** Judges a `SolomonIslandsPlates.private` value: two letters and four digits
 * (`MA 5021`). Reports, never bars. */
class SolomonIslandsValidator : RuledPlateValidator() {
    override val checks = listOf(
        PlateCheck("series", "[A-Z]{2}", "The series is two letters."),
        PlateCheck("serial", "[0-9]{4}", "The serial is four digits."),
    )
}

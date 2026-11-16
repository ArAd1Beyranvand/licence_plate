package plates.countries.rwanda

import plates.core.validators.PlateCheck
import plates.core.validators.RuledPlateValidator

/** Judges a plate `RXX ###X`: a register of three letters starting with `R`, then three digits and a letter. */
class RwandaValidator : RuledPlateValidator() {
    override val checks = listOf(
        PlateCheck("register", "R[A-Z]{2}", "The register is three letters starting with R."),
        PlateCheck("serial", "[0-9]{3}[A-Z]", "The number is three digits and a letter."),
    )
}

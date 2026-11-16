package plates.countries.gabon

import plates.core.validators.PlateCheck
import plates.core.validators.RuledPlateValidator

// Explicit ASCII class, portable across JVM/JS/Wasm regex engines.

/** Judges `AB-123-CD`: two letters, three digits, two letters. Reports, never bars a keystroke. */
class GabonValidator : RuledPlateValidator("number") {
    override val checks = listOf(
        PlateCheck("series", "[A-Z]{2}", "The first group is 2 letters."),
        PlateCheck("number", "[0-9]{3}", "The number is 3 digits."),
        PlateCheck("suffix", "[A-Z]{2}", "The last group is 2 letters."),
    )
}

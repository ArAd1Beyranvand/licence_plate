package plates.countries.federated_states_of_micronesia

import plates.core.validators.PlateCheck
import plates.core.validators.RuledPlateValidator

/** Judges a Micronesian plate: one `serial` group of four digits, the same on
 * the Kosrae, Pohnpei and Yap plates. Reports, never bars. */
class FederatedStatesOfMicronesiaValidator : RuledPlateValidator() {
    override val checks = listOf(
        PlateCheck("serial", "[0-9]{4}", "The serial is four digits."),
    )
}

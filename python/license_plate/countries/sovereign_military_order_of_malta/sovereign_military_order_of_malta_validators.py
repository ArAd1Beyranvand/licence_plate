from __future__ import annotations

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length


class SovereignMilitaryOrderOfMaltaValidator(GatedPlateValidator):
    gate_group = "number"
    reason_prefix = "The prefix is SMOM."
    reason_number = "The number is two digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if entry.group("prefix") != "SMOM":
            return PlateValidation.invalid(self.reason_prefix)
        if not is_digits_of_length(entry.group("number"), 2):
            return PlateValidation.invalid(self.reason_number)
        return PlateValidation.valid()

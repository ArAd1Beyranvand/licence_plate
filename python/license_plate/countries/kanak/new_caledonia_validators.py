from __future__ import annotations

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation


class NewCaledoniaValidator(GatedPlateValidator):
    gate_group = "number"
    reason_digits = "The number must be six digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        v = entry.group("number")
        if not entry.spec.slots[0].accepts(v) or len(v) != 6:
            return PlateValidation.invalid(self.reason_digits)
        return PlateValidation.valid()

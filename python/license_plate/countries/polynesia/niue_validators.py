from __future__ import annotations

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length


class NiueValidator(GatedPlateValidator):
    gate_group = "serial"
    reason_serial = "The number is four digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        return (
            PlateValidation.valid()
            if is_digits_of_length(entry.group("serial"), 4)
            else PlateValidation.invalid(self.reason_serial)
        )

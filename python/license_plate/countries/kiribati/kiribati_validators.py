from __future__ import annotations

import re
from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length


class KiribatiValidator(GatedPlateValidator):
    gate_group = "serial"
    _letters = re.compile(r"^[A-Z]{3}$")
    reason_letters = "The register is three letters."
    reason_serial = "The number is three digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        letters = entry.group("letters")
        if letters and not self._letters.fullmatch(letters):
            return PlateValidation.invalid(self.reason_letters)
        if not is_digits_of_length(entry.group("serial"), 3):
            return PlateValidation.invalid(self.reason_serial)
        return PlateValidation.valid()

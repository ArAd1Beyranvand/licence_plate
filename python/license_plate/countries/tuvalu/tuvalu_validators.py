from __future__ import annotations

import re
from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length


class TuvaluValidator(GatedPlateValidator):
    gate_group = "serial"
    _letters = re.compile(r"^[A-Z]{2}$")
    reason_letters = "The register is two letters."
    reason_serial = "The number is four digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        letters = entry.group("letters")
        serial = entry.group("serial")
        if letters and not self._letters.fullmatch(letters):
            return PlateValidation.invalid(self.reason_letters)
        if not is_digits_of_length(serial, 4):
            return PlateValidation.invalid(self.reason_serial)
        return PlateValidation.valid()

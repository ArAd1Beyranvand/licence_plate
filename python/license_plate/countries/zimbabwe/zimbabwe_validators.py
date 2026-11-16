from __future__ import annotations

import re
from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length


@dataclass(frozen=True)
class ZimbabweValidator(GatedPlateValidator):
    gate_group = "serial"
    reason_letters = "The register is three letters."
    reason_serial = "The number is four digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        letters = entry.group("letters")
        if len(letters) != 3 or not re.fullmatch(r"[A-Z]{3}", letters):
            return PlateValidation.invalid(self.reason_letters)
        if not is_digits_of_length(entry.group("serial"), 4):
            return PlateValidation.invalid(self.reason_serial)
        return PlateValidation.valid()

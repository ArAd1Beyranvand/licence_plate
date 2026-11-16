from __future__ import annotations

import re
from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length


@dataclass(frozen=True)
class SaintVincentAndTheGrenadinesValidator(GatedPlateValidator):
    gate_group = "digits"
    reason = "A plate is one letter and four digits."
    _letter = re.compile(r"^[A-Z]$")

    def judge(self, entry: PlateEntry) -> PlateValidation:
        digits = entry.group("digits")
        letters = entry.group("letters")
        ok = is_digits_of_length(digits, 4) and self._letter.fullmatch(letters) is not None
        return PlateValidation.valid() if ok else PlateValidation.invalid(self.reason)

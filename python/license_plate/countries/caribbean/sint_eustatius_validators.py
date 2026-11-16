from __future__ import annotations

import re
from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits


@dataclass(frozen=True)
class SintEustatiusValidator(GatedPlateValidator):
    gate_group = "number"
    reason_prefix = "The prefix is E."
    reason_number = "The number is up to four digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if entry.group("prefix") != "E":
            return PlateValidation.invalid(self.reason_prefix)
        number = entry.group("number")
        if not number or len(number) > 4 or not is_digits(number):
            return PlateValidation.invalid(self.reason_number)
        return PlateValidation.valid()

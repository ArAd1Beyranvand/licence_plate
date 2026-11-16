from __future__ import annotations

import re
from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation


@dataclass(frozen=True)
class PapuaNewGuineaValidator(GatedPlateValidator):
    lead_min: int = 3
    lead_max: int = 3
    number_min: int = 3
    number_max: int = 3
    lead_starts_with: str | None = None
    gate_group = 'number'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        lead = entry.group("lead")
        if not re.fullmatch(f"[A-Z]{{{self.lead_min},{self.lead_max}}}", lead):
            return PlateValidation.invalid(
                f"The letters are {self.lead_min}." if self.lead_min == self.lead_max
                else f"The letters are {self.lead_min} to {self.lead_max}.")
        prefix = self.lead_starts_with
        if prefix is not None and not lead.startswith(prefix):
            return PlateValidation.invalid(f"The letters start with {prefix}.")
        if not re.fullmatch(f"[0-9]{{{self.number_min},{self.number_max}}}", entry.group("number")):
            return PlateValidation.invalid(
                f"The number is {self.number_min} digits." if self.number_min == self.number_max
                else f"The number is {self.number_min} to {self.number_max} digits.")
        return PlateValidation.valid()

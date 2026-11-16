from __future__ import annotations

import re
from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits


@dataclass(frozen=True)
class MarshallIslandsValidator(GatedPlateValidator):
    gate_group = "serial"
    reason_serial = "The number is one to four digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        serial = entry.group("serial")
        if not is_digits(serial) or len(serial) > 4:
            return PlateValidation.invalid(self.reason_serial)
        return PlateValidation.valid()

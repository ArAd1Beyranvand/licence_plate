from __future__ import annotations

import re
from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length


@dataclass(frozen=True)
class CaymanIslandsValidator(GatedPlateValidator):
    gate_group = "second"
    reason_digits = "A plate is two groups of three digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        first, second = entry.group("first"), entry.group("second")
        ok = is_digits_of_length(first, 3) and is_digits_of_length(second, 3)
        return PlateValidation.valid() if ok else PlateValidation.invalid(self.reason_digits)


@dataclass(frozen=True)
class CaymanIslandsSingleValidator(GatedPlateValidator):
    gate_group = "serial"
    reason_digits = "The serial is five digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        serial = entry.group("serial")
        ok = is_digits_of_length(serial, 5)
        return PlateValidation.valid() if ok else PlateValidation.invalid(self.reason_digits)

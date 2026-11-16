from __future__ import annotations

import re
from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length


@dataclass(frozen=True)
class BritishVirginIslandsValidator(GatedPlateValidator):
    gate_group = "serial"
    reason_prefix = "The plate starts with a class prefix: two letters, or TAXI."
    reason_serial = "The serial has the wrong digit count."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        prefix, serial = entry.group("prefix"), entry.group("serial")
        if not re.fullmatch(r"[A-Z]{2}|TAXI", prefix):
            return PlateValidation.invalid(self.reason_prefix)
        required_len = BritishVirginIslandsValidator.digits_for(prefix)
        if not is_digits_of_length(serial, required_len):
            return PlateValidation.invalid(self.reason_serial)
        return PlateValidation.valid()

    @staticmethod
    def digits_for(prefix: str) -> int:
        if prefix == "PV":
            return 5
        if prefix == "TAXI":
            return 3
        return 4

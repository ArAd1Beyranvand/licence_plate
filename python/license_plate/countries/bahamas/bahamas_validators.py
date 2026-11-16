from __future__ import annotations

import re
from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits


@dataclass(frozen=True)
class BahamasValidator(GatedPlateValidator):
    gate_group = "serial"
    max_serial = 5
    reason_prefix = "The class prefix is one letter."
    reason_serial = "The serial is one to five digits."
    _letter = re.compile(r"^[A-Z]$")

    def judge(self, entry: PlateEntry) -> PlateValidation:
        prefix, serial = entry.group("prefix"), entry.group("serial")
        if prefix and not self._letter.fullmatch(prefix):
            return PlateValidation.invalid(self.reason_prefix)
        if not is_digits(serial) or len(serial) > self.max_serial:
            return PlateValidation.invalid(self.reason_serial)
        return PlateValidation.valid()

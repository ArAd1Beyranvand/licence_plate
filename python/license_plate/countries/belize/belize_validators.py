from __future__ import annotations

import re
from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits


@dataclass(frozen=True)
class BelizeValidator(GatedPlateValidator):
    gate_group = "serial"

    _prefix = re.compile(r"^[A-Z]{1,3}$")
    reason_serial = "The serial is three to five digits."
    reason_prefix = "The prefix is one to three letters."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        prefix, serial = entry.group("prefix"), entry.group("serial")
        if prefix and not self._prefix.fullmatch(prefix):
            return PlateValidation.invalid(self.reason_prefix)
        if not is_digits(serial) or len(serial) < 3 or len(serial) > 5:
            return PlateValidation.invalid(self.reason_serial)
        return PlateValidation.valid()

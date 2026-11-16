from __future__ import annotations

import re
from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits


class SintMaartenValidator(GatedPlateValidator):
    gate_group = "number"
    _prefix = re.compile(r"^[A-Z]{1,2}$")
    reasonPrefix = "The prefix is one or two letters."
    reasonNumber = "The number is up to four digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        prefix = entry.group("prefix")
        if not self._prefix.fullmatch(prefix):
            return PlateValidation.invalid(self.reasonPrefix)
        number = entry.group("number")
        if not number or len(number) > 4 or not is_digits(number):
            return PlateValidation.invalid(self.reasonNumber)
        return PlateValidation.valid()

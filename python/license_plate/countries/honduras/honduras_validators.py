from __future__ import annotations

import re
from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length


class HondurasValidator(GatedPlateValidator):
    gate_group = "serial"

    reason_class = "The class is one letter."
    reason_series = "The series is two letters."
    reason_serial = "The number is four digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if not re.fullmatch(r"[A-Z]", entry.group("class")):
            return PlateValidation.invalid(self.reason_class)
        if not re.fullmatch(r"[A-Z]{2}", entry.group("series")):
            return PlateValidation.invalid(self.reason_series)
        if not is_digits_of_length(entry.group("serial"), 4):
            return PlateValidation.invalid(self.reason_serial)
        return PlateValidation.valid()

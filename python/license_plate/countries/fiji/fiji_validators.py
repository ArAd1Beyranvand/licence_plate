from __future__ import annotations

import re

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits


class FijiValidator(GatedPlateValidator):
    gate_group = 'serial'

    reason_letters = "The register is one or two letters."
    reason_serial = "The number is three or four digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if re.fullmatch(r"[A-Z]{1,2}", entry.group("letters")) is None:
            return PlateValidation.invalid(self.reason_letters)
        serial = entry.group("serial")
        if not is_digits(serial) or not 3 <= len(serial) <= 4:
            return PlateValidation.invalid(self.reason_serial)
        return PlateValidation.valid()

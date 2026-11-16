from __future__ import annotations

import re
from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits


class TongaValidator(GatedPlateValidator):
    gate_group = "serial"

    reason_letters = "The register is one or two letters."
    reason_serial = "The number is one to five digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        letters = entry.group("letters")
        if not re.fullmatch(r"[A-Z]{1,2}", letters):
            return PlateValidation.invalid(self.reason_letters)
        serial = entry.group("serial")
        if not re.fullmatch(r"[0-9]{1,5}", serial):
            return PlateValidation.invalid(self.reason_serial)
        return PlateValidation.valid()

from __future__ import annotations

import re

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length)


class PeruValidator(GatedPlateValidator):
    gate_group = "serial"

    REASON_REGISTER = ("The register is three letters or digits "
                       "(AB1), two on a motorcycle, two letters on a special plate.")
    REASON_SERIAL = "The number is three digits, four on a motorcycle."
    REASON_SPECIAL = "E marks the special series; a regular register does not start with it."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        spec_id = entry.spec.id
        special = spec_id == "pe.special"
        register_length = 3 if spec_id == "pe.regular" else 2
        serial_length = 4 if spec_id == "pe.motorcycle" else 3
        register = entry.group("register")
        pattern = r"[A-Z]+" if special else r"[A-Z0-9]+"
        if len(register) != register_length or not re.fullmatch(pattern, register):
            return PlateValidation.invalid(self.REASON_REGISTER)
        if not special and register.startswith("E"):
            return PlateValidation.invalid(self.REASON_SPECIAL)
        if not is_digits_of_length(entry.group("serial"), serial_length):
            return PlateValidation.invalid(self.REASON_SERIAL)
        return PlateValidation.valid()

from __future__ import annotations

import re

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length


class JamaicaValidator(GatedPlateValidator):
    gate_group = 'serial'

    reason_serial = "The serial is four digits."
    reason_letters = "The series is one or two letters."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        return self.validate_fields(entry.group("serial"), entry.group("letters"))

    @classmethod
    def validate_fields(cls, serial: str, letters: str) -> PlateValidation:
        if not is_digits_of_length(serial, 4):
            return PlateValidation.invalid(cls.reason_serial)
        if re.fullmatch(r"[A-Z]{1,2}", letters) is None:
            return PlateValidation.invalid(cls.reason_letters)
        return PlateValidation.valid()

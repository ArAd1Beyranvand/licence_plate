from __future__ import annotations

import re

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, PlateValidator, is_digits, is_digits_of_length, restriction_verdict)


_LETTERS = re.compile(r"[A-Z]{3}")


class NauruValidator(GatedPlateValidator):
    gate_group = "serial"
    reason_letters = "The register is three letters."
    reason_prefix = "The prefix is one digit."
    reason_serial = "The number has the wrong digit count."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        letters = entry.group("letters")
        prefix = entry.group("prefix")
        serial = entry.group("serial")
        if letters and not _LETTERS.fullmatch(letters):
            return PlateValidation.invalid(self.reason_letters)
        if prefix and not is_digits_of_length(prefix, 1):
            return PlateValidation.invalid(self.reason_prefix)
        digits = 3 if letters or prefix else 4
        if not is_digits_of_length(serial, digits):
            return PlateValidation.invalid(self.reason_serial)
        return PlateValidation.valid()

from __future__ import annotations

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length


class BosniaAndHerzegovinaValidator(GatedPlateValidator):
    gate_group = 'digits'

    reason_serial = "A plate is X00-X-000."
    reason_six = "The plate carries six digits."
    reason_four = "An EUPM plate carries four digits."
    reason_diplomatic = "A diplomatic plate is a code from 10 to 49, a letter and three digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        digits = entry.group("digits")
        prefix = entry.group("prefix")
        letter = entry.group("letter")
        code = entry.group("code")
        if code:
            n = int(code) if is_digits_of_length(code, 2) else None
            if n is not None and 10 <= n <= 49 and n != 31 and len(letter) == 1 and is_digits_of_length(digits, 3):
                return PlateValidation.valid()
            return PlateValidation.invalid(self.reason_diplomatic)
        if prefix:
            if len(prefix) == 3 and len(letter) == 1 and is_digits_of_length(digits, 3):
                return PlateValidation.valid()
            return PlateValidation.invalid(self.reason_serial)
        if is_digits_of_length(digits, 6):
            return PlateValidation.valid()
        if is_digits_of_length(digits, 4):
            return PlateValidation.valid()
        return PlateValidation.invalid(self.reason_six)

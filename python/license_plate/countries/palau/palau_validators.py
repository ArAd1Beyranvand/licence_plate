from __future__ import annotations

import re
from plate_core import PlateEntry, PlateValidation, is_digits, is_digits_of_length


class PalauValidator:
    reason_letters = "The letters are one to three capitals."
    reason_code = "The code is two digits."
    reason_digits = "The number is one to five digits."
    reason_serial = "The serial is up to eight letters and digits."
    _letters = re.compile(r"^[A-Z]{1,3}$")
    _serial = re.compile(r"^[A-Z0-9]{1,8}$")

    def validate(self, entry: PlateEntry) -> PlateValidation:
        digits = entry.group("digits")
        serial = entry.group("serial")
        letters = entry.group("letters")
        code = entry.group("code")
        if digits and not is_digits(digits) or len(digits) > 5:
            return PlateValidation.invalid(self.reason_digits)
        if letters and not self._letters.fullmatch(letters):
            return PlateValidation.invalid(self.reason_letters)
        if code and not is_digits_of_length(code, 2):
            return PlateValidation.invalid(self.reason_code)
        if serial and not self._serial.fullmatch(serial):
            return PlateValidation.invalid(self.reason_serial)
        return PlateValidation.valid()

from __future__ import annotations

import re

from plate_core import (
    PlateEntry, PlateValidation, restriction_verdict)


class MonacoValidator:
    REASON_SERIAL = ("The serial is four digits, a letter and three digits, or three digits "
                     "and a letter.")
    REASON_LETTERS = "The motorcycle prefix is two letters."
    REASON_DIGITS = "The motorcycle number is two digits."

    def validate(self, entry: PlateEntry) -> PlateValidation:
        refused = restriction_verdict(entry)
        if refused is not None:
            return refused
        serial = entry.group("serial")
        if serial:
            ok = re.fullmatch(r"[A-Z][0-9]{3}|[0-9]{4}|[0-9]{3}[A-Z]", serial)
            return PlateValidation.valid() if ok else PlateValidation.invalid(self.REASON_SERIAL)
        digits = entry.group("digits")
        if not digits:
            return PlateValidation.valid()
        if not re.fullmatch(r"[A-Z]{2}", entry.group("letters")):
            return PlateValidation.invalid(self.REASON_LETTERS)
        return PlateValidation.valid() if re.fullmatch(r"[0-9]{2}", digits) else PlateValidation.invalid(self.REASON_DIGITS)

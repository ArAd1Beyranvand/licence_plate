from __future__ import annotations

import re

from plate_core import PlateEntry, PlateValidation, restriction_verdict


class GrenadaValidator:
    def validate(self, entry: PlateEntry) -> PlateValidation:
        refused = restriction_verdict(entry)
        if refused is not None:
            return refused
        if not entry.group("number"):
            return PlateValidation.valid()
        if re.fullmatch(r"[A-Z]{3}", entry.group("letters")) is None:
            return PlateValidation.invalid("The series is 3 letters.")
        if re.fullmatch(r"[0-9]{3}", entry.group("number")) is None:
            return PlateValidation.invalid("The number is 3 digits.")
        return PlateValidation.valid()

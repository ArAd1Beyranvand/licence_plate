from __future__ import annotations

import re

from plate_core import PlateEntry, PlateValidation, restriction_verdict


class TrinidadAndTobagoValidator:
    def validate(self, entry: PlateEntry) -> PlateValidation:
        refused = restriction_verdict(entry)
        if refused is not None:
            return refused
        letters = entry.group("letters")
        if not letters:
            return PlateValidation.valid()
        if re.fullmatch(r"[A-HJ-NP-UW-Z]{1,3}", letters) is None:
            return PlateValidation.invalid("The series is one to three letters, never I, O, Q or V.")
        if re.fullmatch(r"[0-9]{1,4}", entry.group("serial")) is None:
            return PlateValidation.invalid("The number is one to four digits.")
        return PlateValidation.valid()

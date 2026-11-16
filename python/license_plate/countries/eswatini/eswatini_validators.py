from __future__ import annotations

import re

from plate_core import (
    PlateEntry, PlateValidation, restriction_verdict)

REGIONS = frozenset("HLMS")


class EswatiniValidator:
    regions = REGIONS

    def validate(self, entry: PlateEntry) -> PlateValidation:
        refused = restriction_verdict(entry)
        if refused is not None:
            return refused
        suffix = entry.group("suffix")
        if not suffix:
            return PlateValidation.valid()
        if not re.fullmatch(r"[A-Z]SD", entry.group("series")):
            return PlateValidation.invalid("The series is a letter then SD.")
        if not re.fullmatch(r"[0-9]{3}", entry.group("number")):
            return PlateValidation.invalid("The number is 3 digits.")
        if not re.fullmatch(r"[A-Z]{2}", suffix):
            return PlateValidation.invalid("The suffix is 2 letters.")
        if suffix[1] not in REGIONS:
            return PlateValidation.invalid("Unknown region letter.")
        return PlateValidation.valid()

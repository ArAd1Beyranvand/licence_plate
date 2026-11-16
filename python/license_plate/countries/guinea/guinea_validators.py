from __future__ import annotations

import re

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, restriction_verdict)


class GuineaValidator(GatedPlateValidator):
    gate_group = "number"

    def judge(self, entry: PlateEntry) -> PlateValidation:
        keys = {g.key for g in entry.spec.text_groups if g.key is not None}
        legacy = "prefix" in keys
        rules = {
            "series": (r"[A-Z]{1,2}" if legacy else r"[A-Z]{2}",
                       "The series is 1 or 2 letters." if legacy else "The series is 2 letters."),
            "number": (r"[0-9]{4}", "The number is 4 digits."),
            "prefix": (r"[A-Z]{2}", "The region code is 2 letters (RC is Conakry)."),
            "region": (r"0[1-8]", "The region code is 01 to 08."),
            "suffix": (r"[A-Z]", "The suffix is 1 letter."),
        }
        for key, (pattern, reason) in rules.items():
            if key in keys and not re.fullmatch(pattern, entry.group(key)):
                return PlateValidation.invalid(reason)
        return PlateValidation.valid()

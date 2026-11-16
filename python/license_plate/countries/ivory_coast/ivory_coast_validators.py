from __future__ import annotations

import re

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, restriction_verdict)


class IvoryCoastValidator:
    def validate(self, entry: PlateEntry) -> PlateValidation:
        refused = restriction_verdict(entry)
        if refused is not None:
            return refused
        groups = entry.spec.text_groups
        if not groups or not entry.group(groups[-1].key):
            return PlateValidation.valid()
        spec_id = entry.spec.id
        for g in groups:
            value = entry.group(g.key)
            if g.key == "number" and spec_id == "ci.private":
                rule = (r"[0-9]{4}", "The number is 4 digits.")
            elif g.key == "number" and spec_id == "ci.military":
                rule = (r"[0-9]{5}", "The number is 5 digits.")
            elif g.key == "number":
                rule = (r"[0-9]{3}", "The number is 3 digits.")
            elif g.key == "series":
                rule = (r"[A-Z]{2}", "The series is 2 letters.")
            elif g.key == "region":
                rule = (r"[0-9]{2}", "The region code is 2 digits.")
            else:
                continue
            if not re.fullmatch(rule[0], value):
                return PlateValidation.invalid(rule[1])
        return PlateValidation.valid()

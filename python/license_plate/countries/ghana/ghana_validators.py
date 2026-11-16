from __future__ import annotations

import re

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, restriction_verdict)


REGIONS = frozenset(
    "AC AE AK AP AS AW BA BR BW BT CR EN ER ES GB GC GE GG GH GL GM GN GT GS GW GX GY "
    "NR UE UW VA VD VR WR WT GA GP FS PS".split())

_RULES = {
    "number": (r"[0-9]{1,4}", "The number is 1 to 4 digits."),
    "year": (r"[0-9]{2}", "The year is 2 digits."),
    "class": (r"M", "A motorcycle plate starts with M."),
}


class GhanaValidator:
    regions = REGIONS

    def validate(self, entry: PlateEntry) -> PlateValidation:
        refused = restriction_verdict(entry)
        if refused is not None:
            return refused
        groups = entry.spec.text_groups
        if not groups or not entry.group(groups[-1].key):
            return PlateValidation.valid()
        for g in groups:
            rule = _RULES.get(g.key)
            if rule and not re.fullmatch(rule[0], entry.group(g.key)):
                return PlateValidation.invalid(rule[1])
        if entry.group("region") not in REGIONS:
            return PlateValidation.invalid("Unknown region code.")
        return PlateValidation.valid()

from __future__ import annotations

import re
from typing import Set

from plate_core import PlateEntry, PlateValidation


class SouthAfricaValidator:
    provinces: Set[str] = frozenset({
        "EC", "FS", "GP", "L", "MP", "NC", "NW", "WP", "ZN", "G", "M", "B",
    })
    _letters3 = re.compile(r"^[A-Z]{3}$")
    _letters2 = re.compile(r"^[A-Z]{2}$")
    _digits1to3 = re.compile(r"^[0-9]{1,3}$")
    _digits2 = re.compile(r"^[0-9]{2}$")

    def validate(self, entry: PlateEntry) -> PlateValidation:
        groups = entry.spec.text_groups
        if not groups or not entry.group(groups[-1].key):
            return PlateValidation.valid()

        modern = entry.spec.id == "za.modern"
        for g in groups:
            value = entry.group(g.key)
            rule = None
            reason = None
            if g.key == "series":
                if modern:
                    rule, reason = self._letters2, "The series is 2 letters."
                else:
                    rule, reason = self._letters3, "The series is 3 letters."
            elif g.key == "number":
                if modern:
                    rule, reason = self._digits2, "The number is 2 digits."
                else:
                    rule, reason = self._digits1to3, "The number is 1 to 3 digits."
            elif g.key == "letters":
                rule, reason = self._letters2, "The closing letters are 2 letters."
            if rule and not rule.fullmatch(value):
                return PlateValidation.invalid(reason)

        province = entry.group("province")
        if province and province not in self.provinces:
            return PlateValidation.invalid("Unknown province suffix.")

        return PlateValidation.valid()

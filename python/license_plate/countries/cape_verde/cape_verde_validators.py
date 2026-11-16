from __future__ import annotations

import re
from typing import Mapping, Set

from plate_core import PlateEntry, PlateValidation


class CapeVerdeValidator:
    islands: Set[str] = {
        "BR",
        "BV",
        "FG",
        "MA",
        "SA",
        "SL",
        "SN",
        "ST",
        "SV",
    }

    _shape: Mapping[str, tuple[re.Pattern[str], str]] = {
        "series": (re.compile(r"^[A-Z]{2}$"), "The island code is 2 letters."),
        "number": (re.compile(r"^[0-9]{2}$"), "The number is 2 digits."),
        "letters": (re.compile(r"^[A-Z]{2}$"), "The closing series is 2 letters."),
        "suffix": (re.compile(r"^[A-Z]$"), "The suffix is 1 letter."),
        "first": (re.compile(r"^[0-9]{2}$"), "The first number is 2 digits."),
        "second": (re.compile(r"^[0-9]{2}$"), "The second number is 2 digits."),
        "country": (re.compile(r"^[0-9]{2}$"), "The country code is 2 digits."),
        "serial": (re.compile(r"^[0-9]{3}$"), "The serial is 3 digits."),
    }

    def validate(self, entry: PlateEntry) -> PlateValidation:
        refused = self._restriction_verdict(entry)
        if refused is not None:
            return refused

        groups = entry.spec.text_groups
        if not groups or not entry.group(groups[-1].key):
            return PlateValidation.valid()

        for group in groups:
            rule = self._shape.get(group.key)
            if rule is not None and not rule[0].fullmatch(entry.group(group.key)):
                return PlateValidation.invalid(rule[1])

        if entry.spec.id == "cv.regular" and entry.group("series") not in self.islands:
            return PlateValidation.invalid("Unknown island code.")

        return PlateValidation.valid()

    @staticmethod
    def _restriction_verdict(entry: PlateEntry) -> PlateValidation | None:
        # The Dart code calls `restrictionVerdict(entry)` which is not defined in the stub.
        # Based on the Dart code logic, this function seems to be a helper that might return
        # a refusal if certain conditions are met. However, since it's not defined in the Dart
        # snippet provided, we assume it returns None for now.
        return None

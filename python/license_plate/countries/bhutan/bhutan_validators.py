from __future__ import annotations

import re
from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateCheck, PlateEntry, PlateValidation, RuledPlateValidator, is_digits_of_length


@dataclass(frozen=True)
class BhutanValidator(GatedPlateValidator):
    types: tuple[str, ...] = ("BP", "BT", "BG")
    gate_group = "type"

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if entry.group("type") not in self.types:
            return PlateValidation.invalid(f"The type is {' or '.join(self.types)}.")
        keys = {g.key for g in entry.spec.effective_text_groups}
        if "area" in keys and re.fullmatch(r"[1-5]", entry.group("area")) is None:
            return PlateValidation.invalid("The area code is 1 to 5.")
        if "series" in keys and re.fullmatch(r"[A-Z]", entry.group("series")) is None:
            return PlateValidation.invalid("The series is one letter.")
        if not is_digits_of_length(entry.group("number"), 4):
            return PlateValidation.invalid("The number is 4 digits.")
        return PlateValidation.valid()


class BhutanDiplomaticValidator(RuledPlateValidator):
    gate_group = "country"
    checks = (
        PlateCheck("country", r"[0-9]{1,2}", "The country number is 1 or 2 digits."),
        PlateCheck("serial", r"[0-9]{1,2}", "The serial is 1 or 2 digits."),
    )

from __future__ import annotations

import re

from plate_core import GatedPlateValidator, PlateCheck, PlateEntry, PlateValidation, RuledPlateValidator

class NewZealandValidator(RuledPlateValidator):
    checks = (
        PlateCheck("letters", r"[A-Z]{3}", "The letters are three capitals."),
        PlateCheck("serial", r"[0-9]{3}", "The number is three digits."),
    )


class NewZealandLegacyValidator(RuledPlateValidator):
    checks = (
        PlateCheck("letters", r"[A-Z]{2}", "The letters are two capitals."),
        PlateCheck("serial", r"[0-9]{4}", "The number is four digits."),
    )


class NewZealandPersonalisedValidator(GatedPlateValidator):
    gate_group = "serial"
    REASON_RUN = "A personalised plate is one to six letters or digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if re.fullmatch("[A-Z0-9]{1,6}", entry.group("serial")):
            return PlateValidation.valid()
        return PlateValidation.invalid(self.REASON_RUN)

from __future__ import annotations

import re

from plate_core import GatedPlateValidator, PlateCheck, PlateEntry, PlateValidation, RuledPlateValidator


class TurksAndCaicosIslandsValidator(RuledPlateValidator):
    checks = (
        PlateCheck("serial", r"[0-9]{5}", "The number is five digits."),
    )


class TurksAndCaicosIslandsPrefixedValidator(GatedPlateValidator):
    gate_group = "serial"
    reason_prefix = "The plate starts with TC."
    reason_serial = "The number is one to five digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if entry.group("prefix") != "TC":
            return PlateValidation.invalid(self.reason_prefix)
        if not re.fullmatch(r"[0-9]{1,5}", entry.group("serial")):
            return PlateValidation.invalid(self.reason_serial)
        return PlateValidation.valid()

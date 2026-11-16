from __future__ import annotations

import re

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, PlateValidator, is_digits, is_digits_of_length, restriction_verdict)


_CODES = frozenset("ABEKPCTH")


class TransnistriaValidator(GatedPlateValidator):
    gate_group = "serial"
    reason_field = "A field has the wrong length or letters."
    reason_region = "The region letter is not in use."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        spec = entry.spec
        for slot, group in zip(spec.slots, spec.text_groups):
            value = entry.group(group.key)
            if not slot.accepts(value) or len(value) < slot.min_length or len(value) > slot.length:
                return PlateValidation.invalid(self.reason_field)
        region = entry.group("region")
        if region and region not in _CODES:
            return PlateValidation.invalid(self.reason_region)
        return PlateValidation.valid()

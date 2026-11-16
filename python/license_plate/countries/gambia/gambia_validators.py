from __future__ import annotations

import re
from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length


@dataclass(frozen=True)
class GambiaValidator(GatedPlateValidator):
    regions: set[str] = frozenset({
        'BJL', 'KM',
        'WCR', 'NBR', 'LRR', 'CRR', 'URR',
        'WD', 'NBD', 'LRD', 'CRD', 'URD',
    })
    gate_group = "number"

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if entry.group("region") not in self.regions:
            return PlateValidation.invalid("The region code is not a known one.")
        if not is_digits_of_length(entry.group("number"), 4):
            return PlateValidation.invalid("The number is 4 digits.")
        if not re.fullmatch(r"[A-Z]", entry.group("suffix")):
            return PlateValidation.invalid("The suffix is 1 letter.")
        return PlateValidation.valid()

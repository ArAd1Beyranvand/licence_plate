from __future__ import annotations

import re
from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length

MEXICO_FIELD_KEYS = ('first', 'second', 'third')
REASON_CITY_LETTERS = 'Letters I, O and Q are not used.'


@dataclass(frozen=True)
class MexicoValidator(GatedPlateValidator):
    """`format` is the MexicoFormat id: one run of `a` (letters) or `d` (digits) per field, e.g. `aaa-dd-dd`."""

    format: str = 'aaa-dd-dd'

    @property
    def gate_group(self) -> str:
        return MEXICO_FIELD_KEYS[len(self.format.split('-')) - 1]

    def judge(self, entry: PlateEntry) -> PlateValidation:
        for i, run in enumerate(self.format.split('-')):
            letters, length = run[0] == 'a', len(run)
            value = entry.group(MEXICO_FIELD_KEYS[i])
            ok = re.fullmatch(f'[A-Z]{{{length}}}', value) is not None if letters else is_digits_of_length(value, length)
            if not ok:
                return PlateValidation.invalid(
                    f"Field {i + 1} is {length} {'letter' if letters else 'digit'}{'' if length == 1 else 's'}.")
            if self.format == 'ddd-aaa' and letters and re.search('[IOQ]', value):
                return PlateValidation.invalid(REASON_CITY_LETTERS)
        return PlateValidation.valid()

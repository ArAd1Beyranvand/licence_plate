from __future__ import annotations

from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length

REASON_CLASS = 'A motorcycle plate starts with M.'
REASON_SERIAL = 'The number is six digits, five on a motorcycle.'


@dataclass(frozen=True)
class PanamaValidator(GatedPlateValidator):
    gate_group = 'serial'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        prefix = entry.group('class')
        if prefix and prefix != 'M':
            return PlateValidation.invalid(REASON_CLASS)
        if not is_digits_of_length(entry.group('serial'), 5 if prefix else 6):
            return PlateValidation.invalid(REASON_SERIAL)
        return PlateValidation.valid()

from __future__ import annotations

from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length

_LETTERS = frozenset("ABGDRSCTEFKLMNHWY")


@dataclass(frozen=True)
class EgyptValidator(GatedPlateValidator):
    lengths: tuple
    gate_group = 'digits'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        for key, n in self.lengths:
            value = entry.group(key)
            ok = (len(value) == n and all(c in _LETTERS for c in value)
                  if key == 'letters' else is_digits_of_length(value, n))
            if not ok:
                return PlateValidation.invalid(
                    f'The letters are {n} of the 17 plate letters.' if key == 'letters' else f'The {key} is {n} digits.')
        return PlateValidation.valid()

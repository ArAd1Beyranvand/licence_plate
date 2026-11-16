from __future__ import annotations

import re
from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits


@dataclass(frozen=True)
class CostaRicaField:
    key: str
    name: str
    min: int
    max: int
    letters: bool = False

    def accepts(self, value: str) -> bool:
        if not self.min <= len(value) <= self.max:
            return False
        return re.fullmatch(r"[A-Z]+", value) is not None if self.letters else is_digits(value)

    @property
    def reason(self) -> str:
        kind = "letters" if self.letters else "digits"
        if self.min == self.max:
            return f"The {self.name} is {self.max} {kind}."
        return f"The {self.name} is {self.min} to {self.max} {kind}."


@dataclass(frozen=True)
class CostaRicaValidator(GatedPlateValidator):
    format: tuple

    @property
    def fields(self) -> tuple[CostaRicaField, ...]:
        return tuple(f if isinstance(f, CostaRicaField) else CostaRicaField(**f) for f in self.format)

    @property
    def gate_group(self) -> str:
        return self.fields[-1].key

    def judge(self, entry: PlateEntry) -> PlateValidation:
        for field in self.fields:
            if not field.accepts(entry.group(field.key)):
                return PlateValidation.invalid(field.reason)
        return PlateValidation.valid()

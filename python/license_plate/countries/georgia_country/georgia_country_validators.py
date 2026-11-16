from __future__ import annotations

from dataclasses import dataclass

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation

_DIGITS = "0123456789"
_LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
_KINDS = {"digits": _DIGITS, "letters": _LETTERS, "alphanumeric": _DIGITS + _LETTERS}


@dataclass(frozen=True)
class GeorgiaFieldRule:
    key: str
    kind: str
    min: int
    max: int

    def accepts(self, value: str) -> bool:
        return self.min <= len(value) <= self.max and all(c in _KINDS[self.kind] for c in value)


@dataclass(frozen=True)
class GeorgiaCountryValidator(GatedPlateValidator):
    rules: tuple
    reason = "A field is the wrong length or has a wrong character for this plate."

    @property
    def _rules(self) -> tuple[GeorgiaFieldRule, ...]:
        return tuple(r if isinstance(r, GeorgiaFieldRule) else GeorgiaFieldRule(**r) for r in self.rules)

    @property
    def gate_group(self) -> str:
        return self._rules[-1].key

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if all(r.accepts(entry.group(r.key)) for r in self._rules):
            return PlateValidation.valid()
        return PlateValidation.invalid(self.reason)

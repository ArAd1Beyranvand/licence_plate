from __future__ import annotations

import re

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation

_TWO_LETTERS = r"[A-Z]{2}"
_ONE_LETTER = r"[A-Z]"
_THREE_DIGITS = r"[0-9]{3}"
_FIVE_DIGITS = r"[0-9]{5}"
_LDL = {"a": _TWO_LETTERS, "b": _THREE_DIGITS, "c": _TWO_LETTERS}
_TWO_LINE = {"a": _TWO_LETTERS, "b": _ONE_LETTER, "c": _THREE_DIGITS}

_FORMATS = {
    "sk.private": _LDL,
    "sk.privateDash": _LDL,
    "sk.legacy": _LDL,
    "sk.temporary": _TWO_LINE,
    "sk.dealer": _TWO_LINE,
    "sk.personalised": {"a": _TWO_LETTERS, "b": r"[A-Z0-9]{1,5}"},
    "sk.imported": {"a": _ONE_LETTER, "b": _FIVE_DIGITS},
    "sk.military": {"a": r"[0-9]{2}", "b": _FIVE_DIGITS},
    "sk.diplomatic": {"a": _TWO_LETTERS, "b": _FIVE_DIGITS},
    "sk.officials": {"a": _TWO_LETTERS, "b": _ONE_LETTER, "c": _THREE_DIGITS},
}


class SlovakiaValidator(GatedPlateValidator):
    gate_group = "b"
    reason = "The plate does not match its format."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        fmt = _FORMATS.get(entry.spec.id)
        if fmt is None:
            return PlateValidation.valid()
        for key, pattern in fmt.items():
            if re.fullmatch(pattern, entry.group(key)) is None:
                return PlateValidation.invalid(self.reason)
        return PlateValidation.valid()

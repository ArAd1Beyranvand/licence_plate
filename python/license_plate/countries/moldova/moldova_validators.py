from __future__ import annotations

import re

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation

_MONTH = "0[1-9]|1[0-2]"
_YEAR = "[0-9]{2}"


def _letters_digits(letters, digits):
    return {"letters": f"[A-Z]{{{letters}}}", "digits": f"[0-9]{{{digits}}}"}


_FORMATS = {
    "md.private": _letters_digits(3, 3),
    "md.state": _letters_digits(3, 3),
    "md.interior": _letters_digits(3, 4),
    "md.armedForces": _letters_digits(2, 4),
    "md.president": _letters_digits(2, 4),
    "md.protection": _letters_digits(2, 3),
    "md.foreign": {**_letters_digits(1, 4), "month": _MONTH, "year": _YEAR},
    "md.exported": {**_letters_digits(1, 3), "suffix": "[A-Z]", "month": _MONTH, "year": _YEAR},
    "md.resident": _letters_digits(1, 4),
    "md.diplomatic": {**_letters_digits(2, 3), "suffix": "[A-Z]{2}"},
}


class MoldovaValidator(GatedPlateValidator):
    gate_group = "digits"
    REASON = "The plate does not match its format."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        fmt = _FORMATS.get(entry.spec.id)
        if fmt is not None:
            for key, pattern in fmt.items():
                if not re.fullmatch(pattern, entry.group(key)):
                    return PlateValidation.invalid(self.REASON)
        return PlateValidation.valid()

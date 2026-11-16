from __future__ import annotations

import re

from plate_core import PlateEntry, PlateValidation, restriction_verdict

_L12 = r"[A-Z]{1,2}"
_D15 = r"[0-9]{1,5}"
_DISTRICT = {"a": _L12, "b": _D15, "c": _L12}

_FORMATS: dict[str, dict[str, str]] = {
    "at.private": _DISTRICT,
    "at.electric": _DISTRICT,
    "at.trailer": _DISTRICT,
    "at.export": {"a": _L12, "b": r"[0-9]{1,3}", "c": _L12},
    "at.temporary": {"a": _L12, "b": r"[0-9]{1,2}", "c": _L12, "d": r"[0-9]{2}"},
    "at.fire": {"a": "FW", "b": r"[0-9]{1,4}", "c": _L12},
    "at.federal": {"a": _L12, "b": _D15},
    "at.diplomatic": {"a": r"[A-Z]{2}", "mission": r"[0-9]{1,2}"},
    "at.personalised": {"a": _L12, "b": r"[A-Z]{1,5}", "c": r"[0-9]{1,3}"},
    "at.moped": {"a": _L12, "b": r"[0-9]{1,3}", "c": r"[A-Z]{1,3}"},
}


class AustriaValidator:
    reason = "The plate does not match its format."

    def validate(self, entry: PlateEntry) -> PlateValidation:
        refused = restriction_verdict(entry)
        if refused is not None:
            return refused
        fmt = _FORMATS.get(entry.spec.id)
        if fmt is None or not entry.group(list(fmt)[-1]):
            return PlateValidation.valid()
        for key, pattern in fmt.items():
            if re.fullmatch(pattern, entry.group(key)) is None:
                return PlateValidation.invalid(self.reason)
        if entry.spec.id == "at.personalised" and len(entry.group("b")) + len(entry.group("c")) < 3:
            return PlateValidation.invalid(self.reason)
        return PlateValidation.valid()

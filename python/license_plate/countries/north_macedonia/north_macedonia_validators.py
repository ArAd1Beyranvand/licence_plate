from __future__ import annotations

from plate_core import PlateEntry, PlateValidation, is_digits_of_length, restriction_verdict

_AREAS = frozenset("BE BT DB DE DH DK GE GV KA KI KO KR KP KS KU MB MK NE OH PE PP PS RA RE SK SN SU SR ST TE VA VE VI VV".split())
_LETTERS = frozenset("ABCDEFGHIJKLMNOPRSTUVZ")
_TYPES = ("CC", "CD", "CMD")


def _letters(v, n):
    return len(v) == n and all(c in _LETTERS for c in v)


def _ok(ok, reason):
    return PlateValidation.valid() if ok else PlateValidation.invalid(reason)


class NorthMacedoniaValidator:
    REASON_REGION = "The area code is not one in use."
    REASON_DIGITS = "The number is four digits."
    REASON_LETTERS = "The series is two letters."
    REASON_MISSION = "The mission code is not listed."
    REASON_TYPE = "The class is CC, CD or CMD."
    REASON_SERIAL = "The serial is two or three digits."

    def validate(self, entry: PlateEntry) -> PlateValidation:
        diplomatic = entry.spec.id == "mk.diplomatic"
        refused = restriction_verdict(entry)
        if refused is not None:
            return refused
        if not entry.group("serial" if diplomatic else "letters"):
            return PlateValidation.valid()
        return self._judge_diplomatic(entry) if diplomatic else self._judge_standard(entry)

    def _judge_standard(self, entry):
        if entry.group("region") not in _AREAS:
            return PlateValidation.invalid(self.REASON_REGION)
        if not is_digits_of_length(entry.group("digits"), 4):
            return PlateValidation.invalid(self.REASON_DIGITS)
        return _ok(_letters(entry.group("letters"), 2), self.REASON_LETTERS)

    def _judge_diplomatic(self, entry):
        if not is_digits_of_length(entry.group("mission"), 2):
            return PlateValidation.invalid(self.REASON_MISSION)
        if entry.group("type") not in _TYPES:
            return PlateValidation.invalid(self.REASON_TYPE)
        serial = entry.group("serial")
        return _ok(is_digits_of_length(serial, 2) or is_digits_of_length(serial, 3), self.REASON_SERIAL)

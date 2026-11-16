from __future__ import annotations

import re

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation

_MISSIONS = frozenset("ABCDEFGHIJKLMNOPRST")
_LETTERS = re.compile(r"[A-Z]{2}")
_THREE_DIGITS = re.compile(r"[0-9]{3}")
_LETTER_TWO_DIGITS = re.compile(r"[A-Z][0-9]{2}")
_STANDARD = re.compile(r"[A-Z]{2}([0-9]{3}|[A-Z][0-9]{2})")


class IcelandValidator(GatedPlateValidator):
    gate_group = 'serial'

    REASON_LETTERS = "The prefix is two letters."
    REASON_SERIAL = "The second field is three digits or a letter and two digits."
    REASON_MISSION = "A diplomatic plate is CD, a mission letter and two digits."
    REASON_DEALER = "A dealer plate is RN and three digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        letters, serial = entry.group("letters"), entry.group("serial")
        if not _LETTERS.fullmatch(letters):
            return PlateValidation.invalid(self.REASON_LETTERS)
        if letters == "CD":
            if not _LETTER_TWO_DIGITS.fullmatch(serial) or serial[0] not in _MISSIONS:
                return PlateValidation.invalid(self.REASON_MISSION)
        elif letters == "RN":
            if not _THREE_DIGITS.fullmatch(serial):
                return PlateValidation.invalid(self.REASON_DEALER)
        elif not _THREE_DIGITS.fullmatch(serial) and not _LETTER_TWO_DIGITS.fullmatch(serial):
            return PlateValidation.invalid(self.REASON_SERIAL)
        return PlateValidation.valid()


class IcelandVanityValidator(GatedPlateValidator):
    gate_group = 'serial'

    REASON_LENGTH = "A vanity plate is two to six characters."
    REASON_STANDARD = "A vanity plate must not follow the standard format."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        value = entry.group("serial")
        if not 2 <= len(value) <= 6:
            return PlateValidation.invalid(self.REASON_LENGTH)
        if _STANDARD.fullmatch(value):
            return PlateValidation.invalid(self.REASON_STANDARD)
        return PlateValidation.valid()

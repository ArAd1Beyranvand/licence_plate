from __future__ import annotations

from dataclasses import dataclass

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length)

_SERIAL_CHARS = "0123456789ABCDEFGHJKLMNPQRSTUVWXYZ"
_CITY_CHARS = "ABCDEFGHJKLMNPQRSTUVWXYZ"
_SUFFIXES = "学警挂港澳试超"
_ENERGY_LETTERS = "ABCDEFGHJK"


def _is_serial_chars(s: str) -> bool:
    return bool(s) and all(c in _SERIAL_CHARS for c in s)


def _letters(s: str) -> int:
    return sum(c in _CITY_CHARS for c in s)


class ChinaValidator(GatedPlateValidator):
    gate_group = 'serial'

    REASON_CITY = "The city letter is A–Z without I and O."
    REASON_SERIAL = ("The serial is five digits or letters (no I, O), at most two of them "
                     "letters; the last place may be 学 警 挂 港 澳 试 超.")

    def judge(self, entry: PlateEntry) -> PlateValidation:
        return self.validate_fields(city=entry.group("city"), serial=entry.group("serial"))

    @classmethod
    def validate_fields(cls, *, city: str, serial: str) -> PlateValidation:
        if len(city) != 1 or city not in _CITY_CHARS:
            return PlateValidation.invalid(cls.REASON_CITY)
        if len(serial) != 5:
            return PlateValidation.invalid(cls.REASON_SERIAL)
        body = serial[:4] if serial[4] in _SUFFIXES else serial
        if not _is_serial_chars(body) or _letters(body) > 2:
            return PlateValidation.invalid(cls.REASON_SERIAL)
        return PlateValidation.valid()


@dataclass(frozen=True)
class ChinaNewEnergyValidator(GatedPlateValidator):
    large: bool = False
    gate_group = 'serial'

    REASON_SERIAL = "The serial is six digits or letters (no I, O)."
    REASON_ENERGY = "The energy letter is A–E or F–K (D electric, F other fuels)."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        serial = entry.group("serial")
        if len(serial) != 6 or not _is_serial_chars(serial):
            return PlateValidation.invalid(self.REASON_SERIAL)
        energy = serial[5] if self.large else serial[0]
        if energy not in _ENERGY_LETTERS:
            return PlateValidation.invalid(self.REASON_ENERGY)
        return PlateValidation.valid()


class ChinaDiplomaticValidator(GatedPlateValidator):
    gate_group = 'serial'

    REASON_DIGITS = "A diplomatic plate is a three-digit mission code and a three-digit serial."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if not is_digits_of_length(entry.group("mission"), 3) or not is_digits_of_length(entry.group("serial"), 3):
            return PlateValidation.invalid(self.REASON_DIGITS)
        return PlateValidation.valid()

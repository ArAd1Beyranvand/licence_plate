from __future__ import annotations

import re
from dataclasses import dataclass

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, is_digits, is_digits_of_length)

from .philippines_missions import MISSIONS, NOT_FOUND, is_refused

_LETTERS = re.compile(r'[A-Z]+')
_ALL_ZEROS = re.compile(r'0+')


@dataclass(frozen=True)
class PhilippinesValidator(GatedPlateValidator):
    government: bool = False
    gate_group = 'number'

    REASON_LETTERS = 'A plate starts with three letters.'
    REASON_NUMBER = 'The number is all digits.'
    REASON_ZERO = 'The number is never all zeros.'
    REASON_GOVERNMENT = 'S is reserved for government vehicles.'
    REASON_VINTAGE = 'A vintage plate ends in TX, TY or TZ.'
    REASON_YEAR = 'The year is four digits.'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        letters, number = entry.group('letters'), entry.group('number')
        if len(letters) != 3 or not _LETTERS.fullmatch(letters):
            return PlateValidation.invalid(self.REASON_LETTERS)
        if not is_digits(number):
            return PlateValidation.invalid(self.REASON_NUMBER)
        if _ALL_ZEROS.fullmatch(number):
            return PlateValidation.invalid(self.REASON_ZERO)
        if letters.startswith('S') and not self.government:
            return PlateValidation.invalid(self.REASON_GOVERNMENT)
        if entry.spec.indices_of_group('year'):
            if letters[1:] not in ('TX', 'TY', 'TZ'):
                return PlateValidation.invalid(self.REASON_VINTAGE)
            if not is_digits_of_length(entry.group('year'), 4):
                return PlateValidation.invalid(self.REASON_YEAR)
        return PlateValidation.valid()


@dataclass(frozen=True)
class PhilippinesMotorcycleValidator(GatedPlateValidator):
    gate_group = 'serial'

    REASON_LENGTH = 'A motorcycle plate has six characters.'
    REASON_MIX = 'A motorcycle plate mixes letters and digits.'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        serial = entry.group('serial')
        if len(serial) != 6:
            return PlateValidation.invalid(self.REASON_LENGTH)
        if not re.search('[A-Z]', serial) or not re.search('[0-9]', serial):
            return PlateValidation.invalid(self.REASON_MIX)
        return PlateValidation.valid()


@dataclass(frozen=True)
class PhilippinesDiplomaticValidator(GatedPlateValidator):
    gate_group = 'mission'

    REASON_SERIAL = 'The serial is four digits.'

    def validate(self, entry: PlateEntry) -> PlateValidation:
        if is_refused(entry.group('mission')):
            return PlateValidation.invalid(NOT_FOUND)
        return super().validate(entry)

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if entry.group('mission') not in MISSIONS:
            return PlateValidation.invalid(NOT_FOUND)
        if not is_digits_of_length(entry.group('serial'), 4):
            return PlateValidation.invalid(self.REASON_SERIAL)
        return PlateValidation.valid()

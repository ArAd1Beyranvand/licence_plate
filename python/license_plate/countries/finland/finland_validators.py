from __future__ import annotations

import re

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits

_letters_pattern = re.compile(r'[A-ZÅÄÖ]+')


class FinlandValidator(GatedPlateValidator):
    gate_group = 'number'

    REASON_LETTERS = 'The letters are two or three of A–Z, Å, Ä, Ö.'
    REASON_NUMBER = 'The number is one to three digits, not starting with 0.'
    REASON_ALAND = 'The Åland number is up to five digits.'
    REASON_EXPORT = 'The export number is up to four digits.'
    REASON_CODE = 'The prefix is C or CD.'
    REASON_DIPLOMATIC = 'CD takes up to four digits, C up to five.'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        number = entry.group('number')
        code = entry.group('code')
        if code:
            if code not in ('C', 'CD'):
                return PlateValidation.invalid(self.REASON_CODE)
            if not is_digits(number) or len(number) > (5 if code == 'C' else 4):
                return PlateValidation.invalid(self.REASON_DIPLOMATIC)
            return PlateValidation.valid()
        letters = entry.group('letters')
        if not _letters_pattern.fullmatch(letters):
            return PlateValidation.invalid(self.REASON_LETTERS)
        if len(letters) == 1:
            if not is_digits(number) or len(number) > 4:
                return PlateValidation.invalid(self.REASON_EXPORT)
            return PlateValidation.valid()
        if len(letters) > 3:
            return PlateValidation.invalid(self.REASON_LETTERS)
        if letters.startswith('ÅL'):
            if not is_digits(number) or len(number) > 5:
                return PlateValidation.invalid(self.REASON_ALAND)
            return PlateValidation.valid()
        if not is_digits(number) or len(number) > 3 or number.startswith('0'):
            return PlateValidation.invalid(self.REASON_NUMBER)
        return PlateValidation.valid()

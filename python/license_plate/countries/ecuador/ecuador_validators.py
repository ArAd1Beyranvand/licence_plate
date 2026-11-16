from __future__ import annotations

import re

from plate_core import PlateEntry, PlateValidation, restriction_verdict

_letters3 = re.compile(r'[A-Z]{3}')
_number = re.compile(r'[0-9]{3,4}')


class EcuadorValidator:
    PROVINCES = frozenset('ABUCXHOEWGILRMVNSPQKTZYJ')
    PROTOCOL_CODES = frozenset({'CC', 'CD', 'OI', 'AT', 'IT'})

    REASON_PROVINCE = 'The first letter names a province.'
    REASON_LETTERS = 'A plate starts with three letters.'
    REASON_CODE = 'The code is CC, CD, OI, AT or IT.'
    REASON_NUMBER = 'The number is 3 or 4 digits.'

    def validate(self, entry: PlateEntry) -> PlateValidation:
        refused = restriction_verdict(entry)
        if refused is not None:
            return refused
        letters = entry.group('letters')
        number = entry.group('number')
        if not number:
            return PlateValidation.valid()
        if entry.spec.id == 'ec.protocol':
            if letters not in self.PROTOCOL_CODES:
                return PlateValidation.invalid(self.REASON_CODE)
        elif not _letters3.fullmatch(letters):
            return PlateValidation.invalid(self.REASON_LETTERS)
        elif letters[0] not in self.PROVINCES:
            return PlateValidation.invalid(self.REASON_PROVINCE)
        if not _number.fullmatch(number):
            return PlateValidation.invalid(self.REASON_NUMBER)
        return PlateValidation.valid()

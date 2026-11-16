from __future__ import annotations

from plate_core import (
    PlateEntry, PlateValidation, is_digits, is_digits_of_length, restriction_verdict)


class EstoniaValidator:
    REASON_REGULAR = 'Three digits then three letters.'
    REASON_CODE = 'The prefix is CD, AT or CMD.'
    REASON_DIPLOMATIC = 'CD and AT take three or four digits, CMD two or three.'
    REASON_DEFENCE = 'Three digits, then K and a letter or EK and a letter.'

    def validate(self, entry: PlateEntry) -> PlateValidation:
        refused = restriction_verdict(entry)
        if refused is not None:
            return refused
        number = entry.group('number')
        letters = entry.group('letters')
        code = entry.group('code')
        if code:
            return self._diplomatic(code, number)
        if not number or not letters:
            return PlateValidation.valid()
        if entry.spec.id == 'ee.defence':
            shape = (len(letters) == 2 and letters.startswith('K')) or (
                len(letters) == 3 and letters.startswith('EK'))
            return (PlateValidation.valid() if is_digits_of_length(number, 3) and shape
                    else PlateValidation.invalid(self.REASON_DEFENCE))
        return (PlateValidation.valid() if is_digits_of_length(number, 3) and len(letters) == 3
                else PlateValidation.invalid(self.REASON_REGULAR))

    def _diplomatic(self, code: str, number: str) -> PlateValidation:
        low = {'CD': 3, 'AT': 3, 'CMD': 2}.get(code)
        if low is None:
            return PlateValidation.valid() if len(code) < 2 else PlateValidation.invalid(self.REASON_CODE)
        if not number:
            return PlateValidation.valid()
        return (PlateValidation.valid() if is_digits(number) and low <= len(number) <= low + 1
                else PlateValidation.invalid(self.REASON_DIPLOMATIC))

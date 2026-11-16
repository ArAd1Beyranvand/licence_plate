from __future__ import annotations

import re

from plate_core import (
    GatedPlateValidator, PlateEntry, PlateValidation, is_digits, is_digits_of_length)

COUNTY_NAMES = {
    'B': 'Bucharest', 'AB': 'Alba', 'AG': 'Argeș', 'AR': 'Arad',
    'BC': 'Bacău', 'BH': 'Bihor', 'BN': 'Bistrița-Năsăud', 'BR': 'Brăila',
    'BT': 'Botoșani', 'BV': 'Brașov', 'BZ': 'Buzău', 'CJ': 'Cluj',
    'CL': 'Călărași', 'CS': 'Caraș-Severin', 'CT': 'Constanța',
    'CV': 'Covasna', 'DB': 'Dâmbovița', 'DJ': 'Dolj', 'GJ': 'Gorj',
    'GL': 'Galați', 'GR': 'Giurgiu', 'HD': 'Hunedoara', 'HR': 'Harghita',
    'IF': 'Ilfov', 'IL': 'Ialomița', 'IS': 'Iași', 'MH': 'Mehedinți',
    'MM': 'Maramureș', 'MS': 'Mureș', 'NT': 'Neamț', 'OT': 'Olt',
    'PH': 'Prahova', 'SB': 'Sibiu', 'SJ': 'Sălaj', 'SM': 'Satu Mare',
    'SV': 'Suceava', 'TL': 'Tulcea', 'TM': 'Timiș', 'TR': 'Teleorman',
    'VL': 'Vâlcea', 'VN': 'Vrancea', 'VS': 'Vaslui',
}


def _county(code: str) -> bool:
    return code in COUNTY_NAMES


class RomaniaValidator(GatedPlateValidator):
    gate_group = 'letters'

    REASON_COUNTY = 'The county code is one of the 42 codes.'
    REASON_NUMBER = 'The number is two digits, or two or three in Bucharest; not 00.'
    REASON_LETTERS = 'The letters are three, without Q, and do not begin with I or O.'
    _letters = re.compile(r'[A-HJ-NP-Z][A-PR-Z]{2}')

    def judge(self, entry: PlateEntry) -> PlateValidation:
        county = entry.group('county')
        if not _county(county):
            return PlateValidation.invalid(self.REASON_COUNTY)
        number = entry.group('number')
        length_ok = len(number) == 2 or (county == 'B' and len(number) == 3)
        if not length_ok or not is_digits(number) or int(number) == 0:
            return PlateValidation.invalid(self.REASON_NUMBER)
        letters = entry.group('letters')
        if not self._letters.fullmatch(letters) or 'Q' in letters:
            return PlateValidation.invalid(self.REASON_LETTERS)
        return PlateValidation.valid()


class RomaniaTemporaryValidator(GatedPlateValidator):
    gate_group = 'number'

    REASON_NUMBER = 'The number is three to six digits, the first 0 and the second not.'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if not _county(entry.group('county')):
            return PlateValidation.invalid(RomaniaValidator.REASON_COUNTY)
        n = entry.group('number')
        if len(n) < 3 or not is_digits(n) or n[0] != '0' or n[1] == '0':
            return PlateValidation.invalid(self.REASON_NUMBER)
        return PlateValidation.valid()


class RomaniaTestValidator(GatedPlateValidator):
    gate_group = 'number'

    REASON_NUMBER = 'The number is three digits, from 101.'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if not _county(entry.group('county')):
            return PlateValidation.invalid(RomaniaValidator.REASON_COUNTY)
        n = entry.group('number')
        if not is_digits_of_length(n, 3) or int(n) < 101:
            return PlateValidation.invalid(self.REASON_NUMBER)
        return PlateValidation.valid()


class RomaniaDiplomaticValidator(GatedPlateValidator):
    gate_group = 'rank'

    REASON_CODE = 'The code is CD, TC or CO.'
    REASON_DIGITS = 'The mission and the rank are each three digits, from 101.'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if entry.group('code') not in ('CD', 'TC', 'CO'):
            return PlateValidation.invalid(self.REASON_CODE)
        for key in ('mission', 'rank'):
            v = entry.group(key)
            if not is_digits_of_length(v, 3) or int(v) < 101:
                return PlateValidation.invalid(self.REASON_DIGITS)
        return PlateValidation.valid()

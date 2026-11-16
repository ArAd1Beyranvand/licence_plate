from __future__ import annotations

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits

NOT_FOUND = 'COUNTRY NOT FOUND'
REFUSED_MISSIONS = ('336', '337', '338', '339', '340')


def _number(entry: PlateEntry) -> str:
    return entry.group('number') + entry.group('number2') + entry.group('number3')


class VietnamValidator(GatedPlateValidator):
    gate_group = 'number'

    REASON_PROVINCE = 'The province code is 11 to 99.'
    REASON_SERIES = 'The series is missing.'
    REASON_NUMBER = 'The number is 5 digits.'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        province = entry.group('province')
        if len(province) != 2 or not is_digits(province) or int(province) < 11:
            return PlateValidation.invalid(self.REASON_PROVINCE)
        if not entry.group('series'):
            return PlateValidation.invalid(self.REASON_SERIES)
        number = _number(entry)
        if len(number) != 5 or not is_digits(number):
            return PlateValidation.invalid(self.REASON_NUMBER)
        return PlateValidation.valid()


class VietnamForeignValidator(GatedPlateValidator):
    gate_group = 'number'

    REASON_MISSION = 'The mission code is three digits.'
    REASON_NUMBER = 'The number is two digits.'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        mission = entry.group('mission')
        if mission in REFUSED_MISSIONS:
            return PlateValidation.invalid(NOT_FOUND)
        if len(mission) != 3 or not is_digits(mission):
            return PlateValidation.invalid(self.REASON_MISSION)
        number = _number(entry)
        if len(number) != 2 or not is_digits(number):
            return PlateValidation.invalid(self.REASON_NUMBER)
        return PlateValidation.valid()


class VietnamMilitaryValidator(GatedPlateValidator):
    gate_group = 'number'

    REASON_UNIT = 'The unit code is two letters.'
    REASON_NUMBER = 'The number is 3 or 4 digits.'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if len(entry.group('unit')) != 2:
            return PlateValidation.invalid(self.REASON_UNIT)
        number = _number(entry)
        if not 3 <= len(number) <= 4 or not is_digits(number):
            return PlateValidation.invalid(self.REASON_NUMBER)
        return PlateValidation.valid()

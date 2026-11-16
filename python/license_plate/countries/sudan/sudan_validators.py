from __future__ import annotations

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length


_STATES = ("KH", "G", "RS")


class SudanValidator(GatedPlateValidator):
    gate_group = 'serial'

    reason_class = "The class is one digit."
    reason_state = "Unknown state code."
    reason_serial = "The serial is four or five digits."

    def judge(self, entry: PlateEntry) -> PlateValidation:
        return self.validate_fields(entry.group("class"), entry.group("state"), entry.group("serial"))

    @classmethod
    def validate_fields(cls, class_digit: str, state: str, serial: str) -> PlateValidation:
        if not is_digits_of_length(class_digit, 1):
            return PlateValidation.invalid(cls.reason_class)
        if state not in _STATES:
            return PlateValidation.invalid(cls.reason_state)
        if not is_digits_of_length(serial, 4) and not is_digits_of_length(serial, 5):
            return PlateValidation.invalid(cls.reason_serial)
        return PlateValidation.valid()

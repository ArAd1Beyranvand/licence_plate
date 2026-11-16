from __future__ import annotations

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length


class BangladeshValidator(GatedPlateValidator):
    gate_group = "number"

    def judge(self, entry: PlateEntry) -> PlateValidation:
        city = entry.group("city")
        if not city:
            return PlateValidation.invalid("Choose a city.")
        class_letter = entry.group("class")
        if not class_letter:
            return PlateValidation.invalid("Choose a vehicle class letter.")
        series = entry.group("series")
        if not is_digits_of_length(series, 2) or int(series) < 11:
            return PlateValidation.invalid("The series is 11 to 99.")
        number = entry.group("number")
        if not is_digits_of_length(number, 4) or number == "0000":
            return PlateValidation.invalid("The number is 0001 to 9999.")
        return PlateValidation.valid()

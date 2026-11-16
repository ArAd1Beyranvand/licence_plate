
from plate_core import PlateCheck, RuledPlateValidator


class ParaguayValidator(RuledPlateValidator):
    checks = (
        PlateCheck("letters", r"[A-Z]{4}", "The series is four letters."),
        PlateCheck("number", r"[0-9]{3}", "The number is three digits."),
    )

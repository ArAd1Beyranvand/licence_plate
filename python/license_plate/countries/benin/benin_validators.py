
from plate_core import PlateCheck, RuledPlateValidator


class BeninValidator(RuledPlateValidator):
    checks = (
        PlateCheck("series", r"[A-Z]{2}", "The series is 2 letters."),
        PlateCheck("number", r"[0-9]{4}", "The number is 4 digits."),
    )


from plate_core import PlateCheck, RuledPlateValidator


class SomaliaPlateValidator(RuledPlateValidator):
    checks = (
        PlateCheck("series", r"[A-Z]{2}", "The series is two letters."),
        PlateCheck("number", r"[0-9]{4}", "The number is four digits."),
    )

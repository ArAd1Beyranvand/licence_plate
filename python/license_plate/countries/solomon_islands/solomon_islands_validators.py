
from plate_core import PlateCheck, RuledPlateValidator


class SolomonIslandsValidator(RuledPlateValidator):
    checks = (
        PlateCheck("series", r"[A-Z]{2}", "The series is two letters."),
        PlateCheck("serial", r"[0-9]{4}", "The serial is four digits."),
    )
